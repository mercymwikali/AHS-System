namespace HMISBC.HMISBC;

query 52202573 "Marketing Strategies"
{
    Caption = 'Marketing Strategies';
    QueryType = Normal;

    elements
    {
        dataitem(MarketingStrategies; "Marketing Strategies")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
