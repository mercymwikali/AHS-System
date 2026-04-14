namespace PTL.HMIS;
using System.Security.User;

page 85743 "Mpesa Integration Setup"
{
    ApplicationArea = All;
    Caption = 'Mpesa Integration Setup';
    PageType = List;
    SourceTable = "Mpesa Integration Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }
                field("Short Code"; Rec."Short Code")
                {
                    ToolTip = 'Specifies the value of the Short Code field.', Comment = '%';
                }
                field("Consumer Key"; Rec."Consumer Key")
                {
                    ToolTip = 'Specifies the value of the Consumer Key field.', Comment = '%';
                }
                field("Consumer Secret"; Rec."Consumer Secret")
                {
                    ToolTip = 'Specifies the value of the Consumer Secret field.', Comment = '%';
                }
                field("API Integration Type"; Rec."API Integration Type")
                {
                    ToolTip = 'Specifies the value of the API Integration Type field.', Comment = '%';
                }
                field("CallBack URL"; Rec."CallBack URL")
                {
                    ToolTip = 'Specifies the value of the CallBack URL field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Process Customer Mpesa Payment")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Payment;
                ToolTip = 'Executes the Process Customer Mpesa Payment action.';
                trigger OnAction()
                var
                    userSetup: Record "User Setup";
                    "MpesaIntegration": Codeunit "Mpesa Integration";
                begin
                    userSetup.Get(UserId);
                    MpesaIntegration.SendTransaction(userSetup."Global Dimension 1 Code");
                end;
            }
        }
    }
}
