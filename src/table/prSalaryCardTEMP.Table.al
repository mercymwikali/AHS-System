Table 85543 "prSalary Card TEMP"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Basic Pay"; Decimal)
        {
        }
        field(50002; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash';
            OptionMembers = "Bank Transfer",Cheque,Cash,Reli,OFI;
        }
        field(50003; Currency; Code[20])
        {
            TableRelation = "prBasic pay PCA"."Employee Code";
        }
        field(50004; "Pays NSSF"; Boolean)
        {
        }
        field(50005; "Pays NHIF"; Boolean)
        {
        }
        field(50006; "Pays PAYE"; Boolean)
        {
        }
        field(50007; "Payslip Message"; Text[100])
        {
        }
        field(50008; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Basic Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Gross Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Cumm NetPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Net Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Cumm Allowances"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Group Order" = filter(1),
                                                                    "Sub Group Order" = filter(2),
                                                                    "Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Cumm Deductions"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".Deductions where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Suspend Pay"; Boolean)
        {
        }
        field(50014; "Suspension Date"; Date)
        {
        }
        field(50015; "Suspension Reasons"; Text[200])
        {
        }
        field(50016; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50017; Exists; Boolean)
        {
        }
        field(50018; "Cumm PAYE"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".PAYE where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50019; "Cumm NSSF"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".NSSF where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50020; "Cumm Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('637'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50021; "Cumm HELB"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter('320')));
            FieldClass = FlowField;
        }
        field(50022; "Cumm NHIF"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info".NHIF where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50023; "Bank Account Number"; Code[50])
        {
        }
        field(50024; "Bank Branch"; Code[50])
        {
        }
        field(50025; "Employee's Bank"; Code[50])
        {
        }
        field(50026; "Posting Group"; Code[20])
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
