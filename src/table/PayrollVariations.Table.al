Table 85504 "Payroll Variations"
{
    fields
    {
        field(50000; "Employee Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Payroll Period"; Date)
        {
        }
        field(50002; Type; Option)
        {
            OptionMembers = " ","New Employee","Salary Change","Allowance Change","Overtime Claim","Staff Transfer";
        }
        field(50003; "Basic Pay"; Decimal)
        {
        }
        field(50004; "Effective Date"; Date)
        {
        }
        field(50005; "Transaction Code"; Code[20])
        {
            TableRelation = "PR Transaction Codes";
        }
        field(50006; "New Amount"; Decimal)
        {
        }
        field(50007; "Hrs Worked"; Decimal)
        {
        }
        field(50008; "Overtime Type"; Option)
        {
            OptionMembers = " ","2Hr","1.5Hr";
        }
        field(50009; "Created By"; Code[20])
        {
        }
        field(50010; "Date Created"; Date)
        {
        }
        field(50011; Status; Option)
        {
            OptionMembers = Open,Approved,Rejected;
        }
        field(50012; "Approved By"; Code[20])
        {
        }
        field(50013; Closed; Boolean)
        {
        }
        field(50014; "Date Closed"; Date)
        {
        }
        field(50015; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            "Payroll Period" := PayPeriod."Date Opened";
    end;

    var
        PayPeriod: Record "prPayroll Periods";
}
