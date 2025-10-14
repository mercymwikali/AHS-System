Table 52202757 "Capitution Buffer Report"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Pantient No"; Code[10])
        {
        }
        field(2; "Entry No"; Integer)
        {
        }
        field(3; PatientName; Text[30])
        {
        }
        field(4; "Dimension Code"; Option)
        {
            OptionCaption = ',Laboratory,Pharmacy,Inpatient,Outpatient';
            OptionMembers = ,Laboratory,Pharmacy,Inpatient,Outpatient;
        }
        field(5; Cost; Decimal)
        {
        }
        field(6; "Visit No"; Code[10])
        {
        }
        field(7; "Insurance Code"; Code[10])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = filter('INSURANCE' | 'CAPITATION'));
        }
        field(8; "Insurance Name"; Text[30])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; "Document No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
