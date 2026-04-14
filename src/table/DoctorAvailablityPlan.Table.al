table 85149 "Doctor Availablity Plan"
{
    Caption = 'Doctor Availablity Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50001; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            DataClassification = CustomerContent;
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50002; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50003; Slot; Code[30])
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
        field(50004; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(50005; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(50006; Booked; Boolean)
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
