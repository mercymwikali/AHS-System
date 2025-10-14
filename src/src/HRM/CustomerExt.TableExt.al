TableExtension 52202436 "Customer Ext" extends Customer
{
    DrillDownPageId = "Customer List2";
    //Unsupported feature: Property Modification (Permissions) on "Customer(Table 18)".
    // REFACTOR: Clean This Customer Table Extension

    LookupPageID = "Customer List2";

    fields
    {
        field(50133; "In Daily Clinical Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Day IP Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field("Date Filter"), "Insurance No" = field("No."), "Transaction Type" = filter('BED')));
        }
        field(50051; "Day OP Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Appointment Form Header" where(Status = filter(AppointmentStatusEnum::Completed), "Insurance No" = field("No."), "Appointment Date" = field("Date Filter")));
        }
        field(50052; "IP Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(63000; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(63001; "Date Of Birth"; Date)
        {
        }
        field(63002; Age; Decimal)
        {
        }
        field(63003; "Marital Status"; Option)
        {
            OptionMembers = Single,Married,Divorced,Deceased;
        }
        field(63004; "Blood Group"; text[50])
        {
        }
        field(63005; Weight; Decimal)
        {
        }
        field(63006; Height; Decimal)
        {
        }
        field(63007; Religion; Code[30])
        {
            Caption = 'Religion';
            TableRelation = Religions;
        }
        field(63008; Citizenship; text[50])
        {
        }
        field(63009; "Payments By"; Code[20])
        {
            TableRelation = "Payment By".Code;
        }
        field(63011; "ID No"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."ID No", "ID No");
                if Cust.Find('-') then
                    Message('Please note that the ID Numer ' + "ID No" + ' already exists');
            end;
        }
        field(63012; "Date Registered"; Date)
        {
        }
        field(63013; "Membership No"; text[50])
        {
        }
        field(63014; "Customer Type"; Option)
        {
            OptionCaption = 'Customer,Student,Hotel';
            OptionMembers = Customer,Student,Hotel;
        }
        field(63015; "Birth Cert"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."Birth Cert", "Birth Cert");
                if Cust.Find('-') then
                    Error('Birth Cert/KNEC No. exists.');
            end;
        }
        field(63016; "Discharge Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(63019; "Name 3"; Text[50])
        {
        }
        field(63020; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,Academic Leave,Completed';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,"Academic Leave",Completed;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
            end;
        }
        field(63022; "Library Code"; Code[20])
        {
        }
        field(63024; "KNEC No"; Code[30])
        {
        }
        field(63025; "Passport No"; Code[30])
        {
        }
        field(63034; "Post to Biometric"; Boolean)
        {
            trigger OnValidate()
            begin
                "User ID" := UserId;
            end;
        }
        field(63035; "User ID"; Code[20])
        {
        }
        field(63036; "Nationality"; Code[50])
        {
        }
        field(63038; "Library Membership"; Option)
        {
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(63039; libsecurity; text[50])
        {
        }
        field(63041; "Lib Membership"; text[50])
        {
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(63042; "No Of Reversals"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Reversed = const(true)));
            FieldClass = FlowField;
        }
        field(63043; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }
        field(63047; "Staff No."; Code[20])
        {
        }
        field(63048; "Programme Category"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(63051; "Accredited Centre no."; Code[20])
        {
        }
        field(63058; "Group/Company"; Code[30])
        {
        }
        field(63059; "Departure Date"; Date)
        {
        }
        field(63060; "Arrival Date"; Date)
        {
        }
        field(63064; "Barcode No"; Code[20])
        {
        }
        field(63069; Remarks; Text[50])
        {
        }
        field(63070; "Guest Agent Code"; Code[20])
        {
        }
        field(63078; "Check Out Date"; Date)
        {
        }
        field(63079; "Check In Time"; Time)
        {
        }
        field(63080; "HTL Status"; Option)
        {
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(63081; "HELB No."; Code[50])
        {
        }
        field(63082; "Deferement Period"; DateFormula)
        {
        }
        field(63083; "Status Change Date"; Date)
        {
        }
        field(63085; Password; text[50])
        {
            Editable = true;
        }
        field(63086; "Gown 1"; Boolean)
        {
        }
        field(63087; "Gown 2"; Boolean)
        {
        }
        field(63088; "In Campus"; Boolean)
        {
        }
        field(63089; "Date Issued"; Date)
        {
        }
        field(63090; "Gown Status"; Option)
        {
            OptionCaption = ' ,Loaned,Returned';
            OptionMembers = " ",Loaned,Returned;

            trigger OnValidate()
            begin
                if "Gown Status" = "gown status"::Loaned then
                    "Date Issued" := Today;

                if "Gown Status" = "gown status"::Returned then
                    "Date Returned" := Today;
            end;
        }
        field(63091; "Date Returned"; Date)
        {
        }
        field(63092; "Certificate Status"; Option)
        {
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                if "Certificate Status" = "certificate status"::Collected then
                    "Date Collected" := Today;
            end;
        }
        field(63093; "Date Collected"; Date)
        {
        }
        field(63094; Confirmed; Boolean)
        {
        }
        field(63095; "Confirmed Remarks"; Text[50])
        {
        }
        field(63096; "Graduation Remarks"; Text[50])
        {
        }
        field(63097; "Certificate No."; text[50])
        {
        }
        field(63099; "No Of Creidts"; Integer)
        {
            CalcFormula = count("Detailed Cust. Ledg. Entry" where("Customer No." = field("No."),
                                                                    "Entry Type" = const("Initial Entry"),
                                                                    "Credit Amount (LCY)" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(63100; District; Code[20])
        {
            TableRelation = "Application Setup County".Code;

            trigger OnValidate()
            begin
                districtrec.Reset();
                Districtname := '';
                districtrec.SetRange(districtrec.Code, District);
                if districtrec.Find('-') then
                    Districtname := districtrec.Description;
            end;
        }
        field(63103; "Transfer to No."; Code[20])
        {
        }
        field(63106; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63112; "Paid PartTime"; Integer)
        {
        }
        field(63113; "Hostel Black Listed"; Boolean)
        {
        }
        field(63114; "Black Listed Reason"; Text[80])
        {
        }
        field(63115; "Black Listed By"; Code[20])
        {
        }
        field(63116; "Audit Issue"; Boolean)
        {
        }
        field(63117; "Not Billed"; Boolean)
        {
        }
        field(63118; "New Stud"; Boolean)
        {
        }
        field(63119; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(63120; sms_Password; text[50])
        {
        }
        field(63121; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63127; "Lock Online Application"; Boolean)
        {
        }
        field(63128; "PIN No"; Code[20])
        {
        }
        field(63129; "Allow Reg. With Balance"; Boolean)
        {
        }
        field(63130; "Allowed Reg. By"; Code[20])
        {
        }
        field(63131; "Allowed Date"; Date)
        {
        }
        field(63133; "Current Semester"; Code[20])
        {
        }
        field(63134; "ID Card Expiry Year"; Integer)
        {
        }
        field(63135; Tribe; Code[20])
        {
            // TableRelation = "HR Hiring Criteria"."Application Code";
        }
        field(63136; "Barcode Picture"; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(63137; "Graduation Date"; Date)
        {
        }
        field(63139; "Course Details"; Text[50])
        {
        }
        field(63140; "Sponsor Name"; Text[80])
        {
        }
        field(63141; School; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('SCHOOL'));
        }
        field(63142; "Study Mode"; Option)
        {
            OptionCaption = ' ,Full Time,Part Time,Weekend,ODL,School Based,Evening';
            OptionMembers = " ","Full Time","Part Time",Weekend,ODL,"School Based",Evening;
        }
        field(63143; "Course Duration"; Integer)
        {
        }
        field(63144; "Admission Date"; Date)
        {
        }
        field(63151; "Library Security"; Integer)
        {
        }
        field(63152; "Library Username"; Text[50])
        {
        }
        field(63154; "Library Expiry Date"; Date)
        {
        }
        field(63155; Accomodation; Code[20])
        {
        }
        field(63156; "Sponsor Address"; Text[50])
        {
        }
        field(63157; "Sponsor Town"; Text[50])
        {
        }
        field(63158; "Sponsor Phone"; text[50])
        {
        }
        field(63159; "Changed Password"; Boolean)
        {
        }
        field(63161; "Clearance Status"; Option)
        {
            OptionCaption = 'open,Active,Cleared';
            OptionMembers = open,Active,Cleared;
        }
        field(63162; "Clearance Initiated by"; Code[20])
        {
        }
        field(63163; "Clearance Initiated Date"; Date)
        {
        }
        field(63164; "Clearance Initiated Time"; Time)
        {
        }
        field(63168; "Programme End Date"; Date)
        {
        }
        field(63169; "Applied for Clearance"; Boolean)
        {
        }
        field(63170; "Clearance Reason"; Option)
        {
            OptionCaption = ' ,Graduation,Suspension,Transfer';
            OptionMembers = " ",Graduation,Suspension,Transfer;
        }
        field(63171; "Refund on PV"; Decimal)
        {
            // CalcFormula = sum ("Payment Line"."Net Amount" where("Account No." = field("No."),
            //                                                      Posted = const(False),
            //                                                      "Payment Status" = const(Approved)));
            FieldClass = FlowField;
        }
        field(63175; "Library Gender"; Code[10])
        {
        }
        field(63176; "Library Branch"; Code[20])
        {
        }
        field(39003900; "Account Type"; Option)
        {
            OptionCaption = ' ,Travel Advance,Staff Advance,Implementing Partner,Others,Donor,Salary Advance';
            OptionMembers = " ","Travel Advance","Staff Advance","Implementing Partner",Others,Donor,"Salary Advance";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Account Type"));
            end;
        }
        field(39003901; "Employee Job Group"; Code[50])
        {
            //  TableRelation = "HR-Employee"."No.";
        }
        field(39003902; "Donor Category"; Option)
        {
            OptionCaption = ' ,Intramural,Extramural';
            OptionMembers = " ",Intramural,Extramural;
        }
        field(39003903; "Allow Indirect Cost"; Boolean)
        {
        }
        field(39003904; "Dimension Set ID Filter"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            FieldClass = FlowFilter;
            TableRelation = "Dimension Set Entry";
        }
        field(39003905; "Current School"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(39003910; "Student Signature"; Blob)
        {
            SubType = Bitmap;
        }
        field(39003912; "Catering Blocked"; Boolean)
        {
        }
        field(39003913; "Year of Study Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39003914; "Mother Full Name"; text[50])
        {
            Description = 'Stores the full name of the mother in the database';
        }
        field(39003915; "Father Full Name"; text[50])
        {
            Description = 'Stores the full name of the father in the database';
        }
        field(39003916; "Guardian Full Name"; text[50])
        {
            Description = 'Stores the full name of the guardian in the database';
        }
        field(39003917; "Mother Contacts"; Code[20])
        {
        }
        field(39003918; "Father Contacts"; Code[20])
        {
        }
        field(39003919; "Gurdian Contacts"; Code[60])
        {
        }
        field(39003922; "Can Graduate"; Boolean)
        {
        }
        field(39003923; "Current Room No"; Code[20])
        {
            // CalcFormula = lookup ("Rooms Assingment"."Room No" where(Customer = field("No."),
            //                                                         Cleared = filter(No)));
            FieldClass = FlowField;
        }
        field(39003933; "Trans Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(39003957; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39003958; "Evaluation Subsection Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,ADMINISTRATION,COURSE EVALUATION,ICT ,PRESENTATION OF THE SUBJECT,LIBRARY,OVERALL EVALUATION OF THE LECTURER,TEACHING METHODS,WEBSITE';
            OptionMembers = " ",ADMINISTRATION,"COURSE EVALUATION","ICT ","PRESENTATION OF THE SUBJECT",LIBRARY,"OVERALL EVALUATION OF THE LECTURER","TEACHING METHODS",WEBSITE;
        }
        field(39003959; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39003961; "Update Delta"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39003963; "Fine Exists"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            "Document No." = filter('FINE-2019')));
            FieldClass = FlowField;
        }
        field(39003964; "Fine Pay Exist"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Description = const('FINES-Bank Deposit')));
            FieldClass = FlowField;
        }
        field(39003965; "Student Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(39003966; "Repeat Student"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39003967; "ID Count"; Integer)
        {
            CalcFormula = count(Customer where("ID No" = field("ID No"),
                                                "ID No" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(39003968; "Inv Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39003969; "Rec Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51201; "Bereavement Details"; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(51202; "Dioceses"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51203; "Congregation"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51204; "Congregation Name"; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(51205; Minet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51206; "Insurance Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51207; "Resident Consultation Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51208; "Consultants Consultation Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51209; "Co-Pay Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51210; "Co-Pay Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51211; "NHIF Capitation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51212; "NHIF Package"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51213; "Visit Ceiling"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51214; "Resident Consultation Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(51215; "Consultant Consultation Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(51216; "NHIF FFF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51217; "Pharm count"; integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" WHERE("Insurance No1" = FIELD("No."), "Pharmacy Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(51218; "Complete Pharm count"; integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" WHERE("Insurance No1" = FIELD("No."), "Pharmacy Date" = FIELD("Date Filter"), Status = FILTER(Completed)));
            FieldClass = FlowField;
        }
        field(51219; "Complete Lab count"; integer)
        {
            CalcFormula = Count("HMS Laboratory Form Header" WHERE("Insurance No" = FIELD("No."), "Laboratory Date" = FIELD("Date Filter"), "Insurance No" = FIELD("No."), Status = FILTER(Completed)));
            FieldClass = FlowField;
        }
        field(51220; "Complete Inpatient Count"; integer)
        {
            CalcFormula = Count("HMS Admission Form Header" WHERE("Insurance Code" = FIELD("No."), "Admission Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(51221; "Claimed Amount"; Decimal)
        {
        }
    }
    keys
    {
        //Unsupported feature: Deletion (KeyCollection) on "Blocked(Key)".

        //Unsupported feature: Deletion (KeyCollection) on ""Primary Contact No."(Key)".

        key(Key1; "Date Registered")
        {
        }
    }

    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        ItemLedgEntry: Record "Cust. Ledger Entry";
    begin
        //To prevent change of field
        ItemLedgEntry.SetCurrentkey(ItemLedgEntry."Customer No.");
        ItemLedgEntry.SetRange("Customer No.", "No.");
        if ItemLedgEntry.Find('-') then
            Error(Text016, CurrentFieldName);
    end;

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.get(Database.UserId) then begin
            if UserSetup."Can Create Customer" = false then
                error('Please note that you dont have the rights to create/Edit Customers');
        end else
            error('Please note that you dont have the rights to create/Edit Customers');
    end;

    var
        districtrec: Record "Application Setup County";
        Cust: Record Customer;
        //StudChangedReg: Record "Student Changed Numbers";
        Text016: label 'You cannot change the contents of the %1 field because this %2 has one or more posted ledger entries.';
        Districtname: Text[50];
}
