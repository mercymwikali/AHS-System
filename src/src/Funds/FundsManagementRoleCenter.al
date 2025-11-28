page 52202999 "Funds Management Role Center"
{
    Caption = 'Role Center- Funds Management';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control60; "Headline RC General Mgt.")
                {
                    ApplicationArea = RelationshipMgmt;
                }
                part(Control1902304208; "Funds Management Activities")
                {
                    ApplicationArea = all;
                }
                part(Control99; "Finance Performance")
                {
                    ApplicationArea = all;
                    // Visible = false;
                }
                systempart(Control1901420308; Outlook)
                {
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part("My Approval Entries"; "Requests to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval Entries';
                }
                part(Control106; "My Job Queue")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(PatientBilling)
                {
                    action(InsuranceSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Insurance Summary';
                        Image = "Report";
                        RunObject = Report "Posted Sales Invoice Summary";
                        ToolTip = 'Run Posted Sales Invoice Summary Report';
                    }

                    action("Billing Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "Outpatient Bill Summary";
                        ToolTip = 'Executes the Patients Visits Summary action.';
                    }

                    action("IP Billing Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "IP Bill Wise Detailed Revenue";
                        ToolTip = 'This Report Shows IP Bill Wise Detailed Revenue per discharge date.';
                    }
                }
                action("&G/L Trial Balance")
                {
                    ApplicationArea = all;
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'Executes the &G/L Trial Balance action.';
                }
                action("&Bank Detail Trial Balance")
                {
                    ApplicationArea = all;
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'Executes the &Bank Detail Trial Balance action.';
                }
                action("&Bank Account Recon")
                {
                    ApplicationArea = all;
                    Caption = '&Bank Account Recon';
                    Image = "Report";
                    RunObject = Report "Bank Acc. Recon. - Test2";
                    ToolTip = 'Executes the &Bank Account Recon action.';
                }
                action("&Bank Account Recon Posted")
                {
                    ApplicationArea = all;
                    Caption = '&Bank Account Recon Posted';
                    Image = "Report";
                    RunObject = Report "Bank Acc. Recon. -Posted1";
                    ToolTip = 'Executes the &Bank Account Recon Posted action.';
                }
                action("Vote Book Balance")
                {
                    ApplicationArea = all;
                    Caption = 'Vote Book Balance';
                    RunObject = Report "Vote Book Balance";
                    ToolTip = 'Executes the Vote Book Balance action.';
                }
                action("Commitments Report")
                {
                    ApplicationArea = all;
                    Caption = 'Commitments Report';
                    RunObject = Report "Commitments Report";
                    ToolTip = 'Executes the Commitments Report action.';
                }
                action("&Account Schedule")
                {
                    ApplicationArea = all;
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    ToolTip = 'Executes the &Account Schedule action.';
                }
                action("Bu&dget")
                {
                    ApplicationArea = all;
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    ToolTip = 'Executes the Bu&dget action.';
                }
                action("Trial Bala&nce/Budget")
                {
                    ApplicationArea = all;
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'Executes the Trial Bala&nce/Budget action.';
                }
                action("Trial Balance by &Period")
                {
                    ApplicationArea = all;
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Executes the Trial Balance by &Period action.';
                }
                action("Trial Balance 2")
                {
                    ApplicationArea = all;
                    Caption = 'Trial Balance 2';
                    Image = "Report";
                    RunObject = Report "Trial Balance2";
                    ToolTip = 'Executes the Trial Balance 2 action.';
                }
                action("Trial Balance 3")
                {
                    ApplicationArea = all;
                    Caption = 'Trial Balance 3';
                    Image = "Report";
                    RunObject = Report "Trial Balance3";
                    ToolTip = 'Executes the Trial Balance 3 action.';
                }
                action("&Fiscal Year Balance")
                {
                    ApplicationArea = all;
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'Executes the &Fiscal Year Balance action.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    ApplicationArea = all;
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'Executes the Balance Comp. - Prev. Y&ear action.';
                }
                action(Action2)
                {
                    ApplicationArea = all;
                    Caption = 'Vote Book Balance';
                    RunObject = Report "Vote Book Balance";
                    ToolTip = 'Executes the Vote Book Balance action.';
                }
                action("&Closing Trial Balance")
                {
                    ApplicationArea = all;
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'Executes the &Closing Trial Balance action.';
                }
                separator(Separator49)
                {
                }
                action("Cash Flow Date List")
                {
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    ToolTip = 'Executes the Cash Flow Date List action.';
                }
                separator(Separator115)
                {
                }
                action("Aged Accounts &Receivable")
                {
                    ApplicationArea = all;
                    Caption = 'Aged Accounts &Receivable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    ToolTip = 'Executes the Aged Accounts &Receivable action.';
                }
                action("Aged Accounts Pa&yable")
                {
                    ApplicationArea = all;
                    Caption = 'Aged Accounts Pa&yable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ToolTip = 'Executes the Aged Accounts Pa&yable action.';
                }
                action("Reconcile Cus&t. and Vend. Accs")
                {
                    Caption = 'Reconcile Cus&t. and Vend. Accs';
                    Image = "Report";
                    RunObject = Report "Reconcile Cust. and Vend. Accs";
                    ToolTip = 'Executes the Reconcile Cus&t. and Vend. Accs action.';
                }
                separator(Separator53)
                {
                }
                action("&VAT Registration No. Check")
                {
                    Caption = '&VAT Registration No. Check';
                    Image = "Report";
                    RunObject = Report "VAT Registration No. Check";
                    ToolTip = 'Executes the &VAT Registration No. Check action.';
                }
                action("VAT E&xceptions")
                {
                    Caption = 'VAT E&xceptions';
                    Image = "Report";
                    RunObject = Report "VAT Exceptions";
                    ToolTip = 'Executes the VAT E&xceptions action.';
                }
                action("VAT &Statement")
                {
                    Caption = 'VAT &Statement';
                    Image = "Report";
                    RunObject = Report "VAT Statement";
                    ToolTip = 'Executes the VAT &Statement action.';
                }
                action("VAT - VIES Declaration Tax Aut&h")
                {
                    Caption = 'VAT - VIES Declaration Tax Aut&h';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Tax Auth";
                    ToolTip = 'Executes the VAT - VIES Declaration Tax Aut&h action.';
                }
                action("VAT - VIES Declaration Dis&k")
                {
                    Caption = 'VAT - VIES Declaration Dis&k';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Disk";
                    ToolTip = 'Executes the VAT - VIES Declaration Dis&k action.';
                }
                action("EC Sales &List")
                {
                    Caption = 'EC Sales &List';
                    Image = "Report";
                    RunObject = Report "EC Sales List";
                    ToolTip = 'Executes the EC Sales &List action.';
                }
                separator(Separator60)
                {
                }
                action("&Intrastat - Checklist")
                {
                    Caption = '&Intrastat - Checklist';
                    Image = "Report";
                  //  RunObject = Report "Intrastat - Checklist";
                    ToolTip = 'Executes the &Intrastat - Checklist action.';
                }
                action("Intrastat - For&m")
                {
                    Caption = 'Intrastat - For&m';
                    Image = "Report";
                   // RunObject = Report "Intrastat - Form";
                    ToolTip = 'Executes the Intrastat - For&m action.';
                }
                separator(Separator4)
                {
                }
                action("Cost Accounting P/L Statement")
                {
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    ToolTip = 'Executes the Cost Accounting P/L Statement action.';
                }
                action("CA P/L Statement per Period")
                {
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";
                    ToolTip = 'Executes the CA P/L Statement per Period action.';
                }
                action("CA P/L Statement with Budget")
                {
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'Executes the CA P/L Statement with Budget action.';
                }
                action("Cost Accounting Analysis")
                {
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'Executes the Cost Accounting Analysis action.';
                }
                group(ReceiptsReports)
                {
                    caption = 'Receipts Reports';
                    action("Receiptsshiftreport")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts shift report';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type";
                        ToolTip = 'Executes the Receipts shift report action.';
                    }
                    action("ReceiptsSummary")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Summary";
                        ToolTip = 'Executes the Receipts Summary action.';
                    }
                    action("RevenueSummary")
                    {
                        ApplicationArea = all;
                        Caption = 'Revenue Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type2";
                        ToolTip = 'Executes the Revenue Summary action.';
                    }
                    action("ReceiptsReportCombined")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts Report Combined';
                        Image = "Report";
                        RunObject = Report "Receipts Unscattered";
                        ToolTip = 'Executes the Receipts Report Combined action.';
                    }
                    action("Insurance Summary")
                    {
                        ApplicationArea = all;
                        Caption = 'Insurance Summary';
                        Image = "Report";
                        RunObject = Report "HMS Insurance Summary";
                        ToolTip = 'Executes the Insurance Summary action.';
                    }
                    action("Insurance Summary2")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer Credit Sales';
                        Image = "Report";
                        RunObject = Report "HMS Customer Credit Sales";
                        ToolTip = 'Executes the Customer Credit Sales action.';
                    }
                    action("Receipt Summary2")
                    {
                        ApplicationArea = all;
                        Caption = 'Flash Revenue';
                        Image = "Report";
                        RunObject = Report "Flash Revenue";
                        ToolTip = 'Executes the Flash Revenue action.';
                    }
                }
                group(SummaryReports)
                {
                    action(OPBillSummaryReport)
                    {
                        ApplicationArea = all;
                        Caption = 'OP Billing Report Summary';
                        Image = "Report";
                        RunObject = Report "IP Bill Wise Detailed Revenue";
                        ToolTip = 'Executes the Op Billing Report Summary action.';
                    }
                }
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;

                action("Purchase Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the Purchase Journals action.';
                }
                action("Sales Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the Sales Journals action.';
                }
                action("Cash Receipt Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the Cash Receipt Journals action.';
                }
                action("Payment Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the Payment Journals action.';
                }
                action("IC General Journals")
                {
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Intercompany),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the IC General Journals action.';
                }
                action("General Journals")
                {
                    ApplicationArea = all;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the General Journals action.';
                }
                action("Intrastat Journals")
                {
                    Caption = 'Intrastat Journals';
                    Image = "Report";
                    RunObject = Page "Buffer Table";
                    ToolTip = 'Executes the Intrastat Journals action.';
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;

                action(Action17)
                {
                    ApplicationArea = all;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Executes the Fixed Assets action.';
                }
                action(Insurance)
                {
                    ApplicationArea = all;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Executes the Insurance action.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Executes the Fixed Assets G/L Journals action.';
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Executes the Fixed Assets Journals action.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Executes the Fixed Assets Reclass. Journals action.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Executes the Insurance Journals action.';
                }
                action("<Action3>")
                {
                    ApplicationArea = all;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Executes the Recurring General Journals action.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Executes the Recurring Fixed Asset Journals action.';
                }
            }
            group(DoctorPayment)
            {
                Caption = 'Doctors Payment';
                action("Students List")
                {
                    ApplicationArea = all;
                    Caption = 'Doctors';
                    Image = Invoice;
                    Promoted = true;
                    RunObject = Page "Vendor List2";
                    ToolTip = 'Executes the Doctors action.';
                }
                action(DocPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Payment List';
                    Image = ImportExport;
                    RunObject = page "HMS Patient Visits";
                    ToolTip = 'Executes the Doctors Payment List action.';
                }
                action(DocBatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors payment Batch';
                    Image = Bins;
                    RunObject = Page "HMS Doctors Payment Batch List";
                    ToolTip = 'Executes the Doctors payment Batch action.';
                }
                action(DocInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate Doctors Invoice';
                    Image = PostedReceipt;
                    Promoted = true;
                    RunObject = report "HMS Generate Patient Visits";
                    ToolTip = 'Executes the Generate Doctors Invoice action.';
                }
                action(DocSummary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Invoices Summary';
                    Image = "Report";
                    RunObject = Report "HMS Doctors Payments";
                    ToolTip = 'Executes the Doctors Invoices Summary action.';
                }
                action(DocPaySumm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Charges Summary';
                    Image = Report2;
                    Promoted = true;
                    RunObject = Report "Doctors Charges Summary";
                    ToolTip = 'Executes the Doctors Charges Summary action.';
                }
                action(DocPaySumm2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Transactions';
                    Image = Report2;
                    Promoted = true;
                    RunObject = Report "HMS Transactions Per Doctor";
                    ToolTip = 'Executes the Doctors Transactions action.';
                }
                action(DocPayCharges)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Charges Transactions';
                    Image = Report2;
                    Promoted = true;
                    RunObject = Report "HMS Doctor Charges";
                    ToolTip = 'Executes the Doctors Charges Transactions action.';
                }
                action(DocTransac)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate Doctors Transactions';
                    Image = PostedReceipt;
                    Promoted = true;
                    RunObject = report "HMS Generate Patient Visit";
                    Visible = false;
                    ToolTip = 'Executes the Generate Doctors Transactions action.';
                }
            }

            group(FinanceOperation)
            {
                Caption = 'Finance Operations';

                action("InterBank Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'InterBank Transfer';
                    RunObject = Page "Interbank Transfer";
                    ToolTip = 'Executes the InterBank Transfer action.';
                }
                action("Vote Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Vote Transfer';
                    RunObject = Page "Vote Transfer List";
                    ToolTip = 'Executes the Vote Transfer action.';
                }
                action("Payment Voucher")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Voucher';
                    Image = VendorPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Payment Vouchers";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Payment Voucher action.';
                }
                action("Payment Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Schedule';
                    Image = VendorPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Payment Schedule List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Payment Schedule action.';
                }
                action(ActiveCashpat)
                {
                    ApplicationArea = all;
                    Caption = 'Pending Cash Patients';
                    Image = ReceivableBill;
                    Promoted = true;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "HMS Cash Active Patients";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Pending Cash Patients action.';
                }
                action(Receipts)
                {
                    ApplicationArea = all;
                    Caption = 'Receipts';
                    Image = ReceivableBill;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Receipts List";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Receipts action.';
                }
                action("Petty Cash Payment")
                {
                    ApplicationArea = all;
                    Caption = 'Petty Cash Payment';
                    Image = Payment;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Petty Cash";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Petty Cash Payment action.';
                }
                action("Petty Cash Replenishment")
                {
                    ApplicationArea = all;
                    Caption = 'Petty Cash Replenishment';
                    Image = Payment;
                    Promoted = false;
                    RunObject = Page "Petty Cash Replenishment List";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the Petty Cash Replenishment action.';
                }
                action("Travel Advance")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Imprest';
                    Image = Travel;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Travel Advance Vouchers List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Staff Imprest action.';
                }
                action("Travel Advance Accounting")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Imprest Accounting';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Travel Advances Acct. List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Staff Imprest Accounting action.';
                }
                action("Staff Claims")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Claims';
                    Image = InsertTravelFee;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Staff Claim List";
                    RunPageMode = Create;
                    RunPageView = WHERE(Status = FILTER(Pending | "Pending Approval" | Approved));
                    ToolTip = 'Executes the Staff Claims action.';
                }
                action("Other Advance Requests")
                {
                    ApplicationArea = all;
                    Caption = 'Other Advance Requests';
                    Image = VendorBill;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Staff Advance Request List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Other Advance Requests action.';
                }
                action("Other Advance Accounting")
                {
                    ApplicationArea = all;
                    Caption = 'Other Advance Accounting';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Staff Advance Surrender List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Other Advance Accounting action.';
                }
                action("Item Cash")
                {
                    ApplicationArea = all;
                    Caption = 'Item Cash';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item/Cash List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Item Cash action.';
                }
                action("Item Cash Surrender")
                {
                    ApplicationArea = all;
                    Caption = 'Item Cash Surrender';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item/Cash Accounting";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Item Cash Surrender action.';
                }
                action("Unsynched Patient Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Unsynched Patient Invoices';
                    Image = Reconcile;
                    RunObject = Page "Unsynced Visits Invoices";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Unsynched Patient Invoices action.';
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';

                action("Cash Flow Forecasts")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Executes the Cash Flow Forecasts action.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = all;
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'Executes the Chart of Cash Flow Accounts action.';
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Executes the Cash Flow Manual Revenues action.';
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Executes the Cash Flow Manual Expenses action.';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Types")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Types';
                    RunObject = Page "Chart of Cost Types";
                    ToolTip = 'Executes the Cost Types action.';
                }
                action("Cost Centers")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Centers';
                    RunObject = Page "Chart of Cost Centers";
                    ToolTip = 'Executes the Cost Centers action.';
                }
                action("Cost Objects")
                {
                    Caption = 'Cost Objects';
                    RunObject = Page "Chart of Cost Objects";
                    ToolTip = 'Executes the Cost Objects action.';
                }
                action("Cost Allocations")
                {
                    Caption = 'Cost Allocations';
                    RunObject = Page "Cost Allocation Sources";
                    ToolTip = 'Executes the Cost Allocations action.';
                }
                action("Cost Budgets")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Budgets';
                    RunObject = Page "Cost Budget Names";
                    ToolTip = 'Executes the Cost Budgets action.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices.";
                    ToolTip = 'Executes the Posted Sales Invoices action.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Executes the Posted Sales Credit Memos action.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Executes the Posted Purchase Invoices action.';
                }
                action("Posted InterBank Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Posted InterBank Transfer';
                    RunObject = Page "Posted Interbank Transfer List";
                    ToolTip = 'Executes the Posted InterBank Transfer action.';
                }
                action("Posted Payment Voucher")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Payment Voucher';
                    Image = VendorPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Payment Vouchers";
                    RunPageMode = Create;
                    RunPageView = WHERE(Status = FILTER(Posted),
                                        Posted = FILTER(true),
                                        "Payment Type" = CONST(Normal));
                    ToolTip = 'Executes the Posted Payment Voucher action.';
                }
                action("Posted Receipts")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Receipts';
                    Image = ReceivableBill;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Receipts";
                    RunPageMode = Edit;
                    RunPageView = WHERE(Posted = FILTER(true));
                    ToolTip = 'Executes the Posted Receipts action.';
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Petty Cash';
                    Image = Payment;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Payment Vouchers";
                    RunPageMode = Create;
                    RunPageView = WHERE(Status = FILTER(Posted),
                                        Posted = FILTER(true),
                                        "Payment Type" = CONST("Petty Cash"));
                    ToolTip = 'Executes the Posted Petty Cash action.';
                }
                action("Posted Staff Travel Advance")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Staff Imprest';
                    Image = Travel;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted imprest list";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Posted Staff Imprest action.';
                }
                action("Posted Staff Travel Advance Accounting")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Staff Imprest Accounting';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Travel Advs. Accounting";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Posted Staff Imprest Accounting action.';
                }
                action("Posted Staff Claims")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Staff Claims';
                    Image = InsertTravelFee;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Staff Claim List";
                    RunPageMode = Create;
                    RunPageView = WHERE(Status = FILTER(Posted));
                    ToolTip = 'Executes the Posted Staff Claims action.';
                }
                action("Posted Other Advance Requests")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Other Advance Requests';
                    Image = VendorBill;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted Staff Claim List";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Posted Other Advance Requests action.';
                }
                action("Posted Other Advance Accounting")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Other Advance Accounting';
                    Image = Reconcile;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Posted staf Advance Surrenders";
                    RunPageMode = Create;
                    ToolTip = 'Executes the Posted Other Advance Accounting action.';
                }
                action("Posted Store Requisition")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Store Requisition';
                    RunObject = Page "Posted Store Requisitions";
                    ToolTip = 'Executes the Posted Store Requisition action.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Executes the Posted Purchase Credit Memos action.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = all;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'Executes the Issued Reminders action.';
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'Executes the Issued Fin. Charge Memos action.';
                }
                action("G/L Registers")
                {
                    ApplicationArea = all;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'Executes the G/L Registers action.';
                }
                action("Cost Accounting Registers")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                    ToolTip = 'Executes the Cost Accounting Registers action.';
                }
                action("Cost Accounting Budget Registers")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
                    ToolTip = 'Executes the Cost Accounting Budget Registers action.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;

                action(Currencies)
                {
                    ApplicationArea = all;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ToolTip = 'Executes the Currencies action.';
                }
                action("Accounting Periods")
                {
                    ApplicationArea = all;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Executes the Accounting Periods action.';
                }
                action("Number Series")
                {
                    ApplicationArea = all;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'Executes the Number Series action.';
                }
                action("Analysis Views")
                {
                    ApplicationArea = all;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Executes the Analysis Views action.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = all;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Executes the Account Schedules action.';
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                    ToolTip = 'Executes the Dimensions action.';
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Executes the Bank Account Posting Groups action.';
                }
                action(CashOfficeSetup)
                {
                    ApplicationArea = all;
                    Caption = 'Cash Office Setup';
                    RunObject = Page "Cash Office Setup UP";
                    ToolTip = 'Executes the Cash Office Setup action.';
                }
                action("Cash Office User Template")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Office User Template';
                    RunObject = Page "Cash Office User Template UP";
                    ToolTip = 'Executes the Cash Office User Template action.';
                }
                action("Budgetary Control Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Budgetary Control Setup';
                    RunObject = Page "Budgetary Control Setup";
                    ToolTip = 'Executes the Budgetary Control Setup action.';
                }
                action("Receipt Types")
                {
                    ApplicationArea = all;
                    Caption = 'Receipt Types';
                    RunObject = Page "Receipt Types";
                    ToolTip = 'Executes the Receipt Types action.';
                }
                action("Payment Types")
                {
                    ApplicationArea = all;
                    Caption = 'Payment Types';
                    RunObject = Page "Payment Types";
                    ToolTip = 'Executes the Payment Types action.';
                }
                action("Imprest Types")
                {
                    ApplicationArea = all;
                    Caption = 'Imprest Types';
                    RunObject = Page "Imprest Types";
                    ToolTip = 'Executes the Imprest Types action.';
                }
                action("Claim Types")
                {
                    ApplicationArea = all;
                    Caption = 'Claim Types';
                    RunObject = Page "Claim Types";
                    ToolTip = 'Executes the Claim Types action.';
                }
                action("Tarriff Codes List")
                {
                    ApplicationArea = all;
                    Caption = 'Tarriff Codes';
                    RunObject = Page "Tariff Codes UP";
                    ToolTip = 'Executes the Tarriff Codes action.';
                }
                action("Expense Code UP")
                {
                    ApplicationArea = all;
                    Caption = 'Expense Code UP';
                    RunObject = Page "Expense Code UP";
                    ToolTip = 'Executes the Expense Code UP action.';
                }
                action("GL UP")
                {
                    ApplicationArea = all;
                    Caption = 'GL List';
                    RunObject = Page "GL List";
                    ToolTip = 'Executes the GL List action.';
                }
                action("PostCharges")
                {
                    ApplicationArea = all;
                    Caption = 'Post Open Charges';
                    RunObject = report "HMS Post Charges";
                    ToolTip = 'Executes the Post Open Charges action.';
                }
            }
            group(Import)
            {
                Caption = 'Importation';
                action("Imp1")
                {
                    ApplicationArea = all;
                    Caption = 'Import Chart';
                    RunObject = xmlport "Chart of Accounts";
                    ToolTip = 'Executes the Import Chart action.';
                }
                action("Imp2")
                {
                    ApplicationArea = all;
                    Caption = 'Charge Prices';
                    RunObject = xmlport "HMS Branch Charges";
                    ToolTip = 'Executes the Charge Prices action.';
                }
                action("Imp3")
                {
                    ApplicationArea = all;
                    Caption = 'Import Patient Visits';
                    RunObject = xmlport "HMS Patient Vist Nos";
                    ToolTip = 'Executes the Import Patient Visits action.';
                }
                action("Temp")
                {
                    ApplicationArea = all;
                    Caption = 'Ttansactions Buffer';
                    RunObject = page "Temp Delete";
                    ToolTip = 'Executes the Ttansactions Buffer action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;

                action("Pending My Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action("My Approval requests")
                {
                    ApplicationArea = all;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action("Staff Claim")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action("Purchase Requisition")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action("Imprest Surrender")
                {
                    ApplicationArea = all;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action("Imprest Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest List UP";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action("Leave Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = all;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts.";
                ToolTip = 'Executes the Chart of Accounts action.';
            }
            action(Vendors)
            {
                ApplicationArea = all;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List.";
                ToolTip = 'Executes the Vendors action.';
            }

            action(Budgets)
            {
                ApplicationArea = all;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                ToolTip = 'Executes the Budgets action.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = all;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'Executes the Bank Accounts action.';
            }

            action(Items)
            {
                ApplicationArea = all;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Executes the Items action.';
            }
            action(Customers)
            {
                ApplicationArea = all;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List2";
                ToolTip = 'Executes the Customers action.';
            }
            action(SalesQoute)
            {
                ApplicationArea = all;
                Caption = 'Sales Quote';
                Image = Customer;
                RunObject = Page "Sales Quotes.";
                ToolTip = 'Executes the Sales Quote action.';
            }
            action(SalesInv)
            {
                ApplicationArea = all;
                Caption = 'Sales Invoice';
                Image = Customer;
                RunObject = Page "Sales Invoice List.";
                ToolTip = 'Executes the Sales Invoice action.';
            }
            action(PurchaseQoute)
            {
                ApplicationArea = all;
                Caption = 'Purchase Quote';
                Image = Vendor;
                RunObject = Page "Purchase Quotes.";
                ToolTip = 'Executes the Purchase Quote action.';
            }
            action(PurchaseOrder)
            {
                ApplicationArea = all;
                Caption = 'Purchase Order';
                Image = Vendor;
                RunObject = Page "Purchase Order List.";
                ToolTip = 'Executes the Purchase Order action.';
            }
            action(PurchaseCreditmemo)
            {
                ApplicationArea = all;
                Caption = 'Purchase Credit memos';
                Image = Vendor;
                RunObject = Page "Purchase Credit Memos.";
                ToolTip = 'Executes the Purchase Credit memos action.';
            }
            action(PurchaseInv)
            {
                ApplicationArea = all;
                Caption = 'Purchase Invoice';
                Image = Vendor;
                RunObject = Page "Purchase Invoices.";
                ToolTip = 'Executes the Purchase Invoice action.';
            }
            action(PurchaseRec)
            {
                ApplicationArea = all;
                Caption = 'Purchase Receipts';
                Image = Vendor;
                RunObject = Page "Posted Purchase Receipts.";
                ToolTip = 'Executes the Purchase Receipts action.';
            }
            action(TransferOder)
            {
                ApplicationArea = all;
                Caption = 'Purchase Receipts';
                Image = Vendor;
                RunObject = Page "Transfer Orders.";
                ToolTip = 'Executes the Purchase Receipts action.';
            }
            action(PatientList)
            {
                ApplicationArea = all;
                Caption = 'Patient List';
                Image = Users;
                RunObject = Page "HMS Patient List2";
                ToolTip = 'Executes the Patient Lists action.';
            }
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';

                action("Cas&h Receipt Journal")
                {
                    ApplicationArea = all;
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Executes the Cas&h Receipt Journal action.';
                }
                action("Pa&yment Journal")
                {
                    ApplicationArea = all;
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Executes the Pa&yment Journal action.';
                }
                separator(Separator67)
                {
                }
                action("Analysis &View")
                {
                    ApplicationArea = all;
                    Caption = 'Analysis &View';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View Card";
                    ToolTip = 'Executes the Analysis &View action.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = all;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Executes the Analysis by &Dimensions action.';
                }
                action("Bank Account R&econciliation")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'Executes the Bank Account R&econciliation action.';
                }
                action("Adjust E&xchange Rates")
                {
                    ApplicationArea = all;
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                   // RunObject = Report "Adjust Exchange Rates";
                    ToolTip = 'Executes the Adjust E&xchange Rates action.';
                }
            }
            group(Admininistration)
            {
                Caption = 'Administration';
                //IsHeader = true;

                action("General &Ledger Setup")
                {
                    ApplicationArea = all;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Executes the General &Ledger Setup action.';
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = all;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Executes the &Sales && Receivables Setup action.';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = all;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Executes the &Purchases && Payables Setup action.';
                }
                action("Cash Office Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Office Setup';
                    Image = Setup;
                    RunObject = Page "Cash Office Setup UP";
                    ToolTip = 'Executes the Cash Office Setup action.';
                }
                action("Cash Office Templates")
                {
                    ApplicationArea = all;
                    Caption = 'Cash Office Templates';
                    Image = Setup;
                    RunObject = Page "Cash Office User Template UP";
                    ToolTip = 'Executes the Cash Office Templates action.';
                }
            }
            group(History)
            {
                Caption = 'History';
                //  IsHeader = true;

                action("Navi&gate")
                {
                    ApplicationArea = all;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Executes the Navi&gate action.';
                }
            }
        }
    }
}
