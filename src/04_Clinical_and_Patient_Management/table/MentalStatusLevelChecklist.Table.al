table 85303 "Mental Status Level Checklist"
{
    Caption = 'Mental Status Level Checklist';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
        }
        field(50002; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50003; Comments; Text[500])
        {
            Caption = 'Comments';
        }
        field(50004; Status; Text[50])
        {
            Caption = 'Status';
        }
        field(50005; "Doctor ID"; Code[30])
        { // Doctors id from Admission Form header
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Admission Form Header".Doctor where("Admission No." = field("Admission No.")));
        }
        field(50006; "Created By"; Code[30])
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
