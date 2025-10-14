Table 52202713 "HR Jobs"
{
    fields
    {
        field(1; "Job ID"; Code[25])
        {
            NotBlank = true;
        }
        field(2; "Job Description"; Text[250])
        {
            Editable = true;
        }
        field(3; "No of Posts"; Integer)
        {
            trigger OnValidate()
            begin
                //IF "No of Posts" <> xRec."No of Posts" THEN
                "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID" where(Status = const(Approved));
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Positions"; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7; "Score code"; Code[20])
        {
        }
        field(8; "Directorate Code"; Code[20])
        {
            Caption = 'Campus Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Directorate Code");
                if Dimn.Find('-') then
                    "Directorate Name" := Dimn.Name;
            end;
        }
        field(9; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then
                    "Department Name" := Dimn.Name;
            end;
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(19; "Main Objective"; Text[250])
        {
        }
        field(21; "Key Position"; Boolean)
        {
        }
        field(22; Category; Code[20])
        {
        }
        field(23; Grade; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const(Grade));
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = count("HR Employee Requisitions" where("Job ID" = field("Job ID")));
            FieldClass = FlowField;
        }
        field(27; UserID; Code[50])
        {
        }
        field(28; "Supervisor/Manager"; Code[20])
        {
            TableRelation = "HR-Employee"."No." where(Status = const(Normal));

            trigger OnValidate()
            begin
                HREmp.Get("Supervisor/Manager");
                "Supervisor Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(29; "Supervisor Name"; Text[30])
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(32; "Date Created"; Date)
        {
        }
        field(33; "No. of Requirements"; Integer)
        {
            CalcFormula = count("HR Job Requirements" where("Job ID" = field("Job ID")));
            FieldClass = FlowField;
        }
        field(34; "No. of Responsibilities"; Integer)
        {
            CalcFormula = count("Employee Responsibility" where("Responsibility Description" = field("Job ID")));
            FieldClass = FlowField;
        }
        field(35; "Reason for Job creation"; Text[200])
        {
        }
        field(36; "Memo Ref No."; Code[100])
        {
        }
        field(37; "Memo Approval Date"; Date)
        {
        }
        field(38; "Station Code"; Code[20])
        {
            Caption = 'Section Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(0));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Station Code");
                if Dimn.Find('-') then
                    "Station Name" := Dimn.Name;
            end;
        }
        field(50000; "Station Name"; Text[100])
        {
            Caption = 'Section Name';
            Editable = false;
        }
        field(50001; "Directorate Name"; Text[100])
        {
            Caption = 'Campus Name';
            Editable = false;
        }
        field(50002; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50003; "Employment Category"; Code[20])
        {
            TableRelation = "Employee Categories".Code;
        }
        field(50004; "Employment Grade"; Code[20])
        {
            TableRelation = "Job_Salary grade/steps"."Salary Grade code" where("Employee Category" = field("Employment Category"));

            trigger OnValidate()
            begin
                Grade := "Employment Grade";
            end;
        }
        field(50005; "Occupied Positions (F)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Female)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Occupied Positions (M)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Male)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Occupied Positions FullTim (F)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Female),
                                                     "Part Time" = filter(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Occupied Positions FullTim (M)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Male),
                                                     "Part Time" = filter(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Occupied Positions PartTim (F)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Female),
                                                     "Part Time" = filter(1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Occupied Positions PartTim (M)"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Job Specification" = field("Job ID"),
                                                     Status = filter(Normal),
                                                     Gender = filter(Male),
                                                     "Part Time" = filter(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; Division; Code[20])
        {
            CalcFormula = lookup("Dimension Value".Code where(Code = field("Department Code")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50012; "Basic Salary"; Decimal)
        {
        }
        field(50013; "House Allowance"; Decimal)
        {
        }
        field(50014; "Salary Scale From"; Decimal)
        {
        }
        field(50015; "Salary Scale To"; Decimal)
        {
        }
        field(50016; "Medical Insurance Cover IN"; Decimal)
        {
        }
        field(50017; "Medical Insurance Cover OUT"; Decimal)
        {
        }
        field(50018; "Type Of Contract"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(50019; "No. Series"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
        key(Key2; "Grade")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job Description")
        {
        }
    }

    trigger OnDelete()
    begin
        /*
         CALCFIELDS("Occupied Positions");
         IF "Occupied Positions">0 THEN
         ERROR('Cannot delete job if it has occupants');
          */
    end;

    trigger OnInsert()
    var
        HumanResSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        UserID := UserID;
        "Date Created" := Today;
        HumanResSetup.get();
        if "Job ID" = '' then begin
            HumanResSetup.Get();
            HumanResSetup.TestField("Job ID");
            NoSeriesMgt.InitSeries(HumanResSetup."Job ID", xRec."No. Series", 0D, "Job ID", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        /* CALCFIELDS("Occupied Positions");
         IF "Occupied Positions">0 THEN
         ERROR('Cannot modify job if it has occupants');
        */
    end;

    procedure AssistEdit(JD: Record "HR Jobs"): Boolean
    var
        GenLedgerSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        JD := Rec;

        GenLedgerSetup.GET();
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."Job ID");

        IF NoSeriesMgt.SelectSeries(GenLedgerSetup."Job ID", JD."No. Series", JD."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(JD."Job ID");
            Rec := JD;
            EXIT(TRUE);
        END;
    end;

    var
        Dimn: Record "Dimension Value";
        HREmp: Record "HR-Employee";
}
