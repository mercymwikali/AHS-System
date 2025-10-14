page 52202458 "HR Job Applicants Qualified"
{
    // CardPageID = "HR Job Applicants Qualified Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Applicants;
    SourceTableView = WHERE(Qualified = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Application No")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("Date of Interview"; Rec."Date of Interview")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Date of Interview field.';
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the From Time field.';
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the To Time field.';
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Venue field.';
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Room No field.';
                }
                field("Interview Type"; Rec."Interview Type")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Interview Type field.';
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Qualified field.';
                }
                field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
                {
                    ToolTip = 'Specifies the value of the Interview Invitation Sent field.';
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Job Applied For field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Interview Invitation")
                {
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send Interview Invitation action.';
                    /*
                                        trigger OnAction()
                                        begin

                                            //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                                           // IF NOT CONFIRM(Text002,FALSE) THEN EXIT;

                                            TESTFIELD(Qualified,true);
                                            HRJobApplications.SETRANGE(HRJobApplications."Application No","Application No");
                                            CurrPage.SETSELECTIONFILTER(HRJobApplications);
                                            IF HRJobApplications.FIND('-') THEN
                                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                                            HREmailParameters.RESET;
                                            HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"Interview Invitations");
                                            IF HREmailParameters.FIND('-') THEN
                                            BEGIN
                                                 REPEAT
                                                 HRJobApplications.TESTFIELD(HRJobApplications."E-Mail");
                                                 SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HRJobApplications."E-Mail",
                                                 HREmailParameters.Subject,'Dear'+' '+HRJobApplications."First Name"+' '+HREmailParameters.Body+' '+HRJobApplications."Job Applied for Description"+' '+'applied on'+FORMAT("Date Applied")+' '+HREmailParameters."Body 2"+//,TRUE);
                                                 FORMAT(HRJobApplications."Date of Interview")+' '+'Starting '+' '+FORMAT(HRJobApplications."From Time")+' '+'to'+FORMAT(HRJobApplications."To Time")+' '+'at'+HRJobApplications.Venue+'.',TRUE);
                                                 //HREmailParameters.Body,TRUE);
                                                 SMTP.Send();
                                                 UNTIL HRJobApplications.NEXT=0;

                                            IF CONFIRM('Do you want to send this invitation alert?',FALSE) = TRUE THEN BEGIN
                                            "Interview Invitation Sent":=TRUE;
                                            MODIFY;
                                            MESSAGE('All Qualified shortlisted candidates have been invited for the interview ')
                                            END;
                                            END;
                                        end;

                                        */
                }
                action("Job Interview details")
                {
                    Caption = 'Job Interview details';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Interview Code" = FIELD("Application No");
                    ToolTip = 'Executes the Job Interview details action.';
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = false;
                    ToolTip = 'Executes the Card action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    // RunObject = Page "HR Job Applications Card";
                    //  RunPageLink = Field1=FIELD(Field1);
                }
                action("&Upload to Employee Card")
                {
                    Caption = '&Upload to Employee Card';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Upload to Employee Card action.';
                    /*
                                        trigger OnAction()
                                        begin
                                            //TESTFIELDS;
                                            Interview.RESET;
                                            Interview.SETRANGE(Interview."Applicant No","Application No");
                                            IF Interview.FIND('-') THEN BEGIN
                                            IF Interview."Total Score" < 0 THEN
                                            BEGIN
                                                ERROR('Applicants interview details must be entered before hiring');
                                            END;

                                            IF NOT CONFIRM(Text001,FALSE) THEN EXIT;
                                              IF "Employee No" = '' THEN BEGIN
                                              //IF NOT CONFIRM('Are you sure you want to Upload Applications Information to the Employee Card',FALSE) THEN EXIT;
                                              HRJobApplications.SETFILTER(HRJobApplications."Application No","Application No");
                                              REPORT.RUN(70135387,TRUE,FALSE,HRJobApplications);
                                              END ELSE BEGIN
                                              MESSAGE('This applicants information already exists in the employee card');
                                              END;
                                              END;
                                        end;
                                        */
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    ToolTip = 'Executes the Qualifications action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //  RunObject = Page "HR Applicant Qualifications";
                    //   RunPageLink = Application No=FIELD(Field1);
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = false;
                    ToolTip = 'Executes the Referees action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    // RunObject = Page "HR Applicant Referees";
                    //  RunPageLink = Job Application No=FIELD(Field1);
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    ToolTip = 'Executes the Hobbies action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    // RunObject = Page "HR Applicant Hobbies";
                    //  RunPageLink = Job Application No=FIELD(Field1);
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Executes the &Print action.';

                    trigger OnAction()
                    begin
                        HRJobApplications.RESET();
                        HRJobApplications.SETRANGE(HRJobApplications."Application No", Rec."Application No");
                        IF HRJobApplications.FIND('-') THEN
                            REPORT.RUN(39003925, TRUE, TRUE, HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record Applicants;

    procedure TESTFIELDS()
    begin
        Rec.TESTFIELD("Total Score");
    end;
}
