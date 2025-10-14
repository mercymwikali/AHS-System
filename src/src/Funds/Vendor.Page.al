page 52202569 "Vendor List2"
{
    ApplicationArea = All;
    CardPageId = "Vendor Card";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Posting Group" = filter('DOCTOR'));
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Vendor Category"; Rec."Vendor Category")
                {
                    ToolTip = 'Specifies the value of the Vendor Category field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}