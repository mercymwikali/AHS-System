Page 85645 "HR Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = List;
    SourceTable = "HR Employee Kin";
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
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Date Of Birth field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        FrmCalendar.SetDate("Date Of Birth");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Birth" := D;
                        */
                    end;
                }
                field(Percentage; Rec."Percentage(%)")
                {
                    ToolTip = 'Specifies the value of the Percentage(%) field.';
                }
                field(Occupation; Rec.Occupation)
                {
                    ToolTip = 'Specifies the value of the Occupation field.';
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
