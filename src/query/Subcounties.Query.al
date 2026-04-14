namespace HMISBC.HMISBC;

query 85024 Subcounties
{
    Caption = 'Subcounties';
    QueryType = Normal;

    elements
    {
        dataitem(SubCountySetup; "Sub-County Setup")
        {
            column(CountyCode; "County Code")
            {
            }
            column(Name; Name)
            {
            }
            column(SubCountyCode; "Sub County Code")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
