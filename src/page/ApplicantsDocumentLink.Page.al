Page 85582 "Applicants Document Link"
{
    PageType = ListPart;
    SourceTable = "Applicants Document Link";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(DocumentDescription; Rec."Document Description")
                {
                    ToolTip = 'Specifies the value of the Document Description field.';
                }
                field(DocumentLink; Rec."Document Link")
                {
                    ToolTip = 'Specifies the value of the Document Link field.';
                }
                field("Applicant No"; Rec."Applicant No")
                {
                    ToolTip = 'Specifies the value of the Applicant No field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(UserName; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(EmailAddress; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
            }
        }
    }

    actions
    {
    }
}
