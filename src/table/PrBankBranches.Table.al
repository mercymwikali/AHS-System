Table 85506 "Pr Bank Branches"
{
    LookupPageID = "Pr Bank Branches";

    fields
    {
        field(50000; "Bank Code"; Code[10])
        {
            TableRelation = "PR Bank Accounts"."Bank Code";
        }
        field(50001; "Branch Code"; Code[20])
        {
        }
        field(50002; "Bank Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("PR Bank Accounts"."Bank Name" where("Bank Code" = field("Bank Code")));
        }
        field(50003; "Branch Name"; Text[100])
        {
        }
        field(50004; Address; Text[200])
        {
        }
        field(50005; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50006; "KBA Branch Code"; Code[20])
        {
        }
        field(50007; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Bank Code" )
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Branch Code","Branch Name")
        {

        }
    }
}
