namespace HMISBC.HMISBC;

using System.Security.User;

pageextension 52202462 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter("Allow Deferral Posting To")
        {
            field("Branch Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Branch Code field.';
            }
        }
        addafter(PhoneNo)
        {
            field("Cash Account No"; Rec."Cash Account No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cash Account No field.', Comment = '%';
            }
            field("Petty Cash Account No"; Rec."Petty Cash Account No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Petty Cash Account No field.', Comment = '%';
            }

            field("Can Edit HMS Setups"; Rec."Can Edit HMS Setups")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Can Edit HMS Setups field.';
            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Employee No. field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("Can Edit Charges"; Rec."Can Edit Charges")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Can Edit Charges field.';
            }
            
        }
    }
}
