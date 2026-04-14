Table 85424 "HR Medical Scheme Members"
{
    // DrillDownPageID = "Incidents Students List";
    // LookupPageID = "Incidents Students List";

    fields
    {
        field(50000; "Scheme No"; Code[10])
        {
            TableRelation = "HR Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin

                Medscheme.Reset();
                Medscheme.SetRange(Medscheme."Scheme No", "Scheme No");
                if Medscheme.Find('-') then begin
                    "Out-Patient Limit" := Medscheme."Out-patient limit";
                    "Scheme Name" := Medscheme."Scheme Name";
                    "In-patient Limit" := Medscheme."In-patient limit";
                    "Balance In- Patient" := "In-patient Limit" - "Cumm.Amount Spent";
                    "Balance Out- Patient" := "Out-Patient Limit" - "Cumm.Amount Spent Out";
                end;
            end;
        }
        field(50001; "Employee No"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange(Emp."No.", "Employee No");
                if Emp.Find('-') then begin
                    "First Name" := Emp."First Name" + ' ' + Emp."Middle Name";
                    "Last Name" := Emp."Last Name";
                    Designation := Emp."Job Title";
                    Department := Emp."Shortcut Dimension 2 Code";
                    "Scheme Join Date" := Emp."Medical Scheme Join Date";

                    //"In-patient Limit":=Medscheme."In-patient limit";
                end;
            end;
        }
        field(50002; "First Name"; Text[30])
        {
        }
        field(50003; "Last Name"; Text[30])
        {
        }
        field(50004; Designation; Text[50])
        {
        }
        field(50005; Department; Text[100])
        {
        }
        field(50006; "Scheme Join Date"; Date)
        {
        }
        field(50007; "Scheme Anniversary"; Date)
        {
        }
        field(50008; "Cumm.Amount Spent"; Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Scheme Amount Charged" where("Member No" = field("Employee No"),
                                                                                 "Claim Type" = const(Inpatient),
                                                                                 Status = const(Posted)));
            FieldClass = FlowField;
        }
        field(50009; "Out-Patient Limit"; Decimal)
        {
        }
        field(50010; "In-patient Limit"; Decimal)
        {
        }
        field(50011; "Maximum Cover"; Decimal)
        {
        }
        field(50012; "Cumm.Amount Spent Out"; Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Scheme Amount Charged" where("Member No" = field("Employee No"),
                                                                                 "Claim Type" = const(Outpatient),
                                                                                 Status = const(Posted)));
            FieldClass = FlowField;
        }
        field(50013; "Balance Out- Patient"; Decimal)
        {
        }
        field(50014; "Balance In- Patient"; Decimal)
        {
        }
        field(50015; "Maximum No of dependants"; Decimal)
        {
        }
        field(50016; "No of Depnedants"; Integer)
        {
            CalcFormula = count("HR Medical Dependants" where("Pricipal Member no" = field("Employee No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if "No of Depnedants" > "Maximum No of dependants" then
                    Error('No. of dependants cannot exceedd the required number');
            end;
        }
        field(50017; "Scheme Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Scheme No", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR-Employee";
        Medscheme: Record "HR Medical Schemes";
}
