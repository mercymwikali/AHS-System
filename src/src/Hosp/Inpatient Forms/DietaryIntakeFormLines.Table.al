table 52202954 "Dietary Intake Form Lines"
{
    Caption = 'Dietary Intake Form Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
        }
        field(3; Category; Text[150])
        {
            Caption = 'Category';
            TableRelation = "IP Form Lookup Values".Description where(Type = const("IP Form Types"::"Dietary Intake Form"));
        }
        field(4; Comment; Text[300])
        {
            Caption = 'Comment';
        }
    }
    keys
    {
        key(PK; "Line No", "Admission No.")
        {
            Clustered = true;
        }
    }
}
