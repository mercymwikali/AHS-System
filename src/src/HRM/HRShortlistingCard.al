page 52202437 "HR Shortlisting Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlist';
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = CONST(Approved), Closed = CONST(false));

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = true;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Requisition DateEditable";
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Requisition Date field.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PriorityEditable;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Vacant Positions field.';
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Required PositionsEditable";
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Required Positions field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(Shortlisted; "HR Shortlisting Lines")
            {
                ApplicationArea = Basic, Suite;
                Editable = ShortlistedEditable;
                SubPageLink = "Employee Requisition No" = FIELD("Requisition No.");
            }
        }
        area(factboxes)
        {
            part(Control1102755003; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755001; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("&ShortList Applicants By Job Requirements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&ShortList Applicants By Job Requirements';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;
                    ToolTip = 'Executes the &ShortList Applicants By Job Requirements action.';
                    trigger OnAction()
                    var
                        "Experience?": Boolean;
                        AcademicScore: Decimal;
                        ExperienceScore: Decimal;
                        GradeScore: Decimal;
                    begin
                        HRJobRequirements.RESET();
                        HRJobRequirements.SETRANGE(HRJobRequirements."Job Id", Rec."Job ID");
                        //HRJobRequirements.SETRANGE(HRJobRequirements."Need code","Requisition No.");
                        IF HRJobRequirements.COUNT = 0 THEN BEGIN
                            MESSAGE('Job Requirements for the job ' + Rec."Job ID" + ' have not been setup');
                            EXIT;
                        END ELSE BEGIN //***************//HR Job Requirements 1 BEGIN

                            //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants.RESET();

                            //HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants."Employee Requisition No","Requisition No.");
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants."Job Id", Rec."Job ID");
                            //HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants.Mandatory,TRUE);
                            HRShortlistedApplicants.DELETEALL();

                            //GET JOB APPLICANTS
                            HRJobApplications.RESET();
                            HRJobApplications.SETRANGE(HRJobApplications."Job Applied For", Rec."Job ID");
                            //HRJobApplications.SETRANGE(HRJobApplications."No.","Requisition No.");
                            IF HRJobApplications.FIND('-') THEN //Job Applications BEGIN
                                REPEAT//***************//Job Applications REPEAT
                                    AcademicScore := 0;
                                    Rec.Score := 0;
                                    GradeScore := 0;
                                    ExperienceScore := 0;
                                    //GET JOB REQUIREMENTS
                                    HRJobRequirements.RESET();
                                    HRJobRequirements.SETRANGE(HRJobRequirements."Job Id", Rec."Job ID");
                                    //HRJobRequirements.SETRANGE(HRJobRequirements."Need code","Requisition No.");
                                    HRJobRequirements.SETRANGE(HRJobRequirements.Mandatory, TRUE);
                                    IF HRJobRequirements.FIND('-') THEN BEGIN//HR Job Requirements 2 BEGIN
                                        REPEAT //***************//HR Job Requirements REPEAT
                                            AppQualifications.RESET();
                                            AppQualifications.SETRANGE(AppQualifications."Email Address", UPPERCASE(HRJobApplications."E-Mail"));
                                            AppQualifications.SETRANGE(AppQualifications.Qualification, HRJobRequirements."Qualification Type");
                                            AppQualifications.SETRANGE(AppQualifications."Course Code", HRJobRequirements."Qualification Code");
                                            IF AppQualifications.FIND('-') THEN BEGIN //***************//HR App Qualifications BEGIN
                                                AppQualifications.VALIDATE(Classification);
                                                AcademicScore := AcademicScore + 1;
                                                Rec.Score := AppQualifications."Score ID";
                                                IF AppQualifications."Score ID" >= HRJobRequirements."Desired Score" THEN//check Grade
                                                    GradeScore := GradeScore + 1;
                                            END; //***************//HR App Qualifications END

                                            //Check Experience
                                            IF HRJobRequirements."Qualification Type" = 'EXPERIENCE' THEN BEGIN
                                                GradeScore := GradeScore + 1;
                                                AcademicScore := AcademicScore + 1;
                                                ExperienceScore := ROUND(getExperience(HRJobApplications."E-Mail"), 0.1, '=');
                                                IF ExperienceScore >= HRJobRequirements."Desired Score" THEN
                                                    "Experience?" := TRUE;
                                            END;
                                        UNTIL HRJobRequirements.NEXT() = 0;
                                        IF (AcademicScore = GradeScore) AND (GradeScore = HRJobRequirements.COUNT) AND "Experience?" THEN //check Grade

                                            Rec.Qualified := TRUE//by academic
                                        ELSE
                                            Rec.Qualified := FALSE;
                                    END;//***************//HR Job Requirements 2 END

                                    IF Rec.Qualified THEN BEGIN
                                        HRShortlistedApplicants."Job Id" := Rec."Job ID";
                                        HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                                        HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                        HRShortlistedApplicants."Stage Score" := Rec.Score;
                                        HRShortlistedApplicants."Experience Score" := ExperienceScore;
                                        HRShortlistedApplicants.Qualified := Rec.Qualified;
                                        HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                        HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                        HRShortlistedApplicants."E-Mail" := HRJobApplications."E-Mail";
                                        HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                        HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                        HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                        HRShortlistedApplicants.Mandatory := TRUE;
                                        HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                        HRShortlistedApplicants.INSERT();
                                        HRJobApplications.GET(HRShortlistedApplicants."Job Application No");
                                        HRJobApplications.Qualified := TRUE;
                                        //HRJobApplications.fa
                                        HRJobApplications.MODIFY();
                                    END ELSE BEGIN
                                        HRShortlistedApplicants."Job Id" := Rec."Job ID";
                                        HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                                        HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                        HRShortlistedApplicants."Stage Score" := Rec.Score;
                                        HRShortlistedApplicants."Experience Score" := ExperienceScore;
                                        HRShortlistedApplicants.Qualified := FALSE;
                                        HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                        HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                        HRShortlistedApplicants."E-Mail" := HRJobApplications."E-Mail";
                                        HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                        HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                        HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                        HRShortlistedApplicants.Mandatory := TRUE;
                                        HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                        HRShortlistedApplicants.INSERT();
                                        HRJobApplications.GET(HRShortlistedApplicants."Job Application No");
                                        HRJobApplications.Qualified := FALSE;
                                        //HRJobApplications.fa
                                        HRJobApplications.MODIFY();
                                    END;
                                UNTIL HRJobApplications.NEXT() = 0;
                                //***************//Job Applications END
                                //MARK QUALIFIED APPLICANTS AS QUALIFIED
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants.Qualified, TRUE);
                            IF HRShortlistedApplicants.FIND('-') THEN
                                REPEAT //***************//HRShortlistedApplicants REPEAT

                                UNTIL HRShortlistedApplicants.NEXT() = 0;
                            /*
                                                        RecruitmentStages.RESET;
                                                        RecruitmentStages.SETFILTER("Recruitement Stage", '<>%', '');
                                                        IF RecruitmentStages.FINDFIRST THEN BEGIN
                                                            Stage := RecruitmentStages."Recruitement Stage";
                                                            //HRJobRequirements.Complete:=TRUE;
                                                            MODIFY(TRUE);
                                                        END;
                            */
                            MESSAGE('%1', 'Shortlisting Competed Successfully.');
                        END; //***************//HR Job Requirements 1 END;
                             // END ELSE
                             // MESSAGE('%1','You must select the stage you would like to shortlist.');
                    end;
                }
                action("&Print")
                {
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Image = PrintReport;
                    ToolTip = 'Executes the &Print action.';
                    trigger OnAction()
                    begin
                        HREmpReq.RESET();
                        HREmpReq.SETRANGE(HREmpReq."Requisition No.", Rec."Requisition No.");
                        IF HREmpReq.FIND('-') THEN
                            REPORT.RUN(70135261, TRUE, TRUE, HREmpReq);
                    end;
                }
                action("&ShortList Applicants By Criteria")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&ShortList Applicants By Criteria';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &ShortList Applicants By Criteria action.';
                    trigger OnAction()
                    begin
                        "HRJobShortList Criteria".RESET();
                        "HRJobShortList Criteria".SETRANGE("HRJobShortList Criteria"."Job Id", Rec."Job ID");
                        IF "HRJobShortList Criteria".COUNT = 0 THEN BEGIN
                            MESSAGE('Job Requirements for the job ' + Rec."Job ID" + ' have not been setup');
                            EXIT;
                        END ELSE BEGIN

                            //GET JOB REQUIREMENTS
                            "HRJobShortList Criteria".RESET();
                            "HRJobShortList Criteria".SETRANGE("HRJobShortList Criteria"."Job Id", Rec."Job ID");

                            //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants.RESET();
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants."Employee Requisition No", Rec."Requisition No.");
                            HRShortlistedApplicants.DELETEALL();

                            //GET JOB APPLICANTS
                            HRJobApplications.RESET();
                            HRJobApplications.SETRANGE(HRJobApplications."Requisition No", Rec."Requisition No.");
                            IF HRJobApplications.FIND('-') THEN
                                REPEAT
                                    Rec.Qualified := TRUE;
                                    IF HRJobRequirements.FIND('-') THEN BEGIN
                                        StageScore := 0;
                                        Rec.Score := 0;
                                        REPEAT
                                            //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                            AppQualifications.RESET();
                                            AppQualifications.SETRANGE(AppQualifications."Application No", HRJobApplications."Application No");
                                            AppQualifications.SETRANGE(AppQualifications."Qualification Code", "HRJobShortList Criteria"."ShortList Code");
                                            IF AppQualifications.FIND('-') THEN BEGIN
                                                Rec.Score := Rec.Score + AppQualifications."Score ID";
                                                IF AppQualifications."Score ID" < "HRJobShortList Criteria"."Desired Score" THEN
                                                    Rec.Qualified := FALSE;
                                            END ELSE
                                                Rec.Qualified := FALSE;
                                        UNTIL "HRJobShortList Criteria".NEXT() = 0;
                                    END;
                                    HRShortlistedApplicants.init();
                                    HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                                    HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                    HRShortlistedApplicants."Stage Score" := Rec.Score;
                                    HRShortlistedApplicants.Qualified := Rec.Qualified;
                                    HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                    HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                    HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                    HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                    HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                    HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                    HRShortlistedApplicants.INSERT();
                                UNTIL HRJobApplications.NEXT() = 0;
                            //MARK QUALIFIED APPLICANTS AS QUALIFIED
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants.Qualified, TRUE);
                            IF HRShortlistedApplicants.FIND('-') THEN
                                REPEAT
                                    HRJobApplications.GET(HRShortlistedApplicants."Job Application No");
                                    HRJobApplications.Qualified := TRUE;
                                    HRJobApplications.MODIFY();
                                UNTIL HRShortlistedApplicants.NEXT() = 0;
                            /*
                            RecCount:= 0;
                            MyCount:=0;
                            StageShortlist.RESET;
                            StageShortlist.SETRANGE(StageShortlist."Need Code","Need Code");
                            StageShortlist.SETRANGE(StageShortlist."Stage Code","Stage Code");

                            IF StageShortlist.FIND('-') THEN BEGIN
                            RecCount:=StageShortlist.COUNT ;
                            StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                            StageShortlist.ASCENDING;
                            REPEAT
                            MyCount:=MyCount + 1;
                            StageShortlist.Position:=RecCount - MyCount;
                            StageShortlist.MODIFY;
                            UNTIL StageShortlist.NEXT = 0;
                            END;
                            */
                            MESSAGE('%1', 'Shortlisting Competed Successfully.');
                        END;
                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');
                    end;
                }
                action(Requirements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Requirements';
                    RunObject = page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                    ToolTip = 'Executes the Requirements action.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Required PositionsEditable" := TRUE;
        PriorityEditable := TRUE;
        ShortlistedEditable := TRUE;
        "Requisition DateEditable" := TRUE;
        "Job IDEditable" := TRUE;
    end;

    var
        HRJobApplications: Record Applicants;
        AppQualifications: Record "HR Applicant Qualifications";
        HREmpReq: Record "HR Employee Requisitions";
        HRShortlistedApplicants: Record "HR Shortlisted Applicants";
        "HRJobShortList Criteria": Record "HR shortList Requirements";
        HRJobRequirements: Record "HR Stage Requirements";
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        ShortlistedEditable: Boolean;
        StageScore: Decimal;

    procedure getExperience(email: Code[30]) reslt: Decimal
    var
        ApplicantsEmploymentHistory: Record "Applicants Employment History";
        CurrentEmploymentDetails: Record "Current Employment Details";
    begin
        ApplicantsEmploymentHistory.RESET();
        ApplicantsEmploymentHistory.SETRANGE("Email Address", email);
        IF ApplicantsEmploymentHistory.FIND('-') THEN
            REPEAT
                IF (ApplicantsEmploymentHistory.From <> 0D) AND (ApplicantsEmploymentHistory."To" <> 0D) THEN
                    reslt := reslt + ((ApplicantsEmploymentHistory."To" - ApplicantsEmploymentHistory.From) / 365);
            UNTIL ApplicantsEmploymentHistory.NEXT() = 0;
        CurrentEmploymentDetails.RESET();
        CurrentEmploymentDetails.SETRANGE("Email Address", email);
        IF CurrentEmploymentDetails.FIND('-') THEN
            IF (CurrentEmploymentDetails."From Date" <> 0D) AND (CurrentEmploymentDetails."To Date" <> 0D) THEN
                reslt := reslt + ((CurrentEmploymentDetails."To Date" - CurrentEmploymentDetails."From Date") / 365);
        EXIT(reslt);
    end;

    procedure UpdateControls()
    begin

        IF Rec.Status = Rec.Status::New THEN BEGIN
            "Job IDEditable" := TRUE;
            "Requisition DateEditable" := TRUE;
            ShortlistedEditable := TRUE;
            PriorityEditable := TRUE;
            "Required PositionsEditable" := TRUE;
        END ELSE BEGIN
            "Job IDEditable" := FALSE;
            "Requisition DateEditable" := FALSE;
            ShortlistedEditable := FALSE;
            PriorityEditable := FALSE;
            "Required PositionsEditable" := FALSE;
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls();
    end;
}
