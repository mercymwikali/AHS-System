Table 52202576 "Pr Bank Branches"
{
    LookupPageID = "Pr Bank Branches";

    fields
    {
        field(1; "Bank Code"; Code[10])
        {
            TableRelation = "PR Bank Accounts"."Bank Code";
        }
        field(2; "Branch Code"; Code[20])
        {
        }
        field(3; "Bank Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("PR Bank Accounts"."Bank Name" where("Bank Code" = field("Bank Code")));
        }
        field(4; "Branch Name"; Text[100])
        {
        }
        field(5; Address; Text[200])
        {
        }
        field(6; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(7; "KBA Branch Code"; Code[20])
        {
        }
        field(8; "Current Month Filter"; Date)
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
