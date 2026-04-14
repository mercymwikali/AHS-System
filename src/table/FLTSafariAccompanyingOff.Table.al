Table 85097 "FLT-Safari Accompanying Off."
{
    fields
    {
        field(50000; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Safari No."; Code[10])
        {
        }
        field(50002; "Employee No."; Code[10])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                emp.Reset();
                emp.SetRange(emp."No.", "Employee No.");
                if emp.Find('-') then
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(50003; "Employee Name"; Text[100])
        {
        }
        field(50004; Designation; Code[10])
        {
        }
        field(50005; "Emp. Pin No."; Code[10])
        {
        }
        field(50006; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
    }

    keys
    {
        key(Key1; "No.", "Safari No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        emp: Record "HR-Employee";
}
