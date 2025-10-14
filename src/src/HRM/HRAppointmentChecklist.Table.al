Table 52202915 "HR Appointment Checklist"
{
    fields
    {
        field(1; "Employee No."; Code[20])
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
        field(3; Description; Text[100])
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; Signed; Boolean)
        {
        }
        field(6; "Employee First Name"; Text[30])
        {
        }
        field(7; "Employee Last Name"; Text[30])
        {
        }
        field(8; "Contract Type"; Code[20])
        {
            // TableRelation = "Contract Types".Contract;
        }
        field(9; "End Date"; Date)
        {
        }
        field(10; "Line No"; Integer)
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
