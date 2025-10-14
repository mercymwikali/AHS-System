page 52202442 "HR Course List"
{
    CardPageID = "HR Courses Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Courses";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Course Code field.';
                }
                field("Course Tittle"; Rec."Course Tittle")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Course Tittle field.';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Duration Units field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Re-Assessment Date"; Rec."Re-Assessment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Re-Assessment Date field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Provider field.';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cost Of Training field.';
                }
                field("No of Participants Required"; Rec."No of Participants Required")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No of Participants Required field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
            }
            systempart(Control1102755005; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Training Needs")
            {
                Caption = 'Training Needs';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Course List";
                    RunPageLink = "Course Code" = FIELD("Course Code");
                    ToolTip = 'Executes the &Card action.';
                }
            }
        }
    }
}
