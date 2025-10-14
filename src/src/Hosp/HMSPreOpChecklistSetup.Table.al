Table 52202689 "HMS PreOp Checklist Setup"
{
    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "Preop Type"; Option)
        {
            OptionCaption = ',Inpatient,Theatre';
            OptionMembers = ,Inpatient,Theatre;
        }
        field(4; "User Type"; Option)
        {
            OptionCaption = ',Nurse,Doctor,Anaesthetist';
            OptionMembers = ,Nurse,Doctor,Anaesthetist;
        }
        field(5; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(6; "Group Code"; Option)
        {
            OptionCaption = ' ,Before Induction of Anaesthesia,Before Skin incision,Before the patient leaves the OR';
            OptionMembers = " ","Before Induction of Anaesthesia","Before Skin incision","Before the patient leaves the OR";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
