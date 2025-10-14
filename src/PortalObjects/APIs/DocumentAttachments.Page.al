namespace HMISBC.HMISBC;

using Microsoft.Foundation.Attachment;

page 52203243 "DocumentAttachmentsApi"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'hmisbc';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'documentAttachments';
    DelayedInsert = true;
    EntityName = 'DocumentAttachments';
    EntitySetName = 'DocumentAttachments';
    PageType = API;
    SourceTable = "Document Attachment";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(attachedBy; Rec."Attached By")
                {
                    Caption = 'Attached By';
                }
                field(attachedDate; Rec."Attached Date")
                {
                    Caption = 'Attached Date';
                }
                field(documentCategory; Rec."Document Category")
                {
                    Caption = 'Document Category';
                }
                field(documentDescription; Rec."Document Description")
                {
                    Caption = 'Document Description';
                }
                field(documentFlowPurchase; Rec."Document Flow Purchase")
                {
                    Caption = 'Flow to Purch. Trx';
                }
                field(documentFlowSales; Rec."Document Flow Sales")
                {
                    Caption = 'Flow to Sales Trx';
                }
                field(documentReferenceID; Rec."Document Reference ID")
                {
                    Caption = 'Document Reference ID';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(fileExtension; Rec."File Extension")
                {
                    Caption = 'File Extension';
                }
                field(fileName; Rec."File Name")
                {
                    Caption = 'Attachment';
                }
                field(fileType; Rec."File Type")
                {
                    Caption = 'File Type';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(no2; Rec."No. 2")
                {
                    Caption = 'No. 2';
                }
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(user; Rec.User)
                {
                    Caption = 'User';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
