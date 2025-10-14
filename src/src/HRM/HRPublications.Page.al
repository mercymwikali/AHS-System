Page 52202726 "HR Publications"
{
    PageType = List;
    SourceTable = "HR Publications";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(username; Rec.username)
                {
                    ToolTip = 'Specifies the value of the username field.';
                }
                field(EmailAddress; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field(TitleOfPublication; Rec."Title Of Publication")
                {
                    ToolTip = 'Specifies the value of the Title Of Publication field.';
                }
                field(Publisher; Rec.Publisher)
                {
                    ToolTip = 'Specifies the value of the Publisher field.';
                }
                field(YearOfPublication; Rec."Year Of Publication")
                {
                    ToolTip = 'Specifies the value of the Year Of Publication field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field("Field"; Rec.Field)
                {
                    ToolTip = 'Specifies the value of the Field field.';
                }
                field(NumberofAuthors; Rec."Number of Authors")
                {
                    ToolTip = 'Specifies the value of the Number of Authors field.';
                }
                field(FieldofResearch; Rec."Field of Research")
                {
                    ToolTip = 'Specifies the value of the Field of Research field.';
                }
                field(PositionofAuthor; Rec."Position of Author")
                {
                    ToolTip = 'Specifies the value of the Position of Author field.';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }
    }

    actions
    {
    }
}
