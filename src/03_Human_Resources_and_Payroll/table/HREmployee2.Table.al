Table 85056 "HR Employee2"
{
    Caption = 'Employee';
    //DataCaptionFields = "No.","Job Title","First Name","Middle Name","Last Name","Search Name";
    // DrillDownFormID = Form39005622;
    // LookupFormID = Form39005622;

    fields
    {
        field(50000; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(50001; "First Name"; Text[30])
        {
        }
        field(50002; "Middle Name"; Text[30])
        {
        }
        field(50003; "Last Name"; Text[30])
        {
        }
        field(50004; Initials; Text[50])
        {
            //TableRelation = "Staff Title".Code;
        }
        field(50005; "Search Name"; Code[50])
        {
        }
        field(50006; "Postal Address"; Text[10])
        {
        }
        field(50007; "Residential Address"; Text[20])
        {
        }
        field(50008; City; Text[20])
        {
        }
        field(50009; "Post Code"; Code[20])
        {
            //TableRelation = "Post Code";
            //This property is currently not supported
            //Test//TableRelation = false;
        }
        field(50010; County; Text[20])
        {
        }
        field(50011; "Home Phone Number"; Text[20])
        {
        }
        field(50012; "Cellular Phone Number"; Text[30])
        {
        }
        field(50013; "Work Phone Number"; Text[20])
        {
        }
        field(50014; "Ext."; Text[10])
        {
        }
        field(50015; "E-Mail"; Text[70])
        {
        }
        field(50016; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50017; "ID Number"; Text[20])
        {
        }
        field(50018; "Union Code"; Code[10])
        {
            //TableRelation = Union;
        }
        field(50019; "UIF Number"; Text[10])
        {
        }
        field(50020; Gender; Option)
        {
            OptionMembers = Female,Male;
        }
        field(50021; "Country Code"; Code[20])
        {
            //TableRelation = "Country/Region";
        }
        field(50022; "Statistics Group Code"; Code[10])
        {
            //TableRelation = "Employee Statistics Group";
        }
        field(50023; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Probation,Confirmed;
        }
        field(50024; "Department Code"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('DEPARTMENT'));

            trigger OnValidate()
            begin
                /*
                 { IF (("Department Code" <> xRec."Department Code") AND (xRec."Department Code" <> '')) THEN BEGIN
                      CareerEvent.SetMessage('Department Changed');
                      CareerEvent.RUNMODAL;
                      OK:= CareerEvent.ReturnResult;
                       IF OK THEN BEGIN
                          IF NOT CareerHistory.FIND('-') THEN
                           CareerHistory."Line No.":=1
                         ELSE BEGIN
                           CareerHistory.FIND('+');
                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
                         END;
                          CareerHistory.INIT;
                          CareerHistory."Employee No.":= "No.";
                          CareerHistory."Date Of Event":= WORKDATE;
                          CareerHistory."Career Event":= 'Department Changed';
                          CareerHistory.Department:="Department Code";
                          CareerHistory."Employee First Name":= "Known As";
                          CareerHistory."Employee Last Name":= "Last Name";
                          CareerHistory.INSERT;
                       END;
                     //  Code below commented by Linus
                      {
                       IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
                         EmployeeResUpdate.ResUpdate(Rec)
                      }
                   END;
                }
               //Added to change dept on employee table and assignment matrix table
               //employee payroll
               IF Payroll.GET("No.") THEN BEGIN
               Payroll."Department Code":="Department Code";
               Payroll.MODIFY;
               END;

               //
                GetPayPeriod;
               // "Payroll Period":=PayStartDate;
               //  "Pay Period":=PayPeriodText;

               //Employee No,Type,Code,Payroll Period,Department Code

               AssMatrix.RESET;
               AssMatrix.SETRANGE(AssMatrix."Employee No","No.");
               AssMatrix.SETRANGE("Payroll Period",PayStartDate);
               IF AssMatrix.FIND('-') THEN BEGIN
                REPEAT
                 AssMatrixTemp.TRANSFERFIELDS(AssMatrix);
                 AssMatrixTemp."Department Code":="Department Code";
                 AssMatrixTemp.INSERT;
                 AssMatrix.DELETE;
                UNTIL AssMatrix.NEXT=0;
               END;

               AssMatrixTemp.RESET;
               AssMatrixTemp.SETRANGE(AssMatrixTemp."Employee No","No.");
               AssMatrixTemp.SETRANGE("Payroll Period",PayStartDate);
               IF AssMatrixTemp.FIND('-') THEN BEGIN
                REPEAT
                 AssMatrix.TRANSFERFIELDS(AssMatrixTemp);
                 //AssMatrix."Department Code":="Department Code";
                 AssMatrix.INSERT;
                AssMatrixTemp.DELETE;
                UNTIL AssMatrixTemp.NEXT=0;
               END;
                */
            end;
        }
        field(50025; Office; Code[10])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('BRANCH'));
        }
        field(50026; "Resource No."; Code[10])
        {
            //TableRelation = Resource;
        }
        field(50027; Comment; Boolean)
        {
            //CalcFormula = exist("HR Human Resource Comments" where ("Table Name"=const(Employee),

            FieldClass = FlowField;
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
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(50031; "Office Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(50032; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Employee;
        }
        field(50033; "Fax Number"; Text[30])
        {
        }
        field(50034; "Company E-Mail"; Text[50])
        {
        }
        field(50035; Title; Option)
        {
            OptionCaption = 'MR,MRS,MISS,MS,DR,  ,CC,ASSCOC.PROF,PROF,REV.,REV. DR.';
            OptionMembers = MR,MRS,MISS,MS,DR,"  ",CC,"ASSCOC.PROF",PROF,"REV.","REV. DR.";
        }
        field(50036; "Salespers./Purch. Code"; Code[20])
        {
        }
        field(50037; "No. Series"; Code[20])
        {
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(50038; "Known As"; Text[30])
        {
        }
        field(50039; Position; Text[10])
        {
        }
        field(50040; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time"," Part Time",Contract;
        }
        field(50041; "Contract Type"; Code[10])
        {
            //TableRelation = "Contract Types".Contract;
        }
        field(50042; "Contract End Date"; Date)
        {
        }
        field(50043; "Notice Period"; Code[20])
        {
            //TableRelation = "HR Notice Period".Code;
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
            //TableRelation = "HR Cost Code";
        }
        field(50050; "PAYE Number"; Text[30])
        {
        }
        field(50051; "UIF Contributor?"; Boolean)
        {
        }
        field(50052; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50053; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(50054; "First Language (R/W/S)"; Code[20])
        {
            //TableRelation = "HR Language Preference";
        }
        field(50055; "Driving Licence"; Code[20])
        {
            //TableRelation = "HR Drivers Licence";
        }
        field(50056; "Vehicle Registration Number"; Code[20])
        {
        }
        field(50057; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(50058; "Health Assesment?"; Boolean)
        {
        }
        field(50059; "Health Assesment Date"; Date)
        {
        }
        field(50060; "Date Of Birth"; Date)
        {
        }
        field(50061; Age; Text[50])
        {
        }
        field(50062; "Date Of Join"; Date)
        {
        }
        field(50063; "Length Of Service"; Text[50])
        {
        }
        field(50064; "End Of Probation Date"; Date)
        {
        }
        field(50065; "Pension Scheme Join"; Date)
        {
        }
        field(50066; "Time Pension Scheme"; Text[20])
        {
        }
        field(50067; "Medical Scheme Join"; Date)
        {
        }
        field(50068; "Time Medical Scheme"; Text[20])
        {
            //This property is currently not supported
            //Test//TableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //Validate//TableRelation = true;
        }
        field(50069; "Date Of Leaving"; Date)
        {
        }
        field(50070; Paterson; Code[20])
        {
            //TableRelation = "HR Paterson".Paterson;
        }
        field(50071; Peromnes; Code[20])
        {
            //TableRelation = "HR Peromnes";
        }
        field(50072; Hay; Code[20])
        {
            //TableRelation = "HR Hay".Hay;
        }
        field(50073; Castellion; Code[20])
        {
            //TableRelation = "HR Castellion".Castillion;
        }
        field(50074; "Per Annum"; Decimal)
        {
        }
        field(50075; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(50076; "Medical Scheme No."; Text[30])
        {
        }
        field(50077; "Medical Scheme Head Member"; Text[60])
        {
        }
        field(50078; "Number Of Dependants"; Integer)
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
        field(50079; "Medical Scheme Name"; Text[30])
        {
            //TableRelation = "Medical Scheme"."Medical Scheme";

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
        field(50080; "Amount Paid By Employee"; Decimal)
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
        field(50081; "Amount Paid By Company"; Decimal)
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
        field(50082; "Receiving Car Allowance ?"; Boolean)
        {
        }
        field(50083; "Second Language (R/W/S)"; Code[20])
        {
            //TableRelation = "HR Language Preference".Code;
        }
        field(50084; "Additional Language"; Code[20])
        {
            //TableRelation = "HR Language Preference".Code;
        }
        field(50085; "Cell Phone Reimbursement?"; Boolean)
        {
        }
        field(50086; "Amount Reimbursed"; Decimal)
        {
        }
        field(50087; "UIF Country"; Code[20])
        {
            //TableRelation = "Country/Region".Code;
        }
        field(50088; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(50089; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50090; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(50091; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;

            //**Added by ACR 12/08/2002
            //**Block resource if Terminated
        }
        field(50092; "Job Specification"; Code[30])
        {
        }
        field(50093; DateOfBirth; Date)
        {
        }
        field(50094; DateEngaged; Date)
        {
        }
        field(50095; "Postal Address2"; Text[30])
        {
        }
        field(50096; "Postal Address3"; Text[20])
        {
        }
        field(50097; "Residential Address2"; Text[30])
        {
        }
        field(50098; "Residential Address3"; Text[20])
        {
        }
        field(50099; "Post Code2"; Code[20])
        {
            //TableRelation = "Post Code";
        }
        field(50100; Citizenship; Code[20])
        {
            //TableRelation = "Country/Region".Code;
        }
        field(50101; "Name Of Manager"; Text[30])
        {
        }
        field(50102; "User ID"; Code[20])
        {
            //TableRelation = User."User ID";
            //This property is currently not supported
            //Test//TableRelation = true;
        }
        field(50103; "Disabling Details"; Text[30])
        {
        }
        field(50104; "Disability Grade"; Text[30])
        {
        }
        field(50105; "Passport Number"; Text[30])
        {
        }
        field(50106; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50107; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50108; PensionJoin; Text[8])
        {
        }
        field(50109; DateLeaving; Text[30])
        {
        }
        field(50110; Region; Code[10])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('REGION'));
        }
        field(50111; "Manager Emp No"; Code[30])
        {
        }
        field(50112; Temp; Text[20])
        {
        }
        field(50113; "Employee Qty"; Integer)
        {
            //CalcFormula = count("HR Employee C");
            FieldClass = FlowField;
        }
        field(50114; "Employee Act. Qty"; Integer)
        {
            //CalcFormula = count("HR Employee C" where ("Termination Category"=filter(=" ")));
            FieldClass = FlowField;
        }
        field(50115; "Employee Arc. Qty"; Integer)
        {
            //CalcFormula = count("HR Employee C" where ("Termination Category"=filter(<>" ")));
            FieldClass = FlowField;
        }
        field(50116; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(50117; "First Language Read"; Boolean)
        {
        }
        field(50118; "First Language Write"; Boolean)
        {
        }
        field(50119; "First Language Speak"; Boolean)
        {
        }
        field(50120; "Second Language Read"; Boolean)
        {
        }
        field(50121; "Second Language Write"; Boolean)
        {
        }
        field(50122; "Second Language Speak"; Boolean)
        {
        }
        field(50123; "Custom Grading"; Code[20])
        {
            //TableRelation = "HR Custom Grading"."Custom Grading";
        }
        field(50124; "PIN Number"; Code[20])
        {
        }
        field(50125; "NSSF No."; Code[20])
        {
        }
        field(50126; "NHIF No."; Code[20])
        {
        }
        field(50127; "Cause of Inactivity Code"; Code[20])
        {
            Caption = 'Cause of Inactivity Code';
            //TableRelation = "Cause of Inactivity";
        }
        field(50128; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            //TableRelation = "Grounds for Termination";
        }
        field(50129; "PAYROLL NO"; Code[10])
        {
        }
        field(50130; "HELB No"; Text[10])
        {
        }
        field(50131; "Co-Operative No"; Text[10])
        {
        }
        field(50132; "Wedding Anniversary"; Date)
        {
        }
        field(50133; Grade; Code[20])
        {
            FieldClass = Normal;
            //TableRelation = Grades.Grade;
        }
        field(50134; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Competency Areas".Code where ("Employee No"=field("No."),
        }
        field(50135; "Cost Center Code"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('COURSE'));
        }
        field(50136; "Position To Succeed"; Code[20])
        {
            //TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate()
            begin
                /*SuccessionGap.RESET;
                SuccessionGap.SETRANGE(SuccessionGap."Employee No","No.");
                IF SuccessionGap.FIND('-') THEN
                SuccessionGap.DELETEALL;

                JobReq.RESET;
                JobReq.SETRANGE(JobReq."Job Id","Position To Succeed");
                IF JobReq.FIND('-') THEN
                BEGIN
                REPEAT
                IF NOT EmpQualification.GET("No.",JobReq."Qualification Code") THEN
                BEGIN
                SuccessionGap.INIT;
                SuccessionGap."Employee No":="No.";
                SuccessionGap."Job Id":=JobReq."Job Id";
                SuccessionGap."Qualification Type":=JobReq."Qualification Type";
                SuccessionGap."Qualification Code":=JobReq."Qualification Code";
                SuccessionGap.Qualification:=JobReq.Qualification;
                SuccessionGap.Priority:=JobReq.Priority;
                SuccessionGap.INSERT;
                END;
                UNTIL JobReq.NEXT = 0;
                END;
                 */
            end;
        }
        field(50137; "Succesion Date"; Date)
        {
        }
        field(50138; "Send Alert to"; Code[20])
        {
            //TableRelation = "HR Employee C"."No.";
        }
        field(50139; Tribe; Code[20])
        {
            //TableRelation = "Ethnic Community".Code;
        }
        field(50140; Religion; Code[20])
        {
            //TableRelation = Religion.Relegion;
        }
        field(50141; "Job Title"; Text[50])
        {
        }
        field(50142; "Post Office No"; Text[10])
        {
        }
        field(50143; "Posting Group"; Code[10])
        {
            NotBlank = true;
            //TableRelation = "HR Posting Groups"."Posting Group";
        }
        field(50144; "Payroll Posting Group"; Code[10])
        {
            //TableRelation = "prEmployee Posting Group".Code;
        }
        field(50145; "Served Notice Period"; Boolean)
        {
        }
        field(50146; "Exit Interview Date"; Date)
        {
        }
        field(50147; "Exit Interview Done by"; Code[20])
        {
            //TableRelation = "HR Employee C"."No.";
        }
        field(50148; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(50149; "Medical Scheme Name #2"; Text[20])
        {
            //TableRelation = "Medical Scheme"."Medical Scheme";

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
        field(50150; "Resignation Date"; Date)
        {
        }
        field(50151; "Suspension Date"; Date)
        {
        }
        field(50152; "Demised Date"; Date)
        {
        }
        field(50153; "Retirement date"; Date)
        {
        }
        field(50154; "Retrenchment date"; Date)
        {
        }
        field(50155; Campus; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('CAMPUS'));
        }
        field(50156; Permanent; Boolean)
        {
        }
        field(50157; "Library Category"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(50158; Category; Code[20])
        {
        }
        field(50159; "Payroll Departments"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(50160; "Library Code"; Code[20])
        {
            //TableRelation = "Library HR Codes"."Lib Code";
        }
        field(50161; "Library Borrower Type"; Option)
        {
            OptionCaption = 'Staff';
            OptionMembers = Staff;
        }
        field(50162; Names; Text[50])
        {
        }
        field(50163; Lecturer; Boolean)
        {
        }
        field(50164; "Maximun Hours"; Decimal)
        {
        }
        field(50165; Password; Text[50])
        {
        }
        field(50166; "count"; Integer)
        {
            //CalcFormula = count("HR Employee C" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(50167; "Portal Password"; Text[20])
        {
            trigger OnValidate()
            begin
                "Changed Password" := false;
                Modify();
            end;
        }
        field(50168; "Changed Password"; Boolean)
        {
        }
        field(50169; Active; Boolean)
        {
        }
        field(50170; "Employee Type"; Option)
        {
            OptionCaption = ' ,Permanent,Casual,Part Time';
            OptionMembers = " ",Permanent,Casual,"Part Time";
        }
        field(50171; "Legnth of Contract"; Text[10])
        {
        }
        field(50172; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50173; "Global Dimension 2"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(50174; "Social Security No."; Code[10])
        {
        }
        field(50175; "Total Leave Taken"; Decimal)
        {
            //CalcFormula = sum("HR Leave Ledg Entries2"."No. of days" where ("Staff No."=field("No."),
            //  "Leave Entry Type"=filter(Negative),
            //  "Leave Type"=field("Leave Type Filter")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(50176; "Total (Leave Days)"; Decimal)
        {
            //CalcFormula = sum("HR Leave Ledg Entries2"."No. of days" where ("Staff No."=field("No."),
            //    "Leave Entry Type"=const(Positive)));
            DecimalPlaces = 2 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50177; "Cash - Leave Earned"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50178; "Reimbursed Leave Days"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                Validate("Allocated Leave Days");
            end;
        }
        field(50179; "Cash per Leave Day"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50180; "Allocated Leave Days"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                CalcFields("Total Leave Taken");
                "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
                //TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(50181; "End of Contract Date"; Date)
        {
        }
        field(50182; "Main Bank"; Code[10])
        {
            //TableRelation = "prBank Structure"."Bank Code";

            trigger OnValidate()
            begin
                // PrBankStructure.SETRANGE(PrBankStructure."Bank Code","Main Bank");
                //  IF  PrBankStructure.FIND('-') THEN
                // "Branch Bank":=PrBankStructure."Branch Code";
            end;
        }
        field(50183; "Branch Bank"; Code[10])
        {
            //TableRelation = "prBank Structure"."Branch Code";

            trigger OnValidate()
            begin
                //   PrBankStructure.SETRANGE(PrBankStructure."Branch Code","Branch Bank");
                //   IF  PrBankStructure.FIND('-') THEN
                //   "Main Bank":=PrBankStructure."Bank Code";
            end;
        }
        field(50184; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(50185; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(50186; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            //TableRelation = "Alternative Address".Code where ("Employee No."=field("No."));
        }
        field(50187; "Bank Account Number"; Code[15])
        {
        }
        field(50188; "Total Absence (Base)"; Decimal)
        {
            //CalcFormula = sum("Employee Absence"."Quantity (Base)" where ("Employee No."=field("No."),
            //"Cause of Absence Code"=field("Cause of Absence Filter"),
            //  "From Date"=field("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50189; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Cause of Absence";
        }
        field(50190; "Leave Status"; Option)
        {
            OptionMembers = "On Leave"," Resumed";
        }
        field(50191; "Leave Type Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Leave Types".Code;
        }
        field(50192; UserID; Code[10])
        {
        }
        field(50193; "HR Department Name"; Text[70])
        {
        }
        field(50194; County1; Text[10])
        {
        }
        field(50195; "Is Driver"; Boolean)
        {
        }
        field(50196; "Is Administrator"; Boolean)
        {
        }
        field(50197; "CCentre Name"; Text[10])
        {
        }
        field(50198; "Leave Date Filter"; Text[10])
        {
        }
        field(50199; TotalLeaveTaken; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50200; "Reason for Joining"; Text[10])
        {
        }
        field(50201; "Reason for Leaving"; Text[10])
        {
        }
        field(50202; "Loan Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            //TableRelation = Employee."Address 2";
        }
        field(50203; CurrentYearFilter; Date)
        {
            Description = 'To filter the leave days as per the year';
            FieldClass = FlowFilter;
        }
        field(50204; "New Bal B/F"; Decimal)
        {
        }
        field(50205; "New Balance"; Decimal)
        {
        }
        field(50206; "New Earned"; Decimal)
        {
        }
        field(50207; "Leave Bal Val"; Decimal)
        {
        }
        field(50208; "Total Leave Earned"; Decimal)
        {
            //CalcFormula = sum("Assignment Matrix M".Amount where ("Employee No"=field("No."),
            //Code=filter(E006)));
            FieldClass = FlowField;
        }
        field(50209; "Staff Special Imprest Account"; Code[20])
        {
            //TableRelation = Customer;
        }
        field(50210; "Staff Other Staff Debt Account"; Code[20])
        {
            //TableRelation = Customer;
        }
        field(50211; "Transport Allowance"; Decimal)
        {
        }
        field(50212; "Last Date of Promotion"; Date)
        {
        }
        field(50213; "Retirement Yrs"; Decimal)
        {
        }
        field(50214; "Check 1"; Boolean)
        {
        }
        field(50215; "Check 2"; Boolean)
        {
        }
        field(50216; "Check 3"; Boolean)
        {
        }
        field(50217; "Check 4"; Boolean)
        {
        }
        field(50218; "Check 5"; Boolean)
        {
        }
        field(50219; "Check 6"; Boolean)
        {
        }
        field(50220; "Check 7"; Boolean)
        {
        }
        field(50221; "Check 8"; Boolean)
        {
        }
        field(50222; "Check 9"; Boolean)
        {
        }
        field(50223; "Check 10"; Boolean)
        {
        }
        field(50224; Check11; Boolean)
        {
        }
        field(50225; "Check 12"; Boolean)
        {
        }
        field(50226; "Leave Allowance"; Decimal)
        {
        }
        field(50227; "Leave Taken Adjusted"; Decimal)
        {
        }
        field(50228; "Leave CateSgory"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Normal,Managerial';
            OptionMembers = Normal,Managerial;
        }
        field(50229; "Earned Leave Days"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50230; "Cost Center Units"; Boolean)
        {
        }
        field(50231; "Lock Bank Details"; Boolean)
        {
        }
        field(50232; test; Code[10])
        {
        }
        field(50233; "HR Department"; Code[10])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=filter('DEPARTMENT'));
        }
        field(50234; "Notice Send Date"; Date)
        {
        }
        field(50235; "Notice Send"; Boolean)
        {
        }
        field(50236; "Application No"; Code[10])
        {
        }
        field(50237; "Dimension 3"; Code[10])
        {
            CaptionClass = '1,2,3';
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=filter('BRANCH'));
        }
        field(50238; "Dimension 4"; Code[10])
        {
            CaptionClass = '1,2,4';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(50239; "Dimension 5"; Code[10])
        {
            CaptionClass = '1,2,5';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(5));
        }
        field(50240; "Dimension 6"; Code[10])
        {
            CaptionClass = '1,2,6';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(6));
        }
        field(50241; "Dimension 7"; Code[10])
        {
            CaptionClass = '1,2,7';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(7));
        }
        field(50242; "Dimension 8"; Code[10])
        {
            CaptionClass = '1,2,8';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(8));
        }
        field(50243; "Dimension 2"; Code[10])
        {
            CaptionClass = '1,2,4';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(50244; Approver; Boolean)
        {
        }
        field(50245; "Alert Date"; Date)
        {
        }
        field(50246; EverLogged; Boolean)
        {
        }
        field(50247; "Disable Portal"; Boolean)
        {
        }
        field(50248; MD; Boolean)
        {
        }
        field(50249; TotalDaysVal; Decimal)
        {
        }
        field(50250; "Actual Job ID"; Code[10])
        {
            //TableRelation = "HR Job Matrix Entry"."Act Job ID" where ("Job ID"=field(Position));
        }
        field(50251; "Activate Terminated"; Boolean)
        {
        }
        field(50252; Step; Code[10])
        {
            //TableRelation = "HR Job Category/Grade".Code where (Type=filter(Step));
        }
        field(50253; "Other Language"; Text[10])
        {
        }
        field(50254; "Calculation Scheme"; Code[10])
        {
            //TableRelation = Table132226.Field1048577;
        }
        field(50255; "TALGWU No."; Code[10])
        {
        }
        field(50256; "Mode of Payments"; Option)
        {
            OptionMembers = Cash,Cheque,Bank;
        }
        field(50257; "PPF No."; Code[10])
        {
        }
        field(50258; "PSPF No"; Code[10])
        {
        }
        field(50259; "LAPF No."; Code[10])
        {
        }
        field(50260; "Staff Salary Advance Account"; Code[20])
        {
            //TableRelation = Customer;
        }
        field(50261; "Staff Loan Account"; Code[20])
        {
            //TableRelation = Customer;
        }
        field(50262; "Grade Step"; Code[10])
        {
        }
        field(50263; Scale; Code[10])
        {
            //TableRelation = "Setup Parameters".Code where (Type=const("Salary Scale"));
        }
        field(50264; "Basic Pay"; Decimal)
        {
        }
        field(50265; "Staff Safari Imprest Account"; Code[20])
        {
            //TableRelation = Customer;
        }
        field(50266; "Bank Code"; Code[10])
        {
            //TableRelation = Employee;
        }
        field(50267; "Bank Code 2"; Code[10])
        {
            //TableRelation = Employee;
        }
        field(50268; "Bank Account No 2"; Code[10])
        {
        }
        field(50269; "Bank Code 3"; Code[10])
        {
            //TableRelation = Employee;
        }
        field(50270; "Bank Account No 3"; Code[10])
        {
        }
        field(50271; "Bank Code 4"; Code[10])
        {
            //TableRelation = Employee;
        }
        field(50272; "Bank Account No 4"; Code[10])
        {
        }
        field(50273; "Bank Account 2 (Net Amount)"; Decimal)
        {
        }
        field(50274; "Bank Account 3 (Net Amount)"; Decimal)
        {
        }
        field(50275; "Bank Account 4 (Net Amount)"; Decimal)
        {
        }
        field(50276; "Confirmation Date"; Date)
        {
        }
        field(50277; "Confirmation Status"; Option)
        {
            OptionMembers = "Not Confirmed",Confirmed;
        }
        field(50278; "Appointment Date"; Date)
        {
        }
        field(50279; Succeed; Text[10])
        {
        }
        field(50280; "Clearance Status"; Option)
        {
            OptionCaption = 'HOD Clearance,FM Clearance,ICT Clearance,HR Clearance,Done Cleared';
            OptionMembers = "HOD Clearance","FM Clearance","ICT Clearance","HR Clearance";
        }
        field(50281; Users; Boolean)
        {
        }
        field(50282; "Total Active Permanent"; Integer)
        {
            //CalcFormula = count("HR Employee C" where ("Employee Type"=filter(Permanent),
            //Status=filter(Normal)));
            FieldClass = FlowField;
        }
        field(50283; "Total Active Casuals"; Integer)
        {
            //CalcFormula = count("HR Employee C" where ("Employee Type"=filter(Casual),
            //  Status=filter(Normal)));
            FieldClass = FlowField;
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
        key(Key5; "User ID")
        {
        }
        key(Key6; "Cost Code")
        {
        }
        key(Key7; "Date Of Join", "Date Of Leaving")
        {
        }
        key(Key8; "Termination Category")
        {
        }
        key(Key9; "Known As")
        {
        }
    }

    fieldgroups
    {
    }

    //MedicalAidBenefit.SETRANGE("Employee No.","No.");
    //MedicalAidBenefit.DELETEALL;

    //PensionBenefit.SETRANGE("Employee No.","No.");
    //PensionBenefit.DELETEALL;

    //CarBenefit.SETRANGE("Employee No.","No.");
    //CarBenefit.DELETEALL;

    trigger OnInsert()
    begin

        //CurrentPayDetails;
    end;

    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("Known As" + ' ' + "Last Name")
        else
            exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}
