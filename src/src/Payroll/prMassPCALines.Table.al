Table 52202607 prMassPCALines
{
    fields
    {
        field(1; "Change Advice Serial No."; Code[20])
        {
        }
        field(2; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(3; "Transaction Code"; Code[30])
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
        field(4; "Transaction Name"; Text[100])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
        {
        }
        field(8; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(9; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(10; "Reference No"; Text[100])
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
