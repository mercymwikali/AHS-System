Page 52203085 "HR Leave Ledger"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Ledger";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(DocumentNo; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(NoofDays; Rec."No. of Days")
                {
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }
                field(TransactionDescription; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field(LeavePeriod; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field(EntryType; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ReverseLeaveEntry)
            {
                Caption = 'Reverse Leave Entry';
                Image = ReverseLines;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Reverse Leave Entry action.';

                trigger OnAction()
                begin
                    if Rec."Entry Type" = Rec."entry type"::Allocation then
                        Error('The selected entry has already been involved in a reversal.\Please select another entry to reverse...');
                    if Confirm('This will reverse the selected Ledger entry, continue?', false) = false then
                        exit;
                    leaveLedger.Reset();
                    if leaveLedger.Find('+') then
                        lastNo := leaveLedger."Entry No." + 10
                    else
                        lastNo := 10;

                    Rec."Entry Type" := Rec."entry type"::Allocation;
                    Rec."Reversed By" := UserId;
                    Rec.Modify();

                    leaveLedger.Init();
                    leaveLedger."Entry No." := lastNo;
                    leaveLedger."Employee No" := Rec."Employee No";
                    leaveLedger."Document No" := Rec."Document No";
                    leaveLedger."Leave Type" := Rec."Leave Type";
                    leaveLedger."Transaction Date" := Rec."Transaction Date";
                    leaveLedger."Transaction Type" := Rec."Transaction Type";
                    leaveLedger."No. of Days" := ((Rec."No. of Days") * (-1));
                    leaveLedger."Transaction Description" := Rec."Transaction Description";
                    leaveLedger."Leave Period" := Rec."Leave Period";
                    leaveLedger."Entry Type" := leaveLedger."entry type"::Allocation;
                    leaveLedger."Reversed By" := UserId;
                    leaveLedger.Insert();
                end;
            }
        }
    }

    var
        leaveLedger: Record "HR Leave Ledger";
        lastNo: Integer;
}
