Table 85445 "KNCHR Commitee Members"
{
    fields
    {
        field(50000; "Member No."; Code[10])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.Get("Member No.");
                "Member Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                if "Member type" = "member type"::"Non-staff" then
                    Error('You cannot fill member number for a Non-Staff');
            end;
        }
        field(50001; "Member Name"; Text[100])
        {
        }
        field(50002; Role; Text[100])
        {
        }
        field(50003; "Date Appointed"; Date)
        {
        }
        field(50004; Grade; Code[20])
        {
        }
        field(50005; Active; Boolean)
        {
        }
        field(50006; Committee; Code[70])
        {
            TableRelation = "HR Committees".Code;
        }
        field(50007; "Member type"; Option)
        {
            OptionMembers = Staff,"Non-staff";
        }
    }

    keys
    {
        key(Key1; Committee, "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR-Employee";
}
