namespace HMISBC.HMISBC;

query 85068 "Urgency Color Coding Setup"
{
    Caption = 'Urgency Color Coding Setup';
    QueryType = Normal;

    elements
    {
        dataitem(UrgencyColorCodingSetup; "Urgency Color Coding Setup")
        {
            column(ColorHexCode; "Color HexCode")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(StyleExpr; StyleExpr)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(UrgencyStatus; "Urgency Status")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
