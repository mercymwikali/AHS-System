page 85801 "Audit Card"
{
    ApplicationArea = All;
    PageType = card;
    SourceTable = Audits;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Audit Programme"; Rec."Audit Programme")
                {
                    ToolTip = 'Specifies the value of the Audit Programme field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Leaders Appointment Date"; Rec."Leaders Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Leaders Appointment Date field.';
                }
                field("Members Appointment Date"; Rec."Members Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Members Appointment Date field.';
                }
                field("Audit From Date"; Rec."Audit From Date")
                {
                    ToolTip = 'Specifies the value of the Audit From Date field.';
                }
                field("Audit To Date"; Rec."Audit To Date")
                {
                    ToolTip = 'Specifies the value of the Audit To Date field.';
                }
                field("Follow Up From Date"; Rec."Follow Up From Date")
                {
                    ToolTip = 'Specifies the value of the Follow Up From Date field.';
                }
                field("Follow Up To Date"; Rec."Follow Up To Date")
                {
                    ToolTip = 'Specifies the value of the Follow Up To Date field.';
                }
                field("Review To Date"; Rec."Review To Date")
                {
                    ToolTip = 'Specifies the value of the Review To Date field.';
                }
            }
            group(Auditors)
            {
                part(Audito; Auditors)
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Audit Code" = field(Code);
                }
            }
            group(CheckList)
            {
                part(Checklis; "Audit CheckList")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Audit Code" = field(Code);
                }
            }
            group(Findings)
            {
                part(Finding; "Audit Finding Action")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Code" = field(Code);
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