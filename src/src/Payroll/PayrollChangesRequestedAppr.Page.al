Page 52202820 "Payroll Changes Requested Appr"
{
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Variations";
    SourceTableView = where(Status = filter(Approved));
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
    }
}
