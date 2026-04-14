Page 85695 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    PageType = Listpart;
    SourceTable = "HR Shortlisted Applicants";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Qualified; Rec.Qualified)
                {
                    Caption = 'Qualified';
                    ToolTip = 'Specifies the value of the Qualified field.';

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify();
                    end;
                }
                field(JobApplicationNo; Rec."Job Application No")
                {
                    ToolTip = 'Specifies the value of the Job Application No field.';
                }
                field(FirstName; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(IDNo; Rec."ID No")
                {
                    ToolTip = 'Specifies the value of the ID No field.';
                }
                field(StageScore; Rec."Stage Score")
                {
                    ToolTip = 'Specifies the value of the Stage Score field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Employed';
                    ToolTip = 'Specifies the value of the Employed field.';
                }
                field(ReportingDate; Rec."Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Reporting Date field.';
                }
                field(ManualChange; Rec."Manual Change")
                {
                    Caption = 'Manual Change';
                    ToolTip = 'Specifies the value of the Manual Change field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}
