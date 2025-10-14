Table 52202615 "prSalary Card TEMP"
{
    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash';
            OptionMembers = "Bank Transfer",Cheque,Cash,Reli,OFI;
        }
        field(4; Currency; Code[20])
        {
            TableRelation = "prBasic pay PCA"."Employee Code";
        }
        field(5; "Pays NSSF"; Boolean)
        {
        }
        field(6; "Pays NHIF"; Boolean)
        {
        }
        field(7; "Pays PAYE"; Boolean)
        {
        }
        field(8; "Payslip Message"; Text[100])
        {
        }
        field(9; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Basic Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Gross Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cumm NetPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Net Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cumm Allowances"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Group Order" = filter(1),
                                                                    "Sub Group Order" = filter(2),
                                                                    "Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cumm Deductions"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".Deductions where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Suspend Pay"; Boolean)
        {
        }
        field(15; "Suspension Date"; Date)
        {
        }
        field(16; "Suspension Reasons"; Text[200])
        {
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
        }
        field(19; "Cumm PAYE"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".PAYE where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".NSSF where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('637'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(22; "Cumm HELB"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter('320')));
            FieldClass = FlowField;
        }
        field(23; "Cumm NHIF"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".NHIF where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(24; "Bank Account Number"; Code[50])
        {
        }
        field(25; "Bank Branch"; Code[50])
        {
        }
        field(26; "Employee's Bank"; Code[50])
        {
        }
        field(27; "Posting Group"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee;
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
}
