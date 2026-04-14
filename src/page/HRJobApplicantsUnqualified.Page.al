page 85660 "HR Job Applicants Unqualified"
{
    // CardPageID = "HR Job Applicants Qualified Ca";
    PageType = List;
    SourceTable = Applicants;
    // SourceTableView = WHERE("Employee No"=field(""));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
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
                action("Send Regret Alert")
                {
                    Caption = 'Send Regret Alert';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Send Regret Alert action.';
                    /*
                                        trigger OnAction()
                                        begin

                                            //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                                            IF NOT CONFIRM(Text002, FALSE) THEN EXIT;

                                            TESTFIELD(Qualified, Qualified::"0");
                                            HRJobApplications.SETRANGE(HRJobApplications."Application No", "Application No");
                                            CurrPage.SETSELECTIONFILTER(HRJobApplications);
                                            IF HRJobApplications.FIND('-') THEN
                                                //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                                                HREmailParameters.RESET;
                                            HREmailParameters.SETRANGE(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Regret Notification");
                                            IF HREmailParameters.FIND('-') THEN BEGIN
                                                REPEAT
                                                    HRJobApplications.TESTFIELD(HRJobApplications."E-Mail");
                                                    SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                                                    HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + ' ' + FORMAT("Date Applied") + ' ' + HREmailParameters."Body 2", TRUE);
                                                    //HREmailParameters."Body 2"+' '+ FORMAT("Date Applied")+'. '+
                                                    // HREmailParameters.Body,TRUE);
                                                    SMTP.Send();
                                                UNTIL HRJobApplications.NEXT = 0;

                                                MESSAGE('All Unqualified  candidates have been sent regret alerts');
                                            END;
                                        end;
                                        */
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
                    //  RunPageLink = Field1 = FIELD(Field1);
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    ToolTip = 'Executes the Qualifications action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //   RunObject = Page "HR Applicant Qualifications";
                    //  RunPageLink = Application No=FIELD(Field1);
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = false;
                    ToolTip = 'Executes the Referees action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //  RunObject = Page "HR Applicant Referees";
                    //                 RunPageLink = Job Application No=FIELD(Field1);
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    ToolTip = 'Executes the Hobbies action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //  RunObject = Page "HR Applicant Hobbies";
                    //                   RunPageLink = Job Application No=FIELD(Field1);
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
                        // IF HRJobApplications.FIND('-') THEN
                        //REPORT.RUN(39003925,TRUE,TRUE,HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record Applicants;
}
