Table 52202604 "prSalary Card"
{
    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";

                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran.Amount:="Basic Pay"*(10/100);
                  prEmpTran.MODIFY;
                  END;
                  END;
                  END; */
            end;
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[20])
        {
            TableRelation = "prBasic pay PCA"."Employee Code";
        }
        field(5; "Pays NSSF"; Boolean)
        {
            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";

                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF NOT prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran2.INIT;
                  prEmpTran2."Employee Code":="Employee Code";
                  prEmpTran2."Transaction Code":=prTrans."Transaction Code";
                  prEmpTran2."Period Month":=objPeriod."Period Month";
                  prEmpTran2."Period Year":=objPeriod."Period Year";
                  prEmpTran2."Payroll Period":=objPeriod."Date Opened";
                  prEmpTran2."Transaction Name":=prTrans."Transaction Name";
                  prEmpTran2.Amount:="Basic Pay"*(10/100);
                  prEmpTran2.INSERT;
                  END;
                  END;
                  END; */
            end;
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
            CalcFormula = sum("prPeriod Transactions".Amount where("Group Order" = filter(8),
                                                                    "Sub Group Order" = filter(0 | 1),
                                                                    "Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter(<> 'Total Deductions')));
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
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('PAYE'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('NSSF'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('0007'),
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
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter('NHIF')));
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
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(28; "Cumm Employer Pension"; Decimal)
        {
            CalcFormula = sum("prEmployer Deductions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = const('0007')));
            FieldClass = FlowField;
        }
        field(29; "Pays Pension"; Boolean)
        {
        }
        field(50000; "Current Round Up"; Decimal)
        {
        }
        field(50001; "Current Round Down"; Decimal)
        {
        }
        field(50002; "Preveous Round Down"; Decimal)
        {
        }
        field(50003; "Preveous Round Up"; Decimal)
        {
        }
        field(50004; "Period Month"; Integer)
        {
        }
        field(50005; "Period Year"; Integer)
        {
        }
        field(50006; "Current Month"; Integer)
        {
        }
        field(50007; "Current Year"; Integer)
        {
        }
        field(50008; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50009; Closed; Boolean)
        {
            CalcFormula = lookup("prPayroll Periods".Closed where("Date Opened" = field("Payroll Period")));
            FieldClass = FlowField;
        }
        field(50010; "Employee Status"; Option)
        {
            CalcFormula = lookup("HR-Employee".Status where("No." = field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased;
        }
        field(50011; "Gratuity Perc."; Decimal)
        {
        }
        field(50012; "Has Pension"; Integer)
        {
            CalcFormula = count("prEmployee Transactions" where("Employee Code" = field("Employee Code"),
                                                                 "Transaction Code" = filter('352')));
            FieldClass = FlowField;
        }
        field(50013; "Pays 30% PAYE"; Boolean)
        {
            Caption = 'Pays 35% PAYE';
            DataClassification = ToBeClassified;
        }
        field(50014; "Gets PAYE Relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Pays AHL"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Pays SHA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Pays NSSF Tier 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Pays NSSF Tier 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Selected Period"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("prPayroll Periods"."Date Opened" where("Date Opened" = field("Payroll Period")));
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
        /* objPeriod.RESET;
         objPeriod.SETFILTER(objPeriod.Closed,'=%1',FALSE);
         objPeriod.SETFILTER(objPeriod."Date Opened",'<>%1',0D);
         IF objPeriod.FIND('-') THEN BEGIN
           "Period Month":=objPeriod."Period Month";
           "Period Year":=objPeriod."Period Year";
           "Payroll Period":=objPeriod."Date Opened";
         END; */
    end;
}
