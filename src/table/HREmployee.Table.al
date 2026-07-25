Table 85388 "HR-Employee"
{
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";
    DrillDownPageID = "HR Employee List";
    LookupPageID = "HR Employee List";

    fields
    {
        field(50000; "No."; Code[30])
        {
            NotBlank = false;

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    HumanResSetup.Get();
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series" := '';
                end;

                //This is for staff to Library Dataport don't Delete!
                // if "No." <> '' then
                //     Category := 'STAFF';
            end;
        }
        field(50001; "First Name"; Text[80])
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in First name', Format(xRec."First Name"), Format("First Name"));
            end;
        }
        field(50002; "Middle Name"; Text[50])
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in Middle name', Format(xRec."Middle Name"), Format("Middle Name"));
            end;
        }
        field(50003; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in Last name', Format(xRec."Last Name"), Format("Last Name"));
            end;
        }
        field(50004; Initials; Text[60])
        {
            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(50005; "Search Name"; Code[50])
        {
        }
        field(50006; "Postal Address"; Text[80])
        {
        }
        field(50007; "Residential Address"; Text[80])
        {
        }
        field(50008; City; Text[60])
        {
        }
        field(50009; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50010; County; Text[60])
        {
        }
        field(50011; "Home Phone Number"; Text[60])
        {
        }
        field(50012; "Cellular Phone Number"; Text[60])
        {
        }
        field(50013; "Work Phone Number"; Text[60])
        {
        }
        field(50014; "Ext."; Text[7])
        {
        }
        field(50015; "E-Mail"; Text[80])
        {
        }
        field(50016; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50017; "ID Number"; Text[30])
        {
            trigger OnValidate()
            begin
                fnCheckIDNumber();
                fnTrackChanges('Change in ID Number', xRec."ID Number", "ID Number");
            end;
        }
        field(50018; "Job Application No"; Code[20])
        {
            TableRelation = Union;
        }
        field(50019; "UIF Number"; Text[20])
        {
        }
        field(50020; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50021; "Country Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(50022; "Statistics Group Code"; Code[20])
        {
            TableRelation = "Employee Statistics Group";
        }
        field(50023; Status; Option)
        {
            Caption = 'Status Reasons';
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
                fnTrackChanges('change in Status', Format(xRec.Status), Format(Status));
            end;
        }
        field(50024; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));

            trigger OnValidate()
            begin
                dimval.Reset();
                dimval.SetRange(dimval.Code, "Shortcut Dimension 2 Code");
                if dimval.Find('-') then
                    "Department Name" := dimval.Name;

                fnTrackChanges('Change in Department', Format(xRec."Shortcut Dimension 2 Code"), Format("Shortcut Dimension 2 Code"));
            end;
        }
        field(50025; Office; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(50026; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        field(50027; Comment; Boolean)
        {
            Editable = false;
        }
        field(50028; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(50029; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50030; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50031; "Office Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50032; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(50033; "Fax Number"; Text[30])
        {
        }
        field(50034; "Company E-Mail"; Text[50])
        {
        }
        field(50035; Title; Option)
        {
            OptionCaption = ' ,Ms,Mrs,Mr,Prof,Dr,Miss,Rev,Capt.';
            OptionMembers = " ",Ms,Mrs,Mr,Prof,Dr,Miss,Rev,"Capt.";
        }
        field(50036; "Salespers./Purch. Code"; Code[20])
        {
        }
        field(50037; "No. Series"; Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50038; "Known As"; Text[60])
        {
        }
        field(50039; Position; Text[50])
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in Position', Format(xRec.Position), Format(Position));
            end;
        }
        field(50040; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time",Contract,Casual,"Part Time",Interns;
        }
        field(50041; "Contract Type"; Enum HRContractTypes)
        {
            Caption = 'Contract Type';

            trigger OnValidate()
            begin
                fnTrackChanges('Change in Contract Type', Format(xRec."Contract Type"), Format("Contract Type"));
            end;
        }
        field(50042; "Contract End Date"; Date)
        {
            trigger OnValidate()
            begin
                // fnTrackChanges('change in Contract End Date', Format(xRec."Contract End Date"), Format("Contract End Date"));
            end;
        }
        field(50043; "Notice Period"; Code[20])
        {
        }
        field(50044; "Union Member?"; Boolean)
        {
        }
        field(50045; "Shift Worker?"; Boolean)
        {
        }
        field(50046; "Contracted Hours"; Decimal)
        {
        }
        field(50047; "Pay Period"; Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(50048; "Pay Per Period"; Decimal)
        {
        }
        field(50049; "Cost Code"; Code[20])
        {
        }
        field(50050; "PAYE Number"; Text[60])
        {
        }
        field(50051; "UIF Contributor?"; Boolean)
        {
            Caption = 'Seconded';
        }
        field(50052; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50053; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(50054; "First Language (R/W/S)"; Code[20])
        {
        }
        field(50055; "Driving Licence"; Code[20])
        {
        }
        field(50056; "Vehicle Registration Number"; Code[20])
        {
        }
        field(50057; Disabled; Boolean)
        {
        }
        field(50058; "Health Assesment?"; Boolean)
        {
        }
        field(50059; "Health Assesment Date"; Date)
        {
        }
        field(50060; "Date Of Birth"; Date)
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in Date of Birth', Format(xRec."Date Of Birth"), Format("Date Of Birth"));
            end;
        }
        field(50061; Age; Text[80])
        {
        }
        field(50062; "Date Of Join"; Date)
        {
            trigger OnValidate()
            begin

                //    IF ("Date Of Join" <> 0D) THEN BEGIN
                //       CareerEvent.SetMessage('Joined The Company');
                //       CareerEvent.RUNMODAL;
                //       OK:= CareerEvent.ReturnResult;
                //        IF OK THEN BEGIN
                //           CareerHistory.INIT;
                //           CareerHistory."Employee No.":= "No.";
                //           CareerHistory."Date Of Event":= "Date Of Join";
                //           CareerHistory."Career Event":= 'Joined The Company';
                //           CareerHistory.Joined:= TRUE;
                //           CareerHistory."Employee First Name":= "Known As";
                //           CareerHistory."Employee Last Name":= "Last Name";
                //           CareerHistory.INSERT;
                //        END;
                //    END;
                fnTrackChanges('change in Date of Join', Format(xRec."Date Of Join"), Format("Date Of Join"));
            end;
        }
        field(50063; "Length Of Service"; Text[80])
        {
        }
        field(50064; "End Of Probation Date"; Date)
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in End of Propation', Format(xRec."End Of Probation Date"), Format("End Of Probation Date"));
            end;
        }
        field(50065; "Pension Scheme Join"; Date)
        {
        }
        field(50066; "Time Pension Scheme"; Text[80])
        {
        }
        field(50067; "Medical Scheme Join"; Date)
        {
        }
        field(50068; "Time Medical Scheme"; Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(50069; "Date Of Leaving"; Date)
        {
        }
        field(50070; "Per Annum"; Decimal)
        {
        }
        field(50071; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(50072; "Medical Scheme No."; Text[60])
        {
            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
            end;
        }
        field(50073; "Medical Scheme Head Member"; Text[60])
        {
            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                //  REPEAT
                //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
                //    MedicalAidBenefit.MODIFY;
                //  UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(50074; "Number Of Dependants"; Integer)
        {
            trigger OnValidate()
            begin
                // MedicalAidBenefit.SETRANGE("Employee No.","No.");
                // OK := MedicalAidBenefit.FIND('+');
                // IF OK THEN BEGIN
                //REPEAT
                //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
                //  MedicalAidBenefit.MODIFY;
                //UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(50075; "Medical Scheme Name"; Text[80])
        {
            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(50076; "Amount Paid By Employee"; Decimal)
        {
            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //  OK := MedicalAidBenefit.FIND('+');
                //   IF OK THEN BEGIN
                //     REPEAT
                //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
                //       MedicalAidBenefit.MODIFY;
                //     UNTIL MedicalAidBenefit.NEXT = 0;
                //    END;
            end;
        }
        field(50077; "Amount Paid By Company"; Decimal)
        {
            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                // REPEAT
                //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
                //      MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                //   END;
            end;
        }
        field(50078; "Receiving Car Allowance ?"; Boolean)
        {
        }
        field(50079; "Second Language (R/W/S)"; Code[20])
        {
        }
        field(50080; "Additional Language"; Code[20])
        {
        }
        field(50081; "Cell Phone Reimbursement?"; Boolean)
        {
        }
        field(50082; "Amount Reimbursed"; Decimal)
        {
        }
        field(50083; "Type of Contract"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(50084; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(50085; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50086; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(50087; "Termination Category"; Enum HRTerminationCategories)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(50088; "Job Specification"; Code[60])
        {
            Caption = 'Job ID';
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                hrjobs.Reset();
                hrjobs.SetRange(hrjobs."Job ID", "Job Specification");
                if hrjobs.Find('-') then
                    "Job Title" := hrjobs."Job Description";
                //MODIFY;
                fnTrackChanges('Change in Job Position', Format(xRec."Job Specification"), Format("Job Specification"));
            end;
        }
        field(50089; DateOfBirth; Text[8])
        {
        }
        field(50090; DateEngaged; Text[8])
        {
        }
        field(50091; "Postal Address2"; Text[60])
        {
        }
        field(50092; "Postal Address3"; Text[20])
        {
        }
        field(50093; "Residential Address2"; Text[60])
        {
        }
        field(50094; "Residential Address3"; Text[20])
        {
        }
        field(50095; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(50096; Citizenship; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(50097; "Name Of Manager"; Text[45])
        {
        }
        field(50098; "User ID"; Code[60])
        {
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(50099; "Disabling Details"; Text[50])
        {
        }
        field(50100; "Disability Grade"; Text[60])
        {
        }
        field(50101; "Passport Number"; Text[60])
        {
        }
        field(50102; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50103; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50104; PensionJoin; Text[8])
        {
        }
        field(50105; DateLeaving; Text[60])
        {
        }
        field(50106; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('REGION'));
        }
        field(50107; "Manager Emp No"; Code[60])
        {
        }
        field(50108; Temp; Text[60])
        {
        }
        field(50109; "Employee Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(50110; "Employee Act. Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(50111; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(50112; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(50113; "First Language Read"; Boolean)
        {
        }
        field(50114; "First Language Write"; Boolean)
        {
        }
        field(50115; "First Language Speak"; Boolean)
        {
        }
        field(50116; "Second Language Read"; Boolean)
        {
        }
        field(50117; "Second Language Write"; Boolean)
        {
        }
        field(50118; "Second Language Speak"; Boolean)
        {
        }
        field(50119; "County Code"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(County));
        }
        field(50120; "PIN Number"; Code[20])
        {
        }
        field(50121; "NSSF No."; Code[20])
        {
        }
        field(50122; "NHIF No."; Code[20])
        {
        }
        field(50123; "Cause of Inactivity Code"; Code[20])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(50124; "Grounds for Term. Code"; Code[20])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(50125; "Sacco Staff No"; Code[20])
        {
        }
        field(50126; "Period Filter"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50127; "HELB No"; Text[60])
        {
        }
        field(50128; "Co-Operative No"; Text[20])
        {
        }
        field(50129; "Wedding Anniversary"; Date)
        {
        }
        field(50130; Counties; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Lookup Values" where(Type = filter(County));
        }
        field(50131; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50132; "Cost Center Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COURSE'));
        }
        field(50133; "Position To Succeed"; Code[20])
        {
        }
        field(50134; "Succesion Date"; Date)
        {
        }
        field(50135; "Send Alert to"; Code[20])
        {
        }
        field(50136; Tribe; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50137; Religion; Code[20])
        {
        }
        field(50138; "Job Title"; Text[50])
        {
        }
        field(50139; "Post Office No"; Text[60])
        {
        }
        field(50140; "Posting Group"; Code[20])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(50141; "Payroll Posting Group"; Code[20])
        {
            TableRelation = "prEmployee Posting Group";
        }
        field(50142; "Served Notice Period"; Boolean)
        {
        }
        field(50143; "Exit Interview Date"; Date)
        {
        }
        field(50144; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50145; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(50146; "Medical Scheme Name #2"; Text[20])
        {
            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(50147; "Resignation Date"; Date)
        {
        }
        field(50148; "Suspension Date"; Date)
        {
        }
        field(50149; "Demised Date"; Date)
        {
        }
        field(50150; "Retirement date"; Date)
        {
        }
        field(50151; "Retrenchment date"; Date)
        {
        }
        field(50152; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50153; Permanent; Boolean)
        {
        }
        field(50154; "Library Code"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(50155; Category; Code[60])
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Change in Category', Format(xRec.Category), Format(Category));
            end;
        }
        field(50156; Schools; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50157; "Library Borrower Type"; Option)
        {
            OptionCaption = 'Staff';
            OptionMembers = Staff;
        }
        field(50158; Lecturer; Boolean)
        {
        }
        field(50159; "Maximun Hours"; Decimal)
        {
        }
        field(50160; Password; Text[250])
        {
        }

        field(50161; "Grade Level"; Integer)
        {
            TableRelation = "Job_Salary grade/steps"."Grade Level" where("Employee Category" = field("Salary Category"), "Salary Grade code" = field("Salary Grade"));

            trigger OnValidate()
            var
                SalaryStep: Record "Job_Salary grade/steps";
                EmpSalary: Record "prSalary Card";
            begin
                if EmpSalary.get("No.") then begin
                    SalaryStep.reset();
                    SalaryStep.SetRange(SalaryStep."Salary Grade code", "Salary Grade");
                    SalaryStep.SetRange(SalaryStep."Employee Category", "Salary Category");
                    SalaryStep.SetRange(SalaryStep."Grade Level", "Grade Level");
                    if SalaryStep.find('-') then
                        if EmpSalary."Basic Pay" <> SalaryStep."Basic Salary" then
                            if Confirm('Do you want to update the basic salary with the new level?', false) then begin
                                EmpSalary."Basic Pay" := SalaryStep."Basic Salary";
                                EmpSalary.modify();
                            end;
                end;
                fnTrackChanges('Change in Grade Level', Format(xRec."Grade Level"), Format("Grade Level"));
            end;
        }
        field(50162; "Company Type"; Option)
        {
            OptionCaption = 'KRC Staff,RTI Staff';
            OptionMembers = "KRC Staff","RTI Staff";
        }
        field(50163; "Main Bank"; Code[50])
        {
            TableRelation = "PR Bank Accounts"."Bank Code";
        }
        field(50164; "Branch Bank"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Branch Code" where("Bank Code" = field("Main Bank"));
        }
        field(50165; "Lock Bank Details"; Boolean)
        {
        }
        field(50166; "Bank Account Number"; Code[60])
        {
        }
        field(50167; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50168; "Holiday Days Entitlement"; Decimal)
        {
        }
        field(50169; "Holiday Days Used"; Decimal)
        {
        }
        field(50170; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(50171; "Hourly Rate"; Decimal)
        {
        }
        field(50172; "Daily Rate"; Decimal)
        {
        }
        field(50173; "Other Names"; Text[50])
        {
        }
        field(50174; "Salary Notch/Step"; Code[20])
        {
        }
        field(50175; "Status Change Date"; Date)
        {
        }
        field(50176; "Previous Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50177; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50178; "Prev. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50179; "Curr. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50180; "Prev. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50181; "Curr. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50182; "Gross Income Variation"; Decimal)
        {
        }
        field(50183; "Basic Pay"; Decimal)
        {
            CalcFormula = sum("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                fnTrackChanges('Change in Basic Pay', Format(xRec."Basic Pay"), Format("Basic Pay"));
            end;
        }
        field(50184; "Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50185; "Transaction Amount"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = field("Transaction Code Filter"),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50186; "Transaction Code Filter"; Text[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50187; "Location/Division Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('LOC/DIV'));
        }
        field(50188; "Cost Centre Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COSTCENTRE'));
        }
        field(50189; "Salary Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Table1325417471.Field2117112;
        }
        field(50190; "Salary Notch Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50191; "Payroll Type"; Option)
        {
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(50192; "Employee Classification"; Code[20])
        {
        }
        field(50193; "Transaction AUtil"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('UTILJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50194; "Transaction AEdu"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('EDUJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50195; "Transaction AFurn"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('FURNJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50196; "Department Name"; Text[50])
        {
        }
        field(50197; "Prev. Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = const('NPAY')));
            FieldClass = FlowField;
        }
        field(50198; "Curr. Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = const('NPAY')));
            FieldClass = FlowField;
        }
        field(50199; "Gross Net Pay Variation"; Decimal)
        {
        }
        field(50200; "Prev net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50201; "Curr net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50202; "Gross Net Variation"; Decimal)
        {
        }
        field(50203; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50204; "Selected Period"; Date)
        {
        }
        field(50205; "count"; Integer)
        {
            CalcFormula = count("HR-Employee" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50206; "Portal Password"; Text[180])
        {
            trigger OnValidate()
            begin
                //"Changed Password":=FALSE;
                //MODIFY;
            end;
        }
        field(50207; "Changed Password"; Boolean)
        {
            Editable = false;
        }
        field(50208; "Leave Balance"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Transaction Date" = field("Date Filter")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50209; "Exists in HR"; Integer)
        {
            CalcFormula = count("HR-Employee" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50210; Grade; Code[20])
        {
            TableRelation = Grades;
        }
        field(50211; "Sort No"; Code[20])
        {
            SQLDataType = Integer;
        }
        field(50212; "Job Application No..."; Boolean)
        {
        }
        field(50213; "Salary Category"; Code[20])
        {
            TableRelation = "Employee Categories".Code where(Section = filter(Payroll));
        }
        field(50214; "Salary Grade"; Code[20])
        {
            TableRelation = "Job_Salary grade/steps"."Salary Grade code" where("Employee Category" = field("Salary Category"));

            trigger OnValidate()
            begin
                fnTrackChanges('Change in Salary Grade', Format(xRec."Salary Grade"), Format("Salary Grade"));
            end;
        }
        field(50215; "Current Basic"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50216; "Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table4874.Field2705096;
        }
        field(50217; "New Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table4874.Field2705096;
        }
        field(50218; "Employee Type"; Option)
        {
            OptionCaption = ' ,Permanent,Casual,Part Time,Secondary';
            OptionMembers = " ",Permanent,Casual,"Part Time",Secondary;
        }
        field(50219; "Basic Salary"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50220; "Salary Segment"; Integer)
        {
        }
        field(50221; Section; Code[60])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Location));
        }
        field(50222; "Probation Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "End Of Probation Date" := CalcDate('<+6M>', "Probation Start Date");
            end;
        }
        field(50223; "Period Year Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(50224; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50225; "Returning Officer"; Boolean)
        {
        }
        field(50226; Signature; Blob)
        {
            SubType = Bitmap;
        }
        field(50227; Registrar; Boolean)
        {
        }
        field(50228; "Head of Department"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50229; "Barcode Picture"; Blob)
        {
            SubType = Bitmap;
        }
        field(50230; "Leave Type"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Leave Types".Code where(Gender = field(Gender));
        }
        field(50231; "Medical Scheme Join Date"; Date)
        {
        }
        field(50232; "Physical Disability"; Boolean)
        {
        }
        field(50233; "On Leave"; Boolean)
        {
        }
        field(50234; "Current Leave No"; Code[20])
        {
        }
        field(50235; "Part Time"; Boolean)
        {
            trigger OnValidate()
            begin
                //fnCheckIDNumber();
            end;
        }
        field(50236; "Main Bank Name"; Text[20])
        {
        }
        field(50237; "Branch Bank Name"; Text[20])
        {
        }
        field(50238; "Sub Tribe"; Code[60])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Sub Tribe"));
        }
        field(50239; Divisions; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIVISION'));
        }
        field(50240; "Type of Employee"; Option)
        {
            OptionCaption = 'Primary Employee,Secondary Employee';
            OptionMembers = "Primary Employee","Secondary Employee";
        }
        field(50241; "Residential Status"; Option)
        {
            OptionCaption = 'Resident,Non Resident';
            OptionMembers = Resident,"Non Resident";
        }
        field(50242; BasicPay; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50243; "Status 1"; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;

            trigger OnValidate()
            begin
                // if "Status 1" = "status 1"::Inactive then
                //     TestField("Exit Date");
            end;
        }
        field(50244; Appointment; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Appointments));

            trigger OnValidate()
            begin
                fnTrackChanges('Appointment', Format(xRec.Appointment), Format(Appointment));

                Lookup.Reset();
                Lookup.SetRange(Lookup.Code, Appointment);
                if Lookup.Find('-') then
                    "Appointment Description" := Lookup.Description;
            end;
        }
        field(50245; "Appointment Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if Format("Appointment Duration") <> ' ' then
                    "Appointment End Date" := CalcDate(Format("Appointment Duration"), "Appointment Start Date");

                fnTrackChanges('AppointmentStart Date', Format(xRec."Appointment Start Date"), Format("Appointment Start Date"));
            end;
        }
        field(50246; "Appointment Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if Format("Appointment Start Date") <> ' ' then
                    "Appointment End Date" := CalcDate(Format("Appointment Duration"), "Appointment Start Date");
            end;
        }
        field(50247; "Appointment End Date"; Date)
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Appointment End Date', Format(xRec."Appointment End Date"), Format("Appointment End Date"));
            end;
        }
        field(50248; "Contract Start Date"; Date)
        {
            trigger OnValidate()
            begin
                // if Format("Contract Duration") <> ' ' then
                //     "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date");

                // fnTrackChanges('Contract Start Date', Format(xRec."Contract Start Date"), Format("Contract Start Date"));
            end;
        }
        field(50249; "Contract Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                // if Format("Contract Duration") <> ' ' then
                //     "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date");

                // fnTrackChanges('Contract Duration', Format(xRec."Contract Duration"), Format("Contract Duration"));
            end;
        }
        field(50250; "Bonding End Date"; Date)
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Bonding End Date', Format(xRec."Bonding End Date"), Format("Bonding End Date"));
            end;
        }
        field(50251; Bonded; Boolean)
        {
            trigger OnValidate()
            begin
                fnTrackChanges('Bonded', Format(xRec.Bonded), Format(Bonded));
            end;
        }
        field(50252; "dept Status"; Boolean)
        {
            CalcFormula = lookup("Dimension Value".Blocked where(Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50253; "Section Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field(Section)));
            FieldClass = FlowField;
        }
        field(50254; "Division Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field(Divisions)));
            FieldClass = FlowField;
        }
        field(50255; "Exit Date"; Date)
        {
        }
        field(50256; "Study Leave Start Date"; Date)
        {
        }
        field(50257; "Study Leave End Date"; Date)
        {
        }
        field(50258; "Country Name"; Code[60])
        {
            CalcFormula = lookup("Country/Region".Name where(Code = field("Country Code")));
            FieldClass = FlowField;
        }
        field(50259; "County Name"; Code[60])
        {
            CalcFormula = lookup("HR Lookup Values".Description where(Code = field("County Code")));
            FieldClass = FlowField;
        }
        field(50260; "Exit Reason"; Text[50])
        {
            CalcFormula = lookup("Grounds for Termination".Description where(Code = field("Grounds for Term. Code")));
            FieldClass = FlowField;
        }
        field(50261; "Notify HR Reminders"; Boolean)
        {
        }
        field(50262; "Leave Allocation"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Transaction Date" = field("Date Filter"),
                                                                     "Transaction Type" = const(Allocation)));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50263; "Leave Taken"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Transaction Date" = field("Date Filter"),
                                                                     "Transaction Type" = const(Application)));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50264; "Leave Adjustment"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Transaction Date" = field("Date Filter"),
                                                                     "Transaction Type" = filter("Negative Adjustment" | "Positive Adjustment")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50265; "Leave Overal Bal"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No.")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50266; "Appointment Description"; Text[80])
        {
        }
        field(50267; HMIS; Boolean)
        {
        }
        field(50268; "Lecturer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Lecturers Category".Code;
        }
        field(50269; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50270; Seconded; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50271; Dean; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50272; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50273; Image; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50274; P9Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50275; "Portal OTP Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50276; "Portal OTP Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50277; "Portal OTP Device"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50278; "Portal Reset Token"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50279; "Portal Reset Token Expired"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50280; "OTP Code Used Today"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50281; "Portal Session Token"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50282; "Doctor ID"; Code[30])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50283; "Sub Category"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50284; "License No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50285; "License Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50286; Exclude; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50287; "Otp Expiry Time"; Time)
        {
        }
        field(50288; "Otp Expiry DateTime"; DateTime)
        {
            Caption = 'OTP Expiry DateTime';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "First Name")
        {
        }
        key(Key3; "Last Name")
        {
        }
        key(Key4; "ID Number")
        {
        }
        key(Key5; "Known As")
        {
        }
        key(Key6; "User ID")
        {
        }
        key(Key7; "Cost Code")
        {
        }
        key(Key8; "Date Of Join", "Date Of Leaving")
        {
        }
        key(Key9; "Termination Category")
        {
        }
        key(Key10; "Shortcut Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }

  trigger OnInsert()
begin
    if "No." = '' then begin
        HumanResSetup.Get();
        HumanResSetup.TestField("Employee Nos.");
        "No." := NoSeriesMgt.GetNextNo(HumanResSetup."Employee Nos.");
    end;

    if "No." <> xRec."No." then begin
        HumanResSetup.Get();
        HumanResSetup.TestField("Employee Nos.");
        NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
        "No. Series" := '';
    end;

    fnTrackChanges('NEW EMPLOYEE', Format(xRec."No."), Format("No."));
end;
    trigger OnModify()
    begin
        //fnCheckIDNumber();
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        dimval: Record "Dimension Value";
        hrjobs: Record "HR Jobs";
        Lookup: Record "HR Lookup Values";
        HumanResSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(OldEmployee: Record "HR-Employee"): Boolean
    begin
    end;

    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("Known As" + ' ' + "Last Name")
        else
            exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    procedure CurrentPayDetails()
    begin
    end;

    procedure UpdtResUsersetp(var HREmpl: Record "HR-Employee")
    begin
        /*
        ContMgtSetup.GET;
        IF ContMgtSetup."Customer Integration" =
           ContMgtSetup."Customer Integration"::"No Integration"
        THEN
          EXIT;
        */
        /*
        Res.SETCURRENTKEY("No.");
        Res.SETRANGE("No.",HREmpl."Resource No.");
        IF Res.FIND('-') THEN BEGIN
          Res."Global Dimension 1 Code" := HREmpl."Department Code";
          Res."Global Dimension 2 Code" := HREmpl.Office;
          Res.MODIFY;
        END;

        IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
          Usersetup.Department := HREmpl."Department Code";
          Usersetup.Office := HREmpl.Office;
          Usersetup.MODIFY;
        END;
        */
    end;

    procedure SetEmployeeHistory()
    begin
    end;

    procedure GetPayPeriod()
    begin
    end;

    procedure fnTrackChanges(columnss: Code[250]; oldValue: Code[250]; NewValue: Code[250])
    var
        HRtracker: Record "HR Change Entries";
    begin
        HRtracker.Init();
        HRtracker."employee No" := "No.";
        HRtracker."Change Date" := Today;
        HRtracker."Change Description" := columnss;
        HRtracker."Old Value" := oldValue;
        HRtracker."New Value" := NewValue;
        HRtracker.UserID := UserId;
        HRtracker.Insert();
    end;

    procedure fnCheckIDNumber()
    var
        objEmp: Record "HR-Employee";
    begin
        objEmp.Reset();
        objEmp.SetRange(objEmp."ID Number", "ID Number");
        objEmp.SetRange(objEmp."Part Time", "Part Time");
        if objEmp.Find('-') then
            Error('ID Number Exist');
    end;
}
