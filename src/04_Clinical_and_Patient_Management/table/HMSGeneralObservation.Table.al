Table 85193 "HMS General Observation"
{
    fields
    {
        field(50000; "Patient No"; Code[20])
        {
        }
        field(50001; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50002; Date; Date)
        {
        }
        field(50003; Category; Option)
        {
            OptionCaption = ' ,Resp Rate,Delivery Mode,Temp,Blood Pressure,Alert,Urine';
            OptionMembers = " ","Resp Rate","Delivery Mode",Temp,"Blood Pressure",Alert,Urine;
        }
        field(50004; "Category Value"; Text[100])
        {
        }
        field(50005; Timing; Option)
        {
            OptionCaption = ' ,6am,10am,2pm,6pm,10pm,2am';
            OptionMembers = " ","6am","10am","2pm","6pm","10pm","2am";
        }
        field(50006; "Admission No"; Code[20])
        {
        }
        field(50007; "ICU Timings"; Option)
        {
            OptionCaption = ',08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,01,02,03,04,05,06,07';
            OptionMembers = ,"08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","01","02","03","04","05","06","07";
        }
        field(50008; ICU; Boolean)
        {
        }
        field(50009; "ICU Category"; Option)
        {
            OptionCaption = ',OXYG %L/M,TEMP,VENTILTN MODE,SET TV,SET P INSP,TV EXPMAND,TV EXPSPONT,MV,SET RR,PEAK PRESS,PEEP,TRIGGER SENS,PS ABOVE PEEP,GAS FLOW,E SENS %,I:E RATIO,SPO2,ET MARK,MAP,CVP,BP,HEART RATE,RESPIRATORY';
            OptionMembers = ,"OXYG %L/M",TEMP,"VENTILTN MODE","SET TV","SET P INSP","TV EXPMAND","TV EXPSPONT",MV,"SET RR","PEAK PRESS",PEEP,"TRIGGER SENS","PS ABOVE PEEP","GAS FLOW","E SENS %","I:E RATIO",SPO2,"ET MARK",MAP,CVP,BP,"HEART RATE",RESPIRATORY;
        }
        field(50010; "ICU Observation Cateory"; Code[50])
        {
            TableRelation = "HMS ICU Observation Category".code;
        }
    }

    keys
    {
        key(Key1; "Patient No", "Admission No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Date := Today;
    end;
}
