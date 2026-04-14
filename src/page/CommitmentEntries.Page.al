Page 85009 "Commitment Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = Committment;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(MonthBudget; Rec."Month Budget")
                {
                    ToolTip = 'Specifies the value of the Month Budget field.';
                }
                field(MonthActual; Rec."Month Actual")
                {
                    ToolTip = 'Specifies the value of the Month Actual field.';
                }
                field(Committed; Rec.Committed)
                {
                    ToolTip = 'Specifies the value of the Committed field.';
                }
                field(CommittedBy; Rec."Committed By")
                {
                    ToolTip = 'Specifies the value of the Committed By field.';
                }
                field(CommittedDate; Rec."Committed Date")
                {
                    ToolTip = 'Specifies the value of the Committed Date field.';
                }
                field(CommittedTime; Rec."Committed Time")
                {
                    ToolTip = 'Specifies the value of the Committed Time field.';
                }
                field(CommittedMachine; Rec."Committed Machine")
                {
                    ToolTip = 'Specifies the value of the Committed Machine field.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field(CancelledBy; Rec."Cancelled By")
                {
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                }
                field(CancelledDate; Rec."Cancelled Date")
                {
                    ToolTip = 'Specifies the value of the Cancelled Date field.';
                }
                field(CancelledTime; Rec."Cancelled Time")
                {
                    ToolTip = 'Specifies the value of the Cancelled Time field.';
                }
                field(CancelledMachine; Rec."Cancelled Machine")
                {
                    ToolTip = 'Specifies the value of the Cancelled Machine field.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(GLAccountNo; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field(Budget; Rec.Budget)
                {
                    ToolTip = 'Specifies the value of the Budget field.';
                }
                field(VendorCustNo; Rec."Vendor/Cust No.")
                {
                    ToolTip = 'Specifies the value of the Vendor/Cust No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(EXistGL; Rec."EXist GL")
                {
                    ToolTip = 'Specifies the value of the EXist GL field.';
                }
                field(ExistPostedInv; Rec."Exist Posted Inv")
                {
                    ToolTip = 'Specifies the value of the Exist Posted Inv field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(UploadedManually; Rec."Uploaded Manually")
                {
                    ToolTip = 'Specifies the value of the Uploaded Manually field.';
                }
                field(BudgetCheckCriteria; Rec."Budget Check Criteria")
                {
                    ToolTip = 'Specifies the value of the Budget Check Criteria field.';
                }
                field(ActualSource; Rec."Actual Source")
                {
                    ToolTip = 'Specifies the value of the Actual Source field.';
                }
                field(DocumentLineNo; Rec."Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark as Cancelled")
            {
                Image = Cancel;
                ToolTip = 'Executes the Mark as Cancelled action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to cancel the Commitment?', false) then
                        if UserRec.Get(Database.UserId) then begin
                            if UserRec."Can Edit Budget" = false then
                                Error('Please note that you dont have the rights to cancel committment!');
                            Rec.Cancelled := true;
                            Rec."Cancelled By" := Format(UserId);
                            Rec."Cancelled Date" := Today;
                            Rec."Cancelled Time" := Time;
                            Rec.Modify();
                        end else
                            Error('Please note that you dont have the rights to cancel committment!');
                end;
            }
        }
    }

    var
        UserRec: Record "User Setup";
}
