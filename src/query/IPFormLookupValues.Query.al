namespace HMISBC.HMISBC;

query 85044 "IP Form Lookup Values"
{
    Caption = 'IP Form Lookup Values';
    QueryType = Normal;

    elements
    {
        dataitem(IPFormLookupValues; "IP Form Lookup Values")
        {
            column(Category; Category)
            {
            }
            column(Description; Description)
            {
            }
            column(SubCategory; "Sub Category")
            {
            }
            column("Type"; "Type")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
