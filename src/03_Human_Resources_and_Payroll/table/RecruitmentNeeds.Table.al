Table 85461 "Recruitment Needs"
{
    // DrillDownPageId=recruitme
    //  LookupPageID = UnknownPage39005846;

    fields
    {
        field(50000; "Need Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange(Jobs."Job ID", "Job ID");
                if Jobs.Find('-') then
                    Description := Jobs."Job Description";
            end;
        }
        field(50002; Date; Date)
        {
        }
        field(50003; Priority; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(50004; Positions; Integer)
        {
        }
        field(50005; Approved; Boolean)
        {
            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(50006; "Date Approved"; Date)
        {
        }
        field(50007; Description; Text[200])
        {
        }
        field(50008; Stage; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Recruitment Stages"."Recruitement Stage";

            trigger OnValidate()
            begin
                /*
                RShort.RESET;
                RShort.SETRANGE(RShort."Need Code","Need Code");
                RShort.SETRANGE(RShort."Stage Code",Stage);
                RShort.CALCSUMS(RShort."Desired Score");
                Score:=RShort."Desired Score";
                */
            end;
        }
        field(50009; Score; Decimal)
        {
            FieldClass = Normal;
        }
        field(50010; "Stage Code"; Code[20])
        {
            TableRelation = "Recruitment Stages"."Recruitement Stage";
        }
        field(50011; Qualified; Boolean)
        {
            FieldClass = Normal;
        }
        field(50012; "No Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(50013; "Start Date"; Date)
        {
        }
        field(50014; "End Date"; Date)
        {
            Editable = false;
        }
        field(50015; "Documentation Link"; Text[200])
        {
        }
        field(50016; "Turn Around Time"; Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Need Code", "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "Company Jobs";
}
