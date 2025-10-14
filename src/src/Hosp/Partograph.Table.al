Table 52202445 Partograph
{
    fields
    {
        field(1; "Patient No"; Code[30])
        {
        }
        field(2; Graph; Option)
        {
            OptionCaption = ',Fetal Heart Rate,Cervix,Contractions,Oxytocin,Drugs Given,Pulse and Bp,Temp,Urine,Head Descent,Liquor,Moulding';
            OptionMembers = ,"Fetal Heart Rate",Cervix,Contractions,Oxytocin,"Drugs Given","Pulse and Bp",Temp,Urine,"Head Descent",Liquor,Moulding;
        }
        field(3; XValues; Time)
        {
        }
        field(4; YValues; Code[10])
        {
        }
        field(5; Contractions; Option)
        {
            OptionCaption = ' ,<20 seconds,20-40 Seconds,>40seconds';
            OptionMembers = " ","<20 seconds","20-40 Seconds",">40seconds";
        }
        field(6; Drops; Integer)
        {
        }
        field(7; "Drug Given"; Text[30])
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
