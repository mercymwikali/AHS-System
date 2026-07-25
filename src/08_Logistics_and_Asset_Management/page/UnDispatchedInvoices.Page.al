Page 85571 "UnDispatched Invoices"
{
    Caption = 'Posted Sales Invoices - Pending Dispatch';
    CardPageID = "Posted Sales Invoice";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Invoice,Navigate,Correct';
    RefreshOnActivate = true;
    SourceTable = "Sales Invoice Header";
    SourceTableView = sorting("Posting Date")
                      order(descending)
                      where(Dispatched = const(false),
                            "Posted Count" = filter(> 0));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posted invoice number.';
                }
                field(CustomerNo; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(TreatmentNo; Rec."Treatment No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment No field.';
                }
                field(AppointmentNo; Rec."Appointment No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment No field.';
                }
                field(SelltoCustomerName; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    ToolTip = 'Specifies the name of the customer that you shipped the items on the invoice to.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the currency code of the invoice.';
                }
                field(DueDate; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the invoice is due for payment.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines. The amount does not include VAT.';

                    trigger OnDrillDown()
                    begin
                        Rec.SetRange("No.");
                        Page.RunModal(Page::"Posted Sales Invoice", Rec)
                    end;
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the amounts in all the amount fields on the invoice, in the currency of the invoice. The amount includes VAT.';

                    trigger OnDrillDown()
                    begin
                        Rec.SetRange("No.");
                        Page.RunModal(Page::"Posted Sales Invoice", Rec)
                    end;
                }
                field(RemainingAmount; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount that remains to be paid for the posted sales invoice.';
                }
                field(SelltoPostCode; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field(SelltoCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field(SelltoContact; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact when you communicate with the customer that you shipped the items to.';
                    Visible = false;
                }
                field(BilltoCustomerNo; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer the invoice was sent to.';
                    Visible = false;
                }
                field(BilltoName; Rec."Bill-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer that the invoice was sent to.';
                    Visible = false;
                }
                field(BilltoPostCode; Rec."Bill-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field(BilltoCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field(BilltoContact; Rec."Bill-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.';
                    Visible = false;
                }
                field(ShiptoCode; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'This field is used with shipments to customers with multiple ship-to addresses.';
                    Visible = false;
                }
                field(ShiptoName; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                    Visible = false;
                }
                field(ShiptoPostCode; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field(ShiptoCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field(ShiptoContact; Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you regularly contact at the customer to whom the items were shipped.';
                    Visible = false;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the invoice was posted.';
                    Visible = false;
                }
                field(SalespersonCode; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies which salesperson is associated with the invoice.';
                    Visible = false;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the dimension value code associated with the invoice.';
                    Visible = false;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the dimension value code associated with the invoice.';
                    Visible = false;
                }
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                }
                field(NoPrinted; Rec."No. Printed")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how many times the invoice has been printed.';
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when you created the sales document.';
                    Visible = false;
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';
                    Visible = false;
                }
                field(PaymentDiscount; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment discount percentage granted if payment is made by the date entered in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field(ShipmentMethodCode; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code that represents the shipment method for the invoice.';
                    Visible = false;
                }
                field(ShippingAgentCode; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    Visible = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the posted sales invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = not Rec.Cancelled;
                    Style = Unfavorable;
                    StyleExpr = Rec.Cancelled;
                    ToolTip = 'Specifies if the posted sales invoice has been either corrected or canceled.';

                    trigger OnDrillDown()
                    begin
                        Rec.ShowCorrectiveCreditMemo();
                    end;
                }
                field(Corrective; Rec.Corrective)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = not Rec.Corrective;
                    Style = Unfavorable;
                    StyleExpr = Rec.Corrective;
                    ToolTip = 'Specifies if the posted sales invoice is a corrective document.';

                    trigger OnDrillDown()
                    begin
                        Rec.ShowCancelledCreditMemo();
                    end;
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Copies the date for this field from the Shipment Date field on the sales header, which is used for planning purposes.';
                    Visible = false;
                }
                field(DocumentExchangeStatus; Rec."Document Exchange Status")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = DocExchStatusStyle;
                    ToolTip = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.';
                    Visible = DocExchStatusVisible;
                }
                // field("<Document Exchange Status>"; Rec."Coupled to CRM")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies that the posted sales order is coupled to a sales order in Microsoft CRM.';
                //     Visible = CRMIntegrationEnabled;
                // }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = not IsOfficeAddin;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Invoice)
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Sales Invoice Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Incoming Document action.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice';
                    Enabled = CRMIsCoupledToRecord;
                    Image = CoupledSalesInvoice;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CreateInCRM)
                {
                    ApplicationArea = All;
                    Caption = 'Create Invoice in Dynamics CRM';
                    Enabled = not CRMIsCoupledToRecord;
                    Image = NewSalesInvoice;
                    ToolTip = 'Generate the document in the coupled Microsoft Dynamics CRM account.';

                    trigger OnAction()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        SalesInvoiceHeaderRecordRef: RecordRef;
                    begin
                        CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                        SalesInvoiceHeader.Next();

                        if SalesInvoiceHeader.Count = 1 then
                            Message(Rec."Dispatch No")
                        // CRMIntegrationManagement.CreateNewRecordInCRM(RecordId,false)
                        else begin
                            SalesInvoiceHeaderRecordRef.GetTable(SalesInvoiceHeader);
                            CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Print Invoice")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print Invoice action.';

                trigger OnAction()
                begin
                    HMSPatCharges.Reset();
                    HMSPatCharges.SetRange(HMSPatCharges."Patient No.", Rec."Patient No.");
                    HMSPatCharges.SetFilter(HMSPatCharges."Posted Invoice No.", Rec."No.");
                    if HMSPatCharges.Find('-') then
                        Report.Run(39005476, true, true, HMSPatCharges);

                    //39005605
                end;
            }
            action("Posted Print Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Posted Invoice';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print Posted Invoice action.';

                trigger OnAction()
                begin
                    invLine.Reset();
                    invLine.SetRange(invLine."Document No.", Rec."No.");
                    if invLine.Find('-') then
                        Report.Run(39005605, true, true, invLine);
                        //39005605
                end;
            }
            action(PrintCashNHIFSales)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Cash NHIF Sales';
                ToolTip = 'Executes the Print Cash NHIF Sales action.';

                trigger OnAction()
                begin
                    HMSPatCharges.Reset();
                    HMSPatCharges.SetRange(HMSPatCharges."Patient No.", Rec."Patient No.");
                    HMSPatCharges.SetRange(HMSPatCharges.Posted, true);
                    if HMSPatCharges.Find('-') then
                        Report.Run(39005479, true, true, HMSPatCharges);
                end;
            }
            action(SendCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.SendRecords();
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = not IsOfficeAddin;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.PrintRecords(true);
                end;
            }
            action(Email)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send by &Email';
                Image = Email;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ToolTip = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
                end;
            }
            action(Navigate)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate';
                Image = Navigate;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category5;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                Visible = not IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Activity Log';
                Image = Log;
                ToolTip = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.';

                trigger OnAction()
                var
                    ActivityLog: Record "Activity Log";
                begin
                    ActivityLog.ShowEntries(Rec.RecordId);
                end;
            }
            group(Correct)
            {
                Caption = 'Correct';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Correct PstdSalesInv (Yes/No)", Rec);
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Create and post a sales credit memo that reverses this posted sales invoice. This posted sales invoice will be canceled.';

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Cancel PstdSalesInv (Yes/No)", Rec);
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Corrective Credit Memo';
                    Image = CreateCreditMemo;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    Scope = Repeater;
                    ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
                    begin
                        CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(Rec, SalesHeader);
                        Page.Run(Page::"Sales Credit Memo", SalesHeader);
                    end;
                }
            }
            group(ActionGroup42)
            {
                Caption = 'Invoice';
                Image = Invoice;
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer.';
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo';
                    Enabled = Rec.Cancelled or Rec.Corrective;
                    Image = CreditMemo;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Scope = Repeater;
                    ToolTip = 'Open the posted sales credit memo that was created when you canceled the posted sales invoice. If the posted sales invoice is the result of a canceled sales credit memo, then canceled sales credit memo will open.';

                    trigger OnAction()
                    begin
                        Rec.ShowCanceledOrCorrCrMemo();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;

    trigger OnAfterGetRecord()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle();

        SalesInvoiceHeader.CopyFilters(Rec);
        SalesInvoiceHeader.SetFilter("Document Exchange Status", '<>%1', Rec."document exchange status"::"Not Sent");
        DocExchStatusVisible := not SalesInvoiceHeader.IsEmpty;

        if Rec."Search Name" = '' then
            Rec."Search Name" := hmsPat.GetPatientName(Rec."Patient No.");
    end;

    trigger OnInit()
    begin
        DocExchStatusVisible := false;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        if Rec.FindFirst() then;
        IsOfficeAddin := OfficeMgt.IsAvailable();
    end;

    var
        HMSPatCharges: Record "HMS Patient Charges";
        invLine: Record "Sales Invoice Line";
        hmsPat: Codeunit "HMS Patient-integration";
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        DocExchStatusVisible: Boolean;
        IsOfficeAddin: Boolean;
        DocExchStatusStyle: Text;
}
