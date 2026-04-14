Table 85394 "HR Appraisal Card1"
{
    fields
    {
        field(50000; "Appraisal Code"; Code[50])
        {
        }
        field(50001; "Staff No"; Code[20])
        {
            // TableRelation = "Enquiry Header"."Enquiry No.";
            TableRelation = "Hr-employee"."No.";
        }
        field(50002; "Appraisal Type"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Type"));
        }
        field(50003; "Appraisal Period"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Period"));
        }
        field(50004; "Supervisor Comment"; Text[250])
        {
        }
        field(50005; "Appraisee Comment"; Text[250])
        {
        }
        field(50006; Recomendations; Text[250])
        {
        }
        field(50007; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Cancelled;
        }
        field(50008; Supervisor; Code[10])
        {
            TableRelation = "Hr-Employee"."No.";
        }
        field(50009; "Explored By Appraisee"; Boolean)
        {
        }
        field(50010; "Explored By Supervisor"; Boolean)
        {
        }
        field(50011; "User ID"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50012; "Resp Center"; Code[30])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50013; "Staff Name"; Text[150])
        {
        }
        field(50014; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(50015; "No Series"; Code[30])
        {
        }
        field(50016; "No of Staff Supervised"; Code[30])
        {
        }
        field(50017; "Appraiser No"; Code[30])
        {
        }
        field(50018; "Appraiser User ID"; Code[100])
        {
        }
        field(50019; "Appraiser Names"; Text[200])
        {
        }
        field(50020; "Duration Supervised"; Text[30])
        {
        }
        field(50021; "Total Weighted Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Objectives".Ratings where("Document No" = field("Appraisal Code"),
                                                                       "Appraisal Period" = field("Appraisal Period"),
                                                                       Section = const("End Year")));
            FieldClass = FlowField;
        }
        field(50022; "Total Competency Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal skills comp Score".Score where("Appraisal No" = field("Appraisal Code"),
                                                                            "Appraisal Period" = field("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50023; "Appraisal Stage"; Option)
        {
            OptionCaption = 'Q1,Q2,Q3,Q4';
            OptionMembers = Q1,Q2,Q3,Q4;
        }
        field(50024; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50025; "Target-Setting"; Boolean)
        {
        }
        field(50026; "Mid-Year"; Boolean)
        {
        }
        field(50027; "End-Year"; Boolean)
        {
        }
        field(50028; "Total Weight"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Objectives"."Max Weight" where("Document No" = field("Appraisal Code"),
                                                                            Section = const("Strategic Objectives"),
                                                                            "Appraisal Period" = field("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50029; "Quarter Two"; Boolean)
        {
        }
        field(50030; "Appraisee Total Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Objectives".Ratings where("Document No" = field("Appraisal Code"),
                                                                       "Appraisal Period" = field("Appraisal Period"),
                                                                       Section = const("End Year")));
            FieldClass = FlowField;
        }
        field(50031; "Supervisor Total Score"; Decimal)
        {
            CalcFormula = sum("HR Appraisal Objectives"."Supervisor Rating" where("Document No" = field("Appraisal Code"),
                                                                                   "Appraisal Period" = field("Appraisal Period"),
                                                                                   Section = const("End Year")));
            FieldClass = FlowField;
        }
        field(50032; "Supervisor Score Part B"; Decimal)
        {
            CalcFormula = sum("HR Appraisal skills comp Score".Score where("Appraisal No" = field("Appraisal Code"),
                                                                            "Appraisal Period" = field("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50033; Branch; Code[20])
        {
        }
        field(50034; "Supervisor Q1 Comment"; Text[250])
        {
        }
        field(50035; "Supervisor Q2 Comment"; Text[250])
        {
        }
        field(50036; "Supervisor Q3 Comment"; Text[250])
        {
        }
        field(50037; "Supervisor Q4 Comment"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Code", "Appraisal Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
