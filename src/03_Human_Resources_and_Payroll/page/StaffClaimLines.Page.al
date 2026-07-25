page 85029 "Staff Claim Lines"
{
    ApplicationArea = all;
    PageType = ListPart;
    SourceTable = "Staff Claim Lines";
    UsageCategory = lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Advance Type"; Rec."Advance Type")
                {
                    ToolTip = 'Specifies the value of the Claim Type field.';
                    trigger OnValidate()
                    begin
                        RecPay.Reset();
                        RecPay.SetRange(RecPay.Code, Rec."Advance Type");
                        if RecPay.Find('-') then;
                            // "Lecturer No"VISIBLE:=TRUE;
                            //"Lecturer NoVisible" := TRUE;
                    end;
                }
                field(No; Rec.No)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Account No:"; Rec."Account No:")
                {
                    ToolTip = 'Specifies the value of the Account No: field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.Validate("Account Name");
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Lecturer No"; Rec."Lecturer No")
                {
                    ToolTip = 'Specifies the value of the Lecturer No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';

                    trigger OnValidate()
                    begin
                        /*{Get the total amount paid}
                        Bal:=0;

                        PayHeader.RESET;
                        PayHeader.SETRANGE(PayHeader."Line No.",No);
                        IF PayHeader.FINDFIRST THEN
                          BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No,PayHeader."Line No.");
                            IF PayLine.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Bal:=Bal + PayLine."Pay Mode";
                                UNTIL PayLine.NEXT=0;
                              END;
                          END;
                        //Bal:=Bal + Amount;

                        IF Bal > PayHeader.Amount THEN
                          BEGIN
                            ERROR('Please ensure that the amount inserted does not exceed the amount in the header');
                          END;
                          */
                    end;
                }
                field("Medical Amount"; Rec."Medical Amount")
                {
                    ToolTip = 'Specifies the value of the Medical Amount field.';
                }
                field("Claim Receipt No"; Rec."Claim Receipt No")
                {
                    ToolTip = 'Specifies the value of the Claim Receipt No field.';
                }
                field("Expenditure Date"; Rec."Expenditure Date")
                {
                    ToolTip = 'Specifies the value of the Expenditure Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    Caption = 'Expenditure Description';
                    ToolTip = 'Specifies the value of the Expenditure Description field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Actual Expenditure"; Rec."Actual Expenditure")
                {
                    ToolTip = 'Specifies the value of the Actual Expenditure field.';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ToolTip = 'Specifies the value of the Committed Amount field.';
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        BudgControl: Record "Budgetary Control Setup";
    begin
        BudgControl.get();
        Rec.SetFilter("Date Filter", '%1..%2', BudgControl."Current Budget Start Date", BudgControl."Current Budget End Date");
        Rec.CalcFields("Committed Amount");
        Rec.CalcFields("Actual Expenditure");
        Rec.CalcFields("Budgeted Amount");
    end;

    var
        RecPay: Record "Receipts and Payment Types";
}
