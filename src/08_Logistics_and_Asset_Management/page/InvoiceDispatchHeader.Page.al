page 85504 "Invoice Dispatch Header"
{
    PageType = Document;
    SourceTable = "Invoice Dispatch Headerd";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date From"; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';

                    trigger OnValidate()
                    begin
                        Rec.Validate("Customer No");
                    end;
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date To field.';
                    trigger OnValidate()
                    begin
                        Rec.Validate("Customer No");
                    end;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                }

                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer No field.';
                    trigger OnValidate()
                    begin
                        DispatchLines.Reset();
                        DispatchLines.SetRange(DispatchLines.No, Rec.No);
                        if DispatchLines.Find('-') then
                            repeat
                                DispatchLines.Delete();
                            until DispatchLines.Next() = 0;

                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange(SalesInvoiceHeader."Sell-to Customer No.", Rec."Customer No");
                        if Rec."Shortcut Dimension 3 Code" <> '' then
                            SalesInvoiceHeader.SetRange("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                        //InvH.SETFILTER(InvH."Posted Count" ,'>%1',0);
                        SalesInvoiceHeader.SetRange(SalesInvoiceHeader.Dispatched, false);
                        //InvH.SETRANGE(InvH."Posting Date","Date To",Date);
                        //InvH.SETRANGE(InvH."Posting Date" >="Date From");
                        if SalesInvoiceHeader.Find('-') then
                            repeat
                                if (SalesInvoiceHeader."Posting Date" >= Rec.Date) and (SalesInvoiceHeader."Posting Date" <= Rec."Date To") then begin

                                    SalesInvoiceHeader.CalcFields("Amount Including VAT");
                                    SalesInvoiceHeader.CalcFields("Posted Count");

                                    if (SalesInvoiceHeader."Posted Count" > 0) then
                                        DispatchLines.Init();
                                    DispatchLines.No := Rec.No;
                                    DispatchLines."Invoice No" := SalesInvoiceHeader."No.";
                                    // DispatchLines.VALIDATE("Invoice No");
                                    DispatchLines."Customer No" := Rec."Customer No";
                                    DispatchLines."Patient No" := SalesInvoiceHeader."Patient No.";
                                    DispatchLines."Original Amount" := SalesInvoiceHeader."Amount Including VAT";
                                    DispatchLines."Invoice Date" := SalesInvoiceHeader."Posting Date";

                                    if HMSPat.Get(SalesInvoiceHeader."Patient No.") then begin
                                        DispatchLines."Patient Name" := HMSPat.Surname + ' ' + HMSPat."Last Name" + ' ' + HMSPat."Middle Name";
                                        DispatchLines."Member No" := HMSPat."Membership No";

                                        PatCharges.SetRange(PatCharges."Patient No.", SalesInvoiceHeader."Patient No.");
                                        PatCharges.SetRange(PatCharges."Posted Invoice No.", SalesInvoiceHeader."No.");
                                        if PatCharges.Find('-') then begin
                                            HmsApp.SetRange(HmsApp."Appointment No.", PatCharges."Visit No");
                                            if HmsApp.Find('-') then
                                                DispatchLines."MCC No." := HmsApp."MVC No.";
                                        end;
                                    end;
                                    DispatchLines.Insert();
                                end;
                            until SalesInvoiceHeader.Next() = 0;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Batch Amount"; Rec."Batch Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Batch Amount field.';
                }
                field("Invoice Counter"; Rec."Invoice Counter")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice Counter field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

            }
            group(Control8)
            {
                ShowCaption = false;
                part(Control7; "Invoice Dispatch Lines")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = No = FIELD(No),
                                  "Customer No" = FIELD("Customer No");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Dispatch")
            {
                ApplicationArea = Basic, Suite;
                Image = PostOrder;
                ToolTip = 'Executes the Post Dispatch action.';
                trigger OnAction()
                begin
                    if Confirm('Do you really want to Post the dispatch?') then begin
                        DispatchLines.Reset();
                        DispatchLines.SetRange(DispatchLines.No, Rec.No);
                        DispatchLines.SetRange(DispatchLines.Select, false);
                        if DispatchLines.Find('-') then
                            repeat
                                DispatchLines.Delete();
                            until DispatchLines.Next() = 0;

                        DispatchLines.Reset();
                        DispatchLines.SetRange(DispatchLines.No, Rec.No);
                        DispatchLines.SetRange(DispatchLines.Select, true);
                        if DispatchLines.Find('-') then
                            repeat
                                // Sales.UpdateDispatch(DispatchLines."Invoice No",No);

                                SalesInvoiceHeader.RESET();
                                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", DispatchLines."Invoice No");
                                IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                                    SalesInvoiceHeader.Dispatched := TRUE;
                                    SalesInvoiceHeader."Dispatch No" := Rec.No;
                                    SalesInvoiceHeader.MODIFY();
                                END;
                            until DispatchLines.Next() = 0;
                        Rec."User ID" := Rec."User ID";
                        Rec."Posting Date" := Today;
                        Rec.Posted := true;
                        Rec.Modify();
                        Message('Dispatch Posted Successfully');

                        /*DispatchLines.RESET;
                        DispatchLines.SETFILTER(DispatchLines.No,No);
                        IF DispatchLines.FIND('-') THEN
                        REPORT.RUN(70135164,TRUE,TRUE,DispatchLines);
                        */
                    end;
                end;
            }
            separator(Separator11)
            {
            }
            action("Print Dispatch Summary")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                ToolTip = 'Executes the Print Dispatch Summary action.';

                trigger OnAction()
                begin
                    DispatchLines.Reset();
                    DispatchLines.SetFilter(DispatchLines.No, Rec.No);
                    DispatchLines.SetRange(DispatchLines.Select, true);
                    if DispatchLines.Find('-') then
                        REPORT.Run(Report::"Invoice Dispatch Report", true, true, DispatchLines);
                end;
            }
            separator(Separator13)
            {
            }
            action("Suggest Lines")
            {
                Image = Suggest;
                Promoted = true;
                ToolTip = 'Executes the Suggest Lines action.';
            }
            separator(Separator14)
            {
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                ToolTip = 'Executes the Approval action.';
                trigger OnAction()
                var

                begin
                    Message('Work in Progress');
                end;

            }

        }
    }

    var
        HmsApp: Record "HMS Appointment Form Header";
        HMSPat: Record "HMS Patient";
        PatCharges: Record "HMS Patient Charges";
        DispatchLines: Record "Invoice Dispatch Linesd";
        SalesInvoiceHeader: Record "Sales Invoice Header";
}
