Report 85311 "update employee transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/updateemployeetransactions.rdl';

    dataset
    {
        dataitem("prEmployee Transactions"; "prEmployee Transactions")
        {
            column(ReportForNavId_8174; 8174)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                prEmpTrans.INIT;
                prEmpTrans."Employee Code":="HR Staff Requisition"."No.";
                prEmpTrans."Transaction Code":="HR Staff Requisition".Date;
                prEmpTrans.VALIDATE("Transaction Code");
                prEmpTrans."Period Month":=1;
                prEmpTrans."Period Year":=2011;
                prEmpTrans."Payroll Period":=20110101D;
                //prEmpTrans.Amount:="prEmployee Trans IMP BAL".Amount;
                prEmpTrans."Amortized Loan Total Repay Amt":="HR Staff Requisition"."Employee Name";
                prEmpTrans.Balance:="HR Staff Requisition"."Campus Code";
                prEmpTrans.INSERT;
                */

                Balance := 0; //"PrLoan Balances".Balance;
                Modify();
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
}
