Table 52202668 "HMS Admission Discharge Header"
{
    LookupPageID = "HMS Admission Discharge List";

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(3; "Discharge Date"; Date)
        {
        }
        field(4; "Discharge Time"; Time)
        {
        }
        field(5; "Doctor ID"; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(6; "Nurse ID"; Code[20])
        {
        }
        field(7; Remarks; Text[200])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = New,Completed,Cancelled;
        }
        field(9; "Ward No."; Code[20])
        {
        }
        field(10; "Bed No."; Code[20])
        {
        }
        field(11; "Date of Admission"; Date)
        {
        }
        field(12; "Time Of Admission"; Time)
        {
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(35; "Doctor Notes"; Text[200])
        {
        }
        field(36; "Nurse Notes"; Text[200])
        {
        }
        field(37; Invoiced; Boolean)
        {
        }
        field(38; "Discharged By"; Code[30])
        {
        }
        field(39; "Discharge Type"; Enum DischargeTypesEnum)
        {
            
        }
        field(40; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(41; "Bill Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false)));
            FieldClass = FlowField;
        }
        field(42; "Security Code"; code[20])
        {
        }
        field(43; Branch; code[20])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(44; "Search Names"; text[250])
        {
        }
        field(45; "Ward Room No."; Code[30])
        {
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field("Ward No."));
        }
        field(47; "Next Apointment Slot"; Code[30])
        {
            TableRelation = "Doctor Availablity Plan".Slot where("Doctor ID" = field("Doctor ID"),
                                                                 Date = field("Next Appointment Date"),
                                                                 Booked = filter(false));
            
        }
        field(48; "Next Appointment Date"; Date)
        {

        }
        field(49; "Next Appointment Time"; Time)
        {

        }
        
        field(50; "Off Duty Days"; Decimal)
        {
        }
        field(51; "Light Duty Days"; Decimal)
        {
        }
        field(52; "Off Duty Comments"; Text[200])
        {
        }
        field(53; "Off Duty"; Boolean)
        {
        }
        field(54; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(55; "Sick Off End Date"; Date)
        {
        }
        field(56; "Next Appointment Comments"; Text[250])
        {
            
        }
        field(57; "Bed Released"; Boolean)
        {
            
        }
    }

    keys
    {
        key(Key1; "Admission No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*Insert the processes to the database*/
        Process.Reset();
        if Process.Find('-') then
            repeat
                Line.Init();
                Line."Admission No." := "Admission No.";
                Line."Process Code" := Process.Code;
                Line.Insert();
            until Process.Next() = 0;
    end;

    var
        Line: Record "HMS Admission Discharge Line";
        Process: Record "HMS Setup Discharge Processes";
}
