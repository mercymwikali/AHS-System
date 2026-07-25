namespace HMISBC.HMISBC;

query 85036 "HMS Systems"
{
    Caption = 'HMS Systems';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSystems; "HMS Systems")
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
