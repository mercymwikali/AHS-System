table 85456 "PC Strategic Plan Imp"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategic Plan Imp.";

    fields
    {
        field(50000; "No"; code[20])
        {
        }
        field(50001; "Objectives"; code[20])
        {
            TableRelation = "PC Strategic Objectives".code;
        }
        field(50002; "Strategies"; code[20])
        {
            TableRelation = "PC Strategies";
        }
        field(50003; "Activities"; code[20])
        {
            TableRelation = "PC Strategic Activities";
        }
        field(50004; "Expected Outputs"; text[200])
        {
        }
        field(50005; "Performance Indicators"; text[200])
        {
        }
        field(50006; "Baseline Value"; text[200])
        {
        }
        field(50007; "Overall Target"; text[200])
        {
        }
        field(50008; "Time – Line"; text[50])
        {
        }
        field(50009; "Annual Targets"; text[150])
        {
        }
        field(50010; "Annual Budgets"; Decimal)
        {
        }
        field(50011; "Overall Budget"; Decimal)
        {
        }
        field(50012; "Action By"; text[100])
        {
        }
        field(50013; "Type"; Option)
        {
            OptionMembers = ,Division,Department,Section;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}