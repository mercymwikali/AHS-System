page 52203161 "HMS Appointment Booking Lines"
{
    ApplicationArea = All;
    Caption = 'HMS Appointment Booking Lines';
    PageType = ListPart;
    SourceTable = "HMS Appointment Booking Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Booked Date"; Rec."Booked Date")
                {
                    ToolTip = 'Specifies the value of the Booked Date field.';
                }
                field("Booked Time"; Rec."Booked Time")
                {
                    ToolTip = 'Specifies the value of the Booked Time field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Dialysis Session"; Rec."Therapy Session")
                {
                    ToolTip = 'Specifies the value of the Dialysis Session field.';
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field("Booked Ward"; Rec."Booked Ward")
                {
                    ToolTip = 'Specifies the value of the Booked Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field("Therapy Type"; Rec."Therapy Type")
                {
                    ToolTip = 'Specifies the value of the Dialysis Machine Code field.';
                }
                field("Therapy Description"; Rec."Therapy Description")
                {
                    ToolTip = 'Specifies the value of the Dialysis Machine Name field.';
                }
            }
        }
    }
}
