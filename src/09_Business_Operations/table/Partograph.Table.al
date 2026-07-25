Table 85332 Partograph
{
    fields
    {
        field(50000; "Patient No"; Code[30])
        {
        }
        field(50001; Graph; Option)
        {
            OptionCaption = ',Fetal Heart Rate,Cervix,Contractions,Oxytocin,Drugs Given,Pulse and Bp,Temp,Urine,Head Descent,Liquor,Moulding';
            OptionMembers = ,"Fetal Heart Rate",Cervix,Contractions,Oxytocin,"Drugs Given","Pulse and Bp",Temp,Urine,"Head Descent",Liquor,Moulding;
        }
        field(50002; XValues; Time)
        {
        }
        field(50003; YValues; Code[10])
        {
        }
        field(50004; Contractions; Option)
        {
            OptionCaption = ' ,<20 seconds,20-40 Seconds,>40seconds';
            OptionMembers = " ","<20 seconds","20-40 Seconds",">40seconds";
        }
        field(50005; Drops; Integer)
        {
        }
        field(50006; "Drug Given"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No", Graph, XValues, YValues)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
