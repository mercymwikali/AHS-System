Page 85506 "Invoice Dispatch List"
{
    CardPageID = "Invoice Dispatch Header";
    Editable = false;
    PageType = List;
    SourceTable = "Invoice Dispatch Headerd";
    SourceTableView = where(Posted = const(false));
    ApplicationArea = Basic, Suite;

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
                field(CustomerNo; Rec."Customer No")
                {
                    ToolTip = 'Specifies the value of the Customer No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Dispatch Summary")
            {
                Image = "Report";
                Visible = false;
                ToolTip = 'Executes the Print Dispatch Summary action.';

                trigger OnAction()
                begin
                    DispH.Reset();
                    DispH.SetFilter(DispH.No, Rec.No);

                    if DispH.Find('-') then
                        Report.Run(39006103, true, true, DispH);
                end;
            }
        }
    }

    var
        DispH: Record "Invoice Dispatch Headerd";
}
