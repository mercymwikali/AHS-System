Table 85175 "HMS Admission Form Process"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Process Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50002; Process; Text[100])
        {
            FieldClass = Normal;
        }
        field(50003; Mandatory; Boolean)
        {
        }
        field(50004; Performed; Boolean)
        {
        }
        field(50005; "Process Date"; Date)
        {
        }
        field(50006; "Process Time"; Time)
        {
        }
        field(50007; Remarks; Text[200])
        {
        }
        field(50008; "Nurse UserId"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Process Code", "Process Date", "Process Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
