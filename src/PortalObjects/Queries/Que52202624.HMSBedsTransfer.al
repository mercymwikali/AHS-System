namespace HMISBC.HMISBC;

query 52202624 "HMS Beds Transfer"
{
    Caption = 'HMS Beds Transfer';
    QueryType = Normal;

    elements
    {
        dataitem(HMSBedsTransfer; "HMS Beds Transfer")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(CurrentBedNo; "Current Bed No")
            {
            }
            column(CurrentWard; "Current Ward")
            {
            }
            column("Date"; "Date")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(NewBedNo; "New Bed No")
            {
            }
            column(NewWard; "New Ward")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(SystemId; SystemId)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
