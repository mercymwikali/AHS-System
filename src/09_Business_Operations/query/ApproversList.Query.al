namespace HMISBC.HMISBC;

using System.Security.User;

query 85008 "Approvers List"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    QueryType = API;
    
    elements
    {
        dataitem(userSetup; "User Setup")
        {
            column(approvalTitle; "Approval Title")
            {
            }
            column(approverID; "Approver ID")
            {
            }
            column(approvermail; Approvermail)
            {
            }
            column(approvername; Approvername)
            {
            }
            column(branchCode; "Branch Code")
            {
            }
            column(department; Department)
            {
            }
            column(doctorID; "Doctor ID")
            {
            }
            column(eMail; "E-Mail")
            {
            }
            column(employeeNo; "Employee No.")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(staffNo; "Staff No")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
