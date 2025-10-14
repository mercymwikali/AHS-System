Page 52202951 "HR Training Providers List"
{
    Caption = 'Vendor List';
    CardPageID = "HR Training Providers Card";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(FaxNo; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field(ICPartnerCode; Rec."IC Partner Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the IC Partner Code field.';
                }
                field(Control35; Rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(PurchaserCode; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Purchaser Code field.';
                }
                field(VendorPostingGroup; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.';
                }
                field(GenBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field(VATBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field(FinChargeTermsCode; Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Fin. Charge Terms Code field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(LanguageCode; Rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(LastDateModified; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(ApplicationMethod; Rec."Application Method")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Application Method field.';
                }
                field("Location Code2"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(ShipmentMethodCode; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                }
                field(LeadTimeCalculation; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Lead Time Calculation field.';
                }
                field(BaseCalendarCode; Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Base Calendar Code field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Vendor)
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                }
                action(BankAccounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Vendor Bank Account List";
                    RunPageLink = "Vendor No." = field("No.");
                    ToolTip = 'Executes the Bank Accounts action.';
                }
                action(Contact)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ToolTip = 'Executes the C&ontact action.';

                    trigger OnAction()
                    begin
                        Rec.ShowContact();
                    end;
                }
                separator(Action55)
                {
                }
                action(OrderAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order &Addresses';
                    Image = Addresses;
                    RunObject = Page "Order Address List";
                    RunPageLink = "Vendor No." = field("No.");
                    ToolTip = 'Executes the Order &Addresses action.';
                }
                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(CrossReferences)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    ToolTip = 'Executes the Cross Re&ferences action.';
                    // RunObject = Page "Cross References";
                    // RunPageLink = "Cross-Reference Type" = const(Vendor),
                    //               "Cross-Reference Type No." = field("No.");
                    // RunPageView = sorting("Cross-Reference Type", "Cross-Reference Type No.");
                }
                separator(Action61)
                {
                }
            }
            group(Purchases)
            {
                Caption = '&Purchases';
                Image = Purchasing;
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Vendor Item Catalog";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ToolTip = 'Executes the Items action.';
                }
                action(InvoiceDiscounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Vend. Invoice Discounts";
                    RunPageLink = Code = field("Invoice Disc. Code");
                    ToolTip = 'Executes the Invoice &Discounts action.';
                }
                action(Prices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ToolTip = 'Executes the Prices action.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Administration;
                action(Quotes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Purchase Quotes";
                    RunPageLink = "Buy-from Vendor No." = field("No.");
                    RunPageView = sorting("Document Type", "Buy-from Vendor No.");
                    ToolTip = 'Executes the Quotes action.';
                }
                action(Orders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Order List";
                    RunPageLink = "Buy-from Vendor No." = field("No.");
                    RunPageView = sorting("Document Type", "Buy-from Vendor No.");
                    ToolTip = 'Executes the Orders action.';
                }
                action(ReturnOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Order List";
                    RunPageLink = "Buy-from Vendor No." = field("No.");
                    RunPageView = sorting("Document Type", "Buy-from Vendor No.");
                    ToolTip = 'Executes the Return Orders action.';
                }
                action(BlanketOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Purchase Orders";
                    RunPageLink = "Buy-from Vendor No." = field("No.");
                    RunPageView = sorting("Document Type", "Buy-from Vendor No.");
                    ToolTip = 'Executes the Blanket Orders action.';
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action(LedgerEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
                }
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
                action(Action21)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ToolTip = 'Executes the Purchases action.';
                }
                action(EntryStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ToolTip = 'Executes the Entry Statistics action.';
                }
                action(StatisticsbyCurrencies)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Vend. Stats. by Curr. Lines";
                    RunPageLink = "Vendor Filter" = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"),
                                  "Date Filter" = field("Date Filter");
                    ToolTip = 'Executes the Statistics by C&urrencies action.';
                }
            }
        }
        area(creation)
        {
            action(BlanketPurchaseOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Blanket Purchase Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Blanket Purchase Order";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Blanket Purchase Order action.';
            }
            action(PurchaseQuote)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Quote";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Quote action.';
            }
            action(PurchaseInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Invoice";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Invoice action.';
            }
            action(PurchaseOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Purchase Order";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Order action.';
            }
            action(PurchaseCreditMemo)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Credit Memo";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Credit Memo action.';
            }
            action(PurchaseReturnOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Purchase Return Order";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Return Order action.';
            }
        }
        area(processing)
        {
            action(PaymentJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payment Journal";
                ToolTip = 'Executes the Payment Journal action.';
            }
            action(PurchaseJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Journal';
                Image = Journals;
                Promoted = false;
                ToolTip = 'Executes the Purchase Journal action.';
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
            }
        }
        area(reporting)
        {
            group(General)
            {
                Caption = 'General';
                action(VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - List";
                    ToolTip = 'Executes the Vendor - List action.';
                }
                action(VendorRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Register';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor Register";
                    ToolTip = 'Executes the Vendor Register action.';
                }
                action(VendorItemCatalog)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Item Catalog';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor Item Catalog";
                    ToolTip = 'Executes the Vendor Item Catalog action.';
                }
                action(VendorLabels)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Labels';
                    Image = "Report";
                    Promoted = false;
                    ToolTip = 'Executes the Vendor - Labels action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                }
                action(VendorTop10List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Top 10 List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Top 10 List";
                    ToolTip = 'Executes the Vendor - Top 10 List action.';
                }
            }
            group(ActionGroup5)
            {
                Caption = 'Orders';
                Image = "Report";
                action(VendorOrderSummary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Summary";
                    ToolTip = 'Executes the Vendor - Order Summary action.';
                }
                action(VendorOrderDetail)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Order Detail';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Detail";
                    ToolTip = 'Executes the Vendor - Order Detail action.';
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = Purchase;
                action(VendorPurchaseList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Purchase List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ToolTip = 'Executes the Vendor - Purchase List action.';
                }
                action(VendorItemPurchases)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor/Item Purchases';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor/Item Purchases";
                    ToolTip = 'Executes the Vendor/Item Purchases action.';
                }
                action(PurchaseStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Statistics';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Purchase Statistics";
                    ToolTip = 'Executes the Purchase Statistics action.';
                }
            }
            group(FinancialManagement)
            {
                Caption = 'Financial Management';
                Image = "Report";
                action(PaymentsonHold)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payments on Hold';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payments on Hold";
                    ToolTip = 'Executes the Payments on Hold action.';
                }
                action(VendorSummaryAging)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Summary Aging";
                    ToolTip = 'Executes the Vendor - Summary Aging action.';
                }
                action(AgedAccountsPayable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ToolTip = 'Executes the Aged Accounts Payable action.';
                }
                action(VendorBalancetoDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Balance to Date';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    ToolTip = 'Executes the Vendor - Balance to Date action.';
                }
                action(VendorTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Trial Balance";
                    ToolTip = 'Executes the Vendor - Trial Balance action.';
                }
                action(VendorDetailTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Detail Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Vendor - Detail Trial Balance";
                    ToolTip = 'Executes the Vendor - Detail Trial Balance action.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec."Vendor Posting Group" := 'Training Provider';
    end;

    procedure GetSelectionFilter(): Text
    var
        Vend: Record Vendor;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(Vend);
        exit(SelectionFilterManagement.GetSelectionFilterForVendor(Vend));
    end;

    procedure SetSelection(var Vend: Record Vendor)
    begin
        CurrPage.SetSelectionFilter(Vend);
    end;
}
