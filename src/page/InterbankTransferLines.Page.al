page 85174 "Interbank Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "Interbank Transfer Lines";
    ApplicationArea = basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Paying Bank No"; Rec."Paying Bank No")
                {
                    ToolTip = 'Specifies the value of the Paying Bank No field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Receipt No"; Rec."Receipt No")
                {
                    DrillDownPageID = "Posted Receipt UP";
                    LookupPageID = "Posted Receipt UP";
                    ToolTip = 'Specifies the value of the Receipt No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Source Campus Code"; Rec."Source Campus Code")
                {
                    ToolTip = 'Specifies the value of the Source Funtion Code field.';
                }
                field("Source Department Code"; Rec."Source Department Code")
                {
                    ToolTip = 'Specifies the value of the Source Budget Center Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
            }
        }
    }
}
