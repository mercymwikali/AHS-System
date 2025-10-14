Page 52202567 "HMS Transactions code"
{
    PageType = List;
    SourceTable = "HMS Transactions code";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field(IncomeGLAccount; Rec."Income G/L Account")
                {
                    ToolTip = 'Specifies the value of the Income G/L Account field.';
                }
                field(ExpenseGLAccount; Rec."Expense G/L Account")
                {
                    ToolTip = 'Specifies the value of the Expense G/L Account field.';
                }
                field("Capitation Cost G/L Account"; Rec."Capitation Cost G/L Account")
                {
                    ToolTip = 'Specifies the value of the Capitation Cost G/L Account field.';
                }
                field(CalculateDoctorFee; Rec."Calculate Doctor Fee")
                {
                    ToolTip = 'Specifies the value of the Calculate Doctor Fee field.';
                }
                field(CalculateInsuranceFee; Rec."Calculate Insurance Fee")
                {
                    ToolTip = 'Specifies the value of the Calculate Insurance Fee field.';
                }
                field("NHIF Capitation Covered"; Rec."NHIF Capitation Covered")
                {
                    ToolTip = 'Specifies the value of the NHIF Capitation Covered field.';
                }
                field(PatientNoFilter; Rec."Patient No Filter")
                {
                    ToolTip = 'Specifies the value of the Patient No Filter field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(DateFilter; Rec."Date Filter")
                {
                    ToolTip = 'Specifies the value of the Date Filter field.';
                }
                field(PatientTypeFilter; Rec."Patient Type Filter")
                {
                    ToolTip = 'Specifies the value of the Patient Type Filter field.';
                }
                field(ReceiptAmount; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field(PostedAmount; Rec."Posted Amount")
                {
                    ToolTip = 'Specifies the value of the Posted Amount field.';
                }
                field(InvoiceAmount; Rec."Invoice Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(CashAmount; Rec."Cash Amount")
                {
                    ToolTip = 'Specifies the value of the Cash Amount field.';
                }
                field("Disable Manual Billing"; Rec."Disable Manual Billing")
                {
                    ToolTip = 'Specifies the value of the Disable Manual Billing field.';
                }
            }
        }
    }

    actions
    {
    }
}
