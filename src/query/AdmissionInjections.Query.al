namespace HMISBC.HMISBC;

query 85067 "Admission Injections"
{
    Caption = 'Admission Injections';
    QueryType = Normal;

    elements
    {
        dataitem(HMSAdmissionInjection; "HMS Admission Injection")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column("Date"; "Date")
            {
            }
            column(InjectionCode; "Injection Code")
            {
            }
            column(InjectionName; "Injection Name")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column("Time"; "Time")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
