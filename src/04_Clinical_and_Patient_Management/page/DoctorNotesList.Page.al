namespace PTL.HMIS;

page 85287 "Doctor Notes List"
{
    ApplicationArea = All;
    Caption = 'Doctor Notes List';
    PageType = ListPart;
    CardPageId = "HMS Doctors Notes Card";
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "HMS Notes";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Treatment Date field.', Comment = '%';
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ToolTip = 'Specifies the value of the Treatment Time field.', Comment = '%';
                }
                field("Notes Type"; Rec."Notes Type")
                {
                    ToolTip = 'Specifies the value of the Notes Type field.', Comment = '%';
                }
                
            }
        }
    }
}
