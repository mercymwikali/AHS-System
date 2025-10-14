Table 52202512 "HMS Patient History Notes"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Patient No"; Code[20])
        {
        }
        field(3; "Treatment No"; Code[20])
        {
        }
        field(4; "Notes Type"; Enum "Patient History Notes Types")
        {

        }
        field(5; Notes; Blob)
        {
        }
        field(6; "Date Taken"; Date)
        {
            
        }
        field(7; "Created By"; Code[20])
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
