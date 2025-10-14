report 52202672 prTransactions
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = where("Transaction Amount" = filter(> 0));
            RequestFilterFields = "No.", "Period Filter", "Transaction Code Filter";
            column(No_; "No.")
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(PAYE_Number; "PAYE Number")
            {
            }
            column(NHIF_No_; "NHIF No.")
            {
            }
            column(NSSF_No_; "NSSF No.")
            {
            }
            column(Names; "First Name" + ' ' + "Last Name")
            {
            }
            column(Transaction_Amount; "Transaction Amount")
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the ActionName action.';
                }
            }
        }
    }

    var
        CompInf: record "Company Information";
}