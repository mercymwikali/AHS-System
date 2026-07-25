# Relationship & Refactoring Strategy Report

Date: 2026-07-25

## Executive Summary

This audit covers the reorganized AL workspace under `src/`, including all Pages, Codeunits, Tables, and Table Extensions after the domain-driven reclassification into 9 module folders.

Key findings:
- 2,125 AL files were successfully reorganized into `src/01_Core_and_Setup/` through `src/09_Business_Operations/`.
- 868 Page objects were scanned, covering 1,346 page triggers.
- 187 pages contain direct record modification logic inside Page triggers.
- 455 trigger occurrences were flagged for direct `Modify`, `Insert`, or `Delete` behavior.
- 46 Codeunits were audited; 8 have direct cross-domain table dependencies, and 11 are monolithic codeunits above 1,000 lines.
- 587 Table objects were scanned; 80 custom table candidates mirror standard BC master entities.
- No explicit FlowField definitions were identified in the scanned Table files.

This report provides a structured relationship and refactoring strategy for the most significant architectural smells found during the audit.

## 1. Page Logic Audit

### Summary
- Pages scanned: 868
- Page triggers scanned: 1,346
- Pages with direct record modifications: 187
- Flagged triggers:
  - `OnAction`: 439
  - `OnAfterGetRecord`: 13
  - `OnQueryClosePage`: 3

### Domain distribution of flagged pages
- `04_Clinical_and_Patient_Management`: 61 pages
- `03_Human_Resources_and_Payroll`: 40 pages
- `05_Inventory_and_Procurement`: 26 pages
- `02_Finance_and_GL`: 18 pages
- `07_Administration_and_Security`: 11 pages
- `08_Logistics_and_Asset_Management`: 11 pages
- `09_Business_Operations`: 8 pages
- `01_Core_and_Setup`: 6 pages
- `06_Portal_and_Integrations`: 6 pages

### Findings
- The largest category of UI logic smells are `OnAction` code triggers that perform direct data writes. These are high-priority candidates for refactoring into dedicated management Codeunits.
- `OnAfterGetRecord` and `OnQueryClosePage` modifications are less frequent but represent embedded business logic outside page lifecycle conventions.
- The Clinical domain contains the most aggressive UI-data mixing, including several HMS pages with 6-13 direct-modification triggers each.

### Top flagged pages by severity
- Page 85316 `HMS` (`04_Clinical_and_Patient_Management`): 13 flagged triggers (`OnAction`, `OnAfterGetRecord`)
- Page 85182 `Item` (`05_Inventory_and_Procurement`): 9 flagged triggers (`OnAction`)
- Page 85291 `HMS` (`04_Clinical_and_Patient_Management`): 9 flagged triggers (`OnAction`)
- Page 85413 `HMS` (`04_Clinical_and_Patient_Management`): 8 flagged triggers (`OnAction`)
- Page 85486 `HMS` (`04_Clinical_and_Patient_Management`): 7 flagged triggers (`OnAction`)
- Page 85373 `HMS` (`04_Clinical_and_Patient_Management`): 7 flagged triggers (`OnAction`)
- Page 85329 `HMS` (`04_Clinical_and_Patient_Management`): 7 flagged triggers (`OnAction`)
- Page 85289 `HMS` (`04_Clinical_and_Patient_Management`): 7 flagged triggers (`OnAction`)
- Page 85060 `Purchase` (`05_Inventory_and_Procurement`): 6 flagged triggers (`OnAction`)
- Page 85459 `HMS` (`04_Clinical_and_Patient_Management`): 6 flagged triggers (`OnAction`)

### Recommended refactoring actions for pages
- Move direct modification logic from Page triggers into domain-specific business Codeunits.
- Replace page-level record writes with event subscribers or `PageAction` calls that delegate to codeunit entry points.
- For Clinical pages, create HMS management Codeunits that encapsulate patient encounter, billing, and appointment write workflows.
- Audit `OnAfterGetRecord` triggers for hidden record mutations and migrate them into record-validation or data-service codeunits.

## 2. Codeunit Dependency Audit

### Summary
- Codeunits scanned: 46
- Cross-domain table dependencies found: 8
- Monolithic codeunits (>1,000 lines): 11
- Codeunits with no detected event subscribers: 40

### Cross-domain dependency findings
The following Codeunits have direct table references into another domain, creating a strong coupling risk:

- `02_Finance_and_GL` Codeunit 85023 `Budgetary` (1,478 lines)
  - Cross-domain references: `Committment` table in `09_Business_Operations`
  - Recommended action: isolate budgetary integration behind a finance-to-business-operations service boundary and/or use events to decouple.

- `03_Human_Resources_and_Payroll` Codeunit 85042 `prPayrollProcessing` (2,500 lines)
  - Cross-domain reference: `Control-Information` table in `09_Business_Operations`
  - Recommended action: move payroll-processing dependencies into a dedicated HR/Payroll domain interface and avoid direct table writes outside HR.

- `03_Human_Resources_and_Payroll` Codeunit 85041 `prPayrollProcessing-Casuals` (1,919 lines)
  - Cross-domain reference: `Control-Information` table in `09_Business_Operations`
  - Recommended action: similar HR/Payroll boundary refactor with targeted event publishing.

- `06_Portal_and_Integrations` Codeunits 85030 `HMS`, 85014 `NewHMISPortal`, 85015 `New` (2,788; 4,348; 6,529 lines)
  - All reference `HR-Employee` in `03_Human_Resources_and_Payroll`
  - Recommended action: implement an integration boundary layer for portal authentication/profile synchronization, with HR-Employee access encapsulated in a dedicated integration service.

- `07_Administration_and_Security` Codeunit 85004 `Custom` (184 lines)
  - Cross-domain reference: `HR-Employee` in `03_Human_Resources_and_Payroll`
  - Recommended action: move employee-related validation or lookup logic into HR domain services and use published events for administrative triggers.

- `09_Business_Operations` Codeunit 85038 `Progress` (65 lines)
  - Cross-domain reference: `HR-Employee` in `03_Human_Resources_and_Payroll`
  - Recommended action: avoid direct cross-domain employee table references in operations codeunits by using event-driven synchronization.

### Recommended refactoring actions for codeunits
- Decompose the 11 monolithic codeunits over 1,000 lines into smaller, domain-specific units.
- Introduce event subscribers in codeunits that currently lack them, especially for integration and workflow points.
- Replace direct cross-domain table references with publish-subscribe boundaries or a lightweight domain service facade.
- Ensure codeunits in `06_Portal_and_Integrations` consume HR employee data via shared abstractions, not direct table writes.

## 3. Table & Relation Audit

### Summary
- Tables scanned: 587
- Duplicate master table candidates identified: 80
- FlowField definitions detected: 0

### Duplicate master entity candidates
The audit found 80 custom tables that appear to duplicate standard BC master concepts. These are strong candidates for consolidation into standard tables with Table Extensions.

- `employee`: 34 candidates
- `item`: 17 candidates
- `patient`: 16 candidates
- `vendor`: 10 candidates
- `customer`: 2 candidates
- `resource`: 1 candidate

### Recommendation for master data consolidation
- Consolidate custom staff and practitioner tables into `Resource` and `ResourceExt`.
- Consolidate custom patient, insurer, and contact tables into `Customer` and `CustomerExt`.
- Consolidate vendor-like tables into `Vendor`/`VendorExt` where applicable.
- Consolidate custom item tables into `Item`/`ItemExt` or create a single shared product catalog table as needed.
- Preserve all custom business fields in Table Extensions and maintain field-level `OnValidate` logic where present.

### Table relation observations
- The audit extracted table relations and flow field usage patterns from table metadata.
- A secondary field-level review is required for `TableRelation` values and `CalcFormula` expressions that may span across domain tables.
- The current audit did not detect any explicit FlowField definitions, suggesting either none exist or they require a deeper syntax parse.

## 4. Refactoring Strategy

### Priority 1: Page-to-Codeunit migration
- Target the 187 flagged pages, especially the 61 Clinical pages and the 40 HR/Payroll pages.
- Move business logic from `OnAction` and `OnAfterGetRecord` into dedicated service codeunits.
- Keep pages as thin UI controllers and use `ControlAddIn` or page actions only for input and navigation.

### Priority 2: Domain boundary enforcement
- Refactor the 8 cross-domain Codeunits to remove direct table references across domains.
- Add domain-specific APIs or event channels for Finance-BusinessOperations, HR-BusinessOperations, Portal-HR, and Admin-HR interactions.
- Introduce wrapper codeunits in each domain that expose only authorized operations.

### Priority 3: Master data normalization
- Replace custom master tables with standard BC tables plus extensions.
- Preserve custom fields in Table Extensions and maintain all validation/business logic.
- Map patient, employee, item, vendor, and resource entities into shared master tables with domain-specific extensions.

### Priority 4: Codeunit complexity reduction
- Break large codeunits into smaller units focused on a single business capability.
- Move shared helper routines into reusable library codeunits or global event subscribers.
- Validate that each codeunit serves a single domain or integration concern.

## 5. Actionable Next Steps

1. Execute a second-pass field-lineage audit for the 80 `duplicate_master` candidate tables.
2. Review the page-specific `OnAction` triggers in the top Clinical and Inventory pages and extract their write logic into isolated codeunits.
3. Refactor `Budgetary` and payroll codeunits to remove direct writes to tables outside their domain.
4. Create `CustomerExt`, `ResourceExt`, and `VendorExt` extension objects as the consolidation backbone for master data.
5. Add or identify event subscribers for all integration Codeunits in `06_Portal_and_Integrations`.

## Appendix A: Audit Metrics

- `src/01_Core_and_Setup/`
- `src/02_Finance_and_GL/`
- `src/03_Human_Resources_and_Payroll/`
- `src/04_Clinical_and_Patient_Management/`
- `src/05_Inventory_and_Procurement/`
- `src/06_Portal_and_Integrations/`
- `src/07_Administration_and_Security/`
- `src/08_Logistics_and_Asset_Management/`
- `src/09_Business_Operations/`

### Domain risk ranking by page logic smell
1. `04_Clinical_and_Patient_Management`
2. `03_Human_Resources_and_Payroll`
3. `05_Inventory_and_Procurement`
4. `02_Finance_and_GL`
5. `07_Administration_and_Security`
6. `08_Logistics_and_Asset_Management`
7. `09_Business_Operations`
8. `01_Core_and_Setup`
9. `06_Portal_and_Integrations`

### Master data duplicate keyword counts
- `employee`: 34
- `item`: 17
- `patient`: 16
- `vendor`: 10
- `customer`: 2
- `resource`: 1

### Cross-domain codeunits
- `85023 Budgetary` (Finance) → `Committment` (`Business Operations`)
- `85042 prPayrollProcessing` (HR) → `Control-Information` (`Business Operations`)
- `85041 prPayrollProcessing-Casuals` (HR) → `Control-Information` (`Business Operations`)
- `85030 HMS` (Portal/Integrations) → `HR-Employee` (`HR`)
- `85014 NewHMISPortal` (Portal/Integrations) → `HR-Employee` (`HR`)
- `85015 New` (Portal/Integrations) → `HR-Employee` (`HR`)
- `85004 Custom` (Administration) → `HR-Employee` (`HR`)
- `85038 Progress` (Business Operations) → `HR-Employee` (`HR`)

## Appendix B: Recommended report file
The file `Relationship_and_Refactoring_Strategy_Report.md` has been added to the repository root with this audit summary.
