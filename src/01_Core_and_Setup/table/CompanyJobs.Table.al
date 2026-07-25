Table 85376 "Company Jobs"
{
    fields
    {
        field(50000; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Job Description"; Text[250])
        {
        }
        field(50002; "No of Posts"; Integer)
        {
            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                    "Vacant Posistions" := "No of Posts" - "Occupied Position";
            end;
        }
        field(50003; "Position Reporting to"; Code[20])
        {
            TableRelation = "Company Jobs"."Job ID";
        }
        field(50004; "Occupied Position"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Position = field("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Vacant Posistions"; Integer)
        {
        }
        field(50006; "Score code"; Code[20])
        {
            TableRelation = "Score Setup";
        }
        field(50007; "Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50008; "Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50009; "Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50010; "Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50011; "Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50012; "Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(50013; "Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(50014; "Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(50015; "No of Position"; Integer)
        {
        }
        field(50016; "Total Score"; Decimal)
        {
            CalcFormula = sum("Job Requirement"."Score ID" where("Job Id" = field("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Stage filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Recruitment Stages";
        }
        field(50018; Objective; Text[250])
        {
        }
        field(50019; "Key Position"; Boolean)
        {
        }
        field(50020; Category; Code[20])
        {
        }
        field(50021; Grade; Code[20])
        {
        }
        field(50022; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50023; "2nd Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50024; "3nd Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50025; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
        key(Key2; "Vacant Posistions")
        {
        }
        key(Key3; "Dimension 1")
        {
        }
        key(Key4; "Dimension 2")
        {
        }
    }

    fieldgroups
    {
    }
}
