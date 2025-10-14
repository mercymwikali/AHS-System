table 52202522 "HMS Ward Charges"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ward No"; code[20])
        {
        }
        field(2; "Charge Code"; code[20])
        {
            TableRelation = "HMS Charges".code;
            trigger OnValidate()
            var
                ChargeRec: Record "HMS Charges";
            begin
                if ChargeRec.get("Charge Code") then
                    "Charge Description" := ChargeRec.Description;
            end;
        }
        field(3; "Charge Description"; text[100])
        {
        }
    }

    keys
    {
        key(PK; "Ward No", "Charge Code")
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