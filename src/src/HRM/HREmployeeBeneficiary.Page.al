Page 52202436 "HR Employee Beneficiary"
{
    Caption = 'Employee  Beneficiaries';
    PageType = List;
    SourceTable = "HR Employee Kin";
    SourceTableView = where(Type = filter(Beneficiary));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field(SurName; Rec.SurName)
                {
                    ToolTip = 'Specifies the value of the SurName field.';
                }
                field(OtherNames; Rec."Other Names")
                {
                    ToolTip = 'Specifies the value of the Other Names field.';
                }
                field(IDNoPassportNo; Rec."ID No/Passport No")
                {
                    ToolTip = 'Specifies the value of the ID No/Passport No field.';
                }
                field(Occupation; Rec.Occupation)
                {
                    ToolTip = 'Specifies the value of the Occupation field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(OfficeTelNo; Rec."Office Tel No")
                {
                    ToolTip = 'Specifies the value of the Office Tel No field.';
                }
                field(HomeTelNo; Rec."Home Tel No")
                {
                    ToolTip = 'Specifies the value of the Home Tel No field.';
                }
                field(Percentage; Rec."Percentage(%)")
                {
                    ToolTip = 'Specifies the value of the Percentage(%) field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(NextofKin)
            {
                Caption = '&Next of Kin';
                action(Comments)
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Relative"),
                                  "No." = field("Employee Code"),
                                  "Table Line No." = field("Line No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
            }
        }
    }
}
