Table 85396 "HR Appraisal Goal Setting L"
{
    fields
    {
        field(50000; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal indicators"."Entry No";

            trigger OnValidate()
            begin
                HRAppraisalGoalSettingH.Get("Appraisal No");
                //"Employee No":=HRAppraisalGoalSettingH."Employee No";
                HRAppraisalGoalSettingH.TestField(HRAppraisalGoalSettingH."Appraisal Year");
                "Appraisal Period" := HRAppraisalGoalSettingH."Appraisal Year";
                //"Appraisal Stage":=HRAppraisalGoalSettingH.Test1;
                "Appraisal Type" := HRAppraisalGoalSettingH."Performance Indicator";
                //Sent:=HRAppraisalGoalSettingH.Test;
            end;
        }
        field(50001; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Appraisal Period"));
        }
        field(50002; "Agreement With Rating"; Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
        }
        field(50003; "Planned Targets/Objectives"; Text[250])
        {
        }
        field(50004; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50005; "Criteria/Target Date"; Text[250])
        {
        }
        field(50006; "Target Points (Total=100)"; Decimal)
        {
        }
        field(50007; Score; Decimal)
        {
            FieldClass = Normal;
            MaxValue = 5;
            MinValue = 0;
        }
        field(50008; "Appraisal Rating"; Code[40])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Grade));
        }
        field(50009; Scored; Decimal)
        {
        }
        field(50010; "Total score"; Decimal)
        {
        }
        field(50011; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting",FirstQuarter,SecondQuarter,ThirdQuarter,EndYearEvaluation;
        }
        field(50012; Sent; Option)
        {
            OptionMembers = "At Appraisee","At Supervisor";
        }
        field(50013; "No Series"; Integer)
        {
            AutoIncrement = true;
        }
        field(50014; "Appraisal Type"; Code[50])
        {
        }
        field(50015; "Appraiser Rating"; Integer)
        {
        }
        field(50016; "Appraisee Rating"; Integer)
        {
        }
        field(50017; "Agreed Rating"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No Series", "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Appraisal No","Appraisal No");
        //IF HRAppraisalGoalSettingH.Sent=1 THEN
        //ERROR(Mcontent);
        if Sent <> Sent::"At Appraisee" then
            Error(Mcontent);
    end;

    trigger OnInsert()
    begin
        HRAppraisalGoalSettingH.Get("Appraisal No");
        // "Employee No":=HRAppraisalGoalSettingH."Employee No";
        HRAppraisalGoalSettingH.TestField(HRAppraisalGoalSettingH."Appraisal Year");
        "Appraisal Period" := HRAppraisalGoalSettingH."Appraisal Year";
        // "Appraisal Stage":=HRAppraisalGoalSettingH.Test1;
        "Appraisal Type" := HRAppraisalGoalSettingH."Performance Indicator";
        //Sent:=HRAppraisalGoalSettingH.Test;

        //HRAppraisalGoalSettingH.RESET;
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Entry No","Appraisal No");
        if HRAppraisalGoalSettingH.Find('-') then
            //IF HRAppraisalGoalSettingH.Test<>HRAppraisalGoalSettingH.Test::"0" THEN
            Error(Mcontent2);
    end;

    trigger OnModify()
    begin
        //IF Sent<> Sent::Appraisee THEN
        //ERROR(Mcontent);

        HRAppraisalGoalSettingH.Reset();
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Entry No","Appraisal No");
        if HRAppraisalGoalSettingH.Find('-') then
            //IF HRAppraisalGoalSettingH.Test<>HRAppraisalGoalSettingH.Test::"0" THEN
            Error(Mcontent);
    end;

    var
        HRAppraisalGoalSettingH: Record "HR Appraisal indicators";
        Mcontent: label 'The Objective cannot be modified while being reviewed by the Supervisor';
        Mcontent2: label 'You cannot insert a new target when the appraisal is being reviewed by the supervisor';
}
