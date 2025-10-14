namespace HMISBC.HMISBC;

query 52202601 "County Wards"
{
    Caption = 'County Wards';
    QueryType = Normal;

    elements
    {
        dataitem(CountyWards; "County Wards")
        {
            column("Code"; "Code")
            {
            }
            column(County; County)
            {
            }
            column(Name; Name)
            {
            }
            column(SubCounty; "Sub-County")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
