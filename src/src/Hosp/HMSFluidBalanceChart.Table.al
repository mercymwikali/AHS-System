Table 52202453 "HMS Fluid Balance Chart"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Patient No"; Code[30])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(3; "Admission No"; Code[30])
        {
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(4; "Fluid Balance"; Option)
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
        field(5; "Intake Date"; Date)
        {
        }
        field(6; Timings; Option)
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
        field(7; "Time Period"; Option)
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
        field(8; "IV Intake Type"; Text[100])
        {
        }
        field(9; "IV Intake Amount"; Decimal)
        {
        }
        field(10; "IV Intake"; Boolean)
        {
            trigger OnValidate()
            begin
                if ((Alimentary = true) and ("Fluid Balance" = "fluid balance"::Intake)) then
                    "IV Intake" := false;
                if (Alimentary = false) and ("Fluid Balance" = "fluid balance"::Intake) then
                    "IV Intake" := true;
            end;
        }
        field(11; Alimentary; Boolean)
        {
            trigger OnValidate()
            begin
                if ("IV Intake" = true) and ("Fluid Balance" = "fluid balance"::Intake) then
                    Alimentary := false;
                if ("IV Intake" = false) and ("Fluid Balance" = "fluid balance"::Intake) then
                    Alimentary := true;
            end;
        }
        field(12; Infused; Decimal)
        {
        }
        field(13; Output; Option)
        {
            OptionCaption = ',No,Yes';
            OptionMembers = ,No,Yes;
        }
        field(14; "Vomit Amount"; Decimal)
        {
        }
        field(15; "Stool Amount"; Text[100])
        {
        }
        field(16; "N\Gast Amount"; Decimal)
        {
        }
        field(17; "Urine Amount"; Text[100])
        {
        }
        field(18; "Others Amount"; Decimal)
        {
        }
        field(22; Weight; Decimal)
        {
        }
        field(23; "Time Period Value"; Integer)
        {
        }
        field(24; "Alimentary Intake Amount"; Decimal)
        {
        }
        field(25; "Alimentary Intake Type"; Text[100])
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
