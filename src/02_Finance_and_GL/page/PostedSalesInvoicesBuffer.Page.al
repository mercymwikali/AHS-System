namespace PTL.Hospital;

page 85249 "Posted Sales Invoices Buffer"
{
    ApplicationArea = All;
    Caption = 'Posted Sales Invoices Buffer';
    PageType = List;
    SourceTable = "Posted Sales Invoices Buffer";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Invoice No"; Rec."Invoice No")
                {
                    ToolTip = 'Specifies the value of the Invoice No field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ToolTip = 'Specifies the value of the Admission Date field.', Comment = '%';
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Discharge Date field.', Comment = '%';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.', Comment = '%';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.', Comment = '%';
                }
                field("Encounter No"; Rec."Encounter No")
                {
                    ToolTip = 'Specifies the value of the Encounter No field.', Comment = '%';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.', Comment = '%';
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.', Comment = '%';
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ToolTip = 'Specifies the value of the Confirmed field.', Comment = '%';
                }
                field("For Review"; Rec."For Review")
                {
                    ToolTip = 'Specifies the value of the For Review field.', Comment = '%';
                }
                field("Review Comments"; Rec."Review Comments")
                {
                    ToolTip = 'Specifies the value of the Review Comments field.', Comment = '%';
                }
                field("For Reversal"; Rec."For Reversal")
                {
                    ToolTip = 'Specifies the value of the For Reversal field.', Comment = '%';
                }
                field("Last Unique Inv NO"; Rec."Last Unique Inv NO")
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Last Posted Invoice")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PostedSalesInvoicesBuffer: Record "Posted Sales Invoices Buffer";
                    PstdSalesInvoicesBuf: Record "Posted Sales Invoices Buffer";
                begin
                    PostedSalesInvoicesBuffer.SetAutoCalcFields("Last Unique Inv No");
                    PostedSalesInvoicesBuffer.Reset();
                    if PostedSalesInvoicesBuffer.FindSet() then
                        repeat
                            PstdSalesInvoicesBuf.Reset();
                            PstdSalesInvoicesBuf.SetRange("Line No", PostedSalesInvoicesBuffer."Last Unique Inv NO");
                            PstdSalesInvoicesBuf.SetRange(Confirmed, false);
                            if PstdSalesInvoicesBuf.FindFirst() then begin
                                PstdSalesInvoicesBuf.Confirmed := true;
                                PstdSalesInvoicesBuf.Modify();
                            end;
                        until PostedSalesInvoicesBuffer.Next() = 0;

                    Message('Done');
                end;

            }
            action("Reset Confirmed Status")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PostedSalesInvoicesBuffer: Record "Posted Sales Invoices Buffer";
                    PstdSalesInvoicesBuf: Record "Posted Sales Invoices Buffer";
                begin
                    PostedSalesInvoicesBuffer.Reset();
                    if PostedSalesInvoicesBuffer.FindSet() then
                        repeat
                            PostedSalesInvoicesBuffer.Confirmed := false;
                            PostedSalesInvoicesBuffer.Modify();
                        until PostedSalesInvoicesBuffer.Next() = 0;
                    Message('Done');
                end;

            }
        }
    }
}
