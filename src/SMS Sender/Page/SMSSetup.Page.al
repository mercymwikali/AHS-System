page 52203184 "SMS Setup"
{
    ApplicationArea = All;
    Caption = 'SMS Setup';
    PageType = Card;
    SourceTable = "SMS Setup";
    UsageCategory = Administration;
    // DeleteAllowed = false;
    // InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Send SMS API URL"; Rec."Send SMS API URL")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Send SMS API URL field.';
                }
                field(ApiKey; Rec.ApiKey)
                {
                    ToolTip = 'Specifies the value of the APi Key field.';
                }
                field("Partner ID"; Rec."Partner ID")
                {
                    ToolTip = 'Specifies the value of the partner ID field.';
                }
                field(Shortcode; Rec.Shortcode)
                {
                    ToolTip = 'Specifies the value of the Shortcode field.';
                }
            }
            group(Templates)
            {
                field("Clinical Report SMS Template"; Rec."Clinical Report SMS Template")
                {
                    ToolTip = 'Specifies the value of the Clinical Report SMS Template field.';
                    Caption = 'Chief Complaints';
                    MultiLine = true;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(TestSendSMS)
            {
                ApplicationArea = All;
                Caption = 'Test Send SMS', comment = 'NLB="Send SMS"';
                Promoted = true;
                ToolTip = 'Test Send SMS';

                trigger OnAction()
                var
                    SMSIntegrationManagement: Codeunit "SMS Integration Management";

                begin
                    // SMSIntegrationManagement.SendSMS('0727750213', 'Hello From CHG Test SMS Integration');
                    SMSIntegrationManagement.SendSMS('0714419825', 'Hello From CHG Test SMS Integration');
                    // SMSIntegrationManagement.SendSMS('0715933401', 'Hello From CHG Test SMS Integration');
                end;
            }
            action(smsTemplating)
            {
                ApplicationArea = All;
                Caption = 'SMS Templates';
                Image = Template;
                RunObject = page "SMS Templates List";
                RunPageMode = Edit;
                ToolTip = 'Executes the SMS Templates List action.';
            }
        }
    }
}
