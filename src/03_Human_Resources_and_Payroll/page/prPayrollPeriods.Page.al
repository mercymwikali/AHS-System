Page 85784 "prPayroll Periods"
{
    PageType = List;
    SourceTable = "prPayroll Periods";
    SourceTableView = sorting("Date Opened")
                      order(descending);
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(PeriodMonth; Rec."Period Month")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(PeriodName; Rec."Period Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Name field.';
                }
                field(DateOpened; Rec."Date Opened")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Opened field.';
                }
                field(DateClosed; Rec."Date Closed")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Closed field.';
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(PayrollCode; Rec."Payroll Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
                field(Payslipmessage; Rec."Payslip Message")
                {
                    Caption = 'Payslip message';
                    ToolTip = 'Specifies the value of the Payslip message field.';
                }
                field(ViewOnline; Rec."Allow View of Online Payslips")
                {
                    Caption = 'View Online';
                    ToolTip = 'Specifies the value of the View Online field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Close Period action.';

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod();

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'PLEASE Confirm You Want to Close [' + strPeriodName + ']';

                    //For Multiple Payroll
                    ContrInfo.Get();
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.SetCurrentkey(EntryNo);
                        if PayrollType.FindFirst() then begin
                            NoofRecords := PayrollType.Count;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next() = 0;
                        end;

                        Selection := StrMenu(PayrollDefined, 3);
                        PayrollType.Reset();
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then
                            PayrollCode := PayrollType."Payroll Code";
                    end;
                    //End Multiple Payroll

                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else
                        Message('You have selected NOT to Close the period');
                end;
            }
            action("Create Initial Period")

            {
                Caption = 'Create Initial Payroll Period';
                Image = Create;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "prCreate Payroll Period";
                ToolTip = 'Executes the Create Initial Payroll Period action.';
            }
            action(updateP9)
            {
                Caption = 'Update Current P9 Date';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Update P9 Date action.';

                trigger OnAction()
                begin
                    if not (Rec.Closed) then
                        Error('The period is still open!');
                    if not (Confirm('Update P9 information for ' + Rec."Period Name" + '?')) then
                        Error('Cancelled by user!');
                    Clear(objOcx);
                    objOcx.fnP9PeriodClosure(Rec."Period Month", Rec."Period Year", Rec."Date Opened", Rec."Payroll Code");
                    Message('P9 information for ' + Rec."Period Name" + ' Successfully updated.');
                end;
            }
            action(p9aLL)
            {
                Caption = 'Generate P9 All';
                ToolTip = 'Executes the p9 aLL action.';

                trigger OnAction()
                begin
                    PayPeriod.Reset();
                    // PayPeriod.SetFilter(PayPeriod."Date Opened", '%1..%2', 20190103D, 20190109D);
                    if PayPeriod.FindSet() then
                        repeat
                            Clear(objOcx);
                            objOcx.fnP9PeriodClosure(PayPeriod."Period Month", PayPeriod."Period Year", PayPeriod."Date Opened", PayPeriod."Payroll Code");
                        until PayPeriod.Next() = 0;

                    Message('P9 information for ' + Rec."Period Name" + ' Successfully updated.');
                end;
            }
        }
    }

    var
        ContrInfo: Record "Control-Information";
        PayPeriod: Record "prPayroll Periods";
        PayrollType: Record "prPayroll Type";
        objOcx: Codeunit prPayrollProcessing;
        Answer: Boolean;
        PayrollCode: Code[10];
        dtOpenPeriod: Date;
        i: Integer;
        NoofRecords: Integer;
        Selection: Integer;
        STR1: Text;
        PayrollDefined: Text[30];
        strPeriodName: Text[30];
        Question: Text[250];

    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period'
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}
