namespace HMISBC.HMISBC;

query 85045 "IP Visitors List"
{
    Caption = 'IP Visitors List';
    QueryType = Normal;

    elements
    {
        dataitem(IPVisitorsList; "IP Visitors List")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(IdNumber; "Id Number")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(PhoneNumber; "Phone Number")
            {
            }
            column(VisitorName; "Visitor Name")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
