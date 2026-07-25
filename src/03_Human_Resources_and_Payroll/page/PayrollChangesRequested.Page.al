Page 85765 "Payroll Changes Requested"
{
    PageType = List;
    SourceTable = "Payroll Variations";
    SourceTableView = where(Closed = const(false));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(BasicPay; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field(EffectiveDate; Rec."Effective Date")
                {
                    ToolTip = 'Specifies the value of the Effective Date field.';
                }
                field(DepartmentCode; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(NewAmount; Rec."New Amount")
                {
                    ToolTip = 'Specifies the value of the New Amount field.';
                }
                field(HrsWorked; Rec."Hrs Worked")
                {
                    ToolTip = 'Specifies the value of the Hrs Worked field.';
                }
                field(OvertimeType; Rec."Overtime Type")
                {
                    ToolTip = 'Specifies the value of the Overtime Type field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(ApprovedBy; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Executes the Approve action.';

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Approved);
                        Rec.SetRange(Closed, false);
                        if Rec.Find('-') then
                            repeat
                                Rec.Closed := true;
                                Rec."Date Closed" := Today;
                                Rec."Approved By" := UserId;
                                Rec.Modify();
                            until Rec.Next() = 0;
                    end;
                }
                separator(Action1102756031)
                {
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ToolTip = 'Executes the Print action.';

                    trigger OnAction()
                    begin
                        Rec.Reset();
                        Report.Run(70135148);
                        Rec.Reset();
                    end;
                }
            }
        }
    }
}
