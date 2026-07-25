TableExtension 85031 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50100; Leave; Boolean)
        {
        }
        field(50101; "School Filter"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,3,3';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50102; "Post Bank Rec"; Boolean)
        {
        }
        field(50103; "Can Change Profile"; Boolean)
        {
        }
        field(50104; "Cash Advance Staff Account"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50105; "ReOpen/Release"; Option)
        {
            OptionMembers = " ",ReOpen,Release;
        }
        field(50106; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50107; "Approval Title"; Text[50])
        {
        }
        field(50108; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50109; UserName; Text[50])
        {
        }
        field(50110; Approvername; Text[30])
        {
        }
        field(50111; Approvermail; Text[30])
        {
        }
        field(50112; "Staff No"; Code[50])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = filter('IMPREST'));

            trigger OnValidate()
            begin
                if Staff.Get("Staff No") then begin
                    UserName := Staff."First Name" + ' ' + Staff."Middle Name" + ' ' + Staff."Last Name";
                    "E-Mail" := Staff."Company E-Mail";
                    "Global Dimension 1 Code" := Staff."Shortcut Dimension 2 Code";
                    "Job Tittle" := Staff."Job Title";
                end
            end;
        }
        field(50113; "Job Tittle"; Text[100])
        {
        }
        field(50114; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(50115; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50116; Lecturer; Boolean)
        {
        }
        field(50117; "Edit Posted Dimensions"; Boolean)
        {
        }
        field(50118; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(50119; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(50121; "Grants Administrator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50120; "Can Print Transcript"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50128; "Responsibility Center"; Code[10])
        {
        }
        field(50129; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50130; "Unlimited PV Amount Approval"; Boolean)
        {
        }
        field(50131; "PV Amount Approval Limit"; Decimal)
        {
        }
        field(50132; "Unlimited PettyAmount Approval"; Boolean)
        {
        }
        field(50133; "Petty C Amount Approval Limit"; Decimal)
        {
        }
        field(50134; "Unlimited Imprest Amt Approval"; Boolean)
        {
        }
        field(50135; "Imprest Amount Approval Limit"; Decimal)
        {
        }
        field(50136; "Unlimited Store RqAmt Approval"; Boolean)
        {
        }
        field(50137; "Store Req. Amt Approval Limit"; Decimal)
        {
        }
        field(50138; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50139; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'School Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50140; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50141; "Unlimited ImprestSurr Amt Appr"; Boolean)
        {
        }
        field(50142; "ImprestSurr Amt Approval Limit"; Decimal)
        {
        }
        field(50143; "Unlimited Interbank Amt Appr"; Boolean)
        {
        }
        field(50144; "Interbank Amt Approval Limit"; Decimal)
        {
        }
        field(50145; "Staff Travel Account"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50146; "Post JVs"; Boolean)
        {
        }
        field(50147; "Post Batch Receipts"; Boolean)
        {
        }
        field(50148; "Unlimited Receipt Amt Approval"; Boolean)
        {
        }
        field(50149; "Receipt Amt Approval Limit"; Decimal)
        {
        }
        field(50150; "Unlimited Claim Amt Approval"; Boolean)
        {
        }
        field(50151; "Claim Amt Approval Limit"; Decimal)
        {
        }
        field(50152; "Unlimited Advance Amt Approval"; Boolean)
        {
        }
        field(50153; "Advance Amt Approval Limit"; Decimal)
        {
        }
        field(50154; "Unlimited AdvSurr Amt Approval"; Boolean)
        {
        }
        field(50155; "AdvSurr Amt Approval Limit"; Decimal)
        {
        }
        field(50156; "Other Advance Staff Account"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50157; "Unlimited Grant Amt Approval"; Boolean)
        {
        }
        field(50158; "Grant Amt Approval Limit"; Decimal)
        {
        }
        field(50159; "Unlimited GrantSurr Approval"; Boolean)
        {
        }
        field(50160; "GrantSurr Amt Approval Limit"; Decimal)
        {
        }
        field(50161; "User Signature"; Blob)
        {
        }
        field(50162; "Post Staff Grants"; Boolean)
        {
        }
        field(50163; "ReValidate LPOs"; Boolean)
        {
            Description = 'Can ReOpen Expired LPOs';
        }
        field(50164; "Procurement Officer"; Boolean)
        {
        }
        field(50165; "Compliance/Grants"; Boolean)
        {
        }
        field(50166; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50167; test; Text[30])
        {
        }
        field(50168; "Archiving User"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50169; "Allow Transaction Reversal"; Boolean)
        {
        }
        field(50170; "Reverse Hostel Allocations"; Boolean)
        {
        }
        field(50171; "Perform Hostel Transfers"; Boolean)
        {
        }
        field(50172; "Perform Hostel Switching"; Boolean)
        {
        }
        field(50173; "Can Assign Lecturer Unit"; Boolean)
        {
        }
        field(50174; "Can Allow Exam Attendance"; Boolean)
        {
        }
        field(50175; "Can Edit Marks"; Boolean)
        {
        }
        field(50176; "Can Exempt Units"; Boolean)
        {
        }
        field(50177; "Allow Late Registration"; Boolean)
        {
        }
        field(50122; "QMS Auditor?"; Boolean)
        {
        }
        field(50123; "QMS PO?"; Boolean)
        {
        }
        field(50124; "QMS MR?"; Boolean)
        {
        }
        field(50125; "QMS VC?"; Boolean)
        {
        }
        field(50126; "QMS Admin?"; Boolean)
        {
        }
        field(50178; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50179; "Cash Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where("Bank Type" = const("Chq Collection"));
        }
        field(50180; "Petty Cash Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where("Bank Type" = const(Cash));
        }
        field(50181; "Can Create Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50182; "Can Edit Budget"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50183; "Multiple Banks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50184; "Can Post Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50185; "Selling Point"; Code[50])
        {
            DataClassification = ToBeClassified;
            //   TableRelation = "Catering Sale Points".Code;
        }
        field(50186; "Can Create Student"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50187; "Can Receipt Student"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50188; "View Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50189; "Default Transaction Type"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50190; "Default Store Location"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.code;
        }
        field(50191; "Can Delete Pharmacy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50192; "Doctor ID"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50193; "Can Edit Charges"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50194; "Can Create Items"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50195; "Can allocate Rebates"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50196; "Can Create G/L Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50197; "Can Reverse Sales Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50198; "Can Ship Items"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50199; "Can Adjust Stock"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "Can Add Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50201; "Can Delete Employee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "Can Delete Sales Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Can Edit HMS Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50204; "Can Delete Charges"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "Can Create Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Deletion (ReplicateData).

    var
        Staff: Record "HR-Employee";
}
