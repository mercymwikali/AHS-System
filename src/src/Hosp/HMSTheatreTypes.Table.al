Table 52202489 "HMS Theatre Types"
{
    DrillDownPageID = "HMS THeatre Type List";
    LookupPageID = "HMS THeatre Type List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Total Amount"; Decimal)
        {
        }
        field(4; Type; Option)
        {
            OptionCaption = ',ORTHOPAEDIC,GENERAL,NEURO,OBSTETRICS & GYNAECOLOGY,DENTAL,Dialysis';
            OptionMembers = ,ORTHOPAEDIC,GENERAL,NEURO,"OBSTETRICS & GYNAECOLOGY",DENTAL,Dialysis;
        }
        field(5; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cash B Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Insurance B Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
