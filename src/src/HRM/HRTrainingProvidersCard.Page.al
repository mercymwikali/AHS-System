Page 52202950 "HR Training Providers Card"
{
    Caption = 'Vendor Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Address2; Rec."Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(PrimaryContactNo; Rec."Primary Contact No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Primary Contact No. field.';
                }
                field(Control16; Rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(BalanceLCY; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Balance (LCY) field.';

                    trigger OnDrillDown()
                    var
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                        VendLedgEntry: Record "Vendor Ledger Entry";
                    begin
                        DtldVendLedgEntry.SetRange("Vendor No.", Rec."No.");
                        Rec.Copyfilter("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        Rec.Copyfilter("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        Rec.Copyfilter("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field(PurchaserCode; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Purchaser Code field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(LastDateModified; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(FaxNo; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(HomePage; Rec."Home Page")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Home Page field.';
                }
                field(ICPartnerCode; Rec."IC Partner Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the IC Partner Code field.';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field(PaytoVendorNo; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pay-to Vendor No. field.';
                }
                field(GenBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field(VATBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field(VendorPostingGroup; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.';
                }
                field(InvoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    ApplicationArea = Basic, Suite;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.';
                }
                field(PricesIncludingVAT; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Prices Including VAT field.';
                }
                field(Prepayment; Rec."Prepayment %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Prepayment % field.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field(ApplicationMethod; Rec."Application Method")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Application Method field.';
                }
                field(PartnerType; Rec."Partner Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Partner Type field.';
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field(PaymentMethodCode; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field(CashFlowPaymentTermsCode; Rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cash Flow Payment Terms Code field.';
                }
                field(OurAccountNo; Rec."Our Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Our Account No. field.';
                }
                field(BlockPaymentTolerance; Rec."Block Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Block Payment Tolerance field.';
                }
                field(CreditorNo; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Creditor No. field.';
                }
            }
            group(Receiving)
            {
                Caption = 'Receiving';
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(ShipmentMethodCode; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                }
                field(LeadTimeCalculation; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Lead Time Calculation field.';
                }
                field(BaseCalendarCode; Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    ToolTip = 'Specifies the value of the Base Calendar Code field.';
                }
                label("Customized Calendar")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customized Calendar';
                    Editable = false;
                }
            }
            group(ForeignTrade)
            {
                Caption = 'Foreign Trade';
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(LanguageCode; Rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field(VATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
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
}
