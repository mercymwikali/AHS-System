table 52202462 "PC Strategic Plan Imp"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategic Plan Imp.";

    fields
    {
        field(1; "No"; code[20])
        {
        }
        field(2; "Objectives"; code[20])
        {
            TableRelation = "PC Strategic Objectives".code;
        }
        field(3; "Strategies"; code[20])
        {
            TableRelation = "PC Strategies";
        }
        field(4; "Activities"; code[20])
        {
            TableRelation = "PC Strategic Activities";
        }
        field(5; "Expected Outputs"; text[200])
        {
        }
        field(6; "Performance Indicators"; text[200])
        {
        }
        field(7; "Baseline Value"; text[200])
        {
        }
        field(8; "Overall Target"; text[200])
        {
        }
        field(9; "Time – Line"; text[50])
        {
        }
        field(10; "Annual Targets"; text[150])
        {
        }
        field(11; "Annual Budgets"; Decimal)
        {
        }
        field(12; "Overall Budget"; Decimal)
        {
        }
        field(13; "Action By"; text[100])
        {
        }
        field(14; "Type"; Option)
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