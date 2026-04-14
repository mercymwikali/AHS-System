Page 85102 "Budgetary Control Setup"
{
    PageType = Card;
    SourceTable = "Budgetary Control Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field(CurrentBudgetCode; Rec."Current Budget Code")
                {
                    ToolTip = 'Specifies the value of the Current Budget Code field.';
                }
                field(CurrentBudgetStartDate; Rec."Current Budget Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Budget Start Date field.';
                }
                field(CurrentBudgetEndDate; Rec."Current Budget End Date")
                {
                    ToolTip = 'Specifies the value of the Current Budget End Date field.';
                }
                field(BudgetDimension1Code; Rec."Budget Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 1 Code field.';
                }
                field(BudgetDimension2Code; Rec."Budget Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 2 Code field.';
                }
                field(BudgetDimension3Code; Rec."Budget Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 3 Code field.';
                }
                field(BudgetDimension4Code; Rec."Budget Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 4 Code field.';
                }
                field(BudgetDimension5Code; Rec."Budget Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 5 Code field.';
                }
                field(BudgetDimension6Code; Rec."Budget Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Budget Dimension 6 Code field.';
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                field(AnalysisViewCode; Rec."Analysis View Code")
                {
                    ToolTip = 'Specifies the value of the Analysis View Code field.';
                }
                field(Dimension1Code; Rec."Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension 1 Code field.';
                }
                field(Dimension2Code; Rec."Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension 2 Code field.';
                }
                field(Dimension3Code; Rec."Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension 3 Code field.';
                }
                field(Dimension4Code; Rec."Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension 4 Code field.';
                }
            }
        }
    }

    actions
    {
    }
}
