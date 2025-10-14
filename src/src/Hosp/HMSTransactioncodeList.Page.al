Page 52202675 "HMS Transaction code List"
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
                field("NHIF Capitation Covered"; Rec."NHIF Capitation Covered")
                {
                    ToolTip = 'Specifies the value of the NHIF Capitation Covered field.';
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
                field(BankAccount; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(CalculateDoctorFee; Rec."Calculate Doctor Fee")
                {
                    ToolTip = 'Specifies the value of the Calculate Doctor Fee field.';
                }
                field("Require Doctor ID"; Rec."Require Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Require Doctor ID field.';
                }
                field(InsurancePercentage; Rec."Insurance Percentage")
                {
                    ToolTip = 'Specifies the value of the Insurance Percentage field.';
                }
                field(CalculateInsuranceFee; Rec."Calculate Insurance Fee")
                {
                    ToolTip = 'Specifies the value of the Calculate Insurance Fee field.';
                }
                field("Disable Manual Billing"; Rec."Disable Manual Billing")
                {
                    ToolTip = 'Specifies the value of the Disable Manual Billing field.';
                }
                field(HideInReport; Rec."Hide InReport")
                {
                    ToolTip = 'Specifies the value of the Hide InReport field.';
                }
            }
        }
    }

    actions
    {
    }
}
