namespace HMISBC.HMISBC;

query 52202596 "Jackson Visual Form"
{
    Caption = 'Jackson Visual Form';
    QueryType = Normal;

    elements
    {
        dataitem(JacksonVisualForm; "Jackson Visual Form")
        {
            column(AdmissionNo; "Admission No")
            {
            }
            column("Date"; "Date ")
            {
            }
            column(IVLine; "IV Line ")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(Nurse; Nurse)
            {
            }
            column(Score; Score)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
