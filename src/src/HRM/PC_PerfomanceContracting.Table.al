table 52202469 "PC Perfomance Contrating"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Performance Contracting List";
    fields
    {
        field(1; No; code[20])
        {
        }
        field(2; "Perfomance Indicator"; text[200])
        {
        }
        field(3; "Unit of Measure"; text[100])
        {
        }
        field(4; "Wt%"; Decimal)
        {
        }
        field(5; "PC Year"; code[20])
        {
        }
        field(6; "Status of Prev. Year"; text[200])
        {
        }
        field(7; "Current Year Target"; text[200])
        {
        }
        field(8; "Quarter Target"; text[200])
        {
        }
        field(9; "Quarter Actual"; text[200])
        {
        }
        field(10; "Quarter Variance"; text[200])
        {
        }
        field(11; "Cummulative Actual"; text[200])
        {
        }
        field(12; "Cummulative Variance"; text[200])
        {
        }
        field(13; "Type"; Option)
        {
            OptionMembers = ,Division,Department,Ministry;
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