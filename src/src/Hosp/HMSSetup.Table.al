Table 52202627 "HMS Setup"
{
    LookupPageId = "HMS Setup Card";
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Description = 'Stores the primary key in the database';
        }
        field(2; "Patient Nos"; Code[20])
        {
            Description = 'Stores the number series reference for the patient in the database';
            TableRelation = "No. Series".Code;
        }
        field(3; "Appointment Nos"; Code[20])
        {
            Description = 'Stores the reference to the number series for appointments';
            TableRelation = "No. Series".Code;
        }
        field(4; "Lab Test Request Nos"; Code[20])
        {
            Description = 'Stores the reference to the lab test request number series in the database';
            TableRelation = "No. Series".Code;
        }
        field(5; "Pharmacy Nos"; Code[20])
        {
            Description = 'Stores the reference to the pharmacy numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(6; "Admission Request Nos"; Code[20])
        {
            Description = 'Stores the admission request nos reference in the database';
            TableRelation = "No. Series".Code;
        }
        field(7; "Referral Nos"; Code[20])
        {
            Description = 'Stores the reference to the referral number series in the database';
            TableRelation = "No. Series".Code;
        }
        field(8; "Visit Nos"; Code[20])
        {
            Description = 'Stores the reference to the visitmade by the patient';
            TableRelation = "No. Series".Code;
        }
        field(9; "Observation Nos"; Code[20])
        {
            Description = 'Stores the reference to  the observation numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(10; "Radiology Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(11; "Pharmacy Item Journal Template"; Code[20])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(12; "Pharmacy Item Journal Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Pharmacy Item Journal Template"));
        }
        field(13; "Bill Students"; Boolean)
        {
        }
        field(14; "Bill Employees"; Boolean)
        {
        }
        field(15; "Bill Other Categories"; Boolean)
        {
        }
        field(16; "Limit Of Next Of Kin"; Integer)
        {
        }
        field(17; "Limit Age Of Next Of Kin(Yrs)"; Decimal)
        {
        }
        field(18; "Bill Admission Based On Days"; Boolean)
        {
        }
        field(19; "Admission G/L Account"; Code[20])
        {
        }
        field(20; "Admission Rate Amount"; Decimal)
        {
        }
        field(21; "Others Fixed Amount"; Decimal)
        {
        }
        field(22; "Others Fixed Amount Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(23; "Observation Room"; Code[20])
        {
            Description = 'Stores the store location of the observation room';
            TableRelation = Location.Code;
        }
        field(24; "Observation Item Journal Temp"; Code[20])
        {
            Description = 'Stores the observation room item journal template name';
            TableRelation = "Item Journal Template".Name;
        }
        field(25; "Observation Item Journal Batch"; Code[20])
        {
            Description = 'Stores the name of the observation room item journal batch name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Observation Item Journal Temp"));
        }
        field(26; "Doctor Room"; Code[20])
        {
            Description = 'Stores the reference to the doctor store location';
            TableRelation = Location.Code;
        }
        field(27; "Doctor Item Journal Template"; Code[20])
        {
            Description = 'Stores the name of the item journal template name in the database';
            TableRelation = "Item Journal Template".Name;
        }
        field(28; "Doctor Item Journal Batch"; Code[20])
        {
            Description = 'Stores the name of the batch name in the database';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Doctor Item Journal Template"));
        }
        field(29; "Laboratory Room"; Code[20])
        {
            Description = 'Stores the name of the laboratory room location in the database';
            TableRelation = Location.Code;
        }
        field(30; "Laboratory Item Journal Temp"; Code[20])
        {
            Description = 'Stores the reference to the laboratory item journal template name in the database';
            TableRelation = "Item Journal Template".Name;
        }
        field(31; "Laboratory Item Journal Batch"; Code[20])
        {
            Description = 'Stores the reference to the laboratory item journal batch in the database';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Laboratory Item Journal Temp"));
        }
        field(32; "Pharmacy Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(33; "Pharmacy G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(133; "Pharmacy Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(34; "Pharmacy In Patient Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(35; "Pharmacy Inpatient G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(36; "Charges Weiver Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "In Patient No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(38; "Doctors Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(39; "Cash Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(90; "Insurance Charges Price Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Charge Amount","Customer Rate";
        }
        field(91; "Insurance Items Price Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Unit Price Insurance Amount","Unit Price + Insurate Rate";
        }
        field(40; "Doctors Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(41; "Morgue No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(42; "Therapy Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(43; "Lab Results Recall Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Admission Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(45; "Patient File"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(46; "Security Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(47; "Discount Exp. Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(147; "Rebates Exp. Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(48; "Walkin Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(49; "Portal Report Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Theatre Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(51; "Physio Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(52; "Portal Reports Path"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(53; "Physio Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(54; "Day Case Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(55; "Nursing Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(56; "NHIF Capitation Cost G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(77; "Capitation Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(63; "NHIF Capitation Control G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(57; "NHIF Package Cost G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(58; "Therapy Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(59; "Charges Posting Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(159; "Doctors Posting Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(60; "Smartlink Base URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "File No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(62; "Weiver Transaction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Transactions code";
        }
        field(64; "SMS Notification Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "SMS Notification Email 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "View Therapy"; Boolean)
        {
        }
        field(67; "Appointment Booking Nos"; Code[20])
        {
            Description = 'Stores the reference to the number series for appointments';
            TableRelation = "No. Series".Code;
        }
        field(68; "Treatment Plan Nos(Therapy)"; Code[20])
        {
            Description = 'Stores the reference to the number series for treatment plan';
            TableRelation = "No. Series".Code;
        }
        field(69; "Doctor Review Request Nos."; Code[20])
        {
            Description = 'Stores the reference to the number series for doctor review request';
            TableRelation = "No. Series".Code;
        }
        field(70; "MSE Fee Code"; Code[20])
        {
            Description = 'Stores the reference of the charge code for MSE Exams';
            TableRelation = "HMS Charges".Code;
        }
        field(71; "SHIF Customer Code"; Code[20])
        {
            TableRelation = Customer."No.";
            Description = 'Stores the Default SHIF Customer Code';
        }
        field(72; "Transcription Nos"; Code[20])
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
