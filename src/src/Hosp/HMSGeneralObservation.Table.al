Table 52202726 "HMS General Observation"
{
    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Date; Date)
        {
        }
        field(4; Category; Option)
        {
            OptionCaption = ' ,Resp Rate,Delivery Mode,Temp,Blood Pressure,Alert,Urine';
            OptionMembers = " ","Resp Rate","Delivery Mode",Temp,"Blood Pressure",Alert,Urine;
        }
        field(5; "Category Value"; Text[100])
        {
        }
        field(6; Timing; Option)
        {
            OptionCaption = ' ,6am,10am,2pm,6pm,10pm,2am';
            OptionMembers = " ","6am","10am","2pm","6pm","10pm","2am";
        }
        field(7; "Admission No"; Code[20])
        {
        }
        field(8; "ICU Timings"; Option)
        {
            OptionCaption = ',08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,01,02,03,04,05,06,07';
            OptionMembers = ,"08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","01","02","03","04","05","06","07";
        }
        field(9; ICU; Boolean)
        {
        }
        field(10; "ICU Category"; Option)
        {
            OptionCaption = ',OXYG %L/M,TEMP,VENTILTN MODE,SET TV,SET P INSP,TV EXPMAND,TV EXPSPONT,MV,SET RR,PEAK PRESS,PEEP,TRIGGER SENS,PS ABOVE PEEP,GAS FLOW,E SENS %,I:E RATIO,SPO2,ET MARK,MAP,CVP,BP,HEART RATE,RESPIRATORY';
            OptionMembers = ,"OXYG %L/M",TEMP,"VENTILTN MODE","SET TV","SET P INSP","TV EXPMAND","TV EXPSPONT",MV,"SET RR","PEAK PRESS",PEEP,"TRIGGER SENS","PS ABOVE PEEP","GAS FLOW","E SENS %","I:E RATIO",SPO2,"ET MARK",MAP,CVP,BP,"HEART RATE",RESPIRATORY;
        }
        field(11; "ICU Observation Cateory"; Code[50])
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
