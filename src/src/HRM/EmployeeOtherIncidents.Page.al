Page 52203111 "Employee Other Incidents"
{
    PageType = Document;
    SourceTable = "HR-Employee";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Initials field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DepartmentCode; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field(ContractType; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field(DateOfJoin; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Join field.';
                }
            }
            part(KPA; "Other Incidents")
            {
                ApplicationArea = basic;
                SubPageLink = "Employee No" = field("No.");
            }
            label(Control1000000030)
            {
                ApplicationArea = Basic, Suite;
                CaptionClass = Text19023373;
                Style = Standard;
                StyleExpr = true;
            }
        }
    }

    actions
    {
    }

    var
        Text19023373: label 'Other Incidents';
}
