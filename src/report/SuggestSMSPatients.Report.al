Report 85192 "Suggest SMS Patients"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            RequestFilterFields = "Patient No.", "Patient Type", "Active Visit No";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InsertSMS();
            end;

            trigger OnPreDataItem()
            begin
                if SMSCode = '' then
                    Error('Please select the sms code');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(SMSCode; SMSCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SMS Code';
                    TableRelation = "SMS Broadcast".Code;
                    ToolTip = 'Specifies the value of the SMS Code field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SMSCode: Code[20];

    local procedure InsertSMS()
    var
        SMSRecipients: Record "SMS Receipients";
    begin
        if (StrLen("HMS Patient"."Telephone No. 1") > 7) and (StrLen("HMS Patient"."Telephone No. 1") < 15) then begin
            SMSRecipients.Init();
            SMSRecipients.Code := SMSCode;
            SMSRecipients.Type := SMSRecipients.Type::Patients;
            SMSRecipients."Account No" := "HMS Patient"."Patient No.";
            SMSRecipients."Phone No" := CopyStr("HMS Patient"."Telephone No. 1", 1, 15);
            if CopyStr("HMS Patient"."Telephone No. 1", 1, 1) = '7' then
                SMSRecipients."Phone No" := '254' + CopyStr("HMS Patient"."Telephone No. 1", 1, 15);
            if CopyStr("HMS Patient"."Telephone No. 1", 1, 1) = '0' then
                SMSRecipients."Phone No" := '254' + CopyStr("HMS Patient"."Telephone No. 1", 2, 15);
            SMSRecipients.Insert();
        end;
    end;
}
