namespace PTL.HMISBC;

query 52202629 "Portal Sessions"
{
    Caption = 'Portal Sessions';
    QueryType = Normal;

    elements
    {
        dataitem(PortalSessions; "Portal Sessions")
        {
            column(SessionID; "Session ID")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(ExpiryDate; ExpiresAt)
            {
            }
            column(NearExpiry; "Near Expiry")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
