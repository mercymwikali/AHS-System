page 85815 "Audit Finding Action"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Audit Findings Actions";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
                field("Action Classification"; Rec."Action Classification")
                {
                    ToolTip = 'Specifies the value of the Action Classification field.';
                }
                field("Follow Up Action"; Rec."Follow Up Action")
                {
                    ToolTip = 'Specifies the value of the Follow Up Action field.';
                }
                field("Follow Up Status"; Rec."Follow Up Status")
                {
                    ToolTip = 'Specifies the value of the Follow Up Status field.';
                }
                field("Finding Code"; Rec."Finding Code")
                {
                    ToolTip = 'Specifies the value of the Finding Code field.';
                }
                field("Finding Classification"; Rec."Finding Classification")
                {
                    ToolTip = 'Specifies the value of the Finding Classification field.';
                }
                field("Correction Desc 1"; Rec."Correction Desc 1")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 1 field.';
                }
                field("Correction Desc 2"; Rec."Correction Desc 2")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 2 field.';
                }
                field("Correction Desc 3"; Rec."Correction Desc 3")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 3 field.';
                }
                field("Correction Desc 4"; Rec."Correction Desc 4")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 4 field.';
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