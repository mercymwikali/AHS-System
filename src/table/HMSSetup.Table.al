Table 85240 "HMS Setup"
{
    LookupPageId = "HMS Setup Card";
    fields
    {
        field(50000; "Primary Key"; Code[20])
        {
            Description = 'Stores the primary key in the database';
        }
        field(50001; "Patient Nos"; Code[20])
        {
            Description = 'Stores the number series reference for the patient in the database';
            TableRelation = "No. Series".Code;
        }
        field(50002; "Appointment Nos"; Code[20])
        {
            Description = 'Stores the reference to the number series for appointments';
            TableRelation = "No. Series".Code;
        }
        field(50003; "Lab Test Request Nos"; Code[20])
        {
            Description = 'Stores the reference to the lab test request number series in the database';
            TableRelation = "No. Series".Code;
        }
        field(50004; "Pharmacy Nos"; Code[20])
        {
            Description = 'Stores the reference to the pharmacy numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(50005; "Admission Request Nos"; Code[20])
        {
            Description = 'Stores the admission request nos reference in the database';
            TableRelation = "No. Series".Code;
        }
        field(50006; "Referral Nos"; Code[20])
        {
            Description = 'Stores the reference to the referral number series in the database';
            TableRelation = "No. Series".Code;
        }
        field(50007; "Visit Nos"; Code[20])
        {
            Description = 'Stores the reference to the visitmade by the patient';
            TableRelation = "No. Series".Code;
        }
        field(50008; "Observation Nos"; Code[20])
        {
            Description = 'Stores the reference to  the observation numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(50009; "Radiology Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50010; "Pharmacy Item Journal Template"; Code[20])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(50011; "Pharmacy Item Journal Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Pharmacy Item Journal Template"));
        }
        field(50012; "Bill Students"; Boolean)
        {
        }
        field(50013; "Bill Employees"; Boolean)
        {
        }
        field(50014; "Bill Other Categories"; Boolean)
        {
        }
        field(50015; "Limit Of Next Of Kin"; Integer)
        {
        }
        field(50016; "Limit Age Of Next Of Kin(Yrs)"; Decimal)
        {
        }
        field(50017; "Bill Admission Based On Days"; Boolean)
        {
        }
        field(50018; "Admission G/L Account"; Code[20])
        {
        }
        field(50019; "Admission Rate Amount"; Decimal)
        {
        }
        field(50020; "Others Fixed Amount"; Decimal)
        {
        }
        field(50021; "Others Fixed Amount Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50022; "Observation Room"; Code[20])
        {
            Description = 'Stores the store location of the observation room';
            TableRelation = Location.Code;
        }
        field(50023; "Observation Item Journal Temp"; Code[20])
        {
            Description = 'Stores the observation room item journal template name';
            TableRelation = "Item Journal Template".Name;
        }
        field(50024; "Observation Item Journal Batch"; Code[20])
        {
            Description = 'Stores the name of the observation room item journal batch name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Observation Item Journal Temp"));
        }
        field(50025; "Doctor Room"; Code[20])
        {
            Description = 'Stores the reference to the doctor store location';
            TableRelation = Location.Code;
        }
        field(50026; "Doctor Item Journal Template"; Code[20])
        {
            Description = 'Stores the name of the item journal template name in the database';
            TableRelation = "Item Journal Template".Name;
        }
        field(50027; "Doctor Item Journal Batch"; Code[20])
        {
            Description = 'Stores the name of the batch name in the database';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Doctor Item Journal Template"));
        }
        field(50028; "Laboratory Room"; Code[20])
        {
            Description = 'Stores the name of the laboratory room location in the database';
            TableRelation = Location.Code;
        }
        field(50029; "Laboratory Item Journal Temp"; Code[20])
        {
            Description = 'Stores the reference to the laboratory item journal template name in the database';
            TableRelation = "Item Journal Template".Name;
        }
        field(50030; "Laboratory Item Journal Batch"; Code[20])
        {
            Description = 'Stores the reference to the laboratory item journal batch in the database';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Laboratory Item Journal Temp"));
        }
        field(50031; "Pharmacy Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50032; "Pharmacy G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50075; "Pharmacy Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50033; "Pharmacy In Patient Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50034; "Pharmacy Inpatient G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50035; "Charges Weiver Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50036; "In Patient No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50037; "Doctors Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50038; "Cash Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50073; "Insurance Charges Price Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Charge Amount","Customer Rate";
        }
        field(50074; "Insurance Items Price Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Unit Price Insurance Amount","Unit Price + Insurate Rate";
        }
        field(50039; "Doctors Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50040; "Morgue No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50041; "Therapy Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50042; "Lab Results Recall Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Admission Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50044; "Patient File"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50045; "Security Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50046; "Discount Exp. Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50076; "Rebates Exp. Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50047; "Walkin Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50048; "Portal Report Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Theatre Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50050; "Physio Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50051; "Portal Reports Path"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50052; "Physio Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50053; "Day Case Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50054; "Nursing Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50055; "NHIF Capitation Cost G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50072; "Capitation Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(50062; "NHIF Capitation Control G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50056; "NHIF Package Cost G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50057; "Therapy Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50058; "Charges Posting Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50077; "Doctors Posting Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50059; "Smartlink Base URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "File No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50061; "Weiver Transaction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Transactions code";
        }
        field(50063; "SMS Notification Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "SMS Notification Email 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "View Therapy"; Boolean)
        {
        }
        field(50066; "Appointment Booking Nos"; Code[20])
        {
            Description = 'Stores the reference to the number series for appointments';
            TableRelation = "No. Series".Code;
        }
        field(50067; "Treatment Plan Nos(Therapy)"; Code[20])
        {
            Description = 'Stores the reference to the number series for treatment plan';
            TableRelation = "No. Series".Code;
        }
        field(50068; "Doctor Review Request Nos."; Code[20])
        {
            Description = 'Stores the reference to the number series for doctor review request';
            TableRelation = "No. Series".Code;
        }
        field(50069; "MSE Fee Code"; Code[20])
        {
            Description = 'Stores the reference of the charge code for MSE Exams';
            TableRelation = "HMS Charges".Code;
        }
        field(50070; "SHIF Customer Code"; Code[20])
        {
            TableRelation = Customer."No.";
            Description = 'Stores the Default SHIF Customer Code';
        }
        field(50071; "Transcription Nos"; Code[20])
        {
            TableRelation = "No. Series";
            Description = 'This field Stores transcription numbers series';
        }
    }

    keys
    {
        key(Key1;
        "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        UserRec: Record "User Setup";
    begin

        if UserRec.get(Database.UserId) then begin
            if UserRec."Can Edit HMS Setups" = false then
                error('Please note that you dont have the rights to edit setups');
        end else
            error('Please note that you dont have the rights to edit setups');
    end;
}
