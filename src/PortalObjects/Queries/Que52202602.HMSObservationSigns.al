namespace HMISBC.HMISBC;

query 52202602 "HMS Observation Signs"
{
    Caption = 'HMS Observation Signs';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationSigns; "HMS Observation Signs")
        {
            column(SignCode; "Sign Code")
            {
            }
            column(SignDescription; "Sign Description")
            {
            }
            column(System; System)
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
