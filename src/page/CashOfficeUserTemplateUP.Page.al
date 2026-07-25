Page 85106 "Cash Office User Template UP"
{
 //   DataCaptionFields = UserID;
    PageType = List;
    SourceTable = "Cash Office User Template";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                }
                field(ReceiptJournalTemplate; Rec."Receipt Journal Template")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Template field.';
                }
                field(ReceiptJournalBatch; Rec."Receipt Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Batch field.';
                }
                field(ImprestTemplate; Rec."Imprest Template")
                {
                    ToolTip = 'Specifies the value of the Imprest Template field.';
                }
                field(ImprestBatch; Rec."Imprest  Batch")
                {
                    ToolTip = 'Specifies the value of the Imprest  Batch field.';
                }
                field(DefaultReceiptsBank; Rec."Default Receipts Bank")
                {
                    ToolTip = 'Specifies the value of the Default Receipts Bank field.';
                }
                field("Default Mpesa Bank"; Rec."Default Mpesa Bank")
                {
                    ToolTip = 'Specifies the value of the Default Mpesa bank Code field.';
                }
                field("Default Branch Code"; Rec."Default Branch Code")
                {
                    ToolTip = 'Specifies the value of the Default Branch Code field.';
                }
                field(DefaultPettyCashBank; Rec."Default Petty Cash Bank")
                {
                    ToolTip = 'Specifies the value of the Default Petty Cash Bank field.';
                }
                field(DefaultPaymentBank; Rec."Default Payment Bank")
                {
                    ToolTip = 'Specifies the value of the Default Payment Bank field.';
                }
                field("Default PDQ Bank"; Rec."Default PDQ Bank")
                {
                    ToolTip = 'Specifies the value of the Default Mpesa bank Code field.';
                }
                field("Default Cheque Bank"; Rec."Default Cheque Bank")
                {
                    ToolTip = 'Specifies the value of the Default Cheque bank Code field.';
                }
                field(PaymentJournalTemplate; Rec."Payment Journal Template")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Template field.';
                }
                field(PaymentJournalBatch; Rec."Payment Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Batch field.';
                }
                field(PettyCashTemplate; Rec."Petty Cash Template")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Template field.';
                }
                field(PettyCashBatch; Rec."Petty Cash Batch")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Batch field.';
                }
                field(InterBankTemplateName; Rec."Inter Bank Template Name")
                {
                    ToolTip = 'Specifies the value of the Inter Bank Template Name field.';
                }
                field(InterBankBatchName; Rec."Inter Bank Batch Name")
                {
                    ToolTip = 'Specifies the value of the Inter Bank Batch Name field.';
                }
                field(BankPayInJournalTemplate; Rec."Bank Pay In Journal Template")
                {
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Template field.';
                }
                field(BankPayInJournalBatch; Rec."Bank Pay In Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Batch field.';
                }
            }
        }
    }

    actions
    {
    }
}
