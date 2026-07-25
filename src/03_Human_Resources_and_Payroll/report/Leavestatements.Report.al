Report 85213 "Leave statements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leavestatements.rdl';

    dataset
    {
        dataitem("HR Leave Ledger"; "HR Leave Ledger")
        {
            RequestFilterFields = "Employee No", "Transaction Date";
            column(ReportForNavId_6; 6)
            {
            }
            column(DocumentNo_HRLeaveLedger; "HR Leave Ledger"."Document No")
            {
            }
            column(LeaveType_HRLeaveLedger; "HR Leave Ledger"."Leave Type")
            {
            }
            column(TransactionDate_HRLeaveLedger; Format("HR Leave Ledger"."Transaction Date",0, '<Weekday Text>, <Month Text> <Day>'))
            {
            }
            column(EmployeeNo_HRLeaveLedger; "HR Leave Ledger"."Employee No")
            {
            }
            column(TransactionType_HRLeaveLedger; "HR Leave Ledger"."Transaction Type")
            {
            }
            column(NoofDays_HRLeaveLedger; "HR Leave Ledger"."No. of Days")
            {
            }
            column(TransactionDescription_HRLeaveLedger; "HR Leave Ledger"."Transaction Description")
            {
            }
            column(EntryType_HRLeaveLedger; "HR Leave Ledger"."Entry Type")
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Names; HREmp."First Name" + ' ' + HREmp."Middle Name" + '  ' + HREmp."Last Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if HREmp.Get("HR Leave Ledger"."Employee No") then;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(CompInf.Picture);
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
        CompInf: Record "Company Information";
        HREmp: Record "HR-Employee";
}
