table 52202454 "Equipment Maint Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Asset No."; code[20])
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
        field(2; "Description."; Text[100])
        {
        }
        field(3; "Serial No."; code[50])
        {
        }
        field(4; "Date of Calibration"; date)
        {
        }
        field(5; "Date due for Calibration"; date)
        {
        }
        field(6; "Remarks"; text[200])
        {
        }
        field(7; Type; Option)
        {
            OptionCaption = ',Calibration,Maintainance';
            OptionMembers = ,Calibration,Maintainance;
        }
        field(8; "Correction Measure"; text[200])
        {
        }
        field(9; "Time Frame"; text[200])
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