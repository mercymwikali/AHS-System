namespace HMISBC.HMISBC;

query 85099 "HMS Setup Lab Tests"
{
    Caption = 'HMS Setup Lab Test';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSetupLabTest; "HMS Setup Lab Test")
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
            column(MeasurementProc; MeasurementProc)
            {
            }
            column(TestType; Department)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
