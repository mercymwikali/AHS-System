namespace PTL.HMISBC;

report 52202710 "Petty Cash"
{
    ApplicationArea = All;
    Caption = 'Petty Cash';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CashPaymentLineq; "Cash Payment Line q")
        {
            column(No; No)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
