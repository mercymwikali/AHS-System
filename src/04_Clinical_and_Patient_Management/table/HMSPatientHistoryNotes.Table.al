Table 85214 "HMS Patient History Notes"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Patient No"; Code[20])
        {
        }
        field(50002; "Treatment No"; Code[20])
        {
        }
        field(50003; "Notes Type"; Enum "Patient History Notes Types")
        {

        }
        field(50004; Notes; Blob)
        {
        }
        field(50005; "Date Taken"; Date)
        {
            
        }
        field(50006; "Created By"; Code[20])
        {
            
        }

    }

    keys
    {
        key(Key1; "Line No", "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Created By" = '' then
            "Created By" := Format(USERID);

        if "Date Taken" = 0D then
            "Date Taken" := WORKDATE();

    end;
}
