page 52203036 "Imprest Details UP"
{
    ApplicationArea = Basic, Suite;
    PageType = ListPart;
    SourceTable = "Imprest Lines";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Advance Type"; Rec."Advance Type")
                {
                    ToolTip = 'Specifies the value of the Advance Type field.';
                }
                field(No; Rec.No)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Account No:"; Rec."Account No:")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Account No: field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Account Name field.';
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
                field("Imprest Holder"; Rec."Imprest Holder")
                {
                    ToolTip = 'Specifies the value of the Imprest Holder field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ToolTip = 'Specifies the value of the Date Issued field.';
                }
                field(Committed; Rec.Committed)
                {
                    ToolTip = 'Specifies the value of the Committed field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Budgetary Control A/C"; Rec."Budgetary Control A/C")
                {
                    ToolTip = 'Specifies the value of the Budgetary Control A/C field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
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

    actions
    {
        area(processing)
        {
            action("Check Line Budget")
            {
                Caption = 'Check Line Budget';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Check Line Budget action.';

                trigger OnAction()
                begin
                    "G/L Vote".Reset();
                    "G/L Vote".SetFilter("G/L Vote"."No.", Rec."Account No:");
                    "G/L Vote".SetFilter("G/L Vote"."Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    // IF "G/L Vote".FIND('-') THEN
                    REPORT.Run(50129, true, true, "G/L Vote");
                end;
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
        "G/L Vote": Record "G/L Account";
}
