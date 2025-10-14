Table 52202507 "FLT-Travel Requisition Staff"
{
    fields
    {
        field(1; "Req No"; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if HrEmployee.Get("Employee No") then begin
                    "Employee Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                    Position := HrEmployee.Initials;
                end;
            end;
        }
        field(3; "Employee Name"; Text[70])
        {
        }
        field(4; Position; Text[70])
        {
        }
        field(5; "Daily Work Ticket"; Code[20])
        {
        }
        field(6; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Req No", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrEmployee: Record "HR-Employee";
}
