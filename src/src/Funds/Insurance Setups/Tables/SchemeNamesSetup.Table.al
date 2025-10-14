table 52202976 "Scheme Names Setup"
{
    Caption = 'Scheme Names Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Scheme Name"; Code[150])
        {
            Caption = 'Scheme Name';
        }
        field(3; "Insurances Linked"; Integer)
        {
            Caption = 'Insurances Linked';
            FieldClass = FlowField;
            CalcFormula = count("Insurance Scheme Setup" where("Scheme Name" = field("Scheme Name")));
        }
        field(4; "No of Patients"; Integer)
        {
            Caption = 'No of Patients';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient" where("Scheme Name" = field("Scheme Name")));
        }
    }
    keys
    {
        key(PK; "Line No", "Scheme Name")
        {
            Clustered = true;
        }
    }
}
