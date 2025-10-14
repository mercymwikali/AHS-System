Table 52202569 "Sec-Visitor Management"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Visitor Name"; Text[250])
        {
        }
        field(3; "ID Number"; Code[10])
        {
            trigger OnValidate()
            begin
                if "ID Number" <> '' then begin
                    HMSPatient.Reset();
                    HMSPatient.SetRange("ID Number", "ID Number");
                    if HMSPatient.FindFirst() then
                        "Patient No." := HMSPatient."Patient No.";
                end
            end;
        }
        field(4; "Phone Number"; Code[10])
        {
        }
        field(5; "Car Reg. Number"; Code[8])
        {
            TableRelation = if ("Visitor Category" = const(Employee)) "HR Employee Vehicle"."Vehicle Reg No" where("Employee No" = field("Visitor Number"));
        }
        field(6; "Person To See"; Text[150])
        {
        }
        field(7; "Purpose of Visit"; Text[150])
        {
        }
        field(8; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(9; "Visitor Pass No."; Code[10])
        {
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Entered,Converted to Patient,Cleared';
            OptionMembers = Arrived,Entered,"Converted to Patient",Cleared;
        }
        field(11; "Initiated By"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(12; "Initiated By Time"; Time)
        {
        }
        field(13; "Cleared By"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(14; "Cleared By Time"; Time)
        {
        }
        field(15; "No. Series"; Code[20])
        {
        }
        field(16; "Created Date"; Date)
        {
        }
        field(17; "Created Time"; Time)
        {
        }
        field(18; "Initiated Date"; Date)
        {
        }
        field(19; "Cleared Date"; Date)
        {
        }
        field(20; "Visitor Category"; Enum "Visitor Category")
        {

        }
        field(21; "Visitor Number"; Code[20])
        {
            TableRelation = if ("Visitor Category" = const(Patient)) "HMS Patient"."Patient No."
            else
            if ("Visitor Category" = const(Employee)) "HR-Employee"."No." where(Status = const(Normal));
            trigger OnValidate()
            begin
                case "Visitor Category" of
                    "Visitor Category"::Employee:
                        if Emp.Get("Visitor Number") then
                            "Visitor Name" := Emp.FullName();
                    "Visitor Category"::Patient:
                        if HMSPatient.Get("Visitor Number") then
                            "Visitor Name" := HMSPatient."Search Name";
                end;
            end;
        }
        field(50000; "Visitor Car Reg Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Action Recommended"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Action Taken"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Incident Details"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Incident Witness"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Incident Reported"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Incident Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Incident Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Staff,Non-Staff,Patient';
            OptionMembers = ,Staff,"Non-Staff",Patient;
        }
        field(50008; "Witness Contacts"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Witness ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Patient No."; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50011; "Global Dimension 1 Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            CaptionClass = '1,1,1';
        }
        field(50012; "Reason For Visit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',,Medication,Official';
            OptionMembers = ,,Medication,Official;

        }
        field(50013; "First Name"; Text[50])
        {
            trigger OnValidate()
            begin
                "Visitor Name" := fullName();
            end;
        }
        field(50014; "Middle Name"; Text[50])
        {
            trigger OnValidate()
            begin
                "Visitor Name" := fullName();
            end;

        }
        field(50015; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
                "Visitor Name" := fullName();
            end;

        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            GenSetu.Get();
            GenSetu.TestField(GenSetu."Visitors Nos");
            NoSeriesMgt.InitSeries(GenSetu."Visitors Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        Status := Status::Arrived;
        "Created Date" := Today;
        "Created Time" := Time;
    end;

    var
        HMSPatient: Record "HMS Patient";
        Emp: Record "HR-Employee";
        GenSetu: Record "Security Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure fullName() name: Text[250]
    begin
        name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
        exit(name);
    end;
}
