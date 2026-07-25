namespace HMISBC.HMISBC;

page 85054 ImprestLines
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'imprestLines';
    DelayedInsert = true;
    EntityName = 'ImprestLines';
    EntitySetName = 'ImprestLines';
    PageType = API;
    SourceTable = "Imprest Lines";
    
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
                    Caption = 'Advance Type';
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
                field(bankPettyCash; Rec."Bank/Petty Cash")
                {
                    Caption = 'Bank/Petty Cash';
                }
                field(budgetBalance; Rec."Budget Balance")
                {
                    Caption = 'Budget Balance';
                }
                field(budgetName; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                }
                field(budgetaryControlAC; Rec."Budgetary Control A/C")
                {
                    Caption = 'Budgetary Control A/C';
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                    Caption = 'Budgeted Amount';
                }
                field(cashSurrenderAmt; Rec."Cash Surrender Amt")
                {
                    Caption = 'Cash Surrender Amt';
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
                field(dailyRateAmount; Rec."Daily Rate(Amount)")
                {
                    Caption = 'Daily Rate(Amount)';
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
                field(destinationCode; Rec."Destination Code")
                {
                    Caption = 'Destination Code';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(eftAccountName; Rec."EFT Account Name")
                {
                    Caption = 'EFT Account Name';
                }
                field(eftBankAccountNo; Rec."EFT Bank Account No")
                {
                    Caption = 'EFT Bank Account No';
                }
                field(eftBankCode; Rec."EFT Bank Code")
                {
                    Caption = 'EFT Bank Code';
                }
                field(employeeJobGroup; Rec."Employee Job Group")
                {
                    Caption = 'Employee Job Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(imprestHolder; Rec."Imprest Holder")
                {
                    Caption = 'Imprest Holder';
                }
                field(imprestType; Rec."Imprest Type")
                {
                    Caption = 'Imprest Type';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(location; Rec.Location)
                {
                    Caption = 'Location';
                }
                field(mRNo; Rec."M.R. No")
                {
                    Caption = 'M.R. No';
                }
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
                field(noOfDays; Rec."No of Days")
                {
                    Caption = 'No of Days';
                }
                field(purpose; Rec.Purpose)
                {
                    Caption = 'Purpose';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
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
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
            }
        }
    }
}
