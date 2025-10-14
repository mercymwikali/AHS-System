Table 52202805 "HR Medical Dependants"
{
    DrillDownPageID = "Store Requisition";
    LookupPageID = "Store Requisition";

    fields
    {
        field(1; "Code"; Code[50])
        {
            TableRelation = "HR Employee Kin"."Employee Code";

            trigger OnValidate()
            begin
                EmpKin.Reset();
                EmpKin.SetRange(EmpKin."Employee Code", Code);
                if EmpKin.Find('-') then begin
                    Names := EmpKin.SurName + ' ' + EmpKin."Other Names";
                    "Date of Birth" := EmpKin."Date Of Birth";
                    "Telephone No" := EmpKin."Home Tel No";
                    Relationship := EmpKin.Relationship;
                    "Pricipal Member no" := EmpKin."Employee Code";
                end;
            end;
        }
        field(2; Dependant; Code[50])
        {
        }
        field(3; Names; Text[30])
        {
        }
        field(4; "Date of Birth"; Date)
        {
        }
        field(5; "Telephone No"; Text[30])
        {
        }
        field(6; Relationship; Code[10])
        {
        }
        field(7; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Pricipal Member no"; Code[50])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                EmpKin.Reset();
                EmpKin.SetRange(EmpKin."Employee Code", Code);
                if EmpKin.Find('-') then begin
                    Names := EmpKin.SurName + ' ' + EmpKin."Other Names";
                    "Date of Birth" := EmpKin."Date Of Birth";
                    "Telephone No" := EmpKin."Home Tel No";
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Pricipal Member no", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpKin: Record "HR Employee Kin";
}
