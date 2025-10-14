table 52202977 "Insurance Scheme Setup"
{
    Caption = 'Insurance Scheme Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Insurance Code"; Code[100])
        {
            Caption = 'Insurance Code';
            TableRelation = Customer."No." where("Customer Posting Group" = filter('INSURANCE'));
        }
        field(3; "Scheme Name"; Code[250])
        {
            Caption = 'Scheme Name';
            TableRelation = "Scheme Names Setup"."Scheme Name";
        }
    }
    keys
    {
        key(PK; "Line No","Insurance Code","Scheme Name")
        {
            Clustered = true;
        }
    }
}
