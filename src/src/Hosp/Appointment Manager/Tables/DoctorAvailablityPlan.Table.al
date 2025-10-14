table 52202966 "Doctor Availablity Plan"
{
    Caption = 'Doctor Availablity Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            DataClassification = CustomerContent;
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; Slot; Code[30])
        {
            Caption = 'Slot';
            TableRelation = "Appointment Time Slots".Name;

            trigger OnValidate()
            var
                AppointmentTimeSlots: Record "Appointment Time Slots";
            begin
                AppointmentTimeSlots.Reset();
                AppointmentTimeSlots.SetRange("Name", Slot);
                if AppointmentTimeSlots.FindFirst() then begin
                    "Start Time" := AppointmentTimeSlots."Start Time";
                    "End Time" := AppointmentTimeSlots."End Time";
                end;
            end;
        }
        field(5; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(6; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(7; Booked; Boolean)
        {
            Caption = 'Booked';
        }
    }
    keys
    {
        key(PK; "Line No.", "Doctor ID", "Date", Slot)
        {
            Clustered = true;
        }
    }
}
