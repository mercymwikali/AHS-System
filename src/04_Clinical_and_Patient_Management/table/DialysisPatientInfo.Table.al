table 85159 "Dialysis Patient Info"
{
    fields
    {
        field(50000; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; TreatmentNo; Code[20])
        {
        }
        field(50002; PatientNo; Code[20])
        {
        }
        field(50003; "Treatment Date"; Date)
        {
        }
        field(50004; "Treatment Time"; Time)
        {
        }
        field(50005; Notes; Text[250])
        {
        }
        field(50006; "Notes Type"; Option)
        {
            OptionCaption = ' ,DoctorsNotes,MedicalReport,history,Treatment Plan,Chief Complaints,Past Medical History,Past Surgical History,Social History,Investigations,Assessment and plan,Reviews of Systems,Impression,Visual Acuity,Past Ocular History,Treatment Done,Past Dental History,Past Family History,Doctors Advice';
            OptionMembers = " ",DoctorsNotes,MedicalReport,history,"Treatment Plan","Chief Complaints","Past Medical History","Past Surgical History","Social History",Investigations,"Assessment and plan","Reviews of Systems",Impression,"Visual Acuity","Past Ocular History","Treatment Done","Past Dental History","Past Family History","Doctors Advice";
        }
        field(50007; "User ID"; Code[30])
        {
        }
        field(50008; "Created Date"; Date)
        {
        }
        field(50009; Clinic; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Medical,Dental,Optical';
            OptionMembers = ,Medical,Dental,Optical;
        }
        field(50010; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Pre-Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "UF Set"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; BP; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Dialysis Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Access; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Fistula,Temporary Catheter,Permanent Catheter';
            OptionMembers = ,Fistula,"Temporary Catheter","Permanent Catheter";
        }
        field(50016; Dialyzer; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; HR; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; Dialysate; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "K+V"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Heparin LD"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Heparin MD"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Dialysis Start Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Dialysis End Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Nurse Commencing Dialysis"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Nurse Disconnecting Dialysis"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Post Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Post Dialysis Bp"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Post Dialysis HR"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Height"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Weight Gain"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Sodium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Potassium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Calcium"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Bicarbonate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Conductivity"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Bolus"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Bolus Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Previous Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Cannulla"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Acid Conc"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "UF Goal"; Text[30])
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
