Table 52202508 "HMS Physio Evalution Form"
{
    fields
    {
        field(1; "Physio No"; Code[20])
        {
        }
        field(2; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            OptionCaption = ',Reviews of System,Investigations & Findings,Treatment';
            OptionMembers = ,"Reviews of System","Investigations & Findings",Treatment;
        }
        field(4; SubType; Option)
        {
            OptionCaption = ',Activities of Daily, Investigations,Physio Findings,Treatment Aims,Treatment Means';
            OptionMembers = ,"Activities of Daily"," Investigations","Physio Findings","Treatment Aims","Treatment Means";
        }
        field(5; Description; Text[250])
        {
        }
        field(6; "Patient No"; Code[20])
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
