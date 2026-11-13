"use client";

import { useTranslations } from "next-intl";
import type { MenuLabels } from "./list-menus";

/** Translated labels for the kit's menus (messages: "Kit" namespace). */
export function useKitLabels(): Required<MenuLabels> {
  const t = useTranslations("Kit");
  return {
    sort: t("sort"),
    sortBy: t("sortBy"),
    ascending: t("ascending"),
    descending: t("descending"),
    columns: t("columns"),
    showColumns: t("showColumns"),
    resetColumns: t("resetColumns"),
    export: t("export"),
    rows: (n: number) => t("rows", { count: n }),
    groupBy: t("groupBy"),
    groupHint: t("groupHint"),
  };
}
