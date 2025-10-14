Page 52203119 "Applicants Qualification"
{
    PageType = ListPart;
    SourceTable = "Applicants Qualification";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(QualificationType; Rec."Qualification Type")
                {
                    ToolTip = 'Specifies the value of the Qualification Type field.';
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field.';
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(InstitutionCompany; Rec."Institution/Company")
                {
                    ToolTip = 'Specifies the value of the Institution/Company field.';
                }
                field(ScoreID; Rec."Score ID")
                {
                    ToolTip = 'Specifies the value of the Score ID field.';
                }
            }
        }
    }

    actions
    {
    }
}
