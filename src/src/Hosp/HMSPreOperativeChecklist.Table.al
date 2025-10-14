Table 52202690 "HMS PreOperative Checklist"
{
    fields
    {
        field(1; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Code"; Code[30])
        {
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Patient No."; Code[30])
        {
        }
        field(5; "Patient Name"; Text[100])
        {
        }
        field(6; "Admission No."; Code[30])
        {
        }
        field(7; "Treatment No."; Code[30])
        {
        }
        field(8; Operation; Text[50])
        {
        }
        field(9; "User ID"; Text[30])
        {
        }
        field(10; Present; Boolean)
        {
        }
        field(11; Value; Text[50])
        {
        }
        field(12; "Preop Type"; Option)
        {
            OptionCaption = ',Inpatient,Theatre';
            OptionMembers = ,Inpatient,Theatre;
        }
        field(13; "User Type"; Option)
        {
            OptionCaption = ',Nurse,Doctor,Anaesthetist';
            OptionMembers = ,Nurse,Doctor,Anaesthetist;
        }
        field(14; "Group Code"; Option)
        {
            OptionCaption = ' ,Before Induction of Anaesthesia,Before Skin incision,Before the patient leaves the OR';
            OptionMembers = " ","Before Induction of Anaesthesia","Before Skin incision","Before the patient leaves the OR";
        }
        field(15; Date; DateTime)
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
