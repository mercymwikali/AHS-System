Table 85158 "Child Registration List"
{
    ObsoleteState = Pending;
    ObsoleteReason = 'This table is no longer in use.';
    fields
    {
        field(50000; "Patient No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*
                IF "Patient No." <> xRec."Patient No." THEN BEGIN
                  HMSSetup.GET;
                  NoSeriesMgt.TestManual(HMSSetup."Patient Nos");
                  "No. Series" := '';
                END;
                */
            end;
        }
        field(50001; "Date Registered"; Date)
        {
        }
        field(50002; "Patient Type"; Option)
        {
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;

            trigger OnValidate()
            begin

                /*IF "Patient Type"<>xRec."Patient Type" THEN BEGIN
                  IF CONFIRM('Do you want to change the existing patient charges from '+FORMAT(xRec."Patient Type")+' to '+FORMAT("Patient Type")+ ' ?',FALSE) THEN BEGIN
                  HMSPatCharges.RESET;
                  HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.","Patient No.");
                  HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                  IF HMSPatCharges.FIND('-') THEN BEGIN
                  IF "Patient Type"="Patient Type"::Corporate THEN BEGIN
                    TESTFIELD("Insurance No.");
                      REPEAT
                        HMSPatCharges."Insurance No":="Insurance No.";
                        HMSPatCharges.MODIFY;
                     UNTIL HMSPatCharges.NEXT=0;
                  END;

                  HMSPatCharges.RESET;
                  HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.","Patient No.");
                  HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                  IF HMSPatCharges.FIND('-') THEN BEGIN
                  IF "Patient Type"="Patient Type"::Cash THEN BEGIN
                    REPEAT
                        HMSPatCharges."Insurance No":='';
                        HMSPatCharges.MODIFY;
                    UNTIL HMSPatCharges.NEXT=0;
                  END;
                END;
                END;
                END;
                {
                // Validate changes
                  HMSPatCharges.RESET;
                  HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.","Patient No.");
                  HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                  IF HMSPatCharges.FIND('-') THEN BEGIN
                    REPEAT
                        HMSPatCharges.VALIDATE(HMSPatCharges."Transaction Type");
                        HMSPatCharges.VALIDATE(HMSPatCharges.Amount);
                        HMSPatCharges.MODIFY;
                    UNTIL HMSPatCharges.NEXT=0;
                  END;
                  }
                END;*/
            end;
        }
        field(50003; Test; Code[10])
        {
        }
        field(50004; Title; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter('Title'));
        }
        field(50005; Surname; Text[30])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                //ValidCharacters(Surname);

                // Religion := "Spouse Telephone No. 1" + ' ' + "Spouse Telephone No. 2" + ' ' + "Spouse Email";
                Names := Surname + ' ' + "Middle Name" + ' ' + "First Name";
            end;
        }
        field(50006; "Middle Name"; Text[30])
        {
            trigger OnValidate()
            begin
                //ValidCharacters("Middle Name");
                // Religion := "Spouse Telephone No. 1" + ' ' + "Spouse Telephone No. 2" + ' ' + "Spouse Email";

                Names := Surname + ' ' + "Middle Name" + ' ' + "First Name";
            end;
        }
        field(50007; "First Name"; Text[30])
        {
            Caption = 'First/English Name';
            trigger OnValidate()
            begin
                // Religion := "Spouse Telephone No. 1" + ' ' + "Spouse Telephone No. 2" + ' ' + "Spouse Email";
                Names := Surname + ' ' + "Middle Name" + ' ' + "First Name";
            end;
        }
        field(50008; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50009; "Date Of Birth"; Date)
        {
        }
        field(50010; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50011; "ID Number"; Code[25])
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                //ValidLength("ID Number",5);

                /*IF DuplicateCustomerExists > 1 THEN BEGIN
                  ERROR('The ID Number Exists');
                END;*/
            end;
        }
        field(50012; Photo; Blob)
        {
        }
        field(50013; "Correspondence Address 1"; Text[100])
        {
        }
        field(50014; "Correspondence Address 2"; Text[100])
        {
        }
        field(50015; "Correspondence Address 3"; Text[100])
        {
        }
        field(50016; "Telephone No. 1"; Code[100])
        {
            trigger OnValidate()
            begin
                //ValidInteger("Telephone No. 1");
                //ValidLength("Telephone No. 1",6);
            end;
        }
        field(50017; "Telephone No. 2"; Code[100])
        {
        }
        field(50018; Email; Text[100])
        {
        }
        field(50019; "Fax No."; Text[30])
        {
        }
        field(50020; "Spouse Name"; Text[30])
        {
        }
        field(50021; "Spouse Address 1"; Text[30])
        {
        }
        field(50022; "Spouse Address 2"; Text[30])
        {
        }
        field(50023; "Spouse Address 3"; Text[30])
        {
        }
        field(50024; "Spouse Telephone No. 1"; Text[30])
        {
        }
        field(50025; "Spouse Telephone No. 2"; Text[30])
        {
        }
        field(50026; "Spouse Email"; Text[100])
        {
        }
        field(50027; "Spouse Fax"; Text[30])
        {
        }
        field(50028; "Place of Birth Village"; Text[30])
        {
        }
        field(50029; "Place of Birth Location"; Text[30])
        {
        }
        field(50030; "Place of Birth District"; Code[20])
        {
        }
        field(50031; "Name of Chief"; Text[100])
        {
        }
        field(50032; "Nearest Police Station"; Text[100])
        {
        }
        field(50033; Nationality; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter('Nationality'));
        }
        field(50034; Religion; Code[20])
        {
        }
        field(50035; "Mother Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(50036; "Mother Full Name"; Text[100])
        {
        }
        field(50037; "Mother Occupation"; Text[30])
        {
        }
        field(50038; "Father Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(50039; "Father Full Name"; Text[100])
        {
        }
        field(50040; "Father Occupation"; Text[30])
        {
        }
        field(50041; "Guardian Name"; Text[100])
        {
        }
        field(50042; "Guardian Occupation"; Text[80])
        {
        }
        field(50043; "Physical Impairment Details"; Text[100])
        {
        }
        field(50044; "Blood Group"; Code[20])
        {
        }
        field(50045; "Without Glasses R.6"; Decimal)
        {
        }
        field(50046; "Without Glasses L.6"; Decimal)
        {
        }
        field(50047; "With Glasses R.6"; Decimal)
        {
        }
        field(50048; "With Glasses L.6"; Decimal)
        {
        }
        field(50049; "Hearing Right Ear"; Decimal)
        {
        }
        field(50050; "Hearing Left Ear"; Decimal)
        {
        }
        field(50051; "Condition Of Teeth"; Text[30])
        {
        }
        field(50052; "Condition Of Throat"; Text[30])
        {
        }
        field(50053; "Condition Of Ears"; Text[30])
        {
        }
        field(50054; "Condition Of Lymphatic Glands"; Text[30])
        {
        }
        field(50055; "Condition Of Nose"; Text[30])
        {
        }
        field(50056; "Circulatory System Pulse"; Text[30])
        {
        }
        field(50057; "Examining Officer"; Text[30])
        {
        }
        field(50058; "Medical Exam Date"; Date)
        {
        }
        field(50059; "Medical Details Not Covered"; Text[100])
        {
        }
        field(50060; "Next of kin Relationship"; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(50061; "Next Of kin Full Name"; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                //ValidCharacters("Next Of kin Full Name");
                //ValidLength("Next Of kin Full Name",2);
            end;
        }
        field(50062; "Next Of kin Address 1"; Text[30])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                //ValidLength("Next Of kin Address 1",6);
            end;
        }
        field(50063; "Next Of kin Address 2"; Text[30])
        {
        }
        field(50064; "Next Of kin Address 3"; Text[30])
        {
        }
        field(50065; "Next Of kin Date of Consent"; Date)
        {
            NotBlank = true;
        }
        field(50066; "Next Of Kin ID Card No."; Code[20])
        {
            Description = 'Stores the national identity card number of the person who consented to the emergency operation';
            NotBlank = true;
        }
        field(50067; "No. Series"; Code[20])
        {
        }
        field(50068; "Appointments Scheduled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50069; "Appointments Completed"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Completed)));
            FieldClass = FlowField;
        }
        field(50070; "Appointments Rescheduled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Rescheduled)));
            FieldClass = FlowField;
        }
        field(50071; "Appointments Cancelled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Cancelled)));
            FieldClass = FlowField;
        }
        field(50072; Height; Decimal)
        {
        }
        field(50073; Weight; Decimal)
        {
        }
        field(50074; "Drug Reaction"; Text[100])
        {
        }
        field(50075; "Insurance No."; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type1" = filter(Customer));

            trigger OnValidate()
            begin
                //IF "Patient Type"<>xRec."Patient Type" THEN BEGIN
                /*IF CONFIRM('Do you want to change the existing patient charges from '+FORMAT(xRec."Patient Type")+' to '+FORMAT("Patient Type")+ ' ?',FALSE)=TRUE THEN BEGIN
                HMSPatCharges.RESET;
                HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.","Patient No.");
                HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                IF HMSPatCharges.FIND('-') THEN BEGIN
                IF "Patient Type"="Patient Type"::Corporate THEN BEGIN
                  TESTFIELD("Insurance No.");
                    REPEAT
                      HMSPatCharges."Insurance No":="Insurance No.";
                      HMSPatCharges.VALIDATE(HMSPatCharges."Transaction Type");
                      HMSPatCharges.VALIDATE(HMSPatCharges.Amount);
                      HMSPatCharges.MODIFY;
                   UNTIL HMSPatCharges.NEXT=0;
                END;

                HMSPatCharges.RESET;
                HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.","Patient No.");
                HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                IF HMSPatCharges.FIND('-') THEN BEGIN
                IF "Patient Type"="Patient Type"::Cash THEN BEGIN
                  REPEAT
                      HMSPatCharges."Insurance No":='';
                      HMSPatCharges.VALIDATE(HMSPatCharges."Transaction Type");
                      HMSPatCharges.VALIDATE(HMSPatCharges.Amount);
                      HMSPatCharges.MODIFY;
                  UNTIL HMSPatCharges.NEXT=0;
                END;
              END;
              END;
              END;

              Customer.GET("Insurance No.");
              "Insurance Name" := Customer.Name;*/
            end;
        }
        field(50076; "Customer Created"; Boolean)
        {
        }
        field(50077; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(50078; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(50079; "Immunization Number"; Code[20])
        {
        }
        field(50080; Blocked; Boolean)
        {
        }
        field(50081; "Request Registration"; Boolean)
        {
        }
        field(50082; Registered; Boolean)
        {
        }
        field(50083; Status; Option)
        {
            OptionMembers = "Request Made","HOD HR Approved","HOD Medical Approved",Registered,"Request Cancelled","HOD HR Rejected","HOD Medical Rejected";
        }
        field(50084; Select; Boolean)
        {
        }
        field(50085; "Patient Ref. No."; Code[20])
        {
            trigger OnValidate()
            begin
                /*IF "Patient Type" = "Patient Type"::Cash THEN BEGIN
                 IF Customer.GET("Patient Ref. No.") THEN BEGIN
                 Title:='';
                 Surname:=Customer.Name;
                 "Middle Name":='';
                 "Last Name":='';
                 Gender:=Customer.Gender;
                 "Date Of Birth":=Customer."Date Of Birth";
                 "Marital Status":=Customer."Marital Status";
                 "ID Number":=  Customer."ID No";
                 "Correspondence Address 1":= Customer.Address;
                 "Correspondence Address 2":= Customer."Address 2";
                 "Correspondence Address 3":=Customer.City;
                 "Telephone No. 1":= Customer."Phone No.";
                 "Telephone No. 2":=Customer."Telex No.";
                 Email:=Customer."E-Mail";
                 "Fax No.":=Customer."Fax No.";
                 "Global Dimension 1 Code":=Customer."Global Dimension 1 Code";
                 "Global Dimension 2 Code" :=Customer."Global Dimension 2 Code";
                 END;
                END ELSE IF "Patient Type" = "Patient Type"::"3" THEN BEGIN
                 IF Emp.GET("Patient Ref. No.") THEN BEGIN
                // Title:=Emp.Title;
                 Surname:= Emp."First Name";
                 "Middle Name":=Emp."Middle Name";
                 "Last Name":=Emp."Last Name";
                 Gender:=Emp.Gender;
                 Title:=FORMAT(Emp.Title);
                 "Date Of Birth":=Emp."Date Of Birth";
                 "Marital Status":=Emp."Marital Status";
                 "ID Number":=Emp."ID Number";
                 "Correspondence Address 1":= Emp."Postal Address";
                 "Correspondence Address 2":=Emp."Residential Address";
                 "Correspondence Address 3":=Emp.City;
                 "Telephone No. 1":= Emp."Cellular Phone Number";
                 "Telephone No. 2":=Emp."Home Phone Number";
                 Email:=Emp."E-Mail";
                 "Fax No.":=Emp."Fax Number";
                 "Global Dimension 2 Code" :=Emp."Department Code";
                 END;

                END  ELSE IF "Patient Type" = "Patient Type"::"4" THEN BEGIN
                benefic.RESET;
                benefic.SETRANGE(benefic."Employee Code","Depandant Principle Member");
                IF "Depandant Principle Member"='' THEN ERROR('Please specify the Principal member number!');
                 benefic.SETRANGE(benefic."Entry No","Patient Ref. No.");
                 IF benefic.FIND('-') THEN BEGIN
                 IF Emp.GET("Depandant Principle Member") THEN BEGIN
                // Title:=Emp.Title;
                 Surname:= benefic.SurName;
                 "Middle Name":=benefic."Other Names";
                 //Gender:=;
                // Title:=FORMAT(Emp.Title);
                 "Date Of Birth":=benefic."Date Of Birth";
                // "Marital Status":=;
                 "ID Number":=benefic."ID No/Passport No";
                 "Correspondence Address 1":= benefic.Address;
                 "Correspondence Address 2":=Emp."Residential Address";
                 "Correspondence Address 3":=Emp.City;
                 "Telephone No. 1":= benefic."Office Tel No";
                 "Telephone No. 2":=benefic."Home Tel No";
                 Email:=Emp."E-Mail";
                 "Fax No.":=Emp."Fax Number";
                 "Global Dimension 2 Code" :=Emp."Department Code";
                 END;
                 END;
                END;

                VALIDATE("Date Of Birth");*/
            end;
        }
        field(50086; "Depandant Principle Member"; Code[50])
        {
        }
        field(50087; "User ID"; Code[20])
        {
        }
        field(50088; "Patient Current Location"; Option)
        {
            OptionCaption = 'New,Triage,Appointment,Observation,Doctor List,Laboratory,Radiology Room,Phamacy,Refered,Cleared,Cancelled,Theatre,Accounts,Discharged';
            OptionMembers = New,Triage,Appointment,Observation,"Doctor List",Laboratory,"Radiology Room",Phamacy,Refered,Cleared,Cancelled,Theatre,Accounts,Discharged;
        }
        field(50089; "Total Billed"; Decimal)
        {
        }
        field(50090; "Registration Status"; Option)
        {
            OptionCaption = 'Registration,Cleared';
            OptionMembers = Registration,Cleared;
        }
        field(50091; "Triage Status"; Option)
        {
            OptionCaption = ' ,Triage,Cleared';
            OptionMembers = " ",Triage,Cleared;
        }
        field(50092; "Appointment Status"; Option)
        {
            OptionCaption = ' ,Appointment,Cleared';
            OptionMembers = " ",Appointment,Cleared;
        }
        field(50093; "Observation Status"; Option)
        {
            OptionCaption = ' ,Observation,Cleared';
            OptionMembers = " ",Observation,Cleared;
        }
        field(50094; "Doctor Visit Status"; Option)
        {
            OptionCaption = ' ,Doctor,Cleared';
            OptionMembers = " ",Doctor,Cleared;
        }
        field(50095; "Laboratory Status"; Option)
        {
            OptionCaption = ' ,Laboratory,Cleared ';
            OptionMembers = " ",Laboratory,"Cleared ";
        }
        field(50096; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Radiology,Cleared';
            OptionMembers = " ",Radiology,Cleared;
        }
        field(50097; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pharmacy,Cleared';
            OptionMembers = " ",Pharmacy,Cleared;
        }
        field(50098; "Hospital Billing Status"; Option)
        {
            OptionCaption = 'Billing,Cleared';
            OptionMembers = Billing,Cleared;
        }
        field(50099; "Insurance Name"; Text[100])
        {
        }
        field(50100; "Membership No"; Code[50])
        {
        }
        field(50101; "Next Appointment"; Date)
        {
        }
        field(50102; "Staff No"; Code[10])
        {
        }
        field(50103; "Adm No."; Code[10])
        {
        }
        field(50104; Inpatient; Boolean)
        {
        }
        field(50105; "Admissions Date"; Date)
        {
        }
        field(50106; "Discharge Date"; Date)
        {
        }
        field(50107; "Walk-in"; Boolean)
        {
        }
        field(50108; "Search Name"; Text[200])
        {
        }
        field(50109; "Employee No."; Code[20])
        {
        }
        field(50110; Activated; Boolean)
        {
            Description = 'Activatred means the patient can be seen from casheir window';
        }
        field(50111; "Bill Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false),
                                                                          "Receipt Reversed" = const(false),
                                                                          "Visit No" = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(50112; "Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Total Amount" = filter(> 0),
                                                                          Closed = const(false),
                                                                          "Visit No" = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(50113; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(false),
                                                                  "Receipt Reversed" = const(false),
                                                                  "Visit No" = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(50114; "Doctor Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No."),
                                                                            Amount = filter(> 0),
                                                                            Claimed = const(false),
                                                                            "Visit No" = field("Visit No Filter")));
            FieldClass = FlowField;
        }
        field(50115; "Age in Years"; Integer)
        {
            Description = ' ,Normal,Transfered,Deceased';
        }
        field(50116; "Discharged Type"; Option)
        {
            OptionCaption = ' ,Normal,Transfered,Deceased';
            OptionMembers = " ",Normal,Transfered,Deceased;
        }
        field(50117; Names; Text[100])
        {
        }
        field(50118; "Special Clinics"; Option)
        {
            OptionCaption = 'Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician';
            OptionMembers = Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician;
        }
        field(50119; "Open Charges Count"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             "Insurance No" = filter(<> ''),
                                                             "Invoice Number" = filter(''),
                                                             "Insurance Amount" = filter(> 0),
                                                             Medicentre = filter(false),
                                                             Sunflash = filter(false),
                                                             Date = field("Date Filter"),
                                                             Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50120; "Appointment No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50121; "File No"; Code[20])
        {
        }
        field(50122; "Open Insurance Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Posted = const(false),
                                                                          Closed = const(false)));
            FieldClass = FlowField;
        }
        field(50123; "Current Adm No"; Code[20])
        {
        }
        field(50124; "Posted Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Total Amount" = filter(> 0),
                                                                          Posted = const(true)));
            FieldClass = FlowField;
        }
        field(50125; "Active Visit No"; Code[20])
        {
        }
        field(50126; "Invoice Amount1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(> 0),
                                                                  Posted = const(true),
                                                                  Closed = const(true)));
            FieldClass = FlowField;
        }
        field(50127; "Receipt Amount1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(true),
                                                                  Posted = const(true),
                                                                  "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(50128; "UnClaimed Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  "Doctors Amount" = filter(> 0),
                                                                  "Doctor ID" = filter(<> ''),
                                                                  Claimed = const(false)));
            FieldClass = FlowField;
        }
        field(50129; "Patient Occupation"; Text[250])
        {
        }
        field(50130; "Exist in Admission"; Integer)
        {
            CalcFormula = count("HMS Admission Form Header" where("Patient No." = field("Patient No."),
                                                                   Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(50131; "Exist in Discharge"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Patient No." = field("Patient No."),
                                                                        Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50132; "Admission Date"; Date)
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission Date" where("Patient No." = field("Patient No."),
                                                                                     Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(50133; "Admitting Doctor"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header".Doctor where("Patient No." = field("Patient No."),
                                                                           Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(50134; "Current Ward"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header".Ward where("Patient No." = field("Patient No."),
                                                                         Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(50135; "Last Appointment Date"; Date)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where("Patient No." = field("Patient No."),
                                                                                         "Appointment No." = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(50136; "Old File No"; Code[10])
        {
        }
        field(50137; "Visit No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50138; Balance; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Visit No Filter")));
            FieldClass = FlowField;
        }
        field(50139; "Dental Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('DENTAL')));
            FieldClass = FlowField;
        }
        field(50140; "DOCTORS  Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('DOCTORS FEES')));
            FieldClass = FlowField;
        }
        field(50141; "ICU Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ICU')));
            FieldClass = FlowField;
        }
        field(50142; "INPATIENT STORE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('INPATIENT STORE')));
            FieldClass = FlowField;
        }
        field(50143; "IP PHARMACY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('IP PHARMACY')));
            FieldClass = FlowField;
        }
        field(50144; "LABORATORY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('LABORATORY')));
            FieldClass = FlowField;
        }
        field(50145; "MATERNITY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('MATERNITY')));
            FieldClass = FlowField;
        }
        field(50146; "NUTRITION Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('NUTRITION')));
            FieldClass = FlowField;
        }
        field(50147; "OP CONSULTATION Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OP CONSULTATION FEES')));
            FieldClass = FlowField;
        }
        field(50148; "OPTICAL Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OPTICAL')));
            FieldClass = FlowField;
        }
        field(50149; "ORTHOPAEDIC Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ORTHOPAEDIC')));
            FieldClass = FlowField;
        }
        field(50150; "OUTPATIENT STORE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OUTPATIENT STORE')));
            FieldClass = FlowField;
        }
        field(50151; "PHYSIOTHERAPY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('PHYSIOTHERAPY')));
            FieldClass = FlowField;
        }
        field(50152; "THEATRE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(50153; "WARD PROCEDURES Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('WARD PROCEDURES')));
            FieldClass = FlowField;
        }
        field(50154; "Admissions Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ADMISSION')));
            FieldClass = FlowField;
        }
        field(50155; "Ambulance Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('AMBULANCE SERVICES')));
            FieldClass = FlowField;
        }
        field(50156; "Bed Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('BED CHARGES')));
            FieldClass = FlowField;
        }
        field(50157; "Visit Invoice No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Patient No." = field("Patient No."),
                                                                               "Visit No" = field("Active Visit No"),
                                                                               "Invoice Number" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50158; "Physio No."; Code[20])
        {
        }
        field(50159; "Admission Type"; Option)
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Medical,Surgical,ICU,Day Case';
            OptionMembers = " ",Medical,Surgical,ICU,"Day Case";
        }
        field(50160; "In Discharge List"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Patient No." = field("Patient No."),
                                                                        Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50161; "Sunflash Counter"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             Sunflash = const(true)));
            FieldClass = FlowField;
        }
        field(50162; "Medicenter Counter"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             Medicentre = const(true)));
            FieldClass = FlowField;
        }
        field(50163; "Sunflash Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Sunflash = const(true),
                                                                          "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(50164; "MediCenter Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Medicentre = const(true),
                                                                          "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(50165; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50166; "Charges Date"; Date)
        {
            CalcFormula = lookup("HMS Patient Charges".Date where("Patient No." = field(upperlimit("Patient No.")),
                                                                   "Insurance No" = filter(<> ''),
                                                                   "Posted Invoice No." = filter(''),
                                                                   "Insurance Amount" = filter(> 0),
                                                                   Medicentre = filter(false),
                                                                   Sunflash = filter(false),
                                                                   Date = field(upperlimit("Date Filter"))));
            FieldClass = FlowField;
        }
        field(50167; "Un Posted Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Insurance No" = filter(<> ''),
                                                                          "Invoice Number" = filter(''),
                                                                          "Insurance Amount" = filter(> 0),
                                                                          Medicentre = filter(false),
                                                                          Sunflash = filter(false),
                                                                          Date = field("Date Filter"),
                                                                          Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50168; "Trans Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false),
                                                                          "Receipt Reversed" = const(false),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = field("Trans Type Filter")));
            FieldClass = FlowField;
        }
        field(50169; "Trans Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50170; "Scheme Name"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
