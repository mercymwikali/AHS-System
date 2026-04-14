Report 85228 "Empl. Loan Balances"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Layouts/EmplLoanBalances.rdl';

    dataset
    {
        dataitem("Empl. Loan Balances"; "Empl. Loan Balances")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Employee; "Empl. Loan Balances"."Emp. Code")
            {
            }
            column(Transaction_Code; "Empl. Loan Balances"."Trans Code")
            {
            }
            column(Totals; "Empl. Loan Balances"."Total Balance")
            {
            }

            trigger OnAfterGetRecord()
            begin
                prpayperio.Reset();
                prpayperio.SetRange(prpayperio."Period Month", 11);
                prpayperio.SetRange(prpayperio."Period Year", 2015);
                if prpayperio.Find('-') then;
                empTrans.Reset();
                empTrans.SetRange(empTrans."Employee Code", "Empl. Loan Balances"."Emp. Code");
                empTrans.SetRange(empTrans."Transaction Code", "Empl. Loan Balances"."Trans Code");
                empTrans.SetRange(empTrans.Amount, "Empl. Loan Balances"."Deduction Amount");
                empTrans.SetRange(empTrans."Period Month", 11);
                empTrans.SetRange(empTrans."Period Year", 2015);
                if empTrans.Find('-') then begin
                    empTrans.Balance := "Empl. Loan Balances"."Total Balance";
                    empTrans.Amount := "Empl. Loan Balances"."Deduction Amount";
                    empTrans.Balance := "Empl. Loan Balances"."Total Balance";
                    // empTrans."Reference No":="Empl. Loan Balances"."Reference No";

                    empTrans.Modify();
                end else begin
                    empTrans.Init();
                    empTrans."Employee Code" := "Empl. Loan Balances"."Emp. Code";
                    empTrans."Transaction Code" := "Empl. Loan Balances"."Trans Code";
                    empTrans."Period Month" := 11;
                    empTrans."Period Year" := 2015;
                    empTrans."Payroll Period" := prpayperio."Date Opened";
                    empTrans.Amount := "Empl. Loan Balances"."Deduction Amount";
                    empTrans.Balance := "Empl. Loan Balances"."Total Balance";
                    empTrans."Reference No" := "Empl. Loan Balances"."Reference No";
                    empTrans."Transaction Name" := "Empl. Loan Balances"."trans Name";
                    empTrans.Insert(true);
                end;
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
        empTrans: Record "prEmployee Transactions";
        prpayperio: Record "prPayroll Periods";
}
