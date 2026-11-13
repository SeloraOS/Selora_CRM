"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { LayoutTemplate, Loader2, MessageCircle } from "lucide-react";
import { toast } from "sonner";
import { useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import type { Contact, Conversation, ConversationStatus, Message, MessageTemplate } from "@/types";
import { CONVERSATION_SELECT, normalizeConversation } from "@/lib/inbox/conversations";
import { useRealtime } from "@/hooks/use-realtime";
import { MessageThread } from "@/components/inbox/message-thread";
import { TemplatePicker, type TemplateSendValues } from "@/components/inbox/template-picker";
import { EmptyState, KButton } from "@/components/kit";

/**
 * This lead's own WhatsApp chat, inside the lead page.
 * Reuses the Inbox's MessageThread (same sending, templates, 24h-window handling) but owns its
 * messages/conversation state and listens to realtime for THIS conversation only.
 * If the contact has no conversation yet, a template can start one (the send API creates it).
 */
export function WhatsAppTab({
  supabase,
  contact,
  canEdit,
  onActivity,
}: {
  supabase: SupabaseClient;
  contact: Contact;
  canEdit: boolean;
  onActivity?: () => void;
}) {
  const t = useTranslations("Lead");
  const [conversation, setConversation] = useState<Conversation | null>(null);
  const [loading, setLoading] = useState(true);
  const [messages, setMessages] = useState<Message[]>([]);
  const [resyncToken, setResyncToken] = useState(0);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [sending, setSending] = useState(false);
  const convIdRef = useRef<string | null>(null);

  const loadConversation = useCallback(async () => {
    const { data } = await supabase
      .from("conversations")
      .select(CONVERSATION_SELECT)
      .eq("contact_id", contact.id)
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle();
    const conv = data ? normalizeConversation(data as Parameters<typeof normalizeConversation>[0]) : null;
    convIdRef.current = conv?.id ?? null;
    setConversation(conv);
    setLoading(false);
  }, [supabase, contact.id]);

  useEffect(() => {
    // setState runs after the awaited query inside loadConversation().
    loadConversation();
  }, [loadConversation]);

  // Catch up after the tab was in the background (realtime can miss events), like the Inbox does.
  useEffect(() => {
    const onVisible = () => document.visibilityState === "visible" && setResyncToken((n) => n + 1);
    document.addEventListener("visibilitychange", onVisible);
    return () => document.removeEventListener("visibilitychange", onVisible);
  }, []);

  const { isConnected } = useRealtime({
    channelName: `lead-chat-${conversation?.id ?? "none"}`,
    conversationId: conversation?.id,
    enabled: !!conversation,
    onMessageEvent: (event) => {
      const msg = event.new;
      if (event.eventType === "INSERT") {
        setMessages((prev) => {
          if (prev.some((m) => m.id === msg.id)) return prev;
          // a real row replaces the optimistic temp one
          return [...prev.filter((m) => !m.id.startsWith("temp-")), msg];
        });
        onActivity?.();
      } else if (event.eventType === "UPDATE") {
        setMessages((prev) => prev.map((m) => (m.id === msg.id ? { ...m, ...msg } : m)));
      }
    },
    onConversationEvent: (event) => {
      if (event.eventType === "UPDATE") setConversation((prev) => (prev ? { ...prev, ...event.new } : prev));
    },
  });

  // Resync once after a reconnect (not on the first connect).
  const wasConnected = useRef(false);
  const firstConnectDone = useRef(false);
  useEffect(() => {
    if (isConnected && !wasConnected.current) {
      if (firstConnectDone.current) setResyncToken((n) => n + 1);
      else firstConnectDone.current = true;
    }
    wasConnected.current = isConnected;
  }, [isConnected]);

  async function startWithTemplate(template: MessageTemplate, values: TemplateSendValues) {
    setSending(true);
    try {
      const res = await fetch("/api/whatsapp/send", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          // No conversation_id: the route find-or-creates one for this contact.
          contact_id: contact.id,
          message_type: "template",
          template_name: template.name,
          template_language: template.language,
          template_message_params: { body: values.body, headerText: values.headerText, buttonParams: values.buttonParams },
          template_params: values.body,
        }),
      });
      const payload = await res.json().catch(() => ({}));
      if (!res.ok) {
        toast.error(t("whatsappFailed", { reason: payload?.error || `HTTP ${res.status}` }));
        return;
      }
      toast.success(t("whatsappSent", { name: template.name }));
      await loadConversation();
      onActivity?.();
    } catch (err) {
      toast.error(t("whatsappFailed", { reason: err instanceof Error ? err.message : "network error" }));
    } finally {
      setSending(false);
    }
  }

  const handleStatusChange = useCallback((conversationId: string, status: ConversationStatus) => {
    setConversation((prev) => (prev && prev.id === conversationId ? { ...prev, status } : prev));
  }, []);
  const handleAssignChange = useCallback((conversationId: string, assignedAgentId: string | null) => {
    setConversation((prev) => (prev && prev.id === conversationId ? { ...prev, assigned_agent_id: assignedAgentId ?? undefined } : prev));
  }, []);

  if (loading) {
    return <div className="k-muted" style={{ padding: 24, textAlign: "center", fontSize: 13 }}>{t("loading")}</div>;
  }

  if (!conversation) {
    return (
      <>
        <EmptyState
          icon={MessageCircle}
          action={
            canEdit ? (
              <KButton variant="primary" disabled={sending} onClick={() => setPickerOpen(true)}>
                {sending ? <Loader2 size={13} className="animate-spin" /> : <LayoutTemplate size={13} />} {t("startConversation")}
              </KButton>
            ) : undefined
          }
        >
          {t("noConversation")}
        </EmptyState>
        <TemplatePicker open={pickerOpen} onOpenChange={setPickerOpen} onSelect={startWithTemplate} />
      </>
    );
  }

  return (
    <div style={{ height: "clamp(420px, 70vh, 720px)", display: "flex", minWidth: 0 }}>
      <MessageThread
        conversation={conversation}
        contact={contact}
        messages={messages}
        onMessagesLoaded={setMessages}
        onNewMessage={(msg) => setMessages((prev) => (prev.some((m) => m.id === msg.id) ? prev : [...prev, msg]))}
        onUpdateMessage={(id, updates) => setMessages((prev) => prev.map((m) => (m.id === id ? { ...m, ...updates } : m)))}
        onStatusChange={handleStatusChange}
        onAssignChange={handleAssignChange}
        resyncToken={resyncToken}
        onRefresh={() => setResyncToken((n) => n + 1)}
      />
    </div>
  );
}
