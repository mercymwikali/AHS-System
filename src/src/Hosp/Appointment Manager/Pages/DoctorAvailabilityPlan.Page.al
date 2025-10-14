namespace PTL.HMIS;

page 52203186 "Doctor Availability Plan"
{
    ApplicationArea = All;
    Caption = 'Doctor Availability Plan';
    PageType = List;
    SourceTable = "Doctor Availablity Plan";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Slot; Rec.Slot)
                {
                    ToolTip = 'Specifies the value of the Slot field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field(Booked; Rec.Booked)
                {
                    ToolTip = 'Specifies the value of the Booked field.', Comment = '%';
                }
            }
        }
    }
}
