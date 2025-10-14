Report 52202649 "Vote Book Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/VoteBookBalance.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Committment Amount", "Net Change", "Budgeted Amount";
            DataItemTableView = sorting("No.") order(ascending) where("Budget Controlled" = const(true), "Account Type" = const(Posting));
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(ReportForNavId_6710; 6710)
            {
            }
            column(No_GLAccount; "G/L Account"."No.")
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            column(BudgetedAmount_GLAccount; "G/L Account"."Budgeted Amount")
            {
            }
            column(NetChange_GLAccount; "G/L Account"."Net Change")
            {
            }
            column(CommittmentAmount_GLAccount; "G/L Account"."Committment Amount")
            {
            }
            column(Balance; "G/L Account"."Budgeted Amount" - ("G/L Account"."Net Change" + "G/L Account"."Committment Amount"))
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(Campus; "G/L Account".GetFilter("Global Dimension 1 Filter"))
            {
            }
            column(Dept; "G/L Account".GetFilter("Global Dimension 2 Filter"))
            {
            }
            column(Datefilter; "G/L Account".GetFilter("Date Filter"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                "G/L Account"."Budget Controlled" := true;
                "G/L Account".Modify();
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
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
}
