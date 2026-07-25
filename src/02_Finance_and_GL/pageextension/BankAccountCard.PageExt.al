pageextension 85007 BankAccountCard extends "Bank Account Card"

{
    layout
    {
        addafter(Blocked)
        {
            field("Receipt No. Series"; Rec."Receipt No. Series")
            {
                ApplicationArea = all;
                Caption = 'Receipts No. Series';
                ToolTip = 'Specifies the value of the Receipts No. Series field.';
            }
            field("Bank Type"; Rec."Bank Type")
            {
                ApplicationArea = all;
                Caption = 'Bank Type';
                ToolTip = 'Specifies the value of the Bank Type field.';
            }
            field("Bank Account Name"; Rec."Bank Account Name")
            {
                ApplicationArea = all;
                Caption = 'Bank Account Name';
                ToolTip = 'Specifies the value of the Bank Account Name field.';
            }
            field("Maximum Cashier Holding"; Rec."Maximum Cashier Holding")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Maximum Cashier Holding field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
        }

        // Add changes to page layout here
    }
}