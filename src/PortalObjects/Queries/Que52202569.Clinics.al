namespace HMISBC.HMISBC;

query 52202569 Clinics
{
    Caption = 'Clinics';
    QueryType = Normal;

    elements
    {
        dataitem(HMSClinicsSetup; "HMS Clinics Setup")
        {
            column(DefaultClinic; "Default Clinic")
            {
            }
            column(Description; Description)
            {
            }
            column(No; No)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
