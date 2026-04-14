Table 85221 "HMS Physio Evalution Form"
{
    fields
    {
        field(50000; "Physio No"; Code[20])
        {
        }
        field(50001; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(50002; Type; Option)
        {
            OptionCaption = ',Reviews of System,Investigations & Findings,Treatment';
            OptionMembers = ,"Reviews of System","Investigations & Findings",Treatment;
        }
        field(50003; SubType; Option)
        {
            OptionCaption = ',Activities of Daily, Investigations,Physio Findings,Treatment Aims,Treatment Means';
            OptionMembers = ,"Activities of Daily"," Investigations","Physio Findings","Treatment Aims","Treatment Means";
        }
        field(50004; Description; Text[250])
        {
        }
        field(50005; "Patient No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Physio No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
