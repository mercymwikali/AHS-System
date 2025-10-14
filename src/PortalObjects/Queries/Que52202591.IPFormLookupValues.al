namespace HMISBC.HMISBC;

query 52202591 "IP Form Lookup Values"
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
