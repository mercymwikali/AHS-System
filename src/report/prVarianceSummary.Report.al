Report 85306 prVarianceSummary
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prVarianceSummary.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeCode_prSalaryCard; "prSalary Card"."Employee Code")
            {
            }
            column(BasicPay_prSalaryCard; "prSalary Card"."Basic Pay")
            {
            }
            column(BPAYDiff; BPAY1 - BPAY2)
            {
            }
            column(GPAYDiff; GPAY1 - GPAY2)
            {
            }
            column(PAYEDiff; PAYE1 - PAYE2)
            {
            }
            column(NHIFDiff; NHIF1 - NHIF2)
            {
            }
            column(NSSFDiff; NSSF1 - NSSF2)
            {
            }
            column(HELBDiff; HELB1 - HELB2)
            {
            }
            column(TotalDedDiff; TotalDed1 - TotalDed2)
            {
            }
            column(NetPayDiff; NetPay1 - NetPay2)
            {
            }
            column(fullNames; fullNames)
            {
            }
            column(SelectedPeriod; SelectedPeriod)
            {
            }
            column(strPeriodName; strPeriodName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                BPAY1 := fnAmount("Employee Code", 'BPAY', SelectedPeriod);
                BPAY2 := fnAmount("Employee Code", 'BPAY', CalcDate('-1M', SelectedPeriod));
                GPAY1 := fnAmount("Employee Code", 'GPAY', SelectedPeriod);
                GPAY2 := fnAmount("Employee Code", 'GPAY', CalcDate('-1M', SelectedPeriod));
                PAYE1 := fnAmount("Employee Code", 'PAYE', SelectedPeriod);
                PAYE2 := fnAmount("Employee Code", 'PAYE', CalcDate('-1M', SelectedPeriod));
                NHIF1 := fnAmount("Employee Code", 'NHIF', SelectedPeriod);
                NHIF2 := fnAmount("Employee Code", 'NHIF', CalcDate('-1M', SelectedPeriod));
                NSSF1 := fnAmount("Employee Code", 'NSSF', SelectedPeriod);
                NSSF2 := fnAmount("Employee Code", 'NSSF', CalcDate('-1M', SelectedPeriod));
                HELB1 := fnAmount("Employee Code", 'D0032', SelectedPeriod);
                HELB2 := fnAmount("Employee Code", 'D0032', CalcDate('-1M', SelectedPeriod));
                HELB1 := fnAmount("Employee Code", 'D0026', SelectedPeriod);
                HELB2 := fnAmount("Employee Code", 'D0026', CalcDate('-1M', SelectedPeriod));
                TotalDed1 := fnAmount("Employee Code", 'TOT-DED', SelectedPeriod);
                TotalDed2 := fnAmount("Employee Code", 'TOT-DED', CalcDate('-1M', SelectedPeriod));
                NetPay1 := fnAmount("Employee Code", 'NPAY', SelectedPeriod);
                NetPay2 := fnAmount("Employee Code", 'NPAY', CalcDate('-1M', SelectedPeriod));

                fullNames := '';
                strPeriodName := '';
                //IF ((BPAY1-BPAY2)=0) THEN CurrReport.SKIP;
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "prSalary Card"."Employee Code");
                if objEmp.Find('-') then
                    fullNames := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                payrollPeriod.Reset();
                payrollPeriod.SetRange(payrollPeriod."Date Opened", SelectedPeriod);
                if payrollPeriod.Find('-') then
                    strPeriodName := payrollPeriod."Period Name";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Selected Period';
                    ToolTip = 'Specifies the value of the Selected Period field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        objEmp: Record "HR-Employee";
        payrollPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        BPAY1: Decimal;
        BPAY2: Decimal;
        GPAY1: Decimal;
        GPAY2: Decimal;
        HELB1: Decimal;
        HELB2: Decimal;
        NetPay1: Decimal;
        NetPay2: Decimal;
        NHIF1: Decimal;
        NHIF2: Decimal;
        NSSF1: Decimal;
        NSSF2: Decimal;
        PAYE1: Decimal;
        PAYE2: Decimal;
        TotalDed1: Decimal;
        TotalDed2: Decimal;
        fullNames: Text;
        strPeriodName: Text;

    local procedure fnAmount(EmpCode: Code[20]; TransCode: Code[20]; PayrollPeriod: Date) decAmount: Decimal
    begin
        decAmount := 0;
        PeriodTrans.Reset();
        PeriodTrans.SetRange(PeriodTrans."Employee Code", EmpCode);
        PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
        PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCode);
        if PeriodTrans.Find('-') then
            decAmount := PeriodTrans.Amount;
    end;
}
