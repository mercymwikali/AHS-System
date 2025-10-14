Table 52202643 "HMS Patient"
{
    DrillDownPageID = "HMS Patient List2";
    LookupPageID = "HMS Patient List2";

    fields
    {
        field(1; "Patient No."; Code[20])
        {
            // Editable = false;
            Enabled = true;

            trigger OnValidate()
            begin

            end;
        }
        field(2; "Date Registered"; Date)
        {
        }
        field(3; "Patient Type"; Option)
        {
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;

            trigger OnValidate()
            begin
                // TODO : Review patient type validation During billing process
                // TODO : Add Insuarance Patient Type
                // if Confirm('Do you want to change the existing patient charges from ' + Format(xRec."Patient Type") + ' to ' + Format("Patient Type") + ' ?', false) = true then
                //     ApplyToPatientCharges();
            end;
        }
        field(4; Test; Code[10])
        {
        }
        field(7; Title; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter('Title'));
        }
        field(8; Surname; Text[100])
        {
            Caption = 'First/English Name';
            NotBlank = true;

            trigger OnValidate()
            begin
                ValidCharacters(Surname);
                Surname := UPPERCASE(Surname);
                "Search Name" := Surname + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
        field(9; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                //ValidCharacters("Middle Name");
                "Middle Name" := UpperCase("Middle Name");
                "Search Name" := Surname + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
        field(10; "Last Name"; Text[50])
        {

            trigger OnValidate()
            begin
                "Last Name" := UpperCase("Last Name");
                "Search Name" := Surname + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
        field(11; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(12; "Date Of Birth"; Date)
        {
        }
        field(13; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(14; "ID Number"; Code[30])
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                ValidLength("ID Number", 5);

                if (Dependant = false) and (DuplicateCustomerExists() > 0) then
                    Error('The ID Number Exists');
            end;
        }
        field(15; Photo; Blob)
        {
        }
        field(16; "Correspondence Address 1"; Text[100])
        {
        }
        field(17; "Correspondence Address 2"; Text[100])
        {
        }
        field(18; "Correspondence Address 3"; Text[100])
        {
        }
        field(19; "Telephone No. 1"; Code[30])
        {

            trigger OnValidate()
            begin
                if strlen("Telephone No. 1") > 12 then error('Invalid Phone number');
                ValidInteger("Telephone No. 1");
                ValidLength("Telephone No. 1", 6);
                if Dependant = false then
                    if DuplicatePhoneExists() > 1 then
                        Error('The Telephone Number Exists');
            end;
        }
        field(20; "Telephone No. 2"; Code[100])
        {
        }
        field(21; Email; Text[100])
        {
        }
        field(22; "Fax No."; Text[30])
        {
        }
        field(23; "Spouse Name"; Text[30])
        {
        }
        field(24; "Spouse Address 1"; Text[30])
        {
        }
        field(25; "Spouse Address 2"; Text[30])
        {
        }
        field(26; "Spouse Address 3"; Text[30])
        {
        }
        field(27; "Spouse Telephone No. 1"; Text[30])
        {
        }
        field(28; "Spouse Telephone No. 2"; Text[30])
        {
        }
        field(29; "Spouse Email"; Text[100])
        {
        }
        field(30; "Spouse Fax"; Text[30])
        {
        }
        field(31; "Place of Birth Village"; Text[30])
        {
        }
        field(32; "Place of Birth Location"; Text[30])
        {
        }
        field(33; "Place of Birth District"; Code[20])
        {
            TableRelation = "Application Setup County".Code;
        }
        field(34; "Name of Chief"; Text[100])
        {
        }
        field(35; "Nearest Police Station"; Text[100])
        {
        }
        field(36; Nationality; Code[20])
        {
            TableRelation = "Country/Region".code;
        }
        field(37; Religion; Code[20])
        {
        }
        field(38; "Mother Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(39; "Mother Full Name"; Text[100])
        {
            trigger OnValidate()
            begin
                "Mother Full Name" := UpperCase("Mother Full Name");
            end;
        }
        field(40; "Mother Occupation"; Text[30])
        {
        }
        field(41; "Father Alive or Dead"; Option)
        {
            OptionMembers = Alive,Deceased;
        }
        field(42; "Father Full Name"; Text[100])
        {
        }
        field(43; "Father Occupation"; Text[30])
        {
        }
        field(44; "Guardian Name"; Text[100])
        {
        }
        field(45; "Guardian Occupation"; Text[80])
        {
        }
        field(46; "Physical Impairment Details"; Text[100])
        {
        }
        field(47; "Blood Group"; Code[20])
        {
        }
        field(48; "Without Glasses R.6"; Decimal)
        {
        }
        field(49; "Without Glasses L.6"; Decimal)
        {
        }
        field(50; "With Glasses R.6"; Decimal)
        {
        }
        field(51; "With Glasses L.6"; Decimal)
        {
        }
        field(52; "Hearing Right Ear"; Decimal)
        {
        }
        field(53; "Hearing Left Ear"; Decimal)
        {
        }
        field(54; "Condition Of Teeth"; Text[30])
        {
        }
        field(55; "Condition Of Throat"; Text[30])
        {
        }
        field(56; "Condition Of Ears"; Text[30])
        {
        }
        field(57; "Condition Of Lymphatic Glands"; Text[30])
        {
        }
        field(58; "Condition Of Nose"; Text[30])
        {
        }
        field(59; "Circulatory System Pulse"; Text[30])
        {
        }
        field(60; "Examining Officer"; Text[30])
        {
        }
        field(61; "Medical Exam Date"; Date)
        {
        }
        field(62; "Medical Details Not Covered"; Text[100])
        {
        }
        field(63; "Next of kin Relationship"; Code[20])
        {
            //NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(64; "Next Of kin Full Name"; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Next Of kin Full Name" <> '' then begin
                    "Next Of kin Full Name" := UpperCase("Next Of kin Full Name");
                    ValidCharacters("Next Of kin Full Name");
                    ValidLength("Next Of kin Full Name", 2);
                end;
            end;
        }
        field(65; "Next Of kin Address 1"; Text[30])
        {
            // NotBlank = true;

            trigger OnValidate()
            begin
                if "Next Of kin Full Name" <> '' then
                    ValidLength("Next Of kin Address 1", 6);
            end;
        }
        field(66; "Next Of kin Address 2"; Text[30])
        {
        }
        field(67; "Next Of kin Address 3"; Text[30])
        {
        }
        field(68; "Next Of kin Date of Consent"; Date)
        {
            NotBlank = true;
        }
        field(69; "Next Of Kin ID Card No."; Code[20])
        {
            Description = 'Stores the national identity card number of the person who consented to the emergency operation';
            NotBlank = true;
        }
        field(70; "No. Series"; Code[20])
        {
        }
        field(71; "Appointments Scheduled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(72; "Appointments Completed"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Completed)));
            FieldClass = FlowField;
        }
        field(73; "Appointments Rescheduled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Rescheduled)));
            FieldClass = FlowField;
        }
        field(74; "Appointments Cancelled"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     Status = const(Cancelled)));
            FieldClass = FlowField;
        }
        field(75; Height; Decimal)
        {
        }
        field(76; Weight; Decimal)
        {
        }
        field(77; "Drug Reaction"; Text[100])
        {
        }
        field(78; "Insurance No."; Code[100])
        {
            TableRelation = Customer."No." where("Customer Type" = filter(Customer), Blocked = const(" "));

            trigger OnValidate()
            begin
                if "Insurance No." <> '' then "Patient Type" := "Patient Type"::Corporate;

                // TestField("Patient Type", "Patient Type"::Corporate);
                //if "Patient Type"<>xRec."Patient Type" then begin

                // if Confirm('Do you want to change the existing patient charges from ' + Format(xRec."Patient Type") + ' to ' + Format("Patient Type") + ' ?', false) = true then
                // ApplyToPatientCharges();
                if "Insurance No." <> '' then begin
                    Customer.Get("Insurance No.");
                    "Insurance Name" := Customer.Name;
                end;
            end;
        }
        field(79; "Customer Created"; Boolean)
        {
        }
        field(80; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(81; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(82; "Immunization Number"; Code[20])
        {
        }
        field(83; Blocked; Boolean)
        {
        }
        field(84; "Request Registration"; Boolean)
        {
        }
        field(85; Registered; Boolean)
        {
        }
        field(86; Status; Option)
        {
            OptionMembers = "Request Made","HOD HR Approved","HOD Medical Approved",Registered,"Request Cancelled","HOD HR Rejected","HOD Medical Rejected";
        }
        field(87; Select; Boolean)
        {
        }
        field(88; "Patient Ref. No."; Code[20])
        {

            trigger OnValidate()
            var
                benefic: Record "Employee Beneficiaries";
            begin
                if "Patient Type" = "patient type"::Cash then
                    if Customer.Get("Patient Ref. No.") then begin
                        Title := '';
                        Surname := Customer.Name;
                        "Middle Name" := '';
                        "Last Name" := '';
                        Gender := Customer.Gender;
                        "Date Of Birth" := Customer."Date Of Birth";
                        "Marital Status" := Customer."Marital Status";
                        "ID Number" := Customer."ID No";
                        "Correspondence Address 1" := Customer.Address;
                        "Correspondence Address 2" := Customer."Address 2";
                        "Correspondence Address 3" := Customer.City;
                        "Telephone No. 1" := Customer."Phone No.";
                        "Telephone No. 2" := Customer."Telex No.";
                        Email := Customer."E-Mail";
                        "Fax No." := Customer."Fax No.";
                        "Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                    end
                    else
                        if "Patient Type" = "patient type"::" " then begin
                            if Emp.Get("Patient Ref. No.") then begin
                                // Title:=Emp.Title;
                                Surname := Emp."First Name";
                                "Middle Name" := Emp."Middle Name";
                                "Last Name" := Emp."Last Name";
                                Gender := Emp.Gender;
                                Title := Format(Emp.Title);
                                "Date Of Birth" := Emp."Date Of Birth";
                                "Marital Status" := Emp."Marital Status";
                                "ID Number" := Emp."ID Number";
                                "Correspondence Address 1" := Emp."Postal Address";
                                "Correspondence Address 2" := Emp."Residential Address";
                                "Correspondence Address 3" := Emp.City;
                                "Telephone No. 1" := Emp."Cellular Phone Number";
                                "Telephone No. 2" := Emp."Home Phone Number";
                                Email := Emp."E-Mail";
                                "Fax No." := Emp."Fax Number";
                                "Global Dimension 2 Code" := Emp."Shortcut Dimension 2 Code";

                            end;
                        end else
                            if "Patient Type" = "patient type"::" " then begin
                                benefic.Reset();
                                benefic.SetRange(benefic."Employee Code", "Depandant Principle Member");
                                if "Depandant Principle Member" = '' then Error('Please specify the Principal member number!');
                                benefic.SetRange(benefic."Entry No", "Patient Ref. No.");
                                if benefic.FindFirst() then
                                    if Emp.Get("Depandant Principle Member") then begin
                                        // Title:=Emp.Title;
                                        Surname := benefic.SurName;
                                        "Middle Name" := benefic."Other Names";
                                        //Gender:=;
                                        // Title:=FORMAT(Emp.Title);
                                        "Date Of Birth" := benefic."Date Of Birth";
                                        // "Marital Status":=;
                                        "ID Number" := benefic."ID No/Passport No";
                                        "Correspondence Address 1" := benefic.Address;
                                        "Correspondence Address 2" := Emp."Residential Address";
                                        "Correspondence Address 3" := Emp.City;
                                        "Telephone No. 1" := benefic."Office Tel No";
                                        "Telephone No. 2" := benefic."Home Tel No";
                                        Email := Emp."E-Mail";
                                        "Fax No." := Emp."Fax Number";
                                        "Global Dimension 2 Code" := Emp."Shortcut Dimension 2 Code";

                                    end;
                            end;

                Validate("Date Of Birth");
            end;
        }
        field(89; "Depandant Principle Member"; Code[50])
        {
        }
        field(90; "User ID"; Code[20])
        {
        }
        field(91; "Patient Current Location"; Option)
        {
            OptionCaption = 'New,Triage,Appointment,Observation,Doctor List,Laboratory,Radiology Room,Phamacy,Refered,Cleared,Cancelled,Theatre,Accounts,Discharged';
            OptionMembers = New,Triage,Appointment,Observation,"Doctor List",Laboratory,"Radiology Room",Phamacy,Refered,Cleared,Cancelled,Theatre,Accounts,Discharged;
        }
        field(92; "Total Billed"; Decimal)
        {
        }
        field(93; "Registration Status"; Option)
        {
            OptionCaption = 'Registration,Cleared';
            OptionMembers = Registration,Cleared;
        }
        field(94; "Triage Status"; Option)
        {
            OptionCaption = ' ,Triage,Cleared';
            OptionMembers = " ",Triage,Cleared;
        }
        field(95; "Appointment Status"; Option)
        {
            OptionCaption = ' ,Appointment,Cleared';
            OptionMembers = " ",Appointment,Cleared;
        }
        field(96; "Observation Status"; Option)
        {
            OptionCaption = ' ,Observation,Cleared';
            OptionMembers = " ",Observation,Cleared;
        }
        field(97; "Doctor Visit Status"; Option)
        {
            OptionCaption = ' ,Doctor,Cleared';
            OptionMembers = " ",Doctor,Cleared;
        }
        field(98; "Laboratory Status"; Option)
        {
            OptionCaption = ' ,Laboratory,Cleared ';
            OptionMembers = " ",Laboratory,"Cleared ";
        }
        field(99; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Radiology,Cleared';
            OptionMembers = " ",Radiology,Cleared;
        }
        field(100; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pharmacy,Cleared';
            OptionMembers = " ",Pharmacy,Cleared;
        }
        field(101; "Hospital Billing Status"; Option)
        {
            OptionCaption = 'Billing,Cleared';
            OptionMembers = Billing,Cleared;
        }
        field(102; "Insurance Name"; Text[100])
        {
        }
        field(103; "Membership No"; Code[50])
        {
        }
        field(105; "Next Appointment"; Date)
        {
        }
        field(106; "Staff No"; Code[10])
        {
        }
        field(107; "Adm No."; Code[20])
        {
        }
        field(110; Inpatient; Boolean)
        {
        }
        field(111; "Admissions Date"; Date)
        {
        }
        field(112; "Discharge Date"; Date)
        {
        }
        field(113; "Walk-in"; Boolean)
        {
        }
        field(114; "Search Name"; Text[250])
        {
        }
        field(115; "Employee No."; Code[20])
        {
        }
        field(116; Activated; Boolean)
        {
            Description = 'Activated means the patient can be seen from cashier window';
        }
        field(117; "Bill Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false),
                                                                          "Receipt Reversed" = const(false),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Invoice ID" = field("Invoice No Filter")));
            FieldClass = FlowField;
        }
        field(118; "Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          //   "Total Amount" = filter(> 0),
                                                                          Closed = const(false),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Invoice ID" = field("Invoice No Filter")));
            FieldClass = FlowField;
        }
        field(119; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(false),
                                                                  "Receipt Reversed" = const(false),
                                                                  "Visit No" = field("Active Visit No"),
                                                                  "Invoice ID" = field("Invoice No Filter")));
            FieldClass = FlowField;
        }
        field(120; "Doctor Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No."),
                                                                            Amount = filter(> 0),
                                                                            Claimed = const(false),
                                                                            "Visit No" = field("Visit No Filter")));
            FieldClass = FlowField;
        }
        field(121; "Age in Years"; Integer)
        {
        }
        field(122; "Discharged Type"; Enum DischargeTypesEnum)
        {
            Description = ' ,Normal,Transfered,Deceased';
        }
        field(123; Names; Text[100])
        {
        }
        field(124; "Special Clinics"; Code[30])
        {
            // TODO Change all implementations to this setup based approach
            TableRelation = "HMS Clinics Setup".No;
            // OptionCaption = 'Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician';
            // OptionMembers = Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician;
        }
        field(125; "Open Charges Count"; Integer)
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
        field(129; "Appointment No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(130; "File No"; Code[20])
        {
        }
        field(131; "Open Insurance Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Posted = const(false),
                                                                          Closed = const(false)));
            FieldClass = FlowField;
        }
        field(132; "Current Adm No"; Code[20])
        {
        }
        field(133; "Posted Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Total Amount" = filter(> 0),
                                                                          Posted = const(true)));
            FieldClass = FlowField;
        }
        field(134; "Active Visit No"; Code[20])
        {
            // TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
            TableRelation = if (Inpatient = filter(true)) "HMS Admission Form Header"."Admission No." where("Patient No." = field("Patient No."))
            else
            "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
        }
        field(135; "Invoice Amount1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(> 0),
                                                                  Posted = const(true),
                                                                  Closed = const(true)));
            FieldClass = FlowField;
        }
        field(136; "Receipt Amount1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(true),
                                                                  Posted = const(true),
                                                                  "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(137; "UnClaimed Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  "Doctors Amount" = filter(> 0),
                                                                  "Doctor ID" = filter(<> ''),
                                                                  Claimed = const(false)));
            FieldClass = FlowField;
        }
        field(138; "Patient Occupation"; Text[250])
        {
        }
        field(139; "Exist in Admission"; Integer)
        {
            CalcFormula = count("HMS Admission Form Header" where("Patient No." = field("Patient No."),
                                                                   Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(140; "Exist in Discharge"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Patient No." = field("Patient No."),
                                                                        Status = filter(New)));
            FieldClass = FlowField;
        }
        field(141; "Admission Date"; Date)
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission Date" where("Patient No." = field("Patient No."),
                                                                                     Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(142; "Admitting Doctor"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header".Doctor where("Patient No." = field("Patient No."),
                                                                           Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(143; "Current Ward"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header".Ward where("Patient No." = field("Patient No."),
                                                                         Status = filter(<> Discharged)));
            FieldClass = FlowField;
        }
        field(144; "Last Appointment Date"; Date)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where("Patient No." = field("Patient No."),
                                                                                         "Appointment No." = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(145; "Old File No"; Code[10])
        {
        }
        field(146; "Visit No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
        }
        field(148; Balance; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No")));
            FieldClass = FlowField;
        }
        field(149; "Dental Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('DENTAL')));
            FieldClass = FlowField;
        }
        field(150; "DOCTORS  Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('DOCTORS FEES')));
            FieldClass = FlowField;
        }
        field(151; "ICU Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ICU')));
            FieldClass = FlowField;
        }
        field(152; "INPATIENT STORE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('INPATIENT STORE')));
            FieldClass = FlowField;
        }
        field(153; "IP PHARMACY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('IP PHARMACY')));
            FieldClass = FlowField;
        }
        field(154; "LABORATORY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('LABORATORY')));
            FieldClass = FlowField;
        }
        field(155; "MATERNITY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('MATERNITY')));
            FieldClass = FlowField;
        }
        field(156; "NUTRITION Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('NUTRITION')));
            FieldClass = FlowField;
        }
        field(157; "OP CONSULTATION Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OP CONSULTATION FEES')));
            FieldClass = FlowField;
        }
        field(158; "OPTICAL Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OPTICAL')));
            FieldClass = FlowField;
        }
        field(159; "ORTHOPAEDIC Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ORTHOPAEDIC')));
            FieldClass = FlowField;
        }
        field(161; "OUTPATIENT STORE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('OUTPATIENT STORE')));
            FieldClass = FlowField;
        }
        field(162; "PHYSIOTHERAPY Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('PHYSIOTHERAPY')));
            FieldClass = FlowField;
        }
        field(163; "THEATRE Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(164; "WARD PROCEDURES Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('WARD PROCEDURES')));
            FieldClass = FlowField;
        }
        field(165; "Admissions Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('ADMISSION')));
            FieldClass = FlowField;
        }
        field(166; "Ambulance Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('AMBULANCE SERVICES')));
            FieldClass = FlowField;
        }
        field(167; "Bed Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = filter('BED CHARGES')));
            FieldClass = FlowField;
        }
        field(168; "Visit Invoice No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Patient No." = field("Patient No."),
                                                                               "Visit No" = field("Active Visit No"),
                                                                               "Invoice Number" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(169; "Physio No."; Code[20])
        {
        }
        field(170; "Admission Type"; Option)
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Medical,Surgical,ICU,Maternity';
            OptionMembers = " ",Medical,Surgical,ICU,Maternity;
        }
        field(171; "In Discharge List"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Patient No." = field("Patient No."),
                                                                        Status = filter(New)));
            FieldClass = FlowField;
        }
        field(172; "Sunflash Counter"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             Sunflash = const(true)));
            FieldClass = FlowField;
        }
        field(173; "Medicenter Counter"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             Medicentre = const(true)));
            FieldClass = FlowField;
        }
        field(174; "Sunflash Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Sunflash = const(true),
                                                                          "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(175; "MediCenter Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Medicentre = const(true),
                                                                          "Receipt Reversed" = const(false)));
            FieldClass = FlowField;
        }
        field(176; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(177; "Charges Date"; Date)
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
        field(178; "Un Posted Balance"; Decimal)
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
        field(179; "Trans Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false),
                                                                          "Receipt Reversed" = const(false),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Transaction Type" = field("Trans Type Filter")));
            FieldClass = FlowField;
        }
        field(180; "Trans Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(181; "Scheme Name"; Code[100])
        {
            // TableRelation = "Insurance Scheme Setup"."Scheme Name" where("Insurance Code" = field("Insurance No."));
        }
        field(182; "Period Appointment Count"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Patient No." = field("Patient No."),
                                                                     "Appointment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(183; "Invoice No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(184; CurrentBenefitNumber; Integer)
        {
        }
        field(185; "Bill Balance SMS"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          Closed = const(false),
                                                                          "Receipt Reversed" = const(false),
                                                                          "Visit No" = field("Active Visit No"),
                                                                          "Invoice ID" = field("Invoice No Filter"),
                                                                          "Invoice Number" = filter('')));
            FieldClass = FlowField;
        }
        field(186; Dependant; Boolean)
        {
        }
        field(187; "Patient Type2"; Option)
        {
            OptionCaption = ' ,Private,Student,Employee,Dependant,High School Student,High School Staff,Primary School Student,Primary School Staff,Roses Staff,Relative,Sun&Shield School,Defence Forces';
            OptionMembers = " ",Private,Student,Employee,Dependant,"High School Student","High School Staff","Primary School Student","Primary School Staff","Roses Staff",Relative,"Sun&Shield School","Defence Forces";
        }
        field(188; "Student No."; Code[20])
        {

        }
        field(189; "Relative No."; Code[20])
        {

        }
        field(190; "Active Appointment date"; date)
        {

        }
        field(193; "How you Knew About Us"; code[100])
        {
            TableRelation = "Marketing Strategies".Code;
        }
        field(192; "Pending Admission Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Admission Form Header" where(Status = filter(New)));
        }
        field(194; "Current Appointment date"; date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where("Appointment No." = field("Active Visit No")));
        }
        field(195; "Current Special Clinics"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Appointment Form Header"."Special Clinics" where("Appointment No." = field("Active Visit No")));
            // OptionCaption = 'Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician,MCH';
            // OptionMembers = Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician,MCH;
        }
        field(196; "Last Billing Date"; date)
        {
        }
        field(197; "Current LOU Amount"; Decimal)
        {
        }
        field(198; "Principal"; Boolean)
        {
            trigger OnValidate()
            begin
                // "Principal Member Name" := '';
                if Principal = true then
                    "Principal Member Name" := "Search Name";
            end;
        }
        field(199; "Patient Status"; Option)
        {
            OptionMembers = Alive,Dead,Transfer;
        }
        field(200; "Debtor Account"; code[20])
        {
            TableRelation = Customer."No.";
        }
        field(201; "Sub-County code"; code[30])
        {
            TableRelation = "Sub-County Setup"."Sub County Code" where("County Code" = field("Place of Birth District"));
            trigger OnValidate()
            begin
                SubCountySetUP.Reset();
                SubCountySetUP.SetRange("Sub County Code", "Sub-County code");
                if SubCountySetUP.FindFirst() then
                    "Sub-County Name" := SubCountySetUP.Name;

            end;

        }

        Field(202; "Sub-County Name"; text[100])
        {
            Editable = false;
        }
        Field(203; "County Ward"; text[100])
        {
            TableRelation = "County Wards".Code where("Sub-County" = field("Sub-County code"));
            trigger OnValidate()
            begin
                countyWards.Reset();
                countyWards.SetRange(countyWards.code, "County Ward");
                if countyWards.Find('-') then
                    "County Ward Name" := countyWards.Name;

            end;
        }
        Field(204; "County Ward Name"; text[100])
        {
            Editable = false;
        }
        field(205; "Principal Member Name"; Code[250])
        {
        }
        field(206; "No. of Insurance List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Insuarance" where("Patient No" = field("Patient No.")));
        }
        field(207; "Active Cashier"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(IDnumber; "ID Number")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Patient No.", "Search Name")
        {
        }
        fieldgroup(Brick; "Patient No.", "Search Name")
        {
        }
    }

    trigger OnDelete()
    begin
        Error('You are no allowed to Delete');
    end;

    trigger OnInsert()
    var
        UserRec: Record "User Setup";
        hmsPatients: Record "HMS Patient";
    begin
        HMSSetup.GET();
        if "ID Number" <> '' then begin
            hmsPatients.Reset();
            hmsPatients.SetRange(hmsPatients."ID Number", "ID Number");
            if hmsPatients.FindFirst() then begin
                if Dependant = false then
                    Error('That ID already Exists for Patient No: %1', hmsPatients."Patient No.");
            end;

            if "Patient No." = '' then begin
                NoSeriesMgt.TestManual(HMSSetup."Patient Nos");
                "Patient No." := NoSeriesMgt.DoGetNextNo(HMSSetup."Patient Nos", today, true, true);
            end;
            // HMSSetup.TestField();
            "File No" := NoSeriesMgt.DoGetNextNo(HMSSetup."File No", today, true, true);
            "Date Registered" := Today;
            if "User ID" = '' then
                "User ID" := Format(UserId);
            if ("Global Dimension 1 Code" = '') and (UserRec.get("User ID")) then
                "Global Dimension 1 Code" := UserRec."Branch Code";
        end;
    end;

    var
        Customer: Record Customer;
        Emp: Record "HR-Employee";
        HMSPatCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SubCountySetUP: Record "Sub-County Setup";
        countyWards: Record "County Wards";


    procedure CreateCustomerAccount()
    var
        LCustomer: Record Customer;
    begin
        if "Customer Created" = true then exit;


        LCustomer.Insert();

    end;

    procedure DuplicateCustomerExists() mCount: Integer
    var
        patient: Record "HMS Patient";
    begin
        mCount := 0;

        patient.Reset();
        patient.SetRange(patient."ID Number", "ID Number");
        if patient.Find('-') then mCount := patient.Count;

        if Dependant then mCount := 0;
    end;

    local procedure ValidInteger(control: Text) valid: Boolean
    var
        NewStrings: Text;
    begin
        if Inpatient = false then begin
            valid := true;
            if StrLen(control) = 1 then valid := false;
            NewStrings := DelChr(UpperCase(control), '=', '!@#$%^&*()_+|}{":;''?>><,./-\-~`ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            if StrLen(NewStrings) <= 1 then valid := false;
            if NewStrings = '' then valid := false;
            if valid = false then Error('Please enter the correct value to proceed');
        end;
    end;

    local procedure ValidCharacters(control: Text) valid: Boolean
    var
        NewStrings: Text;
    begin
        if Inpatient = false then begin
            valid := true;

            NewStrings := DelChr(UpperCase(control), '=', '!@#$%^&*()_+|}{":;''?>><,./-\-~`0123456789');
            if StrLen(NewStrings) <= 1 then valid := false;
            if NewStrings = '' then valid := false;

            if valid = false then Error('Please enter the correct value to proceed');
        end;
    end;

    local procedure ValidLength(control: Text; mLength: Integer) valid: Boolean
    var
        NewStrings: Text;
    begin
        if Inpatient = false then begin
            valid := true;
            if StrLen(control) < mLength then valid := false;
            if valid = false then Error('Please enter the correct number of characters to proceed');
        end;
    end;

    local procedure ApplyToPatientCharges()
    var
        Charges: Record "HMS Charges";
        HMSChargesPrices: Record "HMS Charges Prices";
    begin
        if "Patient Type" <> xRec."Patient Type" then begin
            // if GuiAllowed and CONFIRM('Do you want to change the existing patient charges from ' + FORMAT(xRec."Patient Type") + ' to ' + FORMAT("Patient Type") + ' ?', FALSE) then begin
            HMSPatCharges.RESET();
            HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", "Patient No.");
            HMSPatCharges.SETRANGE(HMSPatCharges.Posted, FALSE);
            HMSPatCharges.SETRANGE(HMSPatCharges."Visit No", "Active Visit No");
            if HMSPatCharges.FindSet() then begin
                HMSPatCharges.Validate("Transaction Type");
                HMSPatCharges.Validate(Code);
                HMSPatCharges.Modify(true);
                /* if "Patient Type" = "Patient Type"::Corporate then begin
                    TESTFIELD("Insurance No.");
                    repeat
                        HMSChargesPrices.Reset();
                        HMSChargesPrices.SetRange("Charge Code", HMSPatCharges.Code);
                        HMSChargesPrices.SetRange("Branch Code", Rec."Global Dimension 1 Code");
                        if HMSChargesPrices.FindFirst() then begin
                            HMSPatCharges."Shortcut Dimension 4 Code" := 'Corporate';
                            HMSPatCharges.Amount := HMSChargesPrices."Corporate Amount";
                            HMSPatCharges.Validate(Amount);
                        end;
                        HMSPatCharges."Insurance No" := "Insurance No.";

                        if HMSPatCharges.Amount > -1 then
                            HMSPatCharges.validate(code);

                        HMSPatCharges.MODIFY();
                    until HMSPatCharges.NEXT() = 0;
                end;
                if "Patient Type" = "Patient Type"::Cash then
                    repeat
                        HMSChargesPrices.Reset();
                        HMSChargesPrices.SetRange("Charge Code", HMSPatCharges.Code);
                        HMSChargesPrices.SetRange("Branch Code", Rec."Global Dimension 1 Code");
                        if HMSChargesPrices.FindFirst() then begin
                            HMSPatCharges."Shortcut Dimension 4 Code" := 'Cash';
                            HMSPatCharges.Amount := HMSChargesPrices."Cash Amount";
                            HMSPatCharges.Validate(Amount);
                        end;

                        HMSPatCharges."Insurance No" := '';
                        if HMSPatCharges.Amount > -1 then
                            HMSPatCharges.validate(code); 
                        HMSPatCharges.MODIFY();
                    until HMSPatCharges.NEXT() = 0; */
                // This Code Validation will get the record with XRec not the current uncomitted transaction.
                // TODO: Find a way to First commit the transaction then update charges. Use Event Triggers?

            end;
        end;
        if "Patient Type" = "Patient Type"::Cash then begin
            "Insurance No." := '';
            "Insurance Name" := '';
        end;
    end;

    procedure DuplicatePhoneExists() mCount: Integer
    var
        patient: Record "HMS Patient";
    begin
        mCount := 0;

        patient.Reset();
        patient.SetRange(patient."Telephone No. 1", "Telephone No. 1");
        if patient.Find('-') then mCount := patient.Count;
    end;

    procedure testfields()
    begin
        if Activated = TRUE THEN ERROR('The patient is active kindly close the other visit to proceed');

        if "Walk-in" = FALSE THEN BEGIN
            // TESTFIELD("ID Number");
            TESTFIELD(Surname);
            TESTFIELD("Middle Name");
            TESTFIELD(Gender);
            TESTFIELD("Date Of Birth");
            TESTFIELD("Global Dimension 1 Code");
            if "Place of Birth Village" = '' then error('Please enter the patient residents');
            if "Patient Type" = "Patient Type"::Corporate THEN begin
                TESTFIELD("Insurance No.");
                TESTFIELD("Scheme Name");
                TESTFIELD("Membership No");
            end ELSE begin
                "Insurance No." := '';
            end;
            TESTFIELD("Next of kin Relationship");
            TESTFIELD("Next Of kin Full Name");
            TESTFIELD("Next Of kin Address 1");
            // if ValidCharacters("ID Number") = FALSE THEN ERROR('Enter Correct ID Number');
            // TESTFIELD("ID Number");
        END;
    end;

    procedure isLastVisitDayWithin7days(var ItsNew: Option New,Revisit) lastVisitDay: Integer
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;
        ItsNew := ItsNew::New;

        appointments.RESET;
        appointments.SETRANGE(appointments."Patient No.", "Patient No.");
        appointments.SETCURRENTKEY("Appointment No.");
        if appointments.FIND('+') THEN BEGIN
            lastVisitDay := TODAY - appointments."Appointment Date";
            ItsNew := ItsNew::Revisit;
        END;
    end;

    procedure getFullName(): text[250]
    begin
        if "Middle Name" = '' then
            exit(Surname + ' ' + "Last Name")
        else
            exit(Surname + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}

