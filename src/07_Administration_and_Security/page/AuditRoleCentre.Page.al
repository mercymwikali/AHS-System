// Page 52202628 "Audit Role Centre"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control29)
//             {
//                 systempart(Control27; Outlook)
//                 {
//                 }
//             }
//             group(Control26)
//             {
//                 part(Control25; "Approval Entries")
//                 {
//                     Caption = 'My Approval Entries';
//                 }
//                 systempart(Control24; Links)
//                 {
//                 }
//                 systempart(Control23; MyNotes)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Navigation)
//         {
//             action(Audit)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Audit';
//                 Image = "List";
//                 RunObject = page "Internal Audits";
//                 ToolTip = 'Executes the Audit action.';
//             }
//         }
//         area(reporting)
//         {
//             action(GLTrialBalance)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&G/L Trial Balance';
//                 Image = "Report";
//                 RunObject = Report "Trial Balance";
//                 ToolTip = 'Executes the &G/L Trial Balance action.';
//             }
//             action(BankDetailTrialBalance)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Bank Detail Trial Balance';
//                 Image = "Report";
//                 RunObject = Report "Bank Acc. - Detail Trial Bal.";
//                 ToolTip = 'Executes the &Bank Detail Trial Balance action.';
//             }
//             action(AccountSchedule)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Account Schedule';
//                 Image = "Report";
//                 RunObject = Report "Account Schedule";
//                 ToolTip = 'Executes the &Account Schedule action.';
//             }
//             action(Budget)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Bu&dget';
//                 Image = "Report";
//                 RunObject = Report Budget;
//                 ToolTip = 'Executes the Bu&dget action.';
//             }
//             action(TrialBalanceBudget)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Trial Bala&nce/Budget';
//                 Image = "Report";
//                 RunObject = Report "Trial Balance/Budget";
//                 ToolTip = 'Executes the Trial Bala&nce/Budget action.';
//             }
//             action(TrialBalancebyPeriod)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Trial Balance by &Period';
//                 Image = "Report";
//                 RunObject = Report "Trial Balance by Period";
//                 ToolTip = 'Executes the Trial Balance by &Period action.';
//             }
//             action(FiscalYearBalance)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Fiscal Year Balance';
//                 Image = "Report";
//                 RunObject = Report "Fiscal Year Balance";
//                 ToolTip = 'Executes the &Fiscal Year Balance action.';
//             }
//             action(BalanceCompPrevYear)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Balance Comp. - Prev. Y&ear';
//                 Image = "Report";
//                 RunObject = Report "Balance Comp. - Prev. Year";
//                 ToolTip = 'Executes the Balance Comp. - Prev. Y&ear action.';
//             }
//             action(ClosingTrialBalance)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Closing Trial Balance';
//                 Image = "Report";
//                 RunObject = Report "Closing Trial Balance";
//                 ToolTip = 'Executes the &Closing Trial Balance action.';
//             }
//             separator(Action106)
//             {
//             }
//             action(CashFlowDateList)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cash Flow Date List';
//                 Image = "Report";
//                 RunObject = Report "Cash Flow Date List";
//                 ToolTip = 'Executes the Cash Flow Date List action.';
//             }
//             separator(Action104)
//             {
//             }
//             action(AgedAccountsReceivable)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Aged Accounts &Receivable';
//                 Image = "Report";
//                 RunObject = Report "Aged Accounts Receivable";
//                 ToolTip = 'Executes the Aged Accounts &Receivable action.';
//             }
//             action(AgedAccountsPayable)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Aged Accounts Pa&yable';
//                 Image = "Report";
//                 RunObject = Report "Aged Accounts Payable";
//                 ToolTip = 'Executes the Aged Accounts Pa&yable action.';
//             }
//             action(ReconcileCustandVendAccs)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Reconcile Cus&t. and Vend. Accs';
//                 Image = "Report";
//                 RunObject = Report "Reconcile Cust. and Vend. Accs";
//                 ToolTip = 'Executes the Reconcile Cus&t. and Vend. Accs action.';
//             }
//             separator(Action100)
//             {
//             }
//             action(VATRegistrationNoCheck)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&VAT Registration No. Check';
//                 Image = "Report";
//                 RunObject = Report "VAT Registration No. Check";
//                 ToolTip = 'Executes the &VAT Registration No. Check action.';
//             }
//             action(VATExceptions)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'VAT E&xceptions';
//                 Image = "Report";
//                 RunObject = Report "VAT Exceptions";
//                 ToolTip = 'Executes the VAT E&xceptions action.';
//             }
//             action(VATStatement)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'VAT &Statement';
//                 Image = "Report";
//                 RunObject = Report "VAT Statement";
//                 ToolTip = 'Executes the VAT &Statement action.';
//             }
//             action(VATVIESDeclarationTaxAuth)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'VAT - VIES Declaration Tax Aut&h';
//                 Image = "Report";
//                 RunObject = Report "VAT- VIES Declaration Tax Auth";
//                 ToolTip = 'Executes the VAT - VIES Declaration Tax Aut&h action.';
//             }
//             action(VATVIESDeclarationDisk)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'VAT - VIES Declaration Dis&k';
//                 Image = "Report";
//                 RunObject = Report "VAT- VIES Declaration Disk";
//                 ToolTip = 'Executes the VAT - VIES Declaration Dis&k action.';
//             }
//             action(ECSalesList)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'EC Sales &List';
//                 Image = "Report";
//                 RunObject = Report "EC Sales List";
//                 ToolTip = 'Executes the EC Sales &List action.';
//             }
//             separator(Action93)
//             {
//             }
//             action(IntrastatChecklist)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Intrastat - Checklist';
//                 Image = "Report";
//                 RunObject = Report "Intrastat - Checklist";
//                 ToolTip = 'Executes the &Intrastat - Checklist action.';
//             }
//             action(IntrastatForm)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Intrastat - For&m';
//                 Image = "Report";
//                 RunObject = Report "Intrastat - Form";
//                 ToolTip = 'Executes the Intrastat - For&m action.';
//             }
//             separator(Action90)
//             {
//             }
//             action(CostAccountingPLStatement)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cost Accounting P/L Statement';
//                 Image = "Report";
//                 RunObject = Report "Cost Acctg. Statement";
//                 ToolTip = 'Executes the Cost Accounting P/L Statement action.';
//             }
//             action(CAPLStatementperPeriod)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'CA P/L Statement per Period';
//                 Image = "Report";
//                 RunObject = Report "Cost Acctg. Stmt. per Period";
//                 ToolTip = 'Executes the CA P/L Statement per Period action.';
//             }
//             action(CAPLStatementwithBudget)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'CA P/L Statement with Budget';
//                 Image = "Report";
//                 RunObject = Report "Cost Acctg. Statement/Budget";
//                 ToolTip = 'Executes the CA P/L Statement with Budget action.';
//             }
//             action(CostAccountingAnalysis)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cost Accounting Analysis';
//                 Image = "Report";
//                 RunObject = Report "Cost Acctg. Analysis";
//                 ToolTip = 'Executes the Cost Accounting Analysis action.';
//             }
//             separator(Action85)
//             {
//             }
//             action(VendorTop10List)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Vendor - T&op 10 List';
//                 Image = "Report";
//                 RunObject = Report "Vendor - Top 10 List";
//                 ToolTip = 'Executes the Vendor - T&op 10 List action.';
//             }
//             action(VendorItemPurchases)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Vendor/&Item Purchases';
//                 Image = "Report";
//                 RunObject = Report "Vendor/Item Purchases";
//                 ToolTip = 'Executes the Vendor/&Item Purchases action.';
//             }
//             separator(Action82)
//             {
//             }
//             group(Procurement)
//             {
//                 Caption = 'Procurement Reports';
//             }
//             action(InventoryAvailabilityPlan)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Inventory - &Availability Plan';
//                 Image = ItemAvailability;
//                 RunObject = Report "Inventory - Availability Plan";
//                 ToolTip = 'Executes the Inventory - &Availability Plan action.';
//             }
//             action(InventoryPurchaseOrders)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Inventory &Purchase Orders';
//                 Image = "Report";
//                 RunObject = Report "Inventory Purchase Orders";
//                 ToolTip = 'Executes the Inventory &Purchase Orders action.';
//             }
//             action(InventoryVendorPurchases)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Inventory - &Vendor Purchases';
//                 Image = "Report";
//                 RunObject = Report "Inventory - Vendor Purchases";
//                 ToolTip = 'Executes the Inventory - &Vendor Purchases action.';
//             }
//             action(InventoryCostandPriceList)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Inventory &Cost and Price List';
//                 Image = "Report";
//                 RunObject = Report "Inventory Cost and Price List";
//                 ToolTip = 'Executes the Inventory &Cost and Price List action.';
//             }
//             action(PurchaseQuoteRequestReport)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Purchase Quote Request Report';
//                 Image = "Report";
//                 RunObject = Report "Purchase Quote Request Report2";
//                 ToolTip = 'Executes the Purchase Quote Request Report action.';
//             }
//             action(Action75)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Purchase Quote Request Report';
//                 Image = "Report";
//                 RunObject = Report "Purchase - Quote";
//                 ToolTip = 'Executes the Purchase Quote Request Report action.';
//             }
//             action(LocalPurchaseOrders)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Local Purchase Orders';
//                 Image = "Report";
//                 RunObject = Report Order;
//                 ToolTip = 'Executes the Local Purchase Orders action.';
//             }
//             action(PurchaseRequisition)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Purchase Requisition';
//                 Image = "Report";
//                 RunObject = Report "Purchase Requisition Form";
//                 ToolTip = 'Executes the Purchase Requisition action.';
//             }

//             group(payroll_Reports)
//             {
//                 Caption = 'Payroll Reports';
//                 action(CompanyPayrollMaster)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Company Payroll Master';
//                     Image = CompanyInformation;
//                     Promoted = true;
//                     RunObject = Report "Company Payroll Summary 3";
//                     ToolTip = 'Executes the Company Payroll Master action.';
//                 }
//                 action(vewpayslip)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'vew payslip';
//                     RunObject = Report "Individual Payslips mst";
//                     ToolTip = 'Executes the vew payslip action.';
//                 }
//                 action(Payrollsummary)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Payroll summary';
//                     RunObject = Report "Individual Payslips mst";
//                     ToolTip = 'Executes the Payroll summary action.';
//                 }
//                 action(payrollsummary2)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'payroll summary2';
//                     RunObject = Report prPayrollSummary2;
//                     ToolTip = 'Executes the payroll summary2 action.';
//                 }
//                 action(deductions)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'deductions';
//                     RunObject = Report "prDeductions Report";
//                     ToolTip = 'Executes the deductions action.';
//                 }
//                 action(Staffpension)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Staff pension';
//                     RunObject = Report "prStaff Pension Contrib";
//                     ToolTip = 'Executes the Staff pension action.';
//                 }
//                 action(GrossNetpay)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Gross Netpay';
//                     RunObject = Report prGrossNetPay;
//                     ToolTip = 'Executes the Gross Netpay action.';
//                 }
//                 action(ThirdRule)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Third Rule';
//                     RunObject = Report "A third Rule Report";
//                     ToolTip = 'Executes the Third Rule action.';
//                 }
//                 action(CoopRemittance)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Co_op Remittance';
//                     RunObject = Report "prCoop remmitance";
//                     ToolTip = 'Executes the Co_op Remittance action.';
//                 }
//                 action(Transactions)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Transactions';
//                     RunObject = Report "pr Transactions";
//                     ToolTip = 'Executes the Transactions action.';
//                 }
//                 action(bankSchedule)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'bank Schedule';
//                     RunObject = Report "pr Bank Schedule";
//                     ToolTip = 'Executes the bank Schedule action.';
//                 }
//                 action(Action59)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'vew payslip';
//                     Image = "report";
//                     Promoted = true;
//                     RunObject = Report "Individual Payslips mst";
//                     ToolTip = 'Executes the vew payslip action.';
//                 }
//                 action(Action58)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Payroll summary';
//                     Image = payslip;
//                     RunObject = Report "Individual Payslips mst";
//                     ToolTip = 'Executes the Payroll summary action.';
//                 }
//                 action(Action57)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'payroll summary2';
//                     Image = summary;
//                     RunObject = Report prPayrollSummary2;
//                     ToolTip = 'Executes the payroll summary2 action.';
//                 }
//                 action(Action56)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'deductions';
//                     Image = DepositSlip;
//                     RunObject = Report "prDeductions Report";
//                     ToolTip = 'Executes the deductions action.';
//                 }
//                 action(Action55)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Staff pension';
//                     Image = Aging;
//                     RunObject = Report "prStaff Pension Contrib";
//                     ToolTip = 'Executes the Staff pension action.';
//                 }
//                 action(Action54)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Gross Netpay';
//                     Image = Giro;
//                     RunObject = Report prGrossNetPay;
//                     ToolTip = 'Executes the Gross Netpay action.';
//                 }
//                 action(Action53)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Third Rule';
//                     Image = AddWatch;
//                     RunObject = Report "A third Rule Report";
//                     ToolTip = 'Executes the Third Rule action.';
//                 }
//                 action(Action52)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Co_op Remittance';
//                     Image = CreateForm;
//                     RunObject = Report "prCoop remmitance";
//                     ToolTip = 'Executes the Co_op Remittance action.';
//                 }
//                 separator(Action51)
//                 {
//                     Caption = 'setup finance';
//                 }
//                 action(receipttype)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'receipt type';
//                     Image = ServiceSetup;
//                     RunObject = Page "Receipt Types";
//                     ToolTip = 'Executes the receipt type action.';
//                 }
//                 action(Action49)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Transactions';
//                     RunObject = Report "pr Transactions";
//                     ToolTip = 'Executes the Transactions action.';
//                 }
//                 action(Action48)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'bank Schedule';
//                     RunObject = Report "pr Bank Schedule";
//                     ToolTip = 'Executes the bank Schedule action.';
//                 }
//                 separator(Action43)
//                 {
//                 }
//                 action(PayeScheule)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Paye Scheule';
//                     RunObject = Report "prPaye Schedule mst";
//                     ToolTip = 'Executes the Paye Scheule action.';
//                 }
//                 action(P10)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'P.10';
//                     RunObject = Report "P.10 A mst";
//                     ToolTip = 'Executes the P.10 action.';
//                 }
//                 action(NSSF)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'NSSF';
//                     Image = Replan;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     RunObject = Report "prNSSF mst";
//                     ToolTip = 'Executes the NSSF action.';
//                 }
//                 action(PAYE)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'PAYE';
//                     Image = Reconcile;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     RunObject = Report "prPaye Schedule mst";
//                     ToolTip = 'Executes the PAYE action.';
//                 }
//                 action(NHIF)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'NHIF';
//                     Image = RefreshText;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     RunObject = Report "prNHIF mst";
//                     ToolTip = 'Executes the NHIF action.';
//                 }
//             }
//             group(Fixed_Reports)
//             {
//                 Caption = 'Fixed Reports';
//                 separator(Action18)
//                 {
//                     Caption = 'Fixed Assets';
//                 }
//                 action(FixedAssetsList)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Fixed Assets List';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - List";
//                     ToolTip = 'Executes the Fixed Assets List action.';
//                 }
//                 action(AcquisitionList)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Acquisition List';
//                     Image = "Report";
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Acquisition List";
//                     ToolTip = 'Executes the Acquisition List action.';
//                 }
//                 action(Details)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Details';
//                     Image = View;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Details";
//                     ToolTip = 'Executes the Details action.';
//                 }
//                 action(BookValue01)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Book Value 01';
//                     Image = "Report";
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Book Value 01";
//                     ToolTip = 'Executes the Book Value 01 action.';
//                 }
//                 action(BookValue02)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Book Value 02';
//                     Image = "Report";
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Book Value 02";
//                     ToolTip = 'Executes the Book Value 02 action.';
//                 }
//                 action(Analysis)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Analysis';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Analysis";
//                     ToolTip = 'Executes the Analysis action.';
//                 }
//                 action(ProjectedValue)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Projected Value';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - Projected Value";
//                     ToolTip = 'Executes the Projected Value action.';
//                 }
//                 action(GLAnalysis)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'G/L Analysis';
//                     Image = "Report";
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset - G/L Analysis";
//                     ToolTip = 'Executes the G/L Analysis action.';
//                 }
//                 action(Register)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Report "Fixed Asset Register";
//                     ToolTip = 'Executes the Register action.';
//                 }
//             }
//         }
//         area(sections)
//         {
//             group(Approvals)
//             {
//                 Caption = 'Verification';
//                 Image = Alerts;
//                 action(PendingMyApproval)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Pending My Approval';
//                     RunObject = Page "Approval Entries";
//                     ToolTip = 'Executes the Pending My Approval action.';
//                 }
//                 action(MyApprovalrequests)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'My Approval requests';
//                     RunObject = Page "Approval Request Entries";
//                     ToolTip = 'Executes the My Approval requests action.';
//                 }
//             }
//             group(Common_req)
//             {
//                 Caption = 'Common Requisitions';
//                 Image = LotInfo;
//                 action(StoresRequisitions)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Stores Requisitions';
//                     RunObject = Page "Store Requisition";
//                     ToolTip = 'Executes the Stores Requisitions action.';
//                 }
//                 action(ImprestRequisitions)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Imprest Requisitions';
//                     RunObject = Page "Imprest List UP";
//                     ToolTip = 'Executes the Imprest Requisitions action.';
//                 }
//                 action(LeaveApplications)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Leave Applications';
//                     RunObject = Page "HR Leave Requisition List";
//                     ToolTip = 'Executes the Leave Applications action.';
//                 }
//                 action(MyApprovedLeaves)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'My Approved Leaves';
//                     Image = History;
//                     RunObject = Page "Hr My Approved Leaves List";
//                     ToolTip = 'Executes the My Approved Leaves action.';
//                 }
//             }
//             group(PostedDocuments)
//             {
//                 Caption = 'Posted Documents';
//                 separator(Action36)
//                 {
//                     Caption = 'LPOs';
//                 }
//                 action(PostedPurchaseReceipts)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Purchase Receipts';
//                     RunObject = Page "Posted Purchase Receipts";
//                     ToolTip = 'Executes the Posted Purchase Receipts action.';
//                 }
//                 action(PostedPurchaseInvoices)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Purchase Invoices';
//                     RunObject = Page "Posted Purchase Invoices";
//                     ToolTip = 'Executes the Posted Purchase Invoices action.';
//                 }
//                 action(PostedReturnShipments)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Return Shipments';
//                     RunObject = Page "Posted Return Shipments";
//                     ToolTip = 'Executes the Posted Return Shipments action.';
//                 }
//                 action(PostedPurchaseCreditMemos)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Purchase Credit Memos';
//                     RunObject = Page "Posted Purchase Credit Memos";
//                     ToolTip = 'Executes the Posted Purchase Credit Memos action.';
//                 }
//                 action(PostedAssemblyOrders)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Assembly Orders';
//                     RunObject = Page "Posted Assembly Orders";
//                     ToolTip = 'Executes the Posted Assembly Orders action.';
//                 }
//                 separator(Action42)
//                 {
//                     Caption = 'Finance';
//                 }
//                 action(Store_Req)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Stores Requisitions';
//                     RunObject = Page "Posted Store Requisitions";
//                     ToolTip = 'Executes the Stores Requisitions action.';
//                 }
//                 action(_Int_bank_trans)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Interbank transfers';
//                     ToolTip = 'Executes the Posted Interbank transfers action.';
//                 }
//                 action("Cancelled inter_Bank")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Receipts';
//                     RunObject = Page "Posted Receipt UP";
//                     ToolTip = 'Executes the Posted Receipts action.';
//                 }
//                 action(Posted_PVss)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Payment Vouchers';
//                     RunObject = Page "Posted Payment Vouchers";
//                     ToolTip = 'Executes the Posted Payment Vouchers action.';
//                 }
//             }
//         }
//     }
// }
