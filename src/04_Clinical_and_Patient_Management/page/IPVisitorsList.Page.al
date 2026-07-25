namespace PTL.HMIS;

page 85496 "IP Visitors List"
{
    ApplicationArea = All;
    Caption = 'IP Visitors List';
    PageType = List;
    SourceTable = "IP Visitors List";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                    ToolTip = 'Specifies the value of the Visitor Name field.', Comment = '%';
                }
                field("Id Number"; Rec."Id Number")
                {
                    ToolTip = 'Specifies the value of the Id Number field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
            }
        }
    }
}
