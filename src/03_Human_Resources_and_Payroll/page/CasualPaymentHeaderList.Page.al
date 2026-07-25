Page 85747 "Casual Payment Header List"
{
    CardPageID = "Casual Header Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Casual Payment Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(PaymentMethod; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(SalaryAccount; Rec."Salary Account")
                {
                    ToolTip = 'Specifies the value of the Salary Account field.';
                }
                field(PAYEAcc; Rec."P.A.Y.E Acc")
                {
                    ToolTip = 'Specifies the value of the P.A.Y.E Acc field.';
                }
                field(NSSFAccount; Rec."NSSF Account")
                {
                    ToolTip = 'Specifies the value of the NSSF Account field.';
                }
                field(NHIFAccount; Rec.NHIFAccount)
                {
                    ToolTip = 'Specifies the value of the NHIF Account field.';
                }
                field(TotalPAYE; Rec."Total PAYE")
                {
                    ToolTip = 'Specifies the value of the Total PAYE field.';
                }
                field(TotalNHIF; Rec."Total NHIF")
                {
                    ToolTip = 'Specifies the value of the Total NHIF field.';
                }
                field(TotalNSSF; Rec."Total NSSF")
                {
                    ToolTip = 'Specifies the value of the Total NSSF field.';
                }
                field(NetPayable; Rec."Net Payable")
                {
                    ToolTip = 'Specifies the value of the Net Payable field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Statutory Deductions")
            {
                RunObject = Report "Casual payments";
                ToolTip = 'Executes the Statutory Deductions action.';
            }
        }
    }
}
