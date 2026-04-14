table 85572 "HMS Appointment Booking Lines"
{
    Caption = 'HMS Appointment Booking Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No';
        }
        field(50001; "Booking No."; Code[20])
        {
            Caption = 'Booking No.';
        }
        field(50002; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
        }
        field(50003; "Booked Date"; Date)
        {
            Caption = 'Booked Date';
            trigger OnValidate()
            begin
                if "Booked Date" < Today then
                    Error('You can only book a future date');
                validate(Bed);
            end;
        }
        field(50004; "Booked Time"; Time)
        {
            Caption = 'Booked Time';
        }
        field(50005; "Booked Ward"; Code[20])
        {
            Caption = 'Booked Ward';
            TableRelation = "HMS Ward Setup"."Ward Code" where("Branch Code" = field(Branch));
        }
        field(50006; "Therapy Session"; Option)
        {
            Caption = 'Therapy Session';
            OptionCaption = ' ,Morning (6am-10am),Mid-Morning (10:30-2pm),Afternoon(2pm-6pm)';
            OptionMembers = " ",Morning,"Mid-Morning",Afternoon;
        }
        field(50007; Bed; Code[20])
        {
            Caption = 'Bed';
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field("Booked Ward"),
                                                       Occupied = const(false));
            trigger OnValidate()
            var
                Prebooked: Record "HMS Patient Appointmnt Bookng";
            begin
                TestField(Section);
                if Section = Section::Therapy then begin
                    Prebooked.Reset();
                    Prebooked.SetRange(Prebooked."Appointment Date", "Booked Date");
                    Prebooked.SetRange(Prebooked.Ward, "Booked Ward");
                    Prebooked.SetRange(Prebooked.Bed, Bed);
                    Prebooked.SetRange(Prebooked."Therapy Session", "Therapy Session");
                    if Prebooked.Find('-') then
                        Error('There is already a prior booking on ' + Format("Booked Date") + 'for the ' + Format("Therapy Session") +
                        ' session, ward' + "Booked Ward" + 'bed ' + Bed + '. Kindly book another bed or time');
                end;
            end;
        }
        field(50008; Status; Option)
        { // REFACTOR: Extract to enum
            OptionCaption = ',Booked,Attended,Failed To Attend,Cancelled';
            OptionMembers = " ",Booked,Attended,"Failed To Attend",Cancelled;
        }
        field(50009; Notified; Boolean)
        {
        }
        field(50010; "Notified Date"; DateTime)
        {
        }
        field(50011; "Therapy Type"; code[20])
        {
            TableRelation = "Therapy Types"."Therapy Code";
            trigger OnValidate()
            var
                TherapyType: Record "Therapy Types";
            begin
                if TherapyType.Get("Therapy Type") then
                    "Therapy Description" := TherapyType.Description;
            end;
        }
        field(50012; "Therapy Description"; Text[200])
        {
        }
        field(50013; "Branch"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(50014; Section; Option)
        {
            OptionMembers = ,Therapy,Consultation,Laboratory,Imaging,Pharmacy,"Procedure"; //REFACTOR: Move this to enum
        }
    }
    keys
    {
        key(PK; "Line No", "Booking No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Prebooked: Record "HMS Patient Appointmnt Bookng";
    begin
        Prebooked.Reset();
        Prebooked.SetRange(Prebooked."Appointment Booking No", "Booking No.");
        if Prebooked.FindFirst() then begin
            "Patient No." := Prebooked."Patient No";
            Branch := Prebooked.Branch;
            "Booked Ward" := Prebooked.Ward;
            "Therapy Session" := Prebooked."Therapy Session";
            Bed := Prebooked.Bed;
            "Booked Time" := Prebooked."Appointment Time";
            "Therapy Type" := Prebooked."Therapy Type";
            Validate("Therapy Type");
            Validate(Bed);
        end;
    end;
}
