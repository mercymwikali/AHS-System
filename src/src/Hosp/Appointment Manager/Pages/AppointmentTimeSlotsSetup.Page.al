namespace PTL.HMIS;

page 52203185 "Appointment Time Slots Setup"
{
    ApplicationArea = All;
    Caption = 'Appointment Time Slots Setup';
    PageType = List;
    SourceTable = "Appointment Time Slots";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
            }
        }
    }
}
