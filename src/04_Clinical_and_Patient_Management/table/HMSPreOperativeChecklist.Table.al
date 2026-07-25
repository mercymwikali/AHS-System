Table 85229 "HMS PreOperative Checklist"
{
    fields
    {
        field(50000; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Code"; Code[30])
        {
        }
        field(50002; Description; Text[150])
        {
        }
        field(50003; "Patient No."; Code[30])
        {
        }
        field(50004; "Patient Name"; Text[100])
        {
        }
        field(50005; "Admission No."; Code[30])
        {
        }
        field(50006; "Treatment No."; Code[30])
        {
        }
        field(50007; Operation; Text[50])
        {
        }
        field(50008; "User ID"; Text[30])
        {
        }
        field(50009; Present; Boolean)
        {
        }
        field(50010; Value; Text[50])
        {
        }
        field(50011; "Preop Type"; Option)
        {
            OptionCaption = ',Inpatient,Theatre';
            OptionMembers = ,Inpatient,Theatre;
        }
        field(50012; "User Type"; Option)
        {
            OptionCaption = ',Nurse,Doctor,Anaesthetist';
            OptionMembers = ,Nurse,Doctor,Anaesthetist;
        }
        field(50013; "Group Code"; Option)
        {
            OptionCaption = ' ,Before Induction of Anaesthesia,Before Skin incision,Before the patient leaves the OR';
            OptionMembers = " ","Before Induction of Anaesthesia","Before Skin incision","Before the patient leaves the OR";
        }
        field(50014; Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Line)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
