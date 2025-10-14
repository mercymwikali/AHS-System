page 52202586 "HR Applicant Referees"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "HR Applicant Referees";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Institution; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("Applicant Postal Address"; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("Applicant Email Address"; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field.';
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