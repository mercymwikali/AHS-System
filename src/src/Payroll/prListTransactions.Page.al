Page 52202801 "prList Transactions"
{
    PageType = List;
    SourceTable = "prEmployee Transactions";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';

                    trigger OnValidate()
                    begin
                        blnIsLoan := false;
                        if objTransCodes.Get(Rec."Transaction Code") then
                            Rec."Transaction Name" := objTransCodes."Transaction Name";
                        Rec."Payroll Period" := SelectedPeriod;
                        Rec."Period Month" := PeriodMonth;
                        Rec."Period Year" := PeriodYear;
                        if objTransCodes."Special Transactions" = 8 then
                            blnIsLoan := true;

                        if objTransCodes."Is Formula" = true then begin
                            empCode := Rec."Employee Code";
                            Clear(objOcx);
                            curTransAmount := objOcx.fnDisplayFrmlValues(empCode, PeriodMonth, PeriodYear, objTransCodes.Formula);
                            Rec.Amount := curTransAmount;
                        end;

                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;

                        if objTransCodes."Include Employer Deduction" = true then begin
                            curTransAmount := objOcx.fnDisplayFrmlValues(empCode, PeriodMonth, PeriodYear, objTransCodes."Is Formula for employer");
                            Rec."Employer Amount" := curTransAmount;
                        end;
                    end;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(NoofUnits; Rec."No of Units")
                {
                    ToolTip = 'Specifies the value of the No of Units field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := ROUND(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := ROUND(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := ROUND(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := ROUND(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(Norelief; Rec."No relief")
                {
                    ToolTip = 'Specifies the value of the No relief field.';
                }
                field(RecuranceIndex; Rec."Recurance Index")
                {
                    ToolTip = 'Specifies the value of the Recurance Index field.';
                }
                field(LoanTerminationReason; Rec."Loan Termination Reason")
                {
                    ToolTip = 'Specifies the value of the Loan Termination Reason field.';
                }
                field(LoanTerminationDate; Rec."Loan Termination Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Termination Date field.';
                }
                field(LoanTerminatedby; Rec."Loan Terminated by")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Terminated by field.';
                }
                field(ofRepayments; Rec."#of Repayments")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the #of Repayments field.';

                    trigger OnValidate()
                    begin
                        if blnIsLoan = true then begin
                            Rec."#of Repayments" := ROUND(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := ROUND(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(AmortizedLoanTotalRepayAmt; Rec."Amortized Loan Total Repay Amt")
                {
                    ToolTip = 'Specifies the value of the Amortized Loan Total Repay Amt field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(Membership; Rec.Membership)
                {
                    ToolTip = 'Specifies the value of the Membership field.';
                }
                field(LoanNumber; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.';
                }
                field(ReferenceNo; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Suspended; Rec.Suspended)
                {
                    ToolTip = 'Specifies the value of the Suspended field.';
                }
                field(StopforNextPeriod; Rec."Stop for Next Period")
                {
                    ToolTip = 'Specifies the value of the Stop for Next Period field.';
                }
                field(EmployerAmount; Rec."Employer Amount")
                {
                    ToolTip = 'Specifies the value of the Employer Amount field.';
                }
                field(EmployerBalance; Rec."Employer Balance")
                {
                    ToolTip = 'Specifies the value of the Employer Balance field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
    end;

    var
        objPeriod: Record "prPayroll Periods";
        objTransCodes: Record "PR Transaction Codes";
        objOcx: Codeunit prPayrollProcessing;
        blnIsLoan: Boolean;
        SelectedPeriod: Date;
        curTransAmount: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        empCode: Text[30];
        PeriodName: Text[30];
}
