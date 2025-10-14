namespace HMISBC.HMISBC;

using System.Automation;

query 52202639 "Approval Comment Line"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'ApprovalComment';
    EntitySetName = 'ApprovalComment';
    QueryType = API;
    
    elements
    {
        dataitem(approvalCommentLine; "Approval Comment Line")
        {
            column(comment; Comment)
            {
            }
            column(dateAndTime; "Date and Time")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(documentType; "Document Type")
            {
            }
            column(entryNo; "Entry No.")
            {
            }
            column(recordIDToApprove; "Record ID to Approve")
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(systemCreatedBy; SystemCreatedBy)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
            }
            column(systemModifiedBy; SystemModifiedBy)
            {
            }
            column(tableID; "Table ID")
            {
            }
            column(userID; "User ID")
            {
            }
            column(workflowStepInstanceID; "Workflow Step Instance ID")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
