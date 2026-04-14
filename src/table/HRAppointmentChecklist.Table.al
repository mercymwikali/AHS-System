Table 85393 "HR Appointment Checklist"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then begin
                    "Employee First Name" := Employee."Known As";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; "Start Date"; Date)
        {
        }
        field(50003; Signed; Boolean)
        {
        }
        field(50004; "Employee First Name"; Text[30])
        {
        }
        field(50005; "Employee Last Name"; Text[30])
        {
        }
        field(50006; "Contract Type"; Code[20])
        {
            // TableRelation = "Contract Types".Contract;
        }
        field(50007; "End Date"; Date)
        {
        }
        field(50008; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        OK := Employee.Get("Employee No.");
        if OK then begin
            "Employee First Name" := Employee."Known As";
            "Employee Last Name" := Employee."Last Name";
        end;
    end;

    var
        Employee: Record "HR-Employee";
        OK: Boolean;
}
