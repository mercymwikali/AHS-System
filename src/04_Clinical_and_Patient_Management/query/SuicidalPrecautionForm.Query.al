namespace HMISBC.HMISBC;

query 85046 "Suicidal Precaution Form"
{
    Caption = 'Suicidal Precaution Form';
    QueryType = Normal;

    elements
    {
        dataitem(SuicidalPrecautionForm; "Suicidal Precaution Form")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column("Date"; "Date")
            {
            }
            column(HandingOver; "Handing Over")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(TakingOver; "Taking Over")
            {
            }
            column("Time"; "Time")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
