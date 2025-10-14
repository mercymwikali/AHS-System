table 52202952 "Mental Status Level Checklist"
{
    Caption = 'Mental Status Level Checklist';
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
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; Comments; Text[500])
        {
            Caption = 'Comments';
        }
        field(5; Status; Text[50])
        {
            Caption = 'Status';
        }
        field(6; "Doctor ID"; Code[30])
        { // Doctors id from Admission Form header
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Admission Form Header".Doctor where("Admission No." = field("Admission No.")));
        }
        field(7; "Created By"; Code[30])
        { // User id of who created the record

        }
    }
    keys
    {
        key(PK; "Line No", "Admission No.", Date)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Created By" = '' then 
            "Created By" := Format(USERID);
    end;
}
