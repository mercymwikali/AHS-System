Table 85530 prMassPCALines
{
    fields
    {
        field(50000; "Change Advice Serial No."; Code[20])
        {
        }
        field(50001; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                if objTransCodes.Get("Employee Code") then
                    "Transaction Code" := objTransCodes."Transaction Name";
                //"Payroll Period":=SelectedPeriod;
                //"Period Month":=PeriodMonth;
                //"Period Year":=PeriodYear;
                //  IF objTransCodes."Special Transactions"=8 THEN blnIsLoan:=TRUE;
            end;
        }
        field(50003; "Transaction Name"; Text[100])
        {
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; "Period Month"; Integer)
        {
        }
        field(50006; "Period Year"; Integer)
        {
        }
        field(50007; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50008; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(50009; "Reference No"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Change Advice Serial No.", "Employee Code", "Period Month", "Period Year", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        objTransCodes: Record "PR Transaction Codes";
}
