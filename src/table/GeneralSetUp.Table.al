Table 85011 "General Set-Up"
{
    fields
    {
        field(50000; "Student Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Registration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "Primary Key"; Code[10])
        {
        }
        field(50003; "Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Defered Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50005; "Transaction Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50006; "Over Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50007; "Pre-Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50008; "Allow Posting From"; Date)
        {
        }
        field(50009; "Allow Posting To"; Date)
        {
        }
        field(50010; "Unallocated Rcpts Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50011; "Batch Receipts Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50012; "Medical Condition Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50013; "Attachment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50014; "Enquiry Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50015; "Application Fee"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50016; "Clearance Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50017; "Proforma Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50018; "Base Date"; Date)
        {
        }
        field(50019; "Max Hours Continiously"; Decimal)
        {
        }
        field(50020; "Max Hours Weekly"; Decimal)
        {
        }
        field(50021; "Max Days Per Week"; Integer)
        {
        }
        field(50022; "Max Lecturer Hours Daily"; Decimal)
        {
        }
        field(50023; "Max Lecturer Days Per Week"; Decimal)
        {
        }
        field(50024; "Applications Date Line"; Date)
        {
        }
        field(50025; "Allow UnPaid Hostel Booking"; Boolean)
        {
        }
        field(50026; "Impt. Unit"; Code[20])
        {
        }
        field(50027; "Impt. Staff"; Code[20])
        {
        }
        field(50028; "Impt. Semester"; Code[20])
        {
        }
        field(50029; "Impt. Stage"; Code[20])
        {
        }
        field(50030; "Impt. RegID"; Code[20])
        {
        }
        field(50031; "Impt. Category"; Code[20])
        {
        }
        field(50032; "Impt. Programme"; Code[20])
        {
        }
        field(50033; "Pass List Label"; Text[250])
        {
        }
        field(50034; "Fail List Label"; Text[250])
        {
        }
        field(50035; "Supp List Label"; Text[250])
        {
        }
        field(50036; "Allow Units Add. in Posted Sem"; Boolean)
        {
        }
        field(50037; "Cons. Marksheet Key1"; Text[250])
        {
        }
        field(50038; "Cons. Marksheet Key2"; Text[250])
        {
        }
        field(50039; "Bill Supplimentary Fee"; Boolean)
        {
        }
        field(50040; "CDF Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50041; "Helb Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50042; lost; Integer)
        {
        }
        field(50043; "Allowed Reg. Fees Perc."; Decimal)
        {
        }
        field(50044; "Allow Online Results Access"; Boolean)
        {
        }
        field(50045; "Current TT Code"; Code[20])
        {
        }
        field(50047; "Class Allocation Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50048; "Bar Code"; Blob)
        {
            SubType = Bitmap;
        }
        field(50049; "Visitor Number"; Code[20])
        {
        }
        field(50050; "Supplimentray Fees"; Decimal)
        {
        }
        field(50051; "Admission Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50052; "Last Bio No"; Integer)
        {
        }
        field(50046; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50053; "Max Hostel Booking Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Marks Approval Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50056; "Tuition Waiver Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Programme Cap.Declaration Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Programmes Capacity Declaration Numbers';
            TableRelation = "No. Series";
        }
        field(50057; "Application Fee G/Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50058; "Portal Reports File Path"; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Portal Attachment File Path"; text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
