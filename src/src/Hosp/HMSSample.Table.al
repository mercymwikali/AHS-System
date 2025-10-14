Table 52202850 "HMS Sample"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
        field(2; "Laboratory No"; code[20])
        {
            TableRelation = "HMS Laboratory Form Header"."Laboratory No.";
        }
        field(3; "Lab Test Code"; Code[20])
        {
            TableRelation = "HMS Laboratory Test Line"."Laboratory Test Code" where("Laboratory No." = field("Laboratory No"));
        }
        field(4; "Test Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Lab Test Code")));
            FieldClass = FlowField;
        }
        field(5; "Collection Date"; Date)
        {
        }
        field(6; "Collection Time"; Time)
        {
        }
        field(7; "Collected By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Type of Tube"; Code[50])
        {
        }
        field(9; Quantity; Code[20])
        {
        }
        field(10; "Unit of Measure"; Code[20])
        {
        }
        field(11; "Receipt Rejection Date"; Date)
        {
        }
        field(12; "Sample Retained"; Boolean)
        {
        }
        field(13; Remarks; Text[250])
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = 'New,Received,Rejected';
            OptionMembers = New,Received,Rejected;
        }
        field(15; "Received Rejected By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(16; Received; Boolean)
        {
        }
        field(17; "Receipt Rejection Time"; Time)
        {
        }
        field(18; "Reason for Rejection"; Text[250])
        {
        }
        field(19; "Sample Retention Status"; Option)
        {
            OptionCaption = 'Discard,Retained,Referred';
            OptionMembers = Discard,Retained,Referred;
        }
        field(20; "Date Referred"; Date)
        {
        }
        field(21; "Time Referred"; Time)
        {
        }
        field(22; "Refered By"; Code[50])
        {
        }
        field(23; "Referal hospital"; Text[30])
        {
        }
        field(24; "Remarks to Referal"; Text[250])
        {
        }
        field(25; TAT; Text[50])
        {
        }
        field(26; "Lab Unique ID"; integer)
        {
        }

    }

    keys
    {
        key(Key1; No, "Laboratory No", "Lab Test Code", "Collection Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
