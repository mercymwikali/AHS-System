page 52202593 "Appraisal Card"
{
    PageType = Card;
    SourceTable = "HR Appraisal Card1";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal Code"; Rec."Appraisal Code")
                {
                    ToolTip = 'Specifies the value of the Appraisal Code field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type field.';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ToolTip = 'Specifies the value of the Appraisal Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Resp Center"; Rec."Resp Center")
                {
                    ToolTip = 'Specifies the value of the Resp Center field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
            }
            part("Appraisal Score Card"; "Appraisal Part List")
            {
                Caption = 'Appraisal Score Card';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Strategic Objectives");
            }
            part("Quarter Two Performance Review"; "Appraisal Part List")
            {
                Caption = 'Quarter Two Performance Review';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST(Quarter2);
            }
            part("Mid year Performance Review"; "Appraisal Part List")
            {
                Caption = 'Mid year Performance Review';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Mid Year");
            }
            part("End Year Performance Review"; "Appraisal Part List")
            {
                Caption = 'End Year Performance Review';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("End Year");
            }
            part("Core Competencies and Values"; "Appraisal Part List")
            {
                Caption = 'Core Competencies and Values';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Core Values");
            }
            part("Performance Improvement Plan"; "Appraisal Part List")
            {
                Caption = 'Performance Improvement Plan';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Performance Improvement Plan");
            }
            part("Learning and Development"; "Appraisal Part List")
            {
                Caption = 'Learning and Development';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Learning and Development");
            }
            part("Notes and Validation"; "Appraisal Part List")
            {
                Caption = 'Notes and Validation';
                SubPageLink = "Document No" = FIELD("Appraisal Code"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Section = CONST("Notes and Validation");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Employee")
            {
                Caption = '&Employee';
                action("print report")
                {
                    Caption = 'print report';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Report "HR Employee PIF";
                    ToolTip = 'Executes the print report action.';
                }
            }
        }
    }
}
