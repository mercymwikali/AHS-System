page 85284 "CEO Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'CEO', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control15; "Ceo Cue")
            {
                ApplicationArea = Basic, Suite;
            }
            part(BreakdownByDoctor; "Doctor Clinical Reports")
            {
                ApplicationArea = All;
                Editable = false;
                // SubPageLink = "Discharge Date Filter" = field("Discharge Date Filter"), "IP Date Filter" = field("Date Filter"), "Date Filter" = field(Date);
                SubPageView = where(Resident = filter(true));
            }
            part(BreakDownByInsurance; "Daily Clinical Report Ins.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Caption = '';
            }
            part(Control56; "Product Video Topics")
            {
                ApplicationArea = All;
            }
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts';
            }
            part(Control9; "Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
            // part(Control98; "Power BI Report Spinner Part")
            // {
            //     AccessByPermission = TableData "Power BI User Configuration" = I;
            //     ApplicationArea = Basic, Suite;
            // }
            part(Control96; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Suite;
            }
            // part(" "; "O365 Link to Financials")
            // {
            //     ApplicationArea = Invoicing;
            //     Caption = ' ';
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Sales Quote")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                Image = NewSalesQuote;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
            action("Sales Order")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                Image = NewOrder;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services.';
            }
            action("Sales Invoice")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Purchase Quote")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Quote';
                Image = NewSalesQuote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote.';
            }
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoice';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a purchase invoice to mirror a sales document sent by a vendor.';
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Customer)
                {
                    AccessByPermission = TableData Customer = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new customer.';
                }
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Imported Payments';
                    Image = ApplyEntries;
                    RunObject = Codeunit "Pmt. Rec. Journals Launcher";
                    ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
                }
                action("Import Bank Transactions")
                {
                    AccessByPermission = TableData "Bank Export/Import Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Bank Transactions...';
                    Image = Import;
                    RunObject = Codeunit "Pmt. Rec. Jnl. Import Trans.";
                    ToolTip = 'To start the process of reconciling new payments, import a bank feed or electronic file containing the related bank transactions.';
                }
                action("Register Customer Payments")
                {
                    AccessByPermission = TableData "Payment Registration Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments';
                    Image = Payment;
                    RunObject = Page "Payment Registration";
                    ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
                }
                action("Create Vendor Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Vendor Payments';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = WHERE("Document Type" = FILTER(Invoice),
                                        "Remaining Amount" = FILTER(< 0),
                                        "Applies-to ID" = FILTER(''));
                    ToolTip = 'Opens vendor ledger entries for all vendors with invoices that have not been paid yet.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Account Schedule";
                        ToolTip = 'View your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                    action("Sales Taxes Collected")
                    {
                        ApplicationArea = SalesTax;
                        Caption = 'Sales Taxes Collected';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Sales Taxes Collected";
                        ToolTip = 'View a report that shows the sales taxes that have been collected on behalf of the authorities.';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                action("Company Settings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                group("Services & Extensions")
                {
                    Caption = 'Services & Extensions';
                    Image = ServiceSetup;
                    action(Extensions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Extensions';
                        Image = NonStockItemSetup;
                        RunObject = Page "Extension Management";
                        ToolTip = 'Install Extensions for greater functionality of the system.';
                    }
                    action("Service Connections")
                    {
                        ApplicationArea = Service;
                        Caption = 'Service Connections';
                        Image = ServiceTasks;
                        RunObject = Page "Service Connections";
                        ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    }
                }
            }
            group(Admissions)
            {
                Caption = 'Admissions';
                Image = Payables;
                action(AdmReq)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Form Header List";
                    ToolTip = 'Executes the Admission Requests action.';
                }
                action(AdmProg)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Process';
                    Image = FixedAssetLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Admission Progress";
                    ToolTip = 'Executes the Admission Process action.';
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                Image = Confirm;
                action(RefHosp)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referral Hospitals';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Card";
                    ToolTip = 'Executes the Referral Hospitals action.';
                }
                action(ActiveRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header Active";
                    ToolTip = 'Executes the Active Referrals action.';
                }
                action(hitRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Released";
                    ToolTip = 'Executes the Completed Referrals action.';
                }
            }
            group(Immunizations)
            {
                Caption = 'Immunizations';
                Image = SNInfo;
                action(Immunization)
                {
                    ApplicationArea = Basic, Suite;
                    Image = NewOrder;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Header";
                    ToolTip = 'Executes the Immunization action.';
                }
                action(ImmHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                    ToolTip = 'Executes the Immunization History action.';
                }
            }
            group(HMISReports)
            {
                Caption = 'HMIS Reports';
                Image = SNInfo;
                group(ReceiptsReports)
                {
                    caption = 'Receipts Reports';
                    action("Receiptsshiftsplitreport")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts shift report-split';
                        Image = "Report";
                        RunObject = Report "HMS Shift Report";
                        ToolTip = 'Executes the Receipts shift report-split action.';
                    }
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
                }
                group(BillingReport)
                {
                    Caption = 'Billing Reports';
                    action("Patients Visits Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "HMS Visit Summary";
                        ToolTip = 'Executes the Patients Visits Summary action.';
                    }
                    action("Billing Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "Outpatient Bill Summary";
                        ToolTip = 'This Report Shows Out Patients Bill Summary per date.';
                    }
                    action("IP Billing Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "IP Bill Wise Detailed Revenue";
                        ToolTip = 'This Report Shows IP Bill Wise Detailed Revenue per discharge date.';
                    }
                    action("HMS Insurance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insuarance Summary';
                        Image = Receipt;
                        RunObject = Report "HMS Insurance Summary";
                        ToolTip = 'Executes the Insuarance Summary action.';
                    }
                    action("HMS Charges Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charges Prices';
                        Image = Receipt;
                        RunObject = Report "HMS Charges Prices";
                        ToolTip = 'Executes the Charges Prices action.';
                    }
                    action("HMS Insurance Rates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Consultation Rates';
                        Image = Receipt;
                        RunObject = Report "HMS Insurance Rates";
                        ToolTip = 'Executes the Insurance Consultation Rates action.';
                    }
                }
                group(HMSReports)
                {
                    Caption = 'HMS Reports';
                    action(AppUser)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments Per user';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Visits Per User";
                        ToolTip = 'Executes the Appointments Per user action.';
                    }
                    action(ConsUser)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Service Per Doctor';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Service Per Doctor";
                        ToolTip = 'Executes the Service Per Doctor action.';
                    }
                    action(DocRev)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Revenue Per Doctor';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Revenue Per Doctor";
                        ToolTip = 'Executes the Revenue Per Doctor action.';
                    }
                    action(App)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action(Observ)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Observations';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Observation Listing Report";
                        ToolTip = 'Executes the Observations action.';
                    }
                    action("Patients Invoices Reports 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of account';
                        RunObject = Report "HMs Invoice Statements";
                        ToolTip = 'Executes the Statement of account action.';
                    }
                    action(treatment)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treatments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Treatment Listing Report";
                        ToolTip = 'Executes the Treatments action.';
                    }
                    action(labtest1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Tests Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Summary";
                        ToolTip = 'Executes the Lab Tests Summary action.';
                    }
                    action(labtest2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Tests Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Detailed";
                        ToolTip = 'Executes the Lab Tests Detailed action.';
                    }
                    action(labtest3)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab tests Findings';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Finding";
                        ToolTip = 'Executes the Lab tests Findings action.';
                    }
                    action(PatList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Patient listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Patient Listing Report";
                        ToolTip = 'Executes the Patient listing action.';
                    }
                    action(Admission_List)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Admission listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Admission Listing Summary";
                        ToolTip = 'Executes the Admission listing action.';
                    }
                    action(Ref_list)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Referrals Listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Referral Listing Report";
                        ToolTip = 'Executes the Referrals Listing action.';
                    }
                    action(Daily_Att_OutPat)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Attendance (Outpatient)';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Daily Attendance Report";
                        ToolTip = 'Executes the Daily Attendance (Outpatient) action.';
                    }
                    action(Inj_Reg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Injection Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Injection Register Report";
                        ToolTip = 'Executes the Injection Register action.';
                    }
                    action(Proc_Emp_and_Deps)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Process Employee & Deps";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action("Monthly patients record")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Total Monthly operation';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Monthly Totals";
                        ToolTip = 'Executes the Appointments action.';
                    }
                }
            }
        }
        area(reporting)
        {

            group(Lab1)
            {
                caption = 'Lab Reports';
                action(labtest10)
                {
                    ApplicationArea = Basic;
                    Caption = 'Lab Tests Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "HMS Laboratory Test Summary";
                }
                action(labtest11)
                {
                    ApplicationArea = Basic;
                    Caption = 'Lab Tests Detailed';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "HMS Laboratory Test Detailed";
                }
                action(labtest12)
                {
                    ApplicationArea = Basic;
                    Caption = 'Lab tests Findings';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "HMS Laboratory Test Finding";
                }
                action(labtest5)
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Per Insurance';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Laboratory Detailed Report2";
                }
                action(labtest6)
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "HMS Lab Tests Summary";
                }
                action(labtest7)
                {
                    ApplicationArea = Basic;
                    Caption = 'Laboratory Capitation';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Laboratory -Capitation";
                }
                action(labtest8)
                {
                    ApplicationArea = Basic;
                    Caption = 'Laboratory Insurance';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Laboratory Insurance Count";
                }
            }

            group("Excel Reports")
            {
                Caption = 'Excel Reports';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Balance Sheet";
                    ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Income Stmt.";
                    ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                    ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retained Earnings Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Retained Earn.";
                    ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                }
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Trial Balance";
                    ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Codeunit "Run Template Aged Acc. Rec.";
                    ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Insurance/Customer';
                Image = Customer;
                RunObject = Page "Customer List2";
                ToolTip = 'Executes the Insurance/Customer action.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ToolTip = 'Executes the Balance action.';
            }
            action(PatientBilling)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Active Patients';
                Image = Calculate;
                RunObject = Page "HMS Patient Billing";
                ToolTip = 'Executes the Active Patients action.';
            }
            action("Active InPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient InPatients";
                ToolTip = 'Executes the Active InPatients action.';
            }
            action("Active OutPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient OutPatients";
                ToolTip = 'Executes the Active OutPatients action.';
            }
            action("Discharge Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Progress List";
                ToolTip = 'Executes the Discharge Request action.';
            }
            action("Discharge List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Discharge List";
                ToolTip = 'Executes the Discharge List action.';
            }
            action("Invoice Dispatch")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Invoice Dispatch List";
                ToolTip = 'Executes the Invoice Dispatch action.';
            }
            action(Charges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Charges';
                Image = Reminder;
                RunObject = Page "HMS Charges";
                ToolTip = 'Executes the Charges action.';
            }
            action(FinanceChargeMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
                ToolTip = 'Executes the Finance Charge Memos action.';
            }
            action(IncomingDocuments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Executes the Incoming Documents action.';
            }
        }
        area(sections)
        {
            group(Action39)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action("G/L Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Budget Names";
                    ToolTip = 'View summary information about the amount budgeted for each general ledger account in different time periods.';
                }
                action(Action62)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action("Intrastat Journals")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'Intrastat Journals';
                    Promoted = true;
                    PromotedCategory = Process;
               //     RunObject = Page "Intrastat Jnl. Batches";
                    ToolTip = 'Summarize the value of your purchases and sales with business partners in the EU for statistical purposes and prepare to send it to the relevant authority.';
                }
                action("Sales Budgets")
                {
                    ApplicationArea = SalesBudget;
                    Caption = 'Sales Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Budget Names Sales";
                    ToolTip = 'Enter item sales values of type amount, quantity, or cost for expected item sales in different time periods. You can create sales budgets by items, customers, customer groups, or other dimensions in your business. The resulting sales budgets can be reviewed here or they can be used in comparisons with actual sales data in sales analysis reports.';
                }
                action("Purchase Budgets")
                {
                    ApplicationArea = PurchaseBudget;
                    Caption = 'Purchase Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Budget Names Purchase";
                    ToolTip = 'Enter item purchases values of type amount, quantity, or cost for expected item purchases in different time periods. You can create purchase budgets by items, vendors, vendor groups, or other dimensions in your business. The resulting purchase budgets can be reviewed here or they can be used in comparisons with actual purchases data in purchase analysis reports.';
                }
                action("Sales Analysis Reports")
                {
                    ApplicationArea = SalesAnalysis;
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page "Analysis Report Sale";
                    ToolTip = 'Analyze the dynamics of your sales according to key sales performance indicators that you select, for example, sales turnover in both amounts and quantities, contribution margin, or progress of actual sales against the budget. You can also use the report to analyze your average sales prices and evaluate the sales performance of your sales force.';
                }
                action("Purchase Analysis Reports")
                {
                    ApplicationArea = PurchaseAnalysis;
                    Caption = 'Purchase Analysis Reports';
                    RunObject = Page "Analysis Report Purchase";
                    ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
                }
                action("Inventory Analysis Reports")
                {
                    ApplicationArea = InventoryAnalysis;
                    Caption = 'Inventory Analysis Reports';
                    RunObject = Page "Analysis Report Inventory";
                    ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
                }
                action("VAT Returns")
                {
                    ApplicationArea = VAT;
                    Caption = 'VAT Returns';
                    RunObject = Page "VAT Report List";
                    ToolTip = 'Prepare the VAT Return report so you can submit VAT amounts to a tax authority.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Employees)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("VAT Statements")
                {
                    ApplicationArea = VAT;
                    Caption = 'VAT Statements';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "VAT Statement Names";
                    ToolTip = 'View a statement of posted VAT amounts, calculate your VAT settlement amount for a certain period, such as a quarter, and prepare to send the settlement to the tax authorities.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.';
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action23)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Debit Collections';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Direct Debit Collections";
                    ToolTip = 'Instruct your bank to withdraw payment amounts from your customer''s bank account and transfer them to your company''s account. A direct debit collection holds information about the customer''s bank account, the affected sales invoices, and the customer''s agreement, the so-called direct-debit mandate. From the resulting direct-debit collection entry, you can then export an XML file that you send or upload to your bank for processing.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }

            group(Registration)
            {
                action("Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = filter(Alive));
                    ToolTip = 'Executes the Patients List action.';
                }
                action("Patients List2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RIP Patients List';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = const(Dead));
                    ToolTip = 'Executes the RIP Patients List action.';
                }
            }
            group(Appointments)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(Action19)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List";
                    ToolTip = 'Executes the Appointments action.';
                }
                action(AppointmentsControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments Control';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form List";
                    ToolTip = 'Executes the Appointments Control action.';
                }
                action(AppointmentsHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form History L";
                    ToolTip = 'Executes the Appointments History action.';
                }
            }
            group("Appointment Booking")
            {
                action("Appointment Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Appointment Booking";
                    ToolTip = 'Executes the Appointment Booking List action.';
                }
            }
            group(ObsRoom)
            {
                Caption = 'Triage Room';
                Image = RegisteredDocs;
                action(Action48)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage';
                    RunObject = Page "HMS Observation List";
                    ToolTip = 'Executes the Triage action.';
                }
                action(TriageHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage History';
                    RunObject = Page "HMS Observation History List";
                    ToolTip = 'Executes the Triage History action.';
                }
            }
            group(DocVisit)
            {
                Caption = 'Consultation Room';
                Image = Journals;
                action(DocVisits)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visits';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Treatment List";
                    ToolTip = 'Executes the Doctor''s Visits action.';
                }
                action(DoctorsVisitHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Theatre)
            {
                Caption = 'Theatre';
                Image = RegisteredDocs;
                action(TheatreList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre List';
                    RunObject = Page "HMS Theatre List";
                    ToolTip = 'Executes the Theatre List action.';
                }
                action(TheatreHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre History';
                    RunObject = Page "HMS Theatre History";
                    ToolTip = 'Executes the Theatre History action.';
                }
            }
            group(ICU)
            {
                Caption = 'ICU';
                Image = RegisteredDocs;
                action(ICUList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICU List';
                    RunObject = Page "HMS ICU List";
                    ToolTip = 'Executes the ICU List action.';
                }
                action(ICUHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICU History';
                    RunObject = Page "HMS ICU History";
                    ToolTip = 'Executes the ICU History action.';
                }
            }
            group(Physio)
            {
                Caption = 'Physiotherapy';
                Image = RegisteredDocs;
                action(PhysiotheraphyObservations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PhysiotheraphyObservations';
                    RunObject = Page "HMS Physiotheraphy List";
                    ToolTip = 'Executes the PhysiotheraphyObservations action.';
                }
                action("CLosed Physiotheraphy List")
                {
                    ApplicationArea = Basic, Suite;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "HMS CLosed Physiotheraphy List";
                    ToolTip = 'Executes the CLosed Physiotheraphy List action.';
                }
            }
            group(Radiology)
            {
                Caption = 'Radiology';
                Image = RegisteredDocs;
                action(Action108)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology';
                    RunObject = Page "HMS Radiology List";
                    ToolTip = 'Executes the Radiology action.';
                }
            }
            group(Lab)
            {
                Caption = 'Lab. Visits';
                Image = FiledPosted;
                action(Lab_List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Requests';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Laboratory List";
                    ToolTip = 'Executes the Test Requests action.';
                }
                action(findings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Findings';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Laboratory History List";
                    ToolTip = 'Executes the Test Findings action.';
                }
                action(Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                Image = Departments;
                action(Pharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Pharmacy List";
                    ToolTip = 'Executes the Pharmacy List action.';
                }
                action(Pharm_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy History List";
                    ToolTip = 'Executes the Pharmacy History action.';
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
                }
            }
            group(HMS_Admissions)
            {
                Caption = 'InPatients';
                Image = LotInfo;
                action(InPatients)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatients';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatients action.';
                }
                action(DischargeRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge Request';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Admission Progress List";
                    ToolTip = 'Executes the Discharge Request action.';
                }
                action(Discharge)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge List';
                    Image = ReleaseShipment;
                    RunObject = Page "HMS Admission Discharge List";
                    ToolTip = 'Executes the Discharge List action.';
                }
            }
            group(Reports_Diagnosis)
            {
                Caption = 'Diagnosis Report';
                Image = ReferenceData;
                action("Dignosis Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Over 5yrs';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Report "Diagnosis Over 5yrs";
                    ToolTip = 'Executes the Diagnosis Over 5yrs action.';
                }
                action(Under_5yrs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Under 5yrs';
                    Image = History;
                    Promoted = true;
                    RunObject = Report "Diagnosis Under 5yrs";
                    ToolTip = 'Executes the Diagnosis Under 5yrs action.';
                }
                action("Hospital Diagnosis.")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DataEntry;
                    RunObject = Report "Hospital Diagnosis<5years";
                    ToolTip = 'Executes the Hospital Diagnosis. action.';
                }
            }
            group(Refs)
            {
                Caption = 'Referrals';
                Image = RegisteredDocs;
                action(ref)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Referrals action.';
                }
                action(ref_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List2";
                    ToolTip = 'Executes the Referrals History action.';
                }
            }
            group(Immuns)
            {
                Caption = 'Immunizations';
                Image = ReferenceData;
                action(Immun)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunizations';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Immunization Header List";
                    ToolTip = 'Executes the Immunizations action.';
                }
                action(Immun_History)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunizations History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Immunization Posted List";
                    ToolTip = 'Executes the Immunizations History action.';
                }
            }
            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action(Receipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipts';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "Receipts List";
                    ToolTip = 'Executes the Receipts action.';
                }
                action("Sales Invoice List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice List';
                    RunObject = Page "Sales Invoice List.";
                    ToolTip = 'Executes the Invoice List action.';
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Executes the Sales Orders action.';
                }
                action(SalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = Invoice;
                    RunObject = Page "Sales Invoice List.";
                    ToolTip = 'Executes the Sales Invoices action.';
                }
                action(SalesReturnOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Executes the Sales Return Orders action.';
                }
            }
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action(PostedSalesShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Executes the Posted Sales Shipments action.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Executes the Posted Sales Invoices action.';
                }
                action(PostedReturnReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Executes the Posted Return Receipts action.';
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Executes the Posted Sales Credit Memos action.';
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Executes the Posted Purchase Invoices action.';
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Executes the Posted Purchase Credit Memos action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Administration;
                action(PendingMyApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action(MyApprovalrequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action(StoresRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action(StaffClaim)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action(PurchaseRequisition)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action(ImprestSurrender)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action(ImprestRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest Lists";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action(LeaveApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action(MyApprovedLeaves)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
                action("Broadcast SMS")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "SMS Broadcast List1";
                    ToolTip = 'Executes the Broadcast SMS action.';
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action("Request to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Executes the Request to Approve action.';
                }
            }
            group(Setups1)
            {
                Caption = 'Hospital Setups.';
                Image = SNInfo;

                action("39006182")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction code';
                    RunObject = Page "HMS Transaction code List";
                    ToolTip = 'Executes the Transaction code action.';
                }
                action(ImmunHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                    ToolTip = 'Executes the Immunization History action.';
                }
                action(HMSSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Card";
                    ToolTip = 'Executes the Setup Card action.';
                }
                action(Systems_Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Systems Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Systems List";
                    ToolTip = 'Executes the Systems Card action.';
                }
                action(Setup_Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Doctor';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Hms Setup Doctors List";
                    ToolTip = 'Executes the Setup Doctor action.';
                }
                action(Setup_Blood_Group)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Blood Group';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Blood Group List";
                    ToolTip = 'Executes the Setup Blood Group action.';
                }
                action(Blood_Group_Donation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Blood Group Donation List";
                    ToolTip = 'Executes the Blood Group Donation action.';
                }
                action(Drug_Interaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drug Interaction';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drug Interaction Header";
                    ToolTip = 'Executes the Drug Interaction action.';
                }
                action(Observation_Signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Observation Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS General Observation Setup";
                    ToolTip = 'Executes the General Observation Setup action.';
                }
                action(Appointment_Typ)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Type';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Appointment Type Lst";
                    ToolTip = 'Executes the Appointment Type action.';
                }
                action("Setup Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Process List";
                    ToolTip = 'Executes the Process Setup action.';
                }
                action("Setup Dosage")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
                }
                action(Injection)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Injection';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Injection List";
                    ToolTip = 'Executes the Injection action.';
                }
                action(Diagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Diagnosis List";
                    ToolTip = 'Executes the Diagnosis action.';
                }
                action(SecondaryDiagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Secondary Diagnosis Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Secondary Diagnosis Setup";
                    ToolTip = 'Executes the Secondary Diagnosis Setup action.';
                }
                action(Allergy)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allergy';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Allergy List";
                    ToolTip = 'Executes the Allergy action.';
                }
                action(signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signs';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Signs";
                    ToolTip = 'Executes the Signs action.';
                }
                action(Symptoms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Symptoms';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Syptoms";
                    ToolTip = 'Executes the Symptoms action.';
                }
                action(messuring_Uni)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measuring Units';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Measuring Unit List";
                    ToolTip = 'Executes the Measuring Units action.';
                }
                action(specimen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Specimen Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Specimen List";
                    ToolTip = 'Executes the Specimen Card action.';
                }
                action(Lab_test)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Test Setups';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Lab Test List";
                    ToolTip = 'Executes the Lab Test Setups action.';
                }
                action(Rad_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Types';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Radiology Type List";
                    ToolTip = 'Executes the Radiology Types action.';
                }
                action(DosageSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
                }
                action(Theatre_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre Types';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS THeatre Type List";
                    ToolTip = 'Executes the Theatre Types action.';
                }
                action(Setup_Disctarge_Process)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Discharge Process';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Disctarge Process";
                    ToolTip = 'Executes the Setup Discharge Process action.';
                }
                action(wards)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ward Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS ward List";
                    ToolTip = 'Executes the Ward Setup action.';
                }
                action(Beds)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Beds';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Beds";
                    ToolTip = 'Executes the Beds action.';
                }
                action(Hos_Charges)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Charges Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Charges";
                    ToolTip = 'Executes the Hospital Charges Setup action.';
                }
                action(Hos_Drugs_Prof)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Drugs Profit';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drugs Profit";
                    ToolTip = 'Executes the Hospital Drugs Profit action.';
                }
            }
            group(Action40)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Sales_CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(Action129)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Sales Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders support warehouse documents for the item handling, the ability to return items from multiple sales documents with one return, and automatic creation of related sales credit memos or other return-related documents, such as a replacement sales order.';
                }
                action(Reminders)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminders';
                    Image = Reminder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Reminder List";
                    ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Finance Charge Memos';
                    Image = FinChargeMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Finance Charge Memo List";
                    ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales return receipts.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'View the list of issued reminders.';
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Finance Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'View the list of issued finance charge memos.';
                }
            }
            group(Action41)
            {
                Caption = 'Purchasing';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents';
                    Gesture = None;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Incoming Documents";
                    ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
                }
                action(Action131)
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Purchase Orders";
                    ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes.';
                }
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Purchase Return Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted purchase return shipments.';
                }
            }
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                action(Action104)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                }
                action(Action107)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                }
                action(Action106)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                }
            }
        }
    }
}
