Table 85235 "HMS Sample"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; No; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
        field(50001; "Laboratory No"; code[20])
        {
            TableRelation = "HMS Laboratory Form Header"."Laboratory No.";
        }
        field(50002; "Lab Test Code"; Code[20])
        {
            TableRelation = "HMS Laboratory Test Line"."Laboratory Test Code" where("Laboratory No." = field("Laboratory No"));
        }
        field(50003; "Test Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Lab Test Code")));
            FieldClass = FlowField;
        }
        field(50004; "Collection Date"; Date)
        {
        }
        field(50005; "Collection Time"; Time)
        {
        }
        field(50006; "Collected By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50007; "Type of Tube"; Code[50])
        {
        }
        field(50008; Quantity; Code[20])
        {
        }
        field(50009; "Unit of Measure"; Code[20])
        {
        }
        field(50010; "Receipt Rejection Date"; Date)
        {
        }
        field(50011; "Sample Retained"; Boolean)
        {
        }
        field(50012; Remarks; Text[250])
        {
        }
        field(50013; Status; Option)
        {
            OptionCaption = 'New,Received,Rejected';
            OptionMembers = New,Received,Rejected;
        }
        field(50014; "Received Rejected By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50015; Received; Boolean)
        {
        }
        field(50016; "Receipt Rejection Time"; Time)
        {
        }
        field(50017; "Reason for Rejection"; Text[250])
        {
        }
        field(50018; "Sample Retention Status"; Option)
        {
            OptionCaption = 'Discard,Retained,Referred';
            OptionMembers = Discard,Retained,Referred;
        }
        field(50019; "Date Referred"; Date)
        {
        }
        field(50020; "Time Referred"; Time)
        {
        }
        field(50021; "Refered By"; Code[50])
        {
        }
        field(50022; "Referal hospital"; Text[30])
        {
        }
        field(50023; "Remarks to Referal"; Text[250])
        {
        }
        field(50024; TAT; Text[50])
        {
        }
        field(50025; "Lab Unique ID"; integer)
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
