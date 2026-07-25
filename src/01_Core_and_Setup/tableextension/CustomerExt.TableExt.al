TableExtension 85027 "Customer Ext" extends Customer
{
    DrillDownPageId = "Customer List2";
    //Unsupported feature: Property Modification (Permissions) on "Customer(Table 18)".
    // REFACTOR: Clean This Customer Table Extension

    LookupPageID = "Customer List2";

    fields
    {
        field(50103; "In Daily Clinical Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Day IP Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field("Date Filter"), "Insurance No" = field("No."), "Transaction Type" = filter('BED')));
        }
        field(50101; "Day OP Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Appointment Form Header" where(Status = filter(AppointmentStatusEnum::Completed), "Insurance No" = field("No."), "Appointment Date" = field("Date Filter")));
        }
        field(50102; "IP Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50125; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(50126; "Date Of Birth"; Date)
        {
        }
        field(50127; Age; Decimal)
        {
        }
        field(50128; "Marital Status"; Option)
        {
            OptionMembers = Single,Married,Divorced,Deceased;
        }
        field(50129; "Blood Group"; text[50])
        {
        }
        field(50130; Weight; Decimal)
        {
        }
        field(50131; Height; Decimal)
        {
        }
        field(50132; Religion; Code[30])
        {
            Caption = 'Religion';
            TableRelation = Religions;
        }
        field(50133; Citizenship; text[50])
        {
        }
        field(50134; "Payments By"; Code[20])
        {
            TableRelation = "Payment By".Code;
        }
        field(50135; "ID No"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."ID No", "ID No");
                if Cust.Find('-') then
                    Message('Please note that the ID Numer ' + "ID No" + ' already exists');
            end;
        }
        field(50136; "Date Registered"; Date)
        {
        }
        field(50137; "Membership No"; text[50])
        {
        }
        field(50138; "Customer Type1"; Option)
        {
            OptionCaption = 'Customer,Student,Hotel';
            OptionMembers = Customer,Student,Hotel;
        }
        field(50139; "Birth Cert"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."Birth Cert", "Birth Cert");
                if Cust.Find('-') then
                    Error('Birth Cert/KNEC No. exists.');
            end;
        }
        field(50140; "Discharge Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50141; "Name 3"; Text[50])
        {
        }
        field(50142; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,Academic Leave,Completed';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expelled,Discontinued,Withdrawn,Deceased,Transferred,"Academic Leave",Completed;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
            end;
        }
        field(50143; "Library Code"; Code[20])
        {
        }
        field(50144; "KNEC No"; Code[30])
        {
        }
        field(50145; "Passport No"; Code[30])
        {
        }
        field(50146; "Post to Biometric"; Boolean)
        {
            trigger OnValidate()
            begin
                "User ID" := UserId;
            end;
        }
        field(50147; "User ID"; Code[20])
        {
        }
        field(50148; "Nationality"; Code[50])
        {
        }
        field(50149; "Library Membership"; Option)
        {
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(50150; libsecurity; text[50])
        {
        }
        field(50151; "Lib Membership"; text[50])
        {
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(50152; "No Of Reversals"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Reversed = const(true)));
            FieldClass = FlowField;
        }
        field(50153; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }
        field(50154; "Staff No."; Code[20])
        {
        }
        field(50155; "Programme Category"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50156; "Accredited Centre no."; Code[20])
        {
        }
        field(50157; "Group/Company"; Code[30])
        {
        }
        field(50158; "Departure Date"; Date)
        {
        }
        field(50159; "Arrival Date"; Date)
        {
        }
        field(50160; "Barcode No"; Code[20])
        {
        }
        field(50161; Remarks; Text[50])
        {
        }
        field(50162; "Guest Agent Code"; Code[20])
        {
        }
        field(50163; "Check Out Date"; Date)
        {
        }
        field(50164; "Check In Time"; Time)
        {
        }
        field(50165; "HTL Status"; Option)
        {
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(50166; "HELB No."; Code[50])
        {
        }
        field(50167; "Deferement Period"; DateFormula)
        {
        }
        field(50168; "Status Change Date"; Date)
        {
        }
        field(50169; Password; text[50])
        {
            Editable = true;
        }
        field(50170; "Gown 1"; Boolean)
        {
        }
        field(50171; "Gown 2"; Boolean)
        {
        }
        field(50172; "In Campus"; Boolean)
        {
        }
        field(50173; "Date Issued"; Date)
        {
        }
        field(50174; "Gown Status"; Option)
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
        field(50175; "Date Returned"; Date)
        {
        }
        field(50176; "Certificate Status"; Option)
        {
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                if "Certificate Status" = "certificate status"::Collected then
                    "Date Collected" := Today;
            end;
        }
        field(50177; "Date Collected"; Date)
        {
        }
        field(50178; Confirmed; Boolean)
        {
        }
        field(50179; "Confirmed Remarks"; Text[50])
        {
        }
        field(50180; "Graduation Remarks"; Text[50])
        {
        }
        field(50181; "Certificate No."; text[50])
        {
        }
        field(50182; "No Of Creidts"; Integer)
        {
            CalcFormula = count("Detailed Cust. Ledg. Entry" where("Customer No." = field("No."),
                                                                    "Entry Type" = const("Initial Entry"),
                                                                    "Credit Amount (LCY)" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50183; District; Code[20])
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
        field(50184; "Transfer to No."; Code[20])
        {
        }
        field(50185; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50186; "Paid PartTime"; Integer)
        {
        }
        field(50187; "Hostel Black Listed"; Boolean)
        {
        }
        field(50188; "Black Listed Reason"; Text[80])
        {
        }
        field(50189; "Black Listed By"; Code[20])
        {
        }
        field(50190; "Audit Issue"; Boolean)
        {
        }
        field(50191; "Not Billed"; Boolean)
        {
        }
        field(50192; "New Stud"; Boolean)
        {
        }
        field(50193; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(50194; sms_Password; text[50])
        {
        }
        field(50195; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50196; "Lock Online Application"; Boolean)
        {
        }
        field(50197; "PIN No"; Code[20])
        {
        }
        field(50198; "Allow Reg. With Balance"; Boolean)
        {
        }
        field(50199; "Allowed Reg. By"; Code[20])
        {
        }
        field(50200; "Allowed Date"; Date)
        {
        }
        field(50201; "Current Semester"; Code[20])
        {
        }
        field(50202; "ID Card Expiry Year"; Integer)
        {
        }
        field(50203; Tribe; Code[20])
        {
            // TableRelation = "HR Hiring Criteria"."Application Code";
        }
        field(50204; "Barcode Picture"; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50205; "Graduation Date"; Date)
        {
        }
        field(50206; "Course Details"; Text[50])
        {
        }
        field(50207; "Sponsor Name"; Text[80])
        {
        }
        field(50208; School; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('SCHOOL'));
        }
        field(50209; "Study Mode"; Option)
        {
            OptionCaption = ' ,Full Time,Part Time,Weekend,ODL,School Based,Evening';
            OptionMembers = " ","Full Time","Part Time",Weekend,ODL,"School Based",Evening;
        }
        field(50210; "Course Duration"; Integer)
        {
        }
        field(50211; "Admission Date"; Date)
        {
        }
        field(50212; "Library Security"; Integer)
        {
        }
        field(50213; "Library Username"; Text[50])
        {
        }
        field(50214; "Library Expiry Date"; Date)
        {
        }
        field(50215; Accomodation; Code[20])
        {
        }
        field(50216; "Sponsor Address"; Text[50])
        {
        }
        field(50217; "Sponsor Town"; Text[50])
        {
        }
        field(50218; "Sponsor Phone"; text[50])
        {
        }
        field(50219; "Changed Password"; Boolean)
        {
        }
        field(50220; "Clearance Status"; Option)
        {
            OptionCaption = 'open,Active,Cleared';
            OptionMembers = open,Active,Cleared;
        }
        field(50221; "Clearance Initiated by"; Code[20])
        {
        }
        field(50222; "Clearance Initiated Date"; Date)
        {
        }
        field(50223; "Clearance Initiated Time"; Time)
        {
        }
        field(50224; "Programme End Date"; Date)
        {
        }
        field(50225; "Applied for Clearance"; Boolean)
        {
        }
        field(50226; "Clearance Reason"; Option)
        {
            OptionCaption = ' ,Graduation,Suspension,Transfer';
            OptionMembers = " ",Graduation,Suspension,Transfer;
        }
        field(50227; "Refund on PV"; Decimal)
        {
            // CalcFormula = sum ("Payment Line"."Net Amount" where("Account No." = field("No."),
            //                                                      Posted = const(False),
            //                                                      "Payment Status" = const(Approved)));
            FieldClass = FlowField;
        }
        field(50228; "Library Gender"; Code[10])
        {
        }
        field(50229; "Library Branch"; Code[20])
        {
        }
        field(50230; "Account Type"; Option)
        {
            OptionCaption = ' ,Travel Advance,Staff Advance,Implementing Partner,Others,Donor,Salary Advance';
            OptionMembers = " ","Travel Advance","Staff Advance","Implementing Partner",Others,Donor,"Salary Advance";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Account Type"));
            end;
        }
        field(50231; "Employee Job Group"; Code[50])
        {
            //  TableRelation = "HR-Employee"."No.";
        }
        field(50232; "Donor Category"; Option)
        {
            OptionCaption = ' ,Intramural,Extramural';
            OptionMembers = " ",Intramural,Extramural;
        }
        field(50233; "Allow Indirect Cost"; Boolean)
        {
        }
        field(50234; "Dimension Set ID Filter"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            FieldClass = FlowFilter;
            TableRelation = "Dimension Set Entry";
        }
        field(50235; "Current School"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50236; "Student Signature"; Blob)
        {
            SubType = Bitmap;
        }
        field(50237; "Catering Blocked"; Boolean)
        {
        }
        field(50238; "Year of Study Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50239; "Mother Full Name"; text[50])
        {
            Description = 'Stores the full name of the mother in the database';
        }
        field(50240; "Father Full Name"; text[50])
        {
            Description = 'Stores the full name of the father in the database';
        }
        field(50241; "Guardian Full Name"; text[50])
        {
            Description = 'Stores the full name of the guardian in the database';
        }
        field(50242; "Mother Contacts"; Code[20])
        {
        }
        field(50243; "Father Contacts"; Code[20])
        {
        }
        field(50244; "Gurdian Contacts"; Code[60])
        {
        }
        field(50245; "Can Graduate"; Boolean)
        {
        }
        field(50246; "Current Room No"; Code[20])
        {
            // CalcFormula = lookup ("Rooms Assingment"."Room No" where(Customer = field("No."),
            //                                                         Cleared = filter(No)));
            FieldClass = FlowField;
        }
        field(50247; "Trans Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50248; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50249; "Evaluation Subsection Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,ADMINISTRATION,COURSE EVALUATION,ICT ,PRESENTATION OF THE SUBJECT,LIBRARY,OVERALL EVALUATION OF THE LECTURER,TEACHING METHODS,WEBSITE';
            OptionMembers = " ",ADMINISTRATION,"COURSE EVALUATION","ICT ","PRESENTATION OF THE SUBJECT",LIBRARY,"OVERALL EVALUATION OF THE LECTURER","TEACHING METHODS",WEBSITE;
        }
        field(50250; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50251; "Update Delta"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50252; "Fine Exists"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            "Document No." = filter('FINE-2019')));
            FieldClass = FlowField;
        }
        field(50253; "Fine Pay Exist"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Description = const('FINES-Bank Deposit')));
            FieldClass = FlowField;
        }
        field(50254; "Student Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50255; "Repeat Student"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50256; "ID Count"; Integer)
        {
            CalcFormula = count(Customer where("ID No" = field("ID No"),
                                                "ID No" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50257; "Inv Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50258; "Rec Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Bereavement Details"; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Dioceses"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Congregation"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Congregation Name"; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; Minet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Insurance Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Resident Consultation Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Consultants Consultation Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Co-Pay Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Co-Pay Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "NHIF Capitation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "NHIF Package"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Visit Ceiling"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Resident Consultation Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50118; "Consultant Consultation Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50119; "NHIF FFF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50120; "Pharm count"; integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" WHERE("Insurance No1" = FIELD("No."), "Pharmacy Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50121; "Complete Pharm count"; integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" WHERE("Insurance No1" = FIELD("No."), "Pharmacy Date" = FIELD("Date Filter"), Status = FILTER(Completed)));
            FieldClass = FlowField;
        }
        field(50122; "Complete Lab count"; integer)
        {
            CalcFormula = Count("HMS Laboratory Form Header" WHERE("Insurance No" = FIELD("No."), "Laboratory Date" = FIELD("Date Filter"), "Insurance No" = FIELD("No."), Status = FILTER(Completed)));
            FieldClass = FlowField;
        }
        field(50123; "Complete Inpatient Count"; integer)
        {
            CalcFormula = Count("HMS Admission Form Header" WHERE("Insurance Code" = FIELD("No."), "Admission Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50124; "Claimed Amount"; Decimal)
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
