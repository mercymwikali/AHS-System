page 52203078 Employee
{
    Caption = 'Employee Card';
    // DelayedInsert = false;
    DeleteAllowed = false;
    PageType = Card;
    // UsageCategory = Documents;
    // ApplicationArea = Basic, Suite;
    PromotedActionCategories = 'New,Process,Reports,Related Information';
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "HR-Employee";
    layout
    {
        area(content)
        {
            group(Control168)
            {
                ShowCaption = false;
                field("gOpt Active"; "gOpt Active")
                {
                    ApplicationArea = Basic, Suite;
                    OptionCaption = 'Show Active Employees,Show Archived Employees,Show All Employees';
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        if "gOpt Active" = "gOpt Active"::All then
                            AllgOptActiveOnValidate();
                        if "gOpt Active" = "gOpt Active"::Archive then
                            ArchivegOptActiveOnValidate();
                        if "gOpt Active" = "gOpt Active"::Active then
                            ActivegOptActiveOnValidate();
                    end;
                }
                field("Employee Act. Qty"; Rec."Employee Act. Qty")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Act. Qty field.';
                }
                field("Employee Arc. Qty"; Rec."Employee Arc. Qty")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Arc. Qty field.';
                }
                field("Employee Qty"; Rec."Employee Qty")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Qty field.';
                }
            }
            group("General Information")
            {
                Caption = 'General Information';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = true;
                    Caption = 'Employee No.';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Employee No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Initials';
                    ToolTip = 'Specifies the value of the Initials field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Passport Number field.';
                }
                field("Notify HR Reminders"; Rec."Notify HR Reminders")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Notify HR Reminders field.';
                }
                field("Salary Category"; Rec."Salary Category")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Category';
                    ToolTip = 'Specifies the value of the Job Category field.';
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Grade';
                    ToolTip = 'Specifies the value of the Job Grade field.';
                }
                field("Job Specification"; Rec."Job Specification")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field("Physical Disability"; Rec."Physical Disability")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Disabled?';
                    ToolTip = 'Specifies the value of the Disabled? field.';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Lecturer field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field("Status 1"; Rec."Status 1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Type field.', Comment = '%';
                }

                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Status Reason';
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Status';
                    OptionCaption = 'Normal,,,,,Disabled';
                    ToolTip = 'Specifies the value of the Payroll Status field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Citizenship field.';
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Postal Address field.';
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Postal Address2 field.';
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code';
                    LookupPageID = "Post Codes";
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(HOD; Rec.HOD)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the HOD field.';
                }
                field(Dean; Rec.Dean)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dean field.';
                }
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Manager field.';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Leave Balance field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Part Time"; Rec."Part Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Part Time field.';
                }
                field("Portal Session Token"; Rec."Portal Session Token")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Portal Session Token field.';
                }
                field("Portal OTP Code"; Rec."Portal OTP Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Portal OTP Code field.';
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    // ExtendedDatatype = None;
                    ToolTip = 'Specifies the value of the Portal Password field.';
                }
                field("Changed Password"; Rec."Changed Password")
                {
                    Visible = false;
                }
                field(HMIS; Rec.HMIS)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the HMIS field.';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Password field.';
                }

            }
            part("Employee Qualifications"; "Employee Qualifications 2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No." = FIELD("No.");
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Religion field.';
                }
                field(Tribe; Rec.Tribe)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Tribe field.';
                }
                field("Sub Tribe"; Rec."Sub Tribe")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Sub Tribe field.';
                }
                field("County Code"; Rec."County Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the County Code field.';
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ToolTip = 'Specifies the value of the Additional Language field.';
                    // LookupPageID = 50040;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vehicle Reg Number';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vehicle Reg Number field.';
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Disabled field.';

                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled = false then begin
                            "Disabling DetailsEditable" := false;
                            "Disability GradeEditable" := false;
                        end
                        else
                            "Disabling DetailsEditable" := true;
                        "Disability GradeEditable" := true;
                    end;
                }
                field("Disabling Details"; Rec."Disabling Details")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Disabling DetailsEditable";
                    ToolTip = 'Specifies the value of the Disabling Details field.';
                }
                field("Disability Grade"; Rec."Disability Grade")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Disability GradeEditable";
                    ToolTip = 'Specifies the value of the Disability Grade field.';
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Health Assessment?';
                    ToolTip = 'Specifies the value of the Health Assessment? field.';
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Scheme No. field.';
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Scheme Head Member field.';
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Number Of Dependants field.';
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Scheme Name field.';
                }
                field("Medical Scheme Name #2"; Rec."Medical Scheme Name #2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Scheme Name #2 field.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cause of Inactivity Code field.';
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Health Assessment Date';
                    ToolTip = 'Specifies the value of the Health Assessment Date field.';
                }
                group("  R      W     S")
                {
                    Caption = '  R      W     S';
                    Visible = false;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    ToolTip = 'Specifies the value of the First Language Read field.';
                    // LookupPageID = 50040;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First Language Write field.';
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First Language Speak field.';
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ToolTip = 'Specifies the value of the Second Language Read field.';
                    // LookupPageID = 50040;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Second Language Write field.';
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Second Language Speak field.';
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(DAge; DAge)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Age';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Of Joining The Company';
                    ToolTip = 'Specifies the value of the Date Of Joining The Company field.';
                }
                field(DService; DService)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Length of Service';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Length of Service field.';
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Probation Start Date field.';
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the End Of Probation Date field.';
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pension Scheme Join Date';
                    ToolTip = 'Specifies the value of the Pension Scheme Join Date field.';
                }
                field(DPension; DPension)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Time On Pension Scheme';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time On Pension Scheme field.';
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Medical Aid Scheme Join Date';
                    ToolTip = 'Specifies the value of the Medical Aid Scheme Join Date field.';
                }
                field(DMedical; DMedical)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Medical Scheme Duration';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Medical Scheme Duration field.';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field("Contract Duration"; Rec."Contract Duration")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contract Duration field.';
                }
                field("Contract End Date1"; Rec."Contract End Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contract End Date';
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(Duration_to_ContractEnd; Duration_to_ContractEnd)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Duration to end of Contract';
                    ToolTip = 'Specifies the value of the Duration to end of Contract field.';
                }
                field(Appointment; Rec.Appointment)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment field.';
                }
                field("Appointment Description"; Rec."Appointment Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Description field.';
                }
                field("Appointment Start Date"; Rec."Appointment Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Start Date field.';
                }
                field("Appointment Duration"; Rec."Appointment Duration")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Duration field.';
                }
                field("Appointment End Date"; Rec."Appointment End Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment End Date field.';
                }
                field(RetirementDur; RetirementDur)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Duration to retirement';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Duration to retirement field.';
                }
                field("Study Leave Start Date"; Rec."Study Leave Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Study Leave Start Date field.';
                }
                field("Study Leave End Date"; Rec."Study Leave End Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Study Leave End Date field.';
                }
                field("Exit Date"; Rec."Exit Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Exit Date field.';
                }
            }
            group("Contact Numbers")
            {
                Caption = 'Contact Numbers';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Home Phone Number field.';
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cellular Phone Number field.';
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fax Number field.';
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Work Phone Number field.';
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Ext. field.';
                }
                field("Post Office No"; Rec."Post Office No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Post Office No field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Company E-Mail field.';
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(Divisions; Rec.Divisions)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Divisions field.';
                }
                field("Department Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Department Code';
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field(Schools; Rec.Schools)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Schools field.';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PIN Number field.';
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                }
                field("HELB No"; Rec."HELB No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the HELB No field.';
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Main Bank field.';
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch Bank field.';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
            }
            group("Misc.")
            {
                Caption = 'Misc.';
                field(Barcode; Rec."Barcode Picture")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Barcode Picture field.';
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Signature field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control149; "HR-Employee Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(Reporting)
        {
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
                    RunObject = page "HR Misc. Article Information";
                    ToolTip = 'Executes the Misc. Article Info action.';
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
                        RunObject = Page "Misc. Article Information";
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
                    action("&Confidential Information")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Confidential Information';
                        Image = SNInfo;
                        Promoted = true;
                        PromotedCategory = Category4;
                        RunObject = Page "HR Confidential Comment List";
                        RunPageLink = "No." = FIELD("No.");
                        ToolTip = 'Executes the &Confidential Information action.';
                    }
                    action("Co&nfidential Info. Overview")
                    {
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category6;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Co&nfidential Info. Overview';
                        RunObject = Page "Confidential Info. Overview";
                        ToolTip = 'Executes the Co&nfidential Info. Overview action.';
                    }
                    action("A&bsences")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'A&bsences';
                        Image = AbsenceCalendar;
                        Promoted = true;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        PromotedCategory = Category4;
                        RunObject = Page "Employee Absences";
                        RunPageLink = "Employee No." = FIELD("No.");
                        ToolTip = 'Executes the A&bsences action.';
                    }
                    action(Dimensions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category6;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(5200),
                                      "No." = FIELD("No.");
                        ToolTip = 'Executes the Dimensions action.';
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

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';
        RetirementDur := '';
        Duration_to_ContractEnd := '';

        if Rec."Date Of Birth" <> 0D then begin
            if EmpCategory.Get(Rec."Salary Category") then
                RDate := Rec."Date Of Birth" + (EmpCategory."Ritirement Age" * 365);
            if Rec."Contract End Date" = 0D then
                Duration_to_ContractEnd := 'Contract End Date not Specified!'
            else
                Duration_to_ContractEnd := Dates.DetermineAge(Today, Rec."Contract End Date");
        end;
        /*
                if Category = '' then
                    RetirementDur := 'Job Category Not specified!'
                else
                    RetirementDur := Dates.DetermineAge(Today, RDate);
        */
        //Recalculate Important Dates
        if (Rec."Date Of Leaving" = 0D) then begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
            if (Rec."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Join", Today);
            if (Rec."Pension Scheme Join" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", Today);
            if (Rec."Medical Scheme Join" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", Today);

            //MODIFY;
        end else begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
            if (Rec."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Join", Rec."Date Of Leaving");
            if (Rec."Pension Scheme Join" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", Rec."Date Of Leaving");
            if (Rec."Medical Scheme Join" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", Rec."Date Of Leaving");
            //MODIFY;
        end;

        //"Job Specification":='';
        "HR Jobs".Reset();
        "HR Jobs".SetRange("HR Jobs"."Job ID", Rec."Job Specification");
        if "HR Jobs".Find('-') then
            Rec."Job Specification" := "HR Jobs"."Job ID";
    end;

    trigger OnInit()
    begin
        "Disability GradeEditable" := true;
        "Disabling DetailsEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //RESET;
        "gOpt Active" := "gOpt Active"::All;
        //MESSAGE('All employee information must be completed.')
    end;

    trigger OnOpenPage()
    begin
        "gOpt Active" := "gOpt Active"::Active;
        Rec.SetCurrentKey("Termination Category");
        "Filter Employees"(0);
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';
        RetirementDur := '';
        Duration_to_ContractEnd := '';

        if Rec."Date Of Birth" <> 0D then begin
            if EmpCategory.Get(Rec."Salary Category") then
                RDate := Rec."Date Of Birth" + (EmpCategory."Ritirement Age" * 365);
            if Rec."Contract End Date" = 0D then
                Duration_to_ContractEnd := 'Contract End Date not Specified!'
            else
                Duration_to_ContractEnd := Dates.DetermineAge(Today, Rec."Contract End Date");
        end;
        /*
                if Category = '' then
                    RetirementDur := 'Job Category Not specified!'
                else
                    RetirementDur := Dates.DetermineAge(Today, RDate);
        */
        //Recalculate Important Dates
        if (Rec."Date Of Leaving" = 0D) then begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
            if (Rec."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Join", Today);
            if (Rec."Pension Scheme Join" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", Today);
            if (Rec."Medical Scheme Join" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", Today);

            //MODIFY;
        end else begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
            if (Rec."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Join", Rec."Date Of Leaving");
            if (Rec."Pension Scheme Join" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join", Rec."Date Of Leaving");
            if (Rec."Medical Scheme Join" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join", Rec."Date Of Leaving");
            //MODIFY;
        end;

        Rec."Job Specification" := '';
        "HR Jobs".Reset();
        "HR Jobs".SetRange("HR Jobs"."Job ID", Rec."Job Specification");
        if "HR Jobs".Find('-') then
            Rec."Job Specification" := "HR Jobs"."Job ID";
    end;

    var
        EmpCategory: Record "Employee Categories";
        HREmp: Record "HR-Employee";
        HRChange: Record "HR Change Entries";
        HRValueChange: Record "HR Change Entries";
        "HR Jobs": Record "HR Jobs";
        //SICNumbersTable: Record "HR Appraisal Evaluation Areas";
        // SICNumbersList: Codeunit "HR SIC Numbers";
        Dates: Codeunit "HR Dates";
        [InDataSet]
        "Disability GradeEditable": Boolean;
        [InDataSet]
        "Disabling DetailsEditable": Boolean;
        RDate: Date;
        "gOpt Active": Option Active,Archive,All;
        Duration_to_ContractEnd: Text;
        DAge: Text[100];
        DMedical: Text[100];
        DPension: Text[100];
        DService: Text[100];
        RetirementDur: Text[250];

    procedure "Filter Employees"(Type: Option Active,Archive,All)
    begin
        if Type = Type::Active then begin
            Rec.Reset();
            Rec.SetFilter("Termination Category", '=%1', Rec."Termination Category"::" ");
        end
        else
            if Type = Type::Archive then begin
                Rec.Reset();
                Rec.SetFilter("Termination Category", '<>%1', Rec."Termination Category"::" ");
            end
            else
                if Type = Type::All then
                    Rec.Reset();

        CurrPage.Update(false);
        Rec.FilterGroup(20);
    end;

    local procedure ActivegOptActiveOnPush()
    begin
        "Filter Employees"(0); //Active Employees
    end;

    local procedure ArchivegOptActiveOnPush()
    begin
        "Filter Employees"(1); //Archived Employees
    end;

    local procedure AllgOptActiveOnPush()
    begin
        "Filter Employees"(2); //  Show All Employees
    end;

    local procedure ActivegOptActiveOnValidate()
    begin
        ActivegOptActiveOnPush();
    end;

    local procedure ArchivegOptActiveOnValidate()
    begin
        ArchivegOptActiveOnPush();
    end;

    local procedure AllgOptActiveOnValidate()
    begin
        AllgOptActiveOnPush();
    end;
}
