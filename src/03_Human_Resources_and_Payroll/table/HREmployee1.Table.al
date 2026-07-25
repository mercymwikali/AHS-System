table 85055 "HR-Employee1"
{
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";

    fields
    {
        field(50000; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(50001; "First Name"; Text[80])
        {
        }
        field(50002; "Middle Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Middle name',Format(xRec."Middle Name"),Format("Middle Name"));
            end;
        }
        field(50003; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Last name',Format(xRec."Last Name"),Format("Last Name"));
            end;
        }
        field(50004; Initials; Text[50])
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
        field(50017; "ID Number"; Text[60])
        {
            trigger OnValidate()
            begin
                //fnCheckIDNumber();
                //fnTrackChanges('Change in ID Number',xRec."ID Number","ID Number");
            end;
        }
        field(50018; "Job Application No"; Code[10])
        {
            TableRelation = Union;
        }
        field(50019; "UIF Number"; Text[10])
        {
            Enabled = false;
        }
        field(50020; Gender; Option)
        {
            OptionMembers = ,Female,Male;
        }
        field(50021; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50022; "Statistics Group Code"; Code[10])
        {
            Enabled = false;
            TableRelation = "Employee Statistics Group";
        }
        field(50023; Status; Option)
        {
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
                //fnTrackChanges('change in Status',Format(xRec.Status),Format(Status));
            end;
        }
        field(50024; "Department Code"; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(50025; Office; Code[10])
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
        field(50030; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50031; "Office Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50032; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(50033; "Fax Number"; Text[60])
        {
            Enabled = false;
        }
        field(50034; "Company E-Mail"; Text[50])
        {
        }
        field(50035; Title; Option)
        {
            OptionCaption = 'MR.,MRS.,MISS.,MS,DR., ENG. ,CC,PROF.,FR,BR,SR';
            OptionMembers = "MR.","MRS.","MISS.",MS,"DR."," ENG. ",CC,"PROF.",FR,BR,SR;
        }
        field(50036; "Salespers./Purch. Code"; Code[10])
        {
        }
        field(50037; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50038; "Known As"; Text[60])
        {
        }
        field(50039; Position; Text[50])
        {
        }
        field(50040; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time","Part Time",Contract;
        }
        field(50041; "Contract Type"; Option)
        {
            Caption = 'Contract Status';
            OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
        }
        field(50042; "Contract End Date"; Date)
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('change in Contract End Date',Format(xRec."Contract End Date"),Format("Contract End Date"));
            end;
        }
        field(50043; "Notice Period"; Code[10])
        {
        }
        field(50044; "Union Member"; Boolean)
        {
        }
        field(50045; "Shift Worker"; Boolean)
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
        field(50049; "Cost Code"; Code[10])
        {
        }
        field(50050; "PAYE Number"; Text[60])
        {
        }
        field(50051; "UIF Contributor"; Boolean)
        {
        }
        field(50052; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow,Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,Widow,Other;
        }
        field(50053; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(50054; "First Language (R/W/S)"; Code[10])
        {
        }
        field(50055; "Driving Licence"; Code[10])
        {
        }
        field(50056; "Vehicle Registration Number"; Code[10])
        {
        }
        field(50057; Disabled; Option)
        {
            OptionMembers = No,Yes," ";

            trigger OnValidate()
            begin
                //IF (Disabled = Disabled::Yes) THEN
                // Status := Status::Disabled;
            end;
        }
        field(50058; "Health Assesment"; Boolean)
        {
        }
        field(50059; "Health Assesment Date"; Date)
        {
        }
        field(50060; "Date Of Birth"; Date)
        {
            trigger OnValidate()
            begin

                //IF FORMAT("Date Of Birth")<>' ' THEN "Retirement date":=CALCDATE(FORMAT("Date Of Birth"),TODAY)-1;

                //fnTrackChanges('Change in Date of Birth',Format(xRec."Date Of Birth"),Format("Date Of Birth"));
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
                //fnTrackChanges('change in Date of Join',Format(xRec."Date Of Join"),Format("Date Of Join"));
            end;
        }
        field(50063; "Length Of Service"; Text[80])
        {
        }
        field(50064; "End Of Probation Date"; Date)
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in End of Propation',Format(xRec."End Of Probation Date"),Format("End Of Probation Date"));
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
        field(50075; "Medical Scheme Name"; Text[150])
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
        field(50078; "Receiving Car Allowance"; Boolean)
        {
        }
        field(50079; "Second Language (R/W/S)"; Code[10])
        {
        }
        field(50080; "Additional Language"; Code[10])
        {
        }
        field(50081; "Cell Phone Reimbursement"; Boolean)
        {
        }
        field(50082; "Amount Reimbursed"; Decimal)
        {
        }
        field(50083; "Type of Contract"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code;
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
        field(50087; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            begin
            end;
        }
        field(50088; "Job Specification"; Code[60])
        {
            Caption = 'Job ID';
            TableRelation = "HR Jobs"."Job ID";
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
        field(50096; Citizenship; Code[10])
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
        field(50106; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('REGION'));
        }
        field(50107; "Manager Emp No"; Code[60])
        {
        }
        field(50108; Temp; Text[100])
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
        field(50123; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(50124; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(50125; "Sacco Staff No"; Code[10])
        {
        }
        field(50126; "Period Filter"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50127; "HELB No"; Text[60])
        {
        }
        field(50128; "Co-Operative No"; Text[60])
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
        field(50132; "Cost Center Code"; Code[10])
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
            TableRelation = "HR Lookup Values".Type where(Type = filter(Language));
        }
        field(50137; Religion; Code[20])
        {
        }
        field(50138; "Job Title"; Text[60])
        {
        }
        field(50139; "Post Office No"; Text[70])
        {
        }
        field(50140; "Posting Group"; Code[50])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(50141; "Payroll Posting Group"; Code[10])
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
        field(50146; "Medical Scheme Name Two"; Text[20])
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
        field(50152; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('CAMPUS'));
        }
        field(50153; Permanent; Boolean)
        {
        }
        field(50154; "Library Category"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(50155; Category; Code[60])
        {
        }
        field(50156; Schools; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50157; "Maximun Hours"; Decimal)
        {
        }
        field(50158; Password; Text[50])
        {
        }
        field(50159; "Grade Level"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(50160; "Company Type"; Option)
        {
            OptionCaption = 'KRC Staff,RTI Staff';
            OptionMembers = "KRC Staff","RTI Staff";
        }
        field(50161; "Main Bank"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";
        }
        field(50162; "Branch Bank"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Branch Code";
        }
        field(50163; "Lock Bank Details"; Boolean)
        {
        }
        field(50164; "Bank Account Number"; Code[60])
        {
        }
        field(50165; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50166; "Holiday Days Entitlement"; Decimal)
        {
        }
        field(50167; "Holiday Days Used"; Decimal)
        {
        }
        field(50168; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(50169; "Hourly Rate"; Decimal)
        {
        }
        field(50170; "Daily Rate"; Decimal)
        {
        }
        field(50171; "Other Names"; Text[50])
        {
        }
        field(50172; "Salary Notch/Step"; Code[20])
        {
        }
        field(50173; "Status Change Date"; Date)
        {
        }
        field(50174; "Previous Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50175; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50176; "Prev. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50177; "Curr. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50178; "Prev. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50179; "Curr. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50180; "Gross Income Variation"; Decimal)
        {
        }
        field(50181; "Basic Pay"; Decimal)
        {
            CalcFormula = sum("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50182; "Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50183; "Transaction Amount"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = field("Transaction Code Filter"),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50184; "Transaction Code Filter"; Text[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50185; "Location/Division Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('LOC/DIV'));
        }
        field(50186; "Cost Centre Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COSTCENTRE'));
        }
        field(50187; "Salary Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //  TableRelation = Table1325417471.Field2117112;
        }
        field(50188; "Salary Notch Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50189; "Payroll Type"; Option)
        {
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(50190; "Employee Classification"; Code[20])
        {
        }
        field(50191; "Transaction AUtil"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('UTILJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50192; "Transaction AEdu"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('EDUJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50193; "Transaction AFurn"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('FURNJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50194; "Department Name"; Text[80])
        {
        }
        field(50195; "Prev. Net Pay"; Decimal)
        {
            // CalcFormula = sum("prPeriod Transactions".Amount where ("Transaction Code"=const('NPAY'),
            //                                                          "Payroll Period"=const(01;
            FieldClass = FlowField;
        }
        field(50196; "Curr. Net Pay"; Decimal)
        {
            /// CalcFormula = sum("prPeriod Transactions".Amount where ("Transaction Code"=const('NPAY'),
            //                                                         "Payroll Period"=const(01;
            FieldClass = FlowField;
        }
        field(50197; "Gross Net Pay Variation"; Decimal)
        {
        }
        field(50198; "Prev net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(50199; "Curr net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(50200; "Gross Net Variation"; Decimal)
        {
        }
        field(50201; "New Departmental Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50202; "Selected Period"; Date)
        {
        }
        field(50203; "count"; Integer)
        {
            //  CalcFormula = count("HR Employee C" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(50204; "Portal Password"; Text[60])
        {
            trigger OnValidate()
            begin
                //"Changed Password":=FALSE;
                //MODIFY;
            end;
        }
        field(50205; "Changed Password"; Boolean)
        {
            Editable = false;
        }
        field(50206; "Leave Balance"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Leave Type" = filter('ANNUAL')));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(50207; "Exists in HR"; Integer)
        {
            // CalcFormula = count("HR Employee" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(50208; Grade; Code[20])
        {
            TableRelation = Grades.Grade;
        }
        field(50209; "Sort No"; Code[10])
        {
            SQLDataType = Integer;
        }
        field(50210; "Job Application No Status"; Boolean)
        {
        }
        field(50211; "Salary Category"; Code[10])
        {
            TableRelation = "Employee Categories".Code where(Section = filter(Payroll));
        }
        field(50212; "Salary Grade"; Code[10])
        {
            TableRelation = "Job_Salary grade/steps"."Salary Grade code" where("Employee Category" = field("Salary Category"));
        }
        field(50213; "Current Basic"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50214; "Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //  TableRelation = Table4874.Field2705096;
        }
        field(50215; "New Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table4874.Field2705096;
        }
        field(50216; "Employee Type"; Option)
        {
            OptionCaption = ' ,Permanent,Casual,Part Time';
            OptionMembers = " ",Permanent,Casual,"Part Time";
        }
        field(50217; "Basic Salary"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50218; "Salary Segment"; Integer)
        {
        }
        field(50219; Section; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50220; "Probation Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "End Of Probation Date" := CalcDate('+6M', "Probation Start Date");
            end;
        }
        field(50221; "Returning Officer"; Boolean)
        {
        }
        field(50222; Signature; Blob)
        {
            SubType = Bitmap;
        }
        field(50223; Registrar; Boolean)
        {
        }
        field(50224; "Head of Department"; Code[10])
        {
            // TableRelation = "HR Employee C"."No.";
        }
        field(50225; "Barcode Picture"; Blob)
        {
            SubType = Bitmap;
        }
        field(50226; "Leave Type"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Leave Types".Code where(Gender = field(Gender));
        }
        field(50227; "Medical Scheme Join Date"; Date)
        {
        }
        field(50228; "Physical Disability"; Boolean)
        {
        }
        field(50229; "On Leave"; Boolean)
        {
        }
        field(50230; "Current Leave No"; Code[10])
        {
        }
        field(50231; "Part Time"; Boolean)
        {
        }
        field(50232; "Main Bank Name"; Text[20])
        {
        }
        field(50233; "Branch Bank Name"; Text[20])
        {
        }
        field(50234; "Sub Tribe"; Code[50])
        {
            Enabled = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Sub Tribe"));
        }
        field(50235; NSSF_Nos; Text[20])
        {
        }
        field(50236; "Period Year Filter"; Integer)
        {
            Description = 'Payroll';
            FieldClass = FlowFilter;
            TableRelation = "prEmployee P9 Info"."Period Year";
        }
        field(50237; "Contract Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if Format("Contract Duration") <> ' ' then
                    "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date") - 1;

                //fnTrackChanges('Contract Start Date',Format(xRec."Contract Start Date"),Format("Contract Start Date"));
            end;
        }
        field(50238; "Contract Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if Format("Contract Duration") <> ' ' then
                    "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date") - 1;

                //fnTrackChanges('Contract Duration',Format(xRec."Contract Duration"),Format("Contract Duration"));
            end;
        }
        field(50239; "Probation Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if Format("Probation Duration") <> ' ' then
                    "End Of Probation Date" := CalcDate(Format("Probation Duration"), "Probation Start Date") - 1;

                //fnTrackChanges('Contract Duration',Format(xRec."Contract Duration"),Format("Contract Duration"));
            end;
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
        key(Key10; "Department Code")
        {
        }
    }
}
