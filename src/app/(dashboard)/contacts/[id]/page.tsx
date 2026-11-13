"use client";

import { useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { Loader2 } from "lucide-react";
import { toast } from "sonner";
import { useTranslations } from "next-intl";
import type { Contact, ContactTag } from "@/types";
import { useCan } from "@/hooks/use-can";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { ContactForm } from "@/components/contacts/contact-form";
import { KButton, KBadge, KTabs } from "@/components/kit";
import { useLead } from "@/components/leads/use-lead";
import { LeadHeader } from "@/components/leads/lead-header";
import { LeadSidebar } from "@/components/leads/lead-sidebar";
import { NotesTab } from "@/components/leads/notes-tab";
import { ActivityTab } from "@/components/leads/activity-tab";
import { TasksTab } from "@/components/leads/tasks-tab";
import { CallsTab } from "@/components/leads/calls-tab";
import { WhatsAppTab } from "@/components/leads/whatsapp-tab";
import { ConvertDialog } from "@/components/leads/convert-dialog";
import { hasLeadColumns } from "@/lib/leads/lead-utils";

type TabId = "activity" | "notes" | "whatsapp" | "tasks" | "calls";

/** Full lead page for one contact: header actions, tabs, and the details sidebar. */
export default function LeadPage() {
  const t = useTranslations("Lead");
  const params = useParams();
  const router = useRouter();
  const contactId = params.id as string;
  const canEdit = useCan("send-messages");
  const lead = useLead(contactId);

  const [tab, setTab] = useState<TabId>("activity");
  // Bumped after anything that adds history, so the Activity tab reloads.
  const [activityKey, setActivityKey] = useState(0);
  const bumpActivity = () => setActivityKey((k) => k + 1);
  const [formOpen, setFormOpen] = useState(false);
  const [formTags, setFormTags] = useState<ContactTag[]>([]);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [deleting, setDeleting] = useState(false);
  const [convertOpen, setConvertOpen] = useState(false);
  const [convertForce, setConvertForce] = useState(false);

  const { contact } = lead;

  async function openEdit() {
    const { data } = await lead.supabase.from("contact_tags").select("*").eq("contact_id", contactId);
    setFormTags((data ?? []) as ContactTag[]);
    setFormOpen(true);
  }

  async function handleDelete() {
    setDeleting(true);
    const { error } = await lead.supabase.from("contacts").delete().eq("id", contactId);
    setDeleting(false);
    if (error) {
      toast.error(t("deleteFailed"));
      return;
    }
    toast.success(t("deleted"));
    router.push("/contacts");
  }

  if (lead.loading) {
    return (
      <div className="flex items-center justify-center gap-2 py-24 text-sm text-muted-foreground">
        <Loader2 className="size-5 animate-spin text-primary" /> {t("loading")}
      </div>
    );
  }

  if (lead.notFound || !contact) {
    return (
      <div className="flex flex-col items-center gap-3 py-24 text-center">
        <p className="text-sm text-muted-foreground">{t("notFound")}</p>
        <Link href="/contacts" className="k-btn">{t("backToContacts")}</Link>
      </div>
    );
  }

  const tabs: Array<{ id: TabId; label: string }> = [
    { id: "activity", label: t("tabActivity") },
    { id: "notes", label: t("tabNotes") },
    { id: "whatsapp", label: t("tabWhatsapp") },
    { id: "tasks", label: t("tabTasks") },
    { id: "calls", label: t("tabCalls") },
  ];

  return (
    <div className="space-y-3">
      {!hasLeadColumns(contact) && (
        <p className="rounded-lg border border-border bg-muted/40 px-3 py-2 text-xs text-muted-foreground">{t("needMigration")}</p>
      )}

      <div className="overflow-hidden rounded-lg border border-border bg-card">
        <LeadHeader
          contact={contact}
          profiles={lead.profiles}
          stages={lead.stages}
          leadPipeline={lead.leadPipeline}
          canEdit={canEdit}
          onUpdate={async (patch) => {
            const ok = await lead.updateContact(patch);
            if (ok) bumpActivity();
            return ok;
          }}
          onEdit={openEdit}
          onDelete={() => setDeleteOpen(true)}
        >
          {hasLeadColumns(contact) && contact.converted_deal_id ? (
            <>
              <KBadge tone="green">{t("convertedBadge")}</KBadge>
              <KButton onClick={() => router.push("/pipelines")}>{t("viewDeal")}</KButton>
              {canEdit && (
                <KButton
                  onClick={() => {
                    if (window.confirm(t("convertAgainConfirm"))) {
                      setConvertForce(true);
                      setConvertOpen(true);
                    }
                  }}
                >
                  {t("convertAgain")}
                </KButton>
              )}
            </>
          ) : (
            hasLeadColumns(contact) &&
            canEdit && (
              <KButton variant="primary" onClick={() => { setConvertForce(false); setConvertOpen(true); }}>
                {t("convertToDeal")}
              </KButton>
            )
          )}
        </LeadHeader>

        <div className="grid lg:grid-cols-[minmax(0,1fr)_340px]">
          <div className="min-w-0" style={{ minHeight: 420 }}>
            <div style={{ padding: "0 16px" }}>
              <KTabs tabs={tabs} value={tab} onChange={(id) => setTab(id as TabId)} />
            </div>
            {tab === "activity" && (
              <ActivityTab
                supabase={lead.supabase}
                contactId={contactId}
                profiles={lead.profiles}
                canEdit={canEdit}
                refreshKey={activityKey}
              />
            )}
            {tab === "notes" && (
              <NotesTab supabase={lead.supabase} contactId={contactId} profiles={lead.profiles} canEdit={canEdit} onChanged={bumpActivity} />
            )}
            {tab === "whatsapp" && (
              <WhatsAppTab supabase={lead.supabase} contact={contact} canEdit={canEdit} onActivity={bumpActivity} />
            )}
            {tab === "tasks" && (
              <TasksTab supabase={lead.supabase} contactId={contactId} profiles={lead.profiles} canEdit={canEdit} onChanged={bumpActivity} />
            )}
            {tab === "calls" && (
              <CallsTab supabase={lead.supabase} contactId={contactId} profiles={lead.profiles} canEdit={canEdit} onChanged={bumpActivity} />
            )}
          </div>

          <div className="border-t border-border lg:border-l lg:border-t-0">
            <LeadSidebar
              contact={contact}
              profiles={lead.profiles}
              fields={lead.fields}
              values={lead.values}
              allTags={lead.allTags}
              tagIds={lead.tagIds}
              canEdit={canEdit}
              onUpdate={lead.updateContact}
              onCustomValue={lead.setCustomValue}
              onToggleTag={lead.toggleTag}
              onOpenWhatsApp={() => setTab("whatsapp")}
            />
          </div>
        </div>
      </div>

      {convertOpen && (
        <ConvertDialog
          supabase={lead.supabase}
          contact={contact}
          profiles={lead.profiles}
          force={convertForce}
          onClose={() => setConvertOpen(false)}
          onConverted={() => {
            void lead.reload();
            bumpActivity();
          }}
        />
      )}

      <ContactForm
        open={formOpen}
        onOpenChange={setFormOpen}
        contact={contact as Contact}
        contactTags={formTags}
        onSaved={() => void lead.reload()}
        onViewExisting={(id) => router.push(`/contacts/${id}`)}
      />

      <Dialog open={deleteOpen} onOpenChange={setDeleteOpen}>
        <DialogContent className="bg-popover border-border text-popover-foreground sm:max-w-sm">
          <DialogHeader>
            <DialogTitle className="text-popover-foreground">{t("deleteTitle")}</DialogTitle>
            <DialogDescription className="text-muted-foreground">
              {t("deleteDesc", { name: contact.name || contact.phone })}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="bg-popover border-border">
            <Button variant="outline" onClick={() => setDeleteOpen(false)} className="border-border text-muted-foreground hover:bg-muted">
              {t("cancel")}
            </Button>
            <Button variant="destructive" onClick={handleDelete} disabled={deleting}>
              {deleting && <Loader2 className="size-4 animate-spin" />}
              {t("deleteBtn")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
