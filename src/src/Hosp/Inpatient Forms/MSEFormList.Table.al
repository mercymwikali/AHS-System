table 52202955 "MSE Form List"
{
    Caption = 'MSE Form List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Patient No."; Code[30])
        {
            Caption = 'Patient No.';
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Category; Text[100])
        {
            Caption = 'Category';
            TableRelation = "IP Form Lookup Values".Category where(Type = const("IP Form Types"::"MSE Form"));
        }
        field(5; Descriptor; Text[150])
        {
            Caption = 'Descriptor';
            TableRelation = "IP Form Lookup Values".Description where(Category = field(Category));
        }
        field(6; Comments; Text[1000])
        {
            Caption = 'Comments';
        }
        field(7; "Observation Type"; Option)
        {
            OptionMembers = History,Visit,Admission;
        }
        field(8; "Link No."; Code[20])
        {
            TableRelation = if ("Observation Type" = const(History)) "HMS Patient"."Patient No." where("Patient No." = field("Patient No."))
            else
            if ("Observation Type" = const(Visit)) "HMS Treatment Form Header"."Treatment No." where("Patient No." = field("Patient No."))
            else
            if ("Observation Type" = const(Admission)) "HMS Admission Form Header"."Admission No." where("Patient No." = field("Patient No."));
        }
    }
    keys
    {
        key(PK; "Line No", "Patient No.", Date)
        {
            Clustered = true;
        }
    }
}
