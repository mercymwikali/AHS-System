Report 52202485 "Transfer Payrol P9 Info"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            RequestFilterFields = "Employee Code", "Period Year", "Period Month";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin

                pAllowances := 0;
                Gpay := 0;
                DCont := 0;
                TaxCharged := 0;
                Npay := 0;
                NSSF := 0;
                NHIF := 0;
                PAYE := 0;
                HLevy := 0;
                PRelief := 0;
                TPay := 0;
                TDeductions := 0;
                BPay := 0;
                HElb := 0;
                Pension := 0;
                IRelief := 0;

                pTrans.Reset();
                pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                pTrans.SetRange(pTrans."Period Month", "Period Month");

                if pTrans.Find('-') then begin

                    p9.Reset();
                    p9.SetRange(p9."Employee Code", "Employee Code");
                    p9.SetRange(p9."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    p9.DeleteAll();

                    //Basic Pay
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '1');
                    pTrans.SetFilter(pTrans."Sub Group Order", '1');
                    if pTrans.Find('-') then
                        BPay := pTrans.Amount;
                    //Basic Pay
                    /*
                    //HELB
                    pTrans.RESET();
                    pTrans.SETRANGE(pTrans."Employee Code","Employee Code");
                    pTrans.SETRANGE(pTrans."Payroll Period","Payroll Period");
                    pTrans.SETRANGE(pTrans."Period Month","Period Month");
                    pTrans.SETFILTER(pTrans."Transaction Name",'University Loan (HELB)');
                    IF pTrans.FIND('-') THEN
                    HElb:= pTrans.Amount;
                    //HELB
                    */
                    //Insurance Relief
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '8');
                    if pTrans.Find('-') then
                        IRelief := pTrans.Amount;
                    //Insurance Relief

                    //Pension Relief
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '2');
                    if pTrans.Find('-') then
                        Pension := pTrans.Amount;
                    //Pension Relief

                    //Total Allowances
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Group Text", 'ALLOWANCE');
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '3');
                    pTrans.SetFilter(pTrans."Sub Group Order", '0');
                    if pTrans.Find('-') then
                        repeat
                            pAllowances := pAllowances + pTrans.Amount;
                        until pTrans.Next() = 0;
                    //Total Allowances

                    //Gross Pay
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '4');
                    if pTrans.Find('-') then
                        Gpay := pTrans.Amount;
                    //Gross Pay

                    //Defined Contribution
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '1');
                    if pTrans.Find('-') then
                        DCont := pTrans.Amount;
                    //Defined Contribution

                    //Taxable Pay
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '6');
                    if pTrans.Find('-') then
                        TPay := pTrans.Amount;
                    //Taxable Pay

                    //Tax Cahrged
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '7');
                    if pTrans.Find('-') then
                        TaxCharged := pTrans.Amount;
                    //Tax Cahrged

                    //PErsonal Relief
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '6');
                    pTrans.SetFilter(pTrans."Sub Group Order", '9');
                    if pTrans.Find('-') then
                        PRelief := pTrans.Amount;
                    //PErsonal Relief

                    //NSSF
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '7');
                    pTrans.SetFilter(pTrans."Sub Group Order", '1');
                    if pTrans.Find('-') then
                        NSSF := pTrans.Amount;

                    //NHIF
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '7');
                    pTrans.SetFilter(pTrans."Sub Group Order", '2');
                    if pTrans.Find('-') then
                        NHIF := pTrans.Amount;

                    //PAYE
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '7');
                    pTrans.SetFilter(pTrans."Sub Group Order", '3');
                    if pTrans.Find('-') then
                        PAYE := pTrans.Amount;

                    //HOUSING LEVY
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '7');
                    pTrans.SetFilter(pTrans."Sub Group Order", '4');
                    if pTrans.Find('-') then
                        HLEVY := pTrans.Amount;

                    //Total Deductions
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '8');
                    pTrans.SetFilter(pTrans."Sub Group Order", '9');
                    if pTrans.Find('-') then
                        TDeductions := pTrans.Amount;

                    //Net Pay
                    pTrans.Reset();
                    pTrans.SetRange(pTrans."Employee Code", "Employee Code");
                    pTrans.SetRange(pTrans."Payroll Period", "Payroll Period");
                    pTrans.SetRange(pTrans."Period Month", "Period Month");
                    pTrans.SetFilter(pTrans."Group Order", '9');
                    if pTrans.Find('-') then
                        Npay := pTrans.Amount;

                    //INSERT INTO p9 TABLE HERE
                    p9."Employee Code" := "Employee Code";
                    p9."Payroll Period" := "Payroll Period";
                    p9."Basic Pay" := BPay;
                    p9.Allowances := pAllowances;
                    //p9.Benefits:=;
                    //p9."Value Of Quarters":=;
                    p9."Defined Contribution" := DCont;
                    p9."Gross Pay" := Gpay;
                    p9."Taxable Pay" := TPay;
                    p9."Tax Charged" := TaxCharged;
                    p9."Insurance Relief" := IRelief;
                    p9."Tax Relief" := PRelief;
                    p9.PAYE := PAYE;
                    p9.NSSF := NSSF;
                    p9.NHIF := NHIF;
                    p9.Deductions := TDeductions;
                    p9."Net Pay" := Npay;
                    p9."Period Month" := "Period Month";
                    p9."Period Year" := "Period Year";
                    p9.Pension := Pension;
                    P9."Housing Levy" := HLevy;
                    p9.HELB := HElb;
                    p9.Insert();
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        p9: Record "prEmployee P9 Info";
        pTrans: Record "prPeriod Transactions";
        BPay: Decimal;
        DCont: Decimal;
        Gpay: Decimal;
        HElb: Decimal;
        HLevy: Decimal;
        IRelief: Decimal;
        NHIF: Decimal;
        Npay: Decimal;
        NSSF: Decimal;
        pAllowances: Decimal;
        PAYE: Decimal;
        Pension: Decimal;
        PRelief: Decimal;
        TaxCharged: Decimal;
        TDeductions: Decimal;
        TPay: Decimal;
}
