page 85632 "HR Courses Card"
{
    Caption = 'HR Training Courses';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Training Courses";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Specifies the value of the Course Code field.';
                }
                field("Course Tittle"; Rec."Course Tittle")
                {
                    ToolTip = 'Specifies the value of the Course Tittle field.';
                }
                field("Course Version"; Rec."Course Version")
                {
                    ToolTip = 'Specifies the value of the Course Version field.';
                }
                field("Course Version Description"; Rec."Course Version Description")
                {
                    ToolTip = 'Specifies the value of the Course Version Description field.';
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Campus Name"; Rec."Campus Name")
                {
                    Caption = 'Branch Name';
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Need Source"; Rec."Need Source")
                {
                    ToolTip = 'Specifies the value of the Need Source field.';
                }
                field("Nature of Training"; Rec."Nature of Training")
                {
                    ToolTip = 'Specifies the value of the Nature of Training field.';
                }
                field("Training Type"; Rec."Training Type")
                {
                    ToolTip = 'Specifies the value of the Training Type field.';
                }
                field("No of Participants Required"; Rec."No of Participants Required")
                {
                    ToolTip = 'Specifies the value of the No of Participants Required field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ToolTip = 'Specifies the value of the Duration Units field.';
                }
                field(Duration; Rec.Duration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Quarter Offered"; Rec."Quarter Offered")
                {
                    ToolTip = 'Specifies the value of the Quarter Offered field.';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the value of the Cost Of Training field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the value of the Provider field.';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Provider Name field.';
                }
                field("Closing Status"; Rec."Closing Status")
                {
                    ToolTip = 'Specifies the value of the Closing Status field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Mark as Closed/Open")
                {
                    Caption = '&Mark as Closed/Open';
                    Image = CloseDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Mark as Closed/Open action.';
                    trigger OnAction()
                    begin
                        if Rec.Closed then begin
                            Rec.Closed := false;
                            Message('Training need :: %1 :: has been Re-Opened', Rec."Course Tittle");
                        end
                        else begin
                            Rec.Closed := true;
                            Message('Training need :: %1 :: has been closed', Rec."Course Tittle");
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }
}
