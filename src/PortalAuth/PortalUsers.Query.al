namespace PTL.HMISBC;

query 52202630 "Portal Users"
{
    Caption = 'Portal Users';
    QueryType = Normal;

    elements
    {
        dataitem(PortalUser; "Portal User")
        {
            column(UserID; "User ID")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(StaffName; "Staff Name")
            {
            }


            column(Password; Password)
            {
            }
            column(Role; Role)
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(OTPCodeUsedToday; "OTP Code Used Today")
            {
            }
            column(PortalOTPCode; "Portal OTP Code")
            {
            }
            column(PortalOTPDate; "Portal OTP Date")
            {
            }
            column(PortalOTPDevice; "Portal OTP Device")
            {
            }
            column(PortalResetToken; "Portal Reset Token")
            {
            }
            column(PortalResetTokenExpired; "Portal Reset Token Expired")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
