Page 52202783 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = ListPart;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control18)
            {
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field.';
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Qualification Description field.';
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
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Institution/Company field.';
                }
                field(ScoreID; Rec."Score ID")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field(DesiredScore; Rec."Desired Score")
                {
                    ToolTip = 'Specifies the value of the Desired Score field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
