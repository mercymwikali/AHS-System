namespace HMISBC.HMISBC;

query 85066 "Admission Form Process"
{
    Caption = 'Admission Form Process';
    QueryType = Normal;

    elements
    {
        dataitem(HMSAdmissionFormProcess; "HMS Admission Form Process")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(Mandatory; Mandatory)
            {
            }
            column(NurseUserId; "Nurse UserId")
            {
            }
            column(Performed; Performed)
            {
            }
            column(Process; Process)
            {
            }
            column(ProcessCode; "Process Code")
            {
            }
            column(ProcessDate; "Process Date")
            {
            }
            column(ProcessTime; "Process Time")
            {
            }
            column(Remarks; Remarks)
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
