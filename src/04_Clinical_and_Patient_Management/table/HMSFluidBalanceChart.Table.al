Table 85191 "HMS Fluid Balance Chart"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Patient No"; Code[30])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50002; "Admission No"; Code[30])
        {
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(50003; "Fluid Balance"; Option)
        {
            OptionCaption = 'Intake,Output';
            OptionMembers = Intake,Output;

            trigger OnValidate()
            begin
                if ("Fluid Balance" = "fluid balance"::Output) then
                    "IV Intake" := false;
                Alimentary := false;
            end;
        }
        field(50004; "Intake Date"; Date)
        {
        }
        field(50005; Timings; Option)
        {
            OptionCaption = '06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,01,02,03,04,05';
            OptionMembers = "06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","01","02","03","04","05";

            trigger OnValidate()
            begin
                if ((Timings = Timings::"01") or (Timings = Timings::"02") or (Timings = Timings::"03") or (Timings = Timings::"04") or (Timings = Timings::"05") or (Timings = Timings::"06")) then
                    "Time Period" := "time period"::Night;
                if ((Timings = Timings::"07") or (Timings = Timings::"08") or (Timings = Timings::"09") or (Timings = Timings::"10") or (Timings = Timings::"11") or (Timings = Timings::"12")) then
                    "Time Period" := "time period"::Morning;
                if ((Timings = Timings::"13") or (Timings = Timings::"14") or (Timings = Timings::"15") or (Timings = Timings::"16") or (Timings = Timings::"17") or (Timings = Timings::"18")) then
                    "Time Period" := "time period"::Afternoon;
                if ((Timings = Timings::"19") or (Timings = Timings::"20") or (Timings = Timings::"21") or (Timings = Timings::"22") or (Timings = Timings::"23") or (Timings = Timings::"24")) then
                    "Time Period" := "time period"::Evening;
            end;
        }
        field(50006; "Time Period"; Option)
        {
            OptionCaption = 'Morning,Afternoon,Evening,Night';
            OptionMembers = Morning,Afternoon,Evening,Night;

            trigger OnValidate()
            begin
                if "Time Period" = "time period"::Morning then
                    "Time Period Value" := 1;
                if "Time Period" = "time period"::Afternoon then
                    "Time Period Value" := 2;
                if "Time Period" = "time period"::Evening then
                    "Time Period Value" := 3;
                if "Time Period" = "time period"::Night then
                    "Time Period Value" := 4;
            end;
        }
        field(50007; "IV Intake Type"; Text[100])
        {
        }
        field(50008; "IV Intake Amount"; Decimal)
        {
        }
        field(50009; "IV Intake"; Boolean)
        {
            trigger OnValidate()
            begin
                if ((Alimentary = true) and ("Fluid Balance" = "fluid balance"::Intake)) then
                    "IV Intake" := false;
                if (Alimentary = false) and ("Fluid Balance" = "fluid balance"::Intake) then
                    "IV Intake" := true;
            end;
        }
        field(50010; Alimentary; Boolean)
        {
            trigger OnValidate()
            begin
                if ("IV Intake" = true) and ("Fluid Balance" = "fluid balance"::Intake) then
                    Alimentary := false;
                if ("IV Intake" = false) and ("Fluid Balance" = "fluid balance"::Intake) then
                    Alimentary := true;
            end;
        }
        field(50011; Infused; Decimal)
        {
        }
        field(50012; Output; Option)
        {
            OptionCaption = ',No,Yes';
            OptionMembers = ,No,Yes;
        }
        field(50013; "Vomit Amount"; Decimal)
        {
        }
        field(50014; "Stool Amount"; Text[100])
        {
        }
        field(50015; "N\Gast Amount"; Decimal)
        {
        }
        field(50016; "Urine Amount"; Text[100])
        {
        }
        field(50017; "Others Amount"; Decimal)
        {
        }
        field(50018; Weight; Decimal)
        {
        }
        field(50019; "Time Period Value"; Integer)
        {
        }
        field(50020; "Alimentary Intake Amount"; Decimal)
        {
        }
        field(50021; "Alimentary Intake Type"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; Timings)
        {
        }
    }

    fieldgroups
    {
    }
}
