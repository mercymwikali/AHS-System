table 85304 "MSE Form List"
{
    Caption = 'MSE Form List';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Patient No."; Code[30])
        {
            Caption = 'Patient No.';
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50002; Date; Date)
        {
            Caption = 'Date';
        }
        field(50003; Category; Text[100])
        {
            Caption = 'Category';
            TableRelation = "IP Form Lookup Values".Category where(Type = const("IP Form Types"::"MSE Form"));
        }
        field(50004; Descriptor; Text[150])
        {
            Caption = 'Descriptor';
            TableRelation = "IP Form Lookup Values".Description where(Category = field(Category));
        }
        field(50005; Comments; Text[1000])
        {
            Caption = 'Comments';
        }
        field(50006; "Observation Type"; Option)
        {
            OptionMembers = History,Visit,Admission;
        }
        field(50007; "Link No."; Code[20])
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
