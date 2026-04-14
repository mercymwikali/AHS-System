namespace HMISBC.HMISBC;

page 85056 staffClaimLines
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'staffClaimLines';
    DelayedInsert = true;
    EntityName = 'staffClaimLines';
    EntitySetName = 'staffClaimLines';
    PageType = API;
    SourceTable = "Staff Claim Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(accountName; Rec."Account Name")
                {
                    Caption = 'Account Name';
                }
                field(accountNo; Rec."Account No:")
                {
                    Caption = 'Account No:';
                }
                field(actualExpenditure; Rec."Actual Expenditure")
                {
                    Caption = 'Actual Expenditure';
                }
                field(actualSpent; Rec."Actual Spent")
                {
                    Caption = 'Actual Spent';
                }
                field(advanceType; Rec."Advance Type")
                {
                    Caption = 'Claim Type';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount LCY")
                {
                    Caption = 'Amount LCY';
                }
                field(applyTo; Rec."Apply to")
                {
                    Caption = 'Apply to';
                }
                field(applyToID; Rec."Apply to ID")
                {
                    Caption = 'Apply to ID';
                }
                field(attendeeOrganizationNames; Rec."Attendee/Organization Names")
                {
                    Caption = 'Attendee/Organization Names';
                }
                field(bankPettyCash; Rec."Bank/Petty Cash")
                {
                    Caption = 'Bank/Petty Cash';
                }
                field(budgetaryControlAC; Rec."Budgetary Control A/C")
                {
                    Caption = 'Budgetary Control A/C';
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                    Caption = 'Budgeted Amount';
                }
                field(campusCode; Rec."Campus Code")
                {
                    Caption = 'Campus Code';
                }
                field(cashSurrenderAmt; Rec."Cash Surrender Amt")
                {
                    Caption = 'Cash Surrender Amt';
                }
                field(claimReceiptNo; Rec."Claim Receipt No")
                {
                    Caption = 'Claim Receipt No';
                }
                field(committed; Rec.Committed)
                {
                    Caption = 'Committed';
                }
                field(committedAmount; Rec."Committed Amount")
                {
                    Caption = 'Committed Amount';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(dateIssued; Rec."Date Issued")
                {
                    Caption = 'Date Issued';
                }
                field(dateTaken; Rec."Date Taken")
                {
                    Caption = 'Date Taken';
                }
                field(deptVchNo; Rec."Dept. Vch. No.")
                {
                    Caption = 'Dept. Vch. No.';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(expenditureDate; Rec."Expenditure Date")
                {
                    Caption = 'Expenditure Date';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(imprestHolder; Rec."Imprest Holder")
                {
                    Caption = 'Imprest Holder';
                }
                field(lecturerNo; Rec."Lecturer No")
                {
                    Caption = 'Lecturer No';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(mRNo; Rec."M.R. No")
                {
                    Caption = 'M.R. No';
                }
                field(medicalAmount; Rec."Medical Amount")
                {
                    Caption = 'Medical Amount';
                }
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
                field(purpose; Rec.Purpose)
                {
                    Caption = 'Purpose';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(surrenderDate; Rec."Surrender Date")
                {
                    Caption = 'Surrender Date';
                }
                field(surrenderDocNo; Rec."Surrender Doc No.")
                {
                    Caption = 'Surrender Doc No.';
                }
                field(surrendered; Rec.Surrendered)
                {
                    Caption = 'Surrendered';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(typeOfSurrender; Rec."Type of Surrender")
                {
                    Caption = 'Type of Surrender';
                }
            }
        }
    }
}
