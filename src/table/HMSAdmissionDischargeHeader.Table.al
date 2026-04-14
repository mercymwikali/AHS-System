Table 85169 "HMS Admission Discharge Header"
{
    LookupPageID = "HMS Admission Discharge List";

    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50002; "Discharge Date"; Date)
        {
        }
        field(50003; "Discharge Time"; Time)
        {
        }
        field(50004; "Doctor ID"; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50005; "Nurse ID"; Code[20])
        {
        }
        field(50006; Remarks; Text[200])
        {
        }
        field(50007; Status; Option)
        {
            OptionMembers = New,Completed,Cancelled;
        }
        field(50008; "Ward No."; Code[20])
        {
        }
        field(50009; "Bed No."; Code[20])
        {
        }
        field(50010; "Date of Admission"; Date)
        {
        }
        field(50011; "Time Of Admission"; Time)
        {
        }
        field(50012; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50013; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50014; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50015; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50016; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50017; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; "Doctor Notes"; Text[200])
        {
        }
        field(50021; "Nurse Notes"; Text[200])
        {
        }
        field(50022; Invoiced; Boolean)
        {
        }
        field(50023; "Discharged By"; Code[30])
        {
        }
        field(50024; "Discharge Type"; Enum DischargeTypesEnum)
        {
            
        }
        field(50025; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50026; "Bill Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false)));
            FieldClass = FlowField;
        }
        field(50027; "Security Code"; code[20])
        {
        }
        field(50028; Branch; code[20])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50029; "Search Names"; text[250])
        {
        }
        field(50030; "Ward Room No."; Code[30])
        {
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field("Ward No."));
        }
        field(50031; "Next Apointment Slot"; Code[30])
        {
            TableRelation = "Doctor Availablity Plan".Slot where("Doctor ID" = field("Doctor ID"),
                                                                 Date = field("Next Appointment Date"),
                                                                 Booked = filter(false));
            
        }
        field(50032; "Next Appointment Date"; Date)
        {

        }
        field(50033; "Next Appointment Time"; Time)
        {

        }
        
        field(50034; "Off Duty Days"; Decimal)
        {
        }
        field(50035; "Light Duty Days"; Decimal)
        {
        }
        field(50036; "Off Duty Comments"; Text[200])
        {
        }
        field(50037; "Off Duty"; Boolean)
        {
        }
        field(50038; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(50039; "Sick Off End Date"; Date)
        {
        }
        field(50040; "Next Appointment Comments"; Text[250])
        {
            
        }
        field(50041; "Bed Released"; Boolean)
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
