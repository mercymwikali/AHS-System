table 85110 "Equipment Maint Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Asset No."; code[20])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if fa.get("Asset No.") then
                    "Description." := fa.Description;
            end;
        }
        field(50001; "Description."; Text[100])
        {
        }
        field(50002; "Serial No."; code[50])
        {
        }
        field(50003; "Date of Calibration"; date)
        {
        }
        field(50004; "Date due for Calibration"; date)
        {
        }
        field(50005; "Remarks"; text[200])
        {
        }
        field(50006; Type; Option)
        {
            OptionCaption = ',Calibration,Maintainance';
            OptionMembers = ,Calibration,Maintainance;
        }
        field(50007; "Correction Measure"; text[200])
        {
        }
        field(50008; "Time Frame"; text[200])
        {
        }
    }

    keys
    {
        key(PK; "Asset No.")
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