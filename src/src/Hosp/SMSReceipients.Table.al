Table 52202494 "SMS Receipients"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Employee,Patients';
            OptionMembers = " ",Employee,Patients;
        }
        field(3; "Account No"; Code[20])
        {
            TableRelation = if (Type = const(Patients)) "HMS Patient"."Patient No."
            else if (Type = const(Employee)) "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Account No") then
                    "Phone No" := Cust."Phone No.";
                if Emp.Get("Account No") then
                    "Phone No" := Emp."Cellular Phone Number";
                if Pat.Get("Account No") then
                    "Phone No" := Pat."Telephone No. 1";
            end;
        }
        field(4; "Phone No"; Code[20])
        {
        }
        field(5; Status; Option)
        {
            CalcFormula = lookup("SMS Sender".Status where(Code = field(Code)));
            FieldClass = FlowField;
            OptionCaption = ' ,Pending,Sent';
            OptionMembers = " ",Pending,Sent;
        }
    }

    keys
    {
        key(Key1; "Code", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        Pat: Record "HMS Patient";
        Emp: Record "HR-Employee";
}
