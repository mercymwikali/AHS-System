table 52202439 "HR-Employee1"
{
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; "First Name"; Text[80])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Middle name',Format(xRec."Middle Name"),Format("Middle Name"));
            end;
        }
        field(4; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Last name',Format(xRec."Last Name"),Format("Last Name"));
            end;
        }
        field(5; Initials; Text[50])
        {
            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[60])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[60])
        {
        }
        field(13; "Home Phone Number"; Text[60])
        {
        }
        field(14; "Cellular Phone Number"; Text[60])
        {
        }
        field(15; "Work Phone Number"; Text[60])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
        }
        field(19; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(21; "ID Number"; Text[60])
        {
            trigger OnValidate()
            begin
                //fnCheckIDNumber();
                //fnTrackChanges('Change in ID Number',xRec."ID Number","ID Number");
            end;
        }
        field(22; "Job Application No"; Code[10])
        {
            TableRelation = Union;
        }
        field(23; "UIF Number"; Text[10])
        {
            Enabled = false;
        }
        field(24; Gender; Option)
        {
            OptionMembers = ,Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Enabled = false;
            TableRelation = "Employee Statistics Group";
        }
        field(31; Status; Option)
        {
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
                //fnTrackChanges('change in Status',Format(xRec.Status),Format(Status));
            end;
        }
        field(36; "Department Code"; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(37; Office; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(38; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        field(39; Comment; Boolean)
        {
            Editable = false;
        }
        field(40; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(42; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(43; "Office Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(49; "Fax Number"; Text[60])
        {
            Enabled = false;
        }
        field(50; "Company E-Mail"; Text[50])
        {
        }
        field(51; Title; Option)
        {
            OptionCaption = 'MR.,MRS.,MISS.,MS,DR., ENG. ,CC,PROF.,FR,BR,SR';
            OptionMembers = "MR.","MRS.","MISS.",MS,"DR."," ENG. ",CC,"PROF.",FR,BR,SR;
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
        }
        field(53; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Known As"; Text[60])
        {
        }
        field(55; Position; Text[50])
        {
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time","Part Time",Contract;
        }
        field(58; "Contract Type"; Option)
        {
            Caption = 'Contract Status';
            OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
        }
        field(59; "Contract End Date"; Date)
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('change in Contract End Date',Format(xRec."Contract End Date"),Format("Contract End Date"));
            end;
        }
        field(60; "Notice Period"; Code[10])
        {
        }
        field(61; "Union Member"; Boolean)
        {
        }
        field(62; "Shift Worker"; Boolean)
        {
        }
        field(63; "Contracted Hours"; Decimal)
        {
        }
        field(64; "Pay Period"; Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(65; "Pay Per Period"; Decimal)
        {
        }
        field(66; "Cost Code"; Code[10])
        {
        }
        field(68; "PAYE Number"; Text[60])
        {
        }
        field(69; "UIF Contributor"; Boolean)
        {
        }
        field(73; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow,Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,Widow,Other;
        }
        field(74; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75; "First Language (R/W/S)"; Code[10])
        {
        }
        field(76; "Driving Licence"; Code[10])
        {
        }
        field(77; "Vehicle Registration Number"; Code[10])
        {
        }
        field(78; Disabled; Option)
        {
            OptionMembers = No,Yes," ";

            trigger OnValidate()
            begin
                //IF (Disabled = Disabled::Yes) THEN
                // Status := Status::Disabled;
            end;
        }
        field(79; "Health Assesment"; Boolean)
        {
        }
        field(80; "Health Assesment Date"; Date)
        {
        }
        field(81; "Date Of Birth"; Date)
        {
            trigger OnValidate()
            begin

                //IF FORMAT("Date Of Birth")<>' ' THEN "Retirement date":=CALCDATE(FORMAT("Date Of Birth"),TODAY)-1;

                //fnTrackChanges('Change in Date of Birth',Format(xRec."Date Of Birth"),Format("Date Of Birth"));
            end;
        }
        field(82; Age; Text[80])
        {
        }
        field(83; "Date Of Join"; Date)
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
        field(84; "Length Of Service"; Text[80])
        {
        }
        field(85; "End Of Probation Date"; Date)
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in End of Propation',Format(xRec."End Of Probation Date"),Format("End Of Probation Date"));
            end;
        }
        field(86; "Pension Scheme Join"; Date)
        {
        }
        field(87; "Time Pension Scheme"; Text[80])
        {
        }
        field(88; "Medical Scheme Join"; Date)
        {
        }
        field(89; "Time Medical Scheme"; Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90; "Date Of Leaving"; Date)
        {
        }
        field(95; "Per Annum"; Decimal)
        {
        }
        field(96; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(97; "Medical Scheme No."; Text[60])
        {
            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
            end;
        }
        field(98; "Medical Scheme Head Member"; Text[60])
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
        field(99; "Number Of Dependants"; Integer)
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
        field(100; "Medical Scheme Name"; Text[150])
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
        field(101; "Amount Paid By Employee"; Decimal)
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
        field(102; "Amount Paid By Company"; Decimal)
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
        field(103; "Receiving Car Allowance"; Boolean)
        {
        }
        field(104; "Second Language (R/W/S)"; Code[10])
        {
        }
        field(105; "Additional Language"; Code[10])
        {
        }
        field(106; "Cell Phone Reimbursement"; Boolean)
        {
        }
        field(107; "Amount Reimbursed"; Decimal)
        {
        }
        field(108; "Type of Contract"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code;
        }
        field(109; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(110; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(112; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            begin
            end;
        }
        field(113; "Job Specification"; Code[60])
        {
            Caption = 'Job ID';
            TableRelation = "HR Jobs"."Job ID";
        }
        field(114; DateOfBirth; Text[8])
        {
        }
        field(115; DateEngaged; Text[8])
        {
        }
        field(116; "Postal Address2"; Text[60])
        {
        }
        field(117; "Postal Address3"; Text[20])
        {
        }
        field(118; "Residential Address2"; Text[60])
        {
        }
        field(119; "Residential Address3"; Text[20])
        {
        }
        field(120; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(121; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(122; "Name Of Manager"; Text[45])
        {
        }
        field(123; "User ID"; Code[60])
        {
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(124; "Disabling Details"; Text[50])
        {
        }
        field(125; "Disability Grade"; Text[60])
        {
        }
        field(126; "Passport Number"; Text[60])
        {
        }
        field(127; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129; PensionJoin; Text[8])
        {
        }
        field(130; DateLeaving; Text[60])
        {
        }
        field(131; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('REGION'));
        }
        field(132; "Manager Emp No"; Code[60])
        {
        }
        field(133; Temp; Text[100])
        {
        }
        field(134; "Employee Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(135; "Employee Act. Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(136; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = count("HR-Employee");
            FieldClass = FlowField;
        }
        field(137; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(138; "First Language Read"; Boolean)
        {
        }
        field(139; "First Language Write"; Boolean)
        {
        }
        field(140; "First Language Speak"; Boolean)
        {
        }
        field(141; "Second Language Read"; Boolean)
        {
        }
        field(142; "Second Language Write"; Boolean)
        {
        }
        field(143; "Second Language Speak"; Boolean)
        {
        }
        field(144; "County Code"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(County));
        }
        field(145; "PIN Number"; Code[20])
        {
        }
        field(146; "NSSF No."; Code[20])
        {
        }
        field(147; "NHIF No."; Code[20])
        {
        }
        field(148; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(149; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(150; "Sacco Staff No"; Code[10])
        {
        }
        field(151; "Period Filter"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(152; "HELB No"; Text[60])
        {
        }
        field(153; "Co-Operative No"; Text[60])
        {
        }
        field(154; "Wedding Anniversary"; Date)
        {
        }
        field(155; Counties; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Lookup Values" where(Type = filter(County));
        }
        field(156; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(157; "Cost Center Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COURSE'));
        }
        field(158; "Position To Succeed"; Code[20])
        {
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[20])
        {
        }
        field(161; Tribe; Code[20])
        {
            TableRelation = "HR Lookup Values".Type where(Type = filter(Language));
        }
        field(162; Religion; Code[20])
        {
        }
        field(163; "Job Title"; Text[60])
        {
        }
        field(164; "Post Office No"; Text[70])
        {
        }
        field(165; "Posting Group"; Code[50])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(166; "Payroll Posting Group"; Code[10])
        {
            TableRelation = "prEmployee Posting Group";
        }
        field(167; "Served Notice Period"; Boolean)
        {
        }
        field(168; "Exit Interview Date"; Date)
        {
        }
        field(169; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name Two"; Text[20])
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
        field(172; "Resignation Date"; Date)
        {
        }
        field(173; "Suspension Date"; Date)
        {
        }
        field(174; "Demised Date"; Date)
        {
        }
        field(175; "Retirement date"; Date)
        {
        }
        field(176; "Retrenchment date"; Date)
        {
        }
        field(177; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('CAMPUS'));
        }
        field(178; Permanent; Boolean)
        {
        }
        field(179; "Library Category"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(180; Category; Code[60])
        {
        }
        field(181; Schools; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(186; "Maximun Hours"; Decimal)
        {
        }
        field(187; Password; Text[50])
        {
        }
        field(188; "Grade Level"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(189; "Company Type"; Option)
        {
            OptionCaption = 'KRC Staff,RTI Staff';
            OptionMembers = "KRC Staff","RTI Staff";
        }
        field(190; "Main Bank"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";
        }
        field(191; "Branch Bank"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Branch Code";
        }
        field(192; "Lock Bank Details"; Boolean)
        {
        }
        field(193; "Bank Account Number"; Code[60])
        {
        }
        field(195; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(196; "Holiday Days Entitlement"; Decimal)
        {
        }
        field(197; "Holiday Days Used"; Decimal)
        {
        }
        field(198; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(199; "Hourly Rate"; Decimal)
        {
        }
        field(200; "Daily Rate"; Decimal)
        {
        }
        field(201; "Other Names"; Text[50])
        {
        }
        field(302; "Salary Notch/Step"; Code[20])
        {
        }
        field(303; "Status Change Date"; Date)
        {
        }
        field(304; "Previous Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(305; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(306; "Prev. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(307; "Curr. Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('BPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(308; "Prev. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(309; "Curr. Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('GPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(310; "Gross Income Variation"; Decimal)
        {
        }
        field(311; "Basic Pay"; Decimal)
        {
            CalcFormula = sum("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(312; "Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(313; "Transaction Amount"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = field("Transaction Code Filter"),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(314; "Transaction Code Filter"; Text[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(318; "Location/Division Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('LOC/DIV'));
        }
        field(320; "Cost Centre Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COSTCENTRE'));
        }
        field(321; "Salary Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //  TableRelation = Table1325417471.Field2117112;
        }
        field(322; "Salary Notch Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(323; "Payroll Type"; Option)
        {
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(324; "Employee Classification"; Code[20])
        {
        }
        field(325; "Transaction AUtil"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('UTILJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(326; "Transaction AEdu"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('EDUJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(327; "Transaction AFurn"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('FURNJN'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(328; "Department Name"; Text[80])
        {
        }
        field(330; "Prev. Net Pay"; Decimal)
        {
            // CalcFormula = sum("prPeriod Transactions".Amount where ("Transaction Code"=const('NPAY'),
            //                                                          "Payroll Period"=const(01;
            FieldClass = FlowField;
        }
        field(331; "Curr. Net Pay"; Decimal)
        {
            /// CalcFormula = sum("prPeriod Transactions".Amount where ("Transaction Code"=const('NPAY'),
            //                                                         "Payroll Period"=const(01;
            FieldClass = FlowField;
        }
        field(332; "Gross Net Pay Variation"; Decimal)
        {
        }
        field(333; "Prev net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(334; "Curr net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("No."),
                                                                    "Transaction Code" = const('NPAY'),
                                                                    "Payroll Period" = field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(335; "Gross Net Variation"; Decimal)
        {
        }
        field(336; "New Departmental Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(337; "Selected Period"; Date)
        {
        }
        field(338; "count"; Integer)
        {
            //  CalcFormula = count("HR Employee C" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(339; "Portal Password"; Text[60])
        {
            trigger OnValidate()
            begin
                //"Changed Password":=FALSE;
                //MODIFY;
            end;
        }
        field(340; "Changed Password"; Boolean)
        {
            Editable = false;
        }
        field(341; "Leave Balance"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("No."),
                                                                     "Leave Type" = filter('ANNUAL')));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(50000; "Exists in HR"; Integer)
        {
            // CalcFormula = count("HR Employee" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(50001; Grade; Code[20])
        {
            TableRelation = Grades.Grade;
        }
        field(50002; "Sort No"; Code[10])
        {
            SQLDataType = Integer;
        }
        field(50003; "Job Application No Status"; Boolean)
        {
        }
        field(50004; "Salary Category"; Code[10])
        {
            TableRelation = "Employee Categories".Code where(Section = filter(Payroll));
        }
        field(50005; "Salary Grade"; Code[10])
        {
            TableRelation = "Job_Salary grade/steps"."Salary Grade code" where("Employee Category" = field("Salary Category"));
        }
        field(50006; "Current Basic"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50007; "Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //  TableRelation = Table4874.Field2705096;
        }
        field(50008; "New Grade Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table4874.Field2705096;
        }
        field(50009; "Employee Type"; Option)
        {
            OptionCaption = ' ,Permanent,Casual,Part Time';
            OptionMembers = " ",Permanent,Casual,"Part Time";
        }
        field(50010; "Basic Salary"; Decimal)
        {
            CalcFormula = lookup("prSalary Card"."Basic Pay" where("Employee Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(50011; "Salary Segment"; Integer)
        {
        }
        field(50012; Section; Code[60])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50013; "Probation Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "End Of Probation Date" := CalcDate('+6M', "Probation Start Date");
            end;
        }
        field(60000; "Returning Officer"; Boolean)
        {
        }
        field(60001; Signature; Blob)
        {
            SubType = Bitmap;
        }
        field(60002; Registrar; Boolean)
        {
        }
        field(60003; "Head of Department"; Code[10])
        {
            // TableRelation = "HR Employee C"."No.";
        }
        field(60004; "Barcode Picture"; Blob)
        {
            SubType = Bitmap;
        }
        field(60005; "Leave Type"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Leave Types".Code where(Gender = field(Gender));
        }
        field(60006; "Medical Scheme Join Date"; Date)
        {
        }
        field(60007; "Physical Disability"; Boolean)
        {
        }
        field(60011; "On Leave"; Boolean)
        {
        }
        field(60012; "Current Leave No"; Code[10])
        {
        }
        field(60013; "Part Time"; Boolean)
        {
        }
        field(60014; "Main Bank Name"; Text[20])
        {
        }
        field(60015; "Branch Bank Name"; Text[20])
        {
        }
        field(60016; "Sub Tribe"; Code[50])
        {
            Enabled = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Sub Tribe"));
        }
        field(60017; NSSF_Nos; Text[20])
        {
        }
        field(60018; "Period Year Filter"; Integer)
        {
            Description = 'Payroll';
            FieldClass = FlowFilter;
            TableRelation = "prEmployee P9 Info"."Period Year";
        }
        field(60019; "Contract Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if Format("Contract Duration") <> ' ' then
                    "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date") - 1;

                //fnTrackChanges('Contract Start Date',Format(xRec."Contract Start Date"),Format("Contract Start Date"));
            end;
        }
        field(60020; "Contract Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if Format("Contract Duration") <> ' ' then
                    "Contract End Date" := CalcDate(Format("Contract Duration"), "Contract Start Date") - 1;

                //fnTrackChanges('Contract Duration',Format(xRec."Contract Duration"),Format("Contract Duration"));
            end;
        }
        field(60021; "Probation Duration"; DateFormula)
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
