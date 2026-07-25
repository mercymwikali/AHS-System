Table 85541 "prSalary Arrears"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee";
        }
        field(50001; "Transaction Code"; Code[20])
        {
        }
        field(50002; "Start Date"; Date)
        {
            Description = 'From when do we back date';
        }
        field(50003; "End Date"; Date)
        {
            Description = 'Upto when do we back date';
        }
        field(50004; "Salary Arrears"; Decimal)
        {
        }
        field(50005; "PAYE Arrears"; Decimal)
        {
        }
        field(50006; "Period Month"; Integer)
        {
        }
        field(50007; "Period Year"; Integer)
        {
        }
        field(50008; "Current Basic"; Decimal)
        {
        }
        field(50009; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50010; Number; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Period Month", "Period Year")
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
            "Period Month" := PayPeriod."Period Month";
        "Period Year" := PayPeriod."Period Year";

        //Get the Salary Arrears code
        TransCode.SetRange(TransCode."Special Transactions", 7);
        if TransCode.Find('-') then
            "Transaction Code" := TransCode."Transaction Code";

        //Get the staff current salary
        if SalCard.Get("Employee Code") then
            "Current Basic" := SalCard."Basic Pay";
    end;

    var
        PayPeriod: Record "prPayroll Periods";
        SalCard: Record "prSalary Card";
        TransCode: Record "PR Transaction Codes";
}
