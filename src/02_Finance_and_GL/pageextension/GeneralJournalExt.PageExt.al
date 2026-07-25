pageextension 85011 "General Journal Ext" extends "General Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDim3Code; ShortcutDimCode[3])
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDim4Code; ShortcutDimCode[4])
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
        }
    }

    actions
    {
        modify(SendApprovalRequestJournalLine)
        {
            trigger OnAfterAction()
            begin
                Rec."Sent For Approval" := true;
                Rec.modify();
            end;
        }
        modify(SendApprovalRequestJournalBatch)
        {
            trigger OnAfterAction()
            begin
                Rec."Sent For Approval" := true;
                Rec.modify();
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //TestField("Sent For Approval", true);
            end;
        }
    }

    var
        ShortcutDimCode: array[8] of Code[20];
}