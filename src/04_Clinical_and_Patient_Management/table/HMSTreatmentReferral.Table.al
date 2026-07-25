Table 85273 "HMS Treatment Referral"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
        }
        field(50001; "Hospital No."; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(50002; "Hospital Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Hospital No.")));
            FieldClass = FlowField;
        }
        field(50003; "Date Referred"; Date)
        {
        }
        field(50004; "Contact person"; Text[30])
        {
            CalcFormula = lookup(Vendor.Contact where("No." = field("Hospital No.")));
            FieldClass = FlowField;
        }
        field(50005; "Referral Reason"; Code[20])
        {
        }
        field(50006; "Referral Remarks"; Text[100])
        {
        }
        field(50007; Status; Option)
        {
            CalcFormula = lookup("HMS Referral Header".Status where("Treatment no." = field("Treatment No."),
                                                                     "Hospital No." = field("Hospital No.")));
            FieldClass = FlowField;
            OptionMembers = New,Referred,Released;
        }
        field(50008; "Clinical History & Treatment"; Text[250])
        {
        }
        field(50009; "Findings on Exam & Investigtn"; Text[250])
        {
        }
        field(50010; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
