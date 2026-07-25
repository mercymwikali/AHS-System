Page 85418 "HMS Radiology Form Line"
{
    PageType = ListPart;
    SourceTable = "HMS Radiology Form Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(RadiologyTypeCode; Rec."Radiology Type Code")
                {
                    ToolTip = 'Specifies the value of the Radiology Type Code field.';
                }
                field(RadiologyTypeName; Rec."Radiology Type Name")
                {
                    ToolTip = 'Specifies the value of the Radiology Type Name field.';
                }
                field(RequiredInvestigation; Rec."Required Investigation")
                {
                    ToolTip = 'Specifies the value of the Required Investigation field.';
                }
                field(PreviousInvestigation; Rec."Previous Investigation")
                {
                    ToolTip = 'Specifies the value of the Previous Investigation field.';
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                }
                field(PerformedDate; Rec."Performed Date")
                {
                    ToolTip = 'Specifies the value of the Performed Date field.';
                }
                field(PerformedTime; Rec."Performed Time")
                {
                    ToolTip = 'Specifies the value of the Performed Time field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Det Custom";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}
