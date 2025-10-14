table 52202849 "Dialysis Patient Info"
{
    fields
    {
        field(1; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; TreatmentNo; Code[20])
        {
        }
        field(3; PatientNo; Code[20])
        {
        }
        field(4; "Treatment Date"; Date)
        {
        }
        field(5; "Treatment Time"; Time)
        {
        }
        field(6; Notes; Text[250])
        {
        }
        field(7; "Notes Type"; Option)
        {
            OptionCaption = ' ,DoctorsNotes,MedicalReport,history,Treatment Plan,Chief Complaints,Past Medical History,Past Surgical History,Social History,Investigations,Assessment and plan,Reviews of Systems,Impression,Visual Acuity,Past Ocular History,Treatment Done,Past Dental History,Past Family History,Doctors Advice';
            OptionMembers = " ",DoctorsNotes,MedicalReport,history,"Treatment Plan","Chief Complaints","Past Medical History","Past Surgical History","Social History",Investigations,"Assessment and plan","Reviews of Systems",Impression,"Visual Acuity","Past Ocular History","Treatment Done","Past Dental History","Past Family History","Doctors Advice";
        }
        field(8; "User ID"; Code[30])
        {
        }
        field(9; "Created Date"; Date)
        {
        }
        field(10; Clinic; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Medical,Dental,Optical';
            OptionMembers = ,Medical,Dental,Optical;
        }
        field(11; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Pre-Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "UF Set"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; BP; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Dialysis Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Access; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Fistula,Temporary Catheter,Permanent Catheter';
            OptionMembers = ,Fistula,"Temporary Catheter","Permanent Catheter";
        }
        field(17; Dialyzer; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; HR; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Dialysate; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "K+V"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Heparin LD"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Heparin MD"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Dialysis Start Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Dialysis End Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Nurse Commencing Dialysis"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Nurse Disconnecting Dialysis"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Post Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Post Dialysis Bp"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Post Dialysis HR"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Height"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Weight Gain"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Sodium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Potassium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Calcium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Bicarbonate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Conductivity"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Bolus"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Bolus Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Previous Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Cannulla"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Acid Conc"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "UF Goal"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
