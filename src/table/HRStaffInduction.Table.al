Table 85437 "HR Staff  Induction"
{
    fields
    {
        field(50000; "Induction Code"; Code[30])
        {
        }
        field(50001; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Hr.Get("Employee Code") then
                    "Employee name" := Hr."First Name" + ' ' + Hr."Middle Name" + ' ' + Hr."Last Name";
                Email := Hr."Company E-Mail";
            end;
        }
        field(50002; "Employee name"; Text[60])
        {
        }
        field(50003; From; Date)
        {
        }
        field(50004; Todate; Date)
        {
        }
        field(50005; Duration; Option)
        {
            OptionCaption = ' ,Days,Week,Months,Years';
            OptionMembers = " ",Days,Week,Months,Years;
        }
        field(50006; "Days Attended"; Decimal)
        {
        }
        field(50007; Depatment; Code[10])
        {
        }
        field(50008; "Induction Status"; Option)
        {
            OptionMembers = "Not done",Done;
        }
        field(50009; "Officer Incharge"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50010; Email; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Induction Code", "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Hr: Record "HR-Employee";
}
