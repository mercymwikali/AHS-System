page 85212 "Payment Schedule List"
{
    ApplicationArea = Basic, Suite;
    CardPageID = "Payment Schedule";
    PageType = List;
    SourceTable = "Payment Schedule";
    SourceTableView = WHERE(Posted = CONST(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Paying Bank No"; Rec."Paying Bank No")
                {
                    ToolTip = 'Specifies the value of the Paying Bank No field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Posting Dated"; Rec."Posting Dated")
                {
                    ToolTip = 'Specifies the value of the Posting Dated field.';
                }
            }
        }
    }

    actions
    {
    }
}
