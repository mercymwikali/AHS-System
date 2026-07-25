Table 85413 "HR Employee SIC Numbers"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then
                    //"Employee First Name":= Employee."Known As";
                    "Employee Last Name" := Employee."Last Name";
            end;
        }
        field(50001; "Level 3 SIC Code"; Code[10])
        {
        }
        field(50002; "Level 4 SIC Code"; Code[10])
        {
        }
        field(50003; SubSection; Code[10])
        {
        }
        field(50004; "Section Description"; Text[250])
        {
        }
        field(50005; "Sub Section Description"; Text[250])
        {
        }
        field(50006; "Employee First Name"; Text[250])
        {
        }
        field(50007; "Employee Last Name"; Text[250])
        {
        }
        field(50008; Section; Code[10])
        {
        }
        field(50009; "Level 1 SIC Code"; Code[10])
        {
        }
        field(50010; "Level 2 SIC Code"; Code[10])
        {
        }
        field(50011; "Level 1 Description"; Text[250])
        {
        }
        field(50012; "Level 2 Description"; Text[250])
        {
        }
        field(50013; "Level 3 Description"; Text[250])
        {
        }
        field(50014; "Level4 Description"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Level 3 SIC Code", "Level 4 SIC Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        OK := Employee.Get("Employee No.");
        if OK then
            //"Employee First Name":= Employee."Known As";
            "Employee Last Name" := Employee."Last Name";
    end;

    var
        Employee: Record "HR-Employee";
        OK: Boolean;
}
