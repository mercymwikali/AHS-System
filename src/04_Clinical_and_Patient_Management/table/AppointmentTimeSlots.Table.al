namespace PTL.HMIS;
/// <summary>
/// This table is to be used only to suggest Start time and end time when selecting availability
/// The Doctors can be allowed to set their own time as long as they do not overlap with another slot
/// </summary>
table 85148 "Appointment Time Slots"
{
    Caption = 'Appointment Time Slots';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Name; Code[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(4; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(5; "Duration"; Code[20])
        {
            Caption = 'Duration';
            DataClassification = CustomerContent;
        }
        field(6; "Booked Sessions"; Integer)
        {
            Caption = 'Booked Sessions';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Appointmnt Bookng" where(Status = filter("Booked"),
                                                                        "Appointment Slot" = field(Name)));
        }
    }
    keys
    {
        key(PK; "Line No", Name)
        {
            Clustered = true;
        }
    }
}
