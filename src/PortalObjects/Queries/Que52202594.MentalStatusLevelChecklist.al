namespace HMISBC.HMISBC;

query 52202594 "Mental Status Level Checklist"
{
    Caption = 'Mental Status Level Checklist';
    QueryType = Normal;

    elements
    {
        dataitem(MentalStatusLevelChecklist; "Mental Status Level Checklist")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(Comments; Comments)
            {
            }
            column("Date"; "Date")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(Status; Status)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
