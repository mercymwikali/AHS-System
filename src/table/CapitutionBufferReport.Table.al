Table 85155 "Capitution Buffer Report"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Pantient No"; Code[10])
        {
        }
        field(50001; "Entry No"; Integer)
        {
        }
        field(50002; PatientName; Text[30])
        {
        }
        field(50003; "Dimension Code"; Option)
        {
            OptionCaption = ',Laboratory,Pharmacy,Inpatient,Outpatient';
            OptionMembers = ,Laboratory,Pharmacy,Inpatient,Outpatient;
        }
        field(50004; Cost; Decimal)
        {
        }
        field(50005; "Visit No"; Code[10])
        {
        }
        field(50006; "Insurance Code"; Code[10])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = filter('INSURANCE' | 'CAPITATION'));
        }
        field(50007; "Insurance Name"; Text[30])
        {
        }
        field(50008; Date; Date)
        {
        }
        field(50009; "Document No"; Code[20])
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
