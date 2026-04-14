Table 85228 "HMS PreOp Checklist Setup"
{
    fields
    {
        field(50000; "Code"; Code[30])
        {
        }
        field(50001; Description; Text[150])
        {
        }
        field(50002; "Preop Type"; Option)
        {
            OptionCaption = ',Inpatient,Theatre';
            OptionMembers = ,Inpatient,Theatre;
        }
        field(50003; "User Type"; Option)
        {
            OptionCaption = ',Nurse,Doctor,Anaesthetist';
            OptionMembers = ,Nurse,Doctor,Anaesthetist;
        }
        field(50004; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50005; "Group Code"; Option)
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
