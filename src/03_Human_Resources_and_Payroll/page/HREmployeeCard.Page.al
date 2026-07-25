page 85620 "HR Employee Card"
{
    Caption = 'Employee Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Employee,Navigate';
    SourceTable = "hr-Employee";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        //  AssistEdit;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';
                group(Control13)
                {
                    ShowCaption = false;
                    field("Postal Address"; Rec."Postal Address")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Postal Address2"; Rec."Postal Address2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;
                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country Code"; Rec."Country Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()

                        begin
                            CurrPage.Update(true);
                            //  DisplayMap;
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;
                    field("Cellular Phone Number"; Rec."Cellular Phone Number")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Category; Rec.Category)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                    }
                    field("Contract Type"; Rec."Contract Type")
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Home Phone Number"; Rec."Home Phone Number")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Residential Address"; Rec."Residential Address")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Residential Address2"; Rec."Residential Address2")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address2.';
                    }
                    field("Residential Address3"; Rec."Residential Address3")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address3.';
                    }
                    field(Disabled; Rec.Disabled)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Disabled field.';
                    }
                    field("Disability Grade"; Rec."Disability Grade")
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        Visible = Rec.Disabled;
                        ToolTip = 'Specifies the value of the Disability Grade field.';
                    }
                    field("Disabling Details"; Rec."Disabling Details")
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        Visible = Rec.Disabled;
                        ToolTip = 'Specifies the value of the Disabling Details field.';
                    }
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Length of Service"; DService)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the DService field.';
                }
                field("Appointment Start Date"; Rec."Appointment Start Date")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Appointment';
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee was appointed.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Demised Date"; Rec."Demised Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Type of Contract"; Rec."Type of Contract")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Retirement Duration"; Dretirement)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Dretirement field.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
                field("Grade Level"; Rec."Grade Level")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Salary Grade';
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee Job Grade.';
                }
                field("Salary Category"; Rec."Salary Category")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee Job Grade.';
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Grade Step';
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee Job Grade.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field(Age; DAge)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the DAge field.';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the KRA number of the employee.';
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s NSSF Number.';
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s NHIF number.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Payroll Posting Group"; Rec."Payroll Posting Group")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s  bank name.';
                }
                field("Main Bank Name"; Rec."Main Bank Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Branch Bank Name"; Rec."Branch Bank Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch name.';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
            }
            group(Pension)
            {
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Pension Scheme Join field.';
                }
                field("Pension Duration"; DPension)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the DPension field.';
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Medical Scheme Head Member field.';
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Medical Scheme Name field.';
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Medical Scheme No. field.';
                }
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Medical Scheme Join Date field.';
                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signature field.';
                }
                field("Barcode Picture"; Rec."Barcode Picture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Barcode Picture field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "HR-Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part("HR Employee Attachments";"Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Hr-Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "HR Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No."),
                                  "Remaining Amount" = FILTER(< 0),
                                  "Applies-to ID" = FILTER('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                }
            }

            group("&Print")
            {
                Caption = '&Print';
                action("Change History")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the Change History action.';
                    trigger OnAction()
                    begin
                        HRChange.Reset();
                        HRChange.SetRange(HRChange."employee No", Rec."No.");
                        if HRChange.Find('-') then
                            REPORT.Run(70134951, true, true, HRChange);
                    end;
                }
                action("Staff ID Card Kabu")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PrintCover;
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the Staff ID Card Kabu action.';
                    trigger OnAction()
                    begin

                        HREmp.Reset();
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            REPORT.Run(70135242, true, true, HREmp);
                    end;
                }
                action("Personal Information File")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the Personal Information File action.';

                    trigger OnAction()
                    begin
                        HREmp.RESET();
                        HREmp.SETRANGE(HREmp."No.", Rec."No.");
                        IF HREmp.FIND('-') THEN
                            REPORT.RUN(70135380, TRUE, TRUE, HREmp);
                    end;
                }
                action("Misc. Article Info")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Misc. Article Info action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*Misc.RESET;
                        Misc.SETRANGE(Misc."Employee No.","No.");
                        IF Misc.FIND('-') THEN
                        REPORT.RUN(5202,TRUE,TRUE,Misc);*/
                    end;
                }
                action("Confidential Info")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Confidential Info action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*Conf.RESET;
                        Conf.SETRANGE(Conf."Employee No.","No.");
                        IF Conf.FIND('-') THEN
                        REPORT.RUN(5203,TRUE,TRUE,Conf);
                        */
                    end;
                }
                action(Label)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Label action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5200,TRUE,TRUE,HREmp);
                        */
                    end;
                }
                action(Addresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Addresses action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.RESET();
                        HREmp.SETRANGE(HREmp."No.", Rec."No.");
                        IF HREmp.FIND('-') THEN
                            REPORT.RUN(5207, TRUE, TRUE, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Alt. Addresses action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5213,TRUE,TRUE,HREmp);  */
                    end;
                }
                action("Phone Nos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    ToolTip = 'Executes the Phone Nos action.';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5210,TRUE,TRUE,HREmp); */
                    end;
                }
                action("Value Change Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value Change Report';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the Value Change Report action.';

                    trigger OnAction()
                    begin
                        HRValueChange.Reset();
                        HRValueChange.SetRange(HRValueChange."employee No", Rec."No.");
                        if HRValueChange.Find('-') then
                            REPORT.Run(70135239, true, true, HRValueChange)
                        else
                            Error('No value changes have been recorded for this employee');
                    end;
                }
                action(Gratuity)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Employee Gratuity";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ToolTip = 'Executes the Gratuity action.';
                }
                action("Change log to this Employee")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change log to this Employee';
                    Image = ChangeLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Changes list";
                    RunPageLink = "employee No" = FIELD("No.");
                    ToolTip = 'Executes the Change log to this Employee action.';
                }
            }
            group("&Employee")
            {
                Caption = '&Employee';
                Image = Departments;

                group(ActionGroup24)
                {
                    Caption = '&Employee';
                    Image = Departments;

                    action("Next of Kin")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Next of Kin';
                        Image = Relatives;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Employees Kin";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ToolTip = 'Executes the Next of Kin action.';
                    }
                    action(Beneficiaries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Beneficiaries';
                        Image = Opportunity;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Employee Beneficiary";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ToolTip = 'Executes the Beneficiaries action.';
                    }
                    action(Dependants)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dependants';
                        Image = Relatives;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Employees Dependants";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ToolTip = 'Executes the Dependants action.';
                    }
                    action(Qualifications)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Qualifications';
                        Image = QualificationOverview;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Employee Qualifications 2";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the Qualifications action.';
                    }
                    action("Employment History")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employment History';
                        Image = History;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Employment History";
                        RunPageLink = "Employee No. Filter" = FIELD("No.");
                        ToolTip = 'Executes the Employment History action.';
                    }
                    action("Appointment Checklist")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointment Checklist';
                        Image = AddAction;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Appointment Checklist";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the Appointment Checklist action.';
                    }
                    action("Proffessional Membership")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Proffessional Membership';
                        Image = Group;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Hr Proffessional Membership";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ToolTip = 'Executes the Proffessional Membership action.';
                    }
                    action("Training History")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Training History';
                        Image = Certificate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = false;
                        RunObject = Page "HR training History";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the Training History action.';
                    }
                    action("Employee Responsibilities")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Responsibilities';
                        Enabled = false;
                        Image = ResourcePlanning;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = false;
                        RunObject = Page "HR Job Responsiblities (RO)";
                        RunPageLink = "Responsibility Description" = FIELD("Job Title");
                        Visible = false;
                        ToolTip = 'Executes the Employee Responsibilities action.';
                    }
                    action("Assign Clearance Items")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Assign Clearance Items';
                        Image = ExternalDocument;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Misc. Article Information";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the Assign Clearance Items action.';
                    }
                    action("View Clearance Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'View Clearance Details';
                        Image = ExternalDocument;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Asset Return Form";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the View Clearance Details action.';
                    }
                    action("Misc. Articles Overview")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Misc. Articles Overview';
                        Image = ViewSourceDocumentLine;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "Misc. Articles Overview";
                        ToolTip = 'Executes the Misc. Articles Overview action.';
                    }
                    action("Employee Picture")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Picture';
                        Image = Picture;
                        RunObject = Page "Hr Employee Picture";
                        ToolTip = 'Executes the Employee Picture action.';
                    }
                    action("Hiring Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hiring Details';
                        Image = Answers;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Job Interview";
                        Visible = false;
                        ToolTip = 'Executes the Hiring Details action.';
                    }
                    action("Employee Disciplinary Cases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Disciplinary Cases';
                        Image = Components;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Disciplinary Cases List";
                        RunPageLink = "Accused Employee" = FIELD("No.");
                        ToolTip = 'Executes the Employee Disciplinary Cases action.';
                    }
                    action("Employee Vehicles")
                    {
                        ApplicationArea = Basic, Suite;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Employee Vehicles";
                        RunPageLink = "Employee No" = FIELD("No.");
                        ToolTip = 'Executes the Employee Vehicles action.';
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country Code");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateImportantDates();
    end;

    var
        EmpCategory: Record "Employee Categories";
        HREmp: Record "HR-Employee";
        HRChange: Record "HR Change Entries";
        HRValueChange: Record "HR Change Entries";
        FormatAddress: Codeunit "Format Address";
        //SICNumbersTable: Record "HR Appraisal Evaluation Areas";
        // SICNumbersList: Codeunit "HR SIC Numbers";
        Dates: Codeunit "HR Dates";
        IsCountyVisible: Boolean;
        NoFieldVisible: Boolean;
        RDate: Date;
        ShowMapLbl: Label 'Show on Map';
        Dretirement: Text;
        Duration_to_ContractEnd: Text;
        DAge: Text[100];
        DMedical: Text[100];
        DPension: Text[100];
        DService: Text[100];
        RetirementDur: Text[250];

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;

    local procedure CalculateImportantDates()
    begin
        IF (Rec."Date Of Leaving" = 0D) THEN BEGIN
            IF (Rec."Date Of Birth" <> 0D) THEN
                DAge := Dates.DetermineAge(Rec."Date Of Birth", TODAY);
            IF (Rec."Date Of Join" <> 0D) THEN
                DService := Dates.DetermineAge(Rec."Date Of Join", TODAY);
            IF (Rec."Pension Scheme Join" <> 0D) THEN
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", TODAY);
            IF (Rec."Medical Scheme Join" <> 0D) THEN
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", TODAY);
        END ELSE BEGIN
            IF (Rec."Date Of Birth" <> 0D) THEN
                DAge := Dates.DetermineAge(Rec."Date Of Birth", TODAY);
            IF (Rec."Date Of Join" <> 0D) THEN
                DService := Dates.DetermineAge(Rec."Date Of Join", Rec."Date Of Leaving");
            IF (Rec."Pension Scheme Join" <> 0D) THEN
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", Rec."Date Of Leaving");
            IF (Rec."Medical Scheme Join" <> 0D) THEN
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", Rec."Date Of Leaving");
        END;

        IF Rec."Date Of Birth" <> 0D THEN BEGIN
            IF EmpCategory.GET(Rec."Salary Category") THEN
                RDate := Rec."Date Of Birth" + (EmpCategory."Ritirement Age" * 365);
            IF Rec."Contract End Date" = 0D THEN
                Duration_to_ContractEnd := 'Contract End Date not Specified!'
            ELSE
                Duration_to_ContractEnd := Dates.DetermineAge(TODAY, Rec."Contract End Date");
        END;

        IF RDate = 0D THEN
            RetirementDur := 'Job Category Not specified!'
        ELSE
            RetirementDur := Dates.DetermineAge(TODAY, RDate);
    end;
}
