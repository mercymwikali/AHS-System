namespace HMISBC.HMISBC;

query 52202586 "HMS Setup Radiology Types"
{
    Caption = 'HMS Setup Radiology Type';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSetupRadiologyType; "HMS Setup Radiology Type")
        {
            column(Amount; Amount)
            {
            }
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(GLAccount; "G/L Account")
            {
            }
            column(InsuranceAmount; "Insurance Amount")
            {
            }
            column(RadiologySection; "Radiology Section")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
