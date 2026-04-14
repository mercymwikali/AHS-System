table 85453 "PC Perfomance Contrating"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Performance Contracting List";
    fields
    {
        field(50000; No; code[20])
        {
        }
        field(50001; "Perfomance Indicator"; text[200])
        {
        }
        field(50002; "Unit of Measure"; text[100])
        {
        }
        field(50003; "Wt%"; Decimal)
        {
        }
        field(50004; "PC Year"; code[20])
        {
        }
        field(50005; "Status of Prev. Year"; text[200])
        {
        }
        field(50006; "Current Year Target"; text[200])
        {
        }
        field(50007; "Quarter Target"; text[200])
        {
        }
        field(50008; "Quarter Actual"; text[200])
        {
        }
        field(50009; "Quarter Variance"; text[200])
        {
        }
        field(50010; "Cummulative Actual"; text[200])
        {
        }
        field(50011; "Cummulative Variance"; text[200])
        {
        }
        field(50012; "Type"; Option)
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