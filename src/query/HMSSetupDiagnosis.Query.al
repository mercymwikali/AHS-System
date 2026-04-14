namespace HMISBC.HMISBC;

query 85040 "HMS Setup Diagnosis"
{
    Caption = 'HMS Setup Diagnosis';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSetupDiagnosis; "HMS Setup Diagnosis")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
            column(Edit; Edit)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
