page 85720 "Performance Contracting Card"
{
    ApplicationArea = All;
    PageType = card;
    SourceTable = "PC Perfomance Contrating";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Perfomance Indicator"; Rec."Perfomance Indicator")
                {
                    ToolTip = 'Specifies the value of the Perfomance Indicator field.';
                }
                field("PC Year"; Rec."PC Year")
                {
                    ToolTip = 'Specifies the value of the PC Year field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Wt%"; Rec."Wt%")
                {
                    ToolTip = 'Specifies the value of the Wt% field.';
                }
            }
            group(Annual)
            {
                Caption = 'Annual';
                field("Current Year Target"; Rec."Current Year Target")
                {
                    ToolTip = 'Specifies the value of the Current Year Target field.';
                }
                field("Cummulative Actual"; Rec."Cummulative Actual")
                {
                    ToolTip = 'Specifies the value of the Cummulative Actual field.';
                }
                field("Cummulative Variance"; Rec."Cummulative Variance")
                {
                    ToolTip = 'Specifies the value of the Cummulative Variance field.';
                }
                field("Status of Prev. Year"; Rec."Status of Prev. Year")
                {
                    ToolTip = 'Specifies the value of the Status of Prev. Year field.';
                }
            }
            group(Quartely)
            {
                field("Quarter Target"; Rec."Quarter Target")
                {
                    ToolTip = 'Specifies the value of the Quarter Target field.';
                }
                field("Quarter Actual"; Rec."Quarter Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter Actual field.';
                }
                field("Quarter Variance"; Rec."Quarter Variance")
                {
                    ToolTip = 'Specifies the value of the Quarter Variance field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}