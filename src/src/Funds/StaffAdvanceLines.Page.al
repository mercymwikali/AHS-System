Page 52203041 "Staff Advance Lines"
{
    PageType = ListPart;
    SourceTable = "Staff Advance Lines";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(AdvanceType; Rec."Advance Type")
                {
                    ToolTip = 'Specifies the value of the Advance Type field.';
                }
                field(No; Rec.No)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(AccountNo; Rec."Account No:")
                {
                    ToolTip = 'Specifies the value of the Account No: field.';
                }
                field(AccountName; Rec."Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
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
                field(DueDate; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(DateIssued; Rec."Date Issued")
                {
                    ToolTip = 'Specifies the value of the Date Issued field.';
                }
            }
        }
    }

    actions
    {
    }
}
