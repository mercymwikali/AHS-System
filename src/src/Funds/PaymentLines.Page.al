Page 52203028 "Payment Lines"
{
    PageType = ListPart;
    SourceTable = "Payment Line";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(DocumentNo; Rec."Document No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(DocumentType; Rec."Document Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(DocumentLine; Rec."Document Line")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document Line field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';

                    trigger OnValidate()
                    var
                        BudgetControl: Record "Budgetary Control Setup";
                    begin
                        BudgetControl.get();
                        Rec.setfilter("Date Filter", '%1..%2', BudgetControl."Current Budget Start Date", BudgetControl."Current Budget End Date");
                        Rec.CalcFields("Budgeted Amount");
                        Rec.CalcFields("Committed Amount");
                        Rec.CalcFields("Actual Expenditure");
                    end;
                }
                field(CouncilNo; Rec."Council No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Council No. field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(AccountName; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(Narration; Rec."Transaction Name")
                {
                    Caption = '<Narration>';
                    ToolTip = 'Specifies the value of the <Narration> field.';
                }
                field(StudentNo; Rec."Student No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Student No field.';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';

                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        if Rec."Payment Reference" = Rec."payment reference"::"Farmer Purchase" then
                            if Rec.Amount <> xRec.Amount then
                                Error('Amount cannot be modified');

                        Rec."Amount With VAT" := Rec.Amount;
                    end;
                }
                field(NotVatable; Rec."Not Vatable")
                {
                    ToolTip = 'Specifies the value of the Not Vatable field.';
                }
                field(VATWithheldAmount; Rec."VAT Withheld Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Withheld Amount field.';
                }
                field(VATWithheldCode; Rec."VAT Withheld Code")
                {
                    ToolTip = 'Specifies the value of the VAT Withheld Code field.';
                }
                field(VATSixRate; Rec."VAT Six % Rate")
                {
                    ToolTip = 'Specifies the value of the VAT Six % Rate field.';
                }
                field(Commission; Rec.Commission)
                {
                    ToolTip = 'Specifies the value of the Commission field.';
                }
                field(WithholdingTaxCode; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                }
                field(NetAmount; Rec."Net Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Amount field.';
                }
                field(BudgetGLAccount; Rec."G/L Account")
                {
                    Caption = 'Budget G/L Account';
                    ToolTip = 'Specifies the value of the Budget G/L Account field.';
                }
                field(BudgetedAmount; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field(ActualExpenditure; Rec."Actual Expenditure")
                {
                    ToolTip = 'Specifies the value of the Actual Expenditure field.';
                }
                field(CommittedAmount; Rec."Committed Amount")
                {
                    ToolTip = 'Specifies the value of the Committed Amount field.';
                }
                field(Balances; Rec."Budgeted Amount" - Rec."Actual Expenditure" - Rec."Committed Amount")
                {
                    Caption = 'Balances';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Balances field.';
                }
                field(PAYEAmount; Rec."PAYE Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the PAYE Amount field.';
                }
                field(PAYECode; Rec."PAYE Code")
                {
                    ToolTip = 'Specifies the value of the PAYE Code field.';
                }
                field(KRAPinNo; Rec."KRA Pin No.")
                {
                    ToolTip = 'Specifies the value of the KRA Pin No. field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(WithholdingTaxAmount; Rec."Withholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Amount field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field(Committed; Rec.Committed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Committed field.';
                }
                field(BudgetaryControlAC; Rec."Budgetary Control A/C")
                {
                    ToolTip = 'Specifies the value of the Budgetary Control A/C field.';
                }
                field(VATCode; Rec."VAT Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the VAT Code field.';
                }
                field(VATRate; Rec."VAT Rate")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the VAT Rate field.';
                }
                field(VATAmount; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field(RetentionCode; Rec."Retention Code")
                {
                    ToolTip = 'Specifies the value of the Retention Code field.';
                }
                field(RetentionAmount; Rec."Retention  Amount")
                {
                    ToolTip = 'Specifies the value of the Retention  Amount field.';
                }
                field(CommisionAmount; Rec."Commision Amount")
                {
                    ToolTip = 'Specifies the value of the Commision Amount field.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        BudgetControl: Record "Budgetary Control Setup";
    begin
        BudgetControl.get();
        Rec.setfilter("Date Filter", '%1..%2', BudgetControl."Current Budget Start Date", BudgetControl."Current Budget End Date");
        Rec.CalcFields("Budgeted Amount");
        Rec.CalcFields("Committed Amount");
        Rec.CalcFields("Actual Expenditure");
    end;

    procedure GetDocNo(): Code[20]
    begin
        //EXIT("Inv Doc No");
    end;
}
