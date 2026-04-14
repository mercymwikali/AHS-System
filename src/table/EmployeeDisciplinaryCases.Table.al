Table 85383 "Employee Disciplinary Cases"
{
    fields
    {
        field(50000; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Refference No"; Code[20])
        {
            NotBlank = true;
        }
        field(50002; Date; Date)
        {
        }
        field(50003; "Disciplinary Case"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Disciplinary Cases".Code;
        }
        field(50004; "Recommended Action"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(50005; "Case Description"; Text[250])
        {
        }
        field(50006; "Accused Defence"; Text[250])
        {
        }
        field(50007; "Witness #1"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50008; "Witness #2"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50009; "Action Taken"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(50010; "Date Taken"; Date)
        {
        }
        field(50011; "Document Link"; Text[200])
        {
        }
        field(50012; "Disciplinary Remarks"; Code[50])
        {
            TableRelation = "Disciplinary Remarks".Remark;
        }
        field(50013; Comments; Text[250])
        {
        }
        field(50014; "Cases Discusion"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Refference No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
