Table 85430 "HR Publications"
{
    fields
    {
        field(50000; username; Code[30])
        {
        }
        field(50001; "Email Address"; Code[30])
        {
        }
        field(50002; Author; Text[100])
        {
        }
        field(50003; "Title Of Publication"; Text[200])
        {
        }
        field(50004; Publisher; Text[150])
        {
        }
        field(50005; "Year Of Publication"; Code[30])
        {
        }
        field(50006; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50007; "Field"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Number of Authors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Position of Author"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Number of Authors" <> 0) and ("Position of Author" <> 0) then
                    //Score:=16*(("Number of Authors"+1-"Position of Author")/("Number of Authors"*("Number of Authors"+1)));
                    Score := ROUND(16 * (("Number of Authors" + 1 - "Position of Author") / ("Number of Authors" * ("Number of Authors" + 1))), 0.01, '=');
            end;
        }
        field(50010; "Field of Research"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Score Per Field"; Decimal)
        {
            CalcFormula = sum("HR Publications".Score where("Email Address" = field("Email Address"),
                                                             Field = field(Field)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; username, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
