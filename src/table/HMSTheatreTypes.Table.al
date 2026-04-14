Table 85259 "HMS Theatre Types"
{
    DrillDownPageID = "HMS THeatre Type List";
    LookupPageID = "HMS THeatre Type List";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; "Total Amount"; Decimal)
        {
        }
        field(50003; Type; Option)
        {
            OptionCaption = ',ORTHOPAEDIC,GENERAL,NEURO,OBSTETRICS & GYNAECOLOGY,DENTAL,Dialysis';
            OptionMembers = ,ORTHOPAEDIC,GENERAL,NEURO,"OBSTETRICS & GYNAECOLOGY",DENTAL,Dialysis;
        }
        field(50004; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Cash B Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Insurance B Price"; Decimal)
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
