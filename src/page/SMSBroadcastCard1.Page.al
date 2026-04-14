Page 85566 "SMS Broadcast Card1"
{
    PageType = Card;
    SourceTable = "SMS Broadcast";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(SMSMessage; Rec."SMS Message")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SMS Message field.';
                }
            }
            group(Recipients)
            {
                Caption = 'Recipients';
                part(Control7; "SMS Receipients1")
                {
                    SubPageLink = Code = field(Code);
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Suggest Patients")
            {
                ApplicationArea = Basic, Suite;
                Image = Suggest;
                RunObject = Report "Suggest SMS Patients";
                ToolTip = 'Executes the Suggest Patients action.';
            }
            separator(Action10)
            {
            }
            action("Clear Recipients")
            {
                ApplicationArea = Basic, Suite;
                Image = CancelAllLines;
                ToolTip = 'Executes the Clear Recipients action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to clear the recipients?') then begin
                        SMSRece.Reset();
                        SMSRece.SetRange(SMSRece.Code, Rec.Code);
                        if SMSRece.Find('-') then
                            SMSRece.DeleteAll();
                    end;
                end;
            }
            separator(Action12)
            {
            }
            action("Post SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                ToolTip = 'Executes the Post SMS action.';

                trigger OnAction()
                begin
                    Rec.TestField("SMS Message");
                    Rec.TestField(Posted, false);
                    if Confirm('Do you really want to post the messageto all recipents?') then begin
                        SMSSend.Reset();
                        if SMSSend.Find('+') then
                            Ln := SMSSend."Entry No";

                        SMSRece.Reset();
                        SMSRece.SetRange(SMSRece.Code, Rec.Code);
                        if SMSRece.Find('-') then
                            repeat
                                Ln := Ln + 1;
                                SMSSend.Init();
                                SMSSend."Entry No" := Ln;
                                SMSSend."Phone No" := SMSRece."Phone No";
                                SMSSend.Message := Rec."SMS Message";
                                SMSSend.Status := SMSSend.Status::Pending;
                                SMSSend.Date := Today;
                                SMSSend.Code := Rec.Code;
                                SMSSend.Insert();
                            until SMSRece.Next() = 0;
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                    end;
                end;
            }
        }
    }

    var
        SMSRece: Record "SMS Receipients";
        SMSSend: Record "SMS Sender";
        Ln: Integer;
}
