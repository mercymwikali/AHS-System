table 85031 "Portal User"
{
    Caption = 'Portal User';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(50001; "Staff No"; Code[30])
        {
            Caption = 'Staff No';
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            var
                HREmployee: Record "HR-Employee";
                PortalUser: Record "Portal User";
            begin
                PortalUser.Reset();
                PortalUser.SetRange("Staff No", "Staff No");
                if PortalUser.FindFirst() then
                    Error('Staff Portal Logins Already Exist. User ID: %1', PortalUser."User ID");

                HREmployee.Reset();
                HREmployee.SetRange("No.", "Staff No");
                if HREmployee.FindFirst() then begin
                    "Staff Name" := HREmployee."First Name" + ' ' + HREmployee."Last Name";
                    "Shortcut Dimension 1 Code" := HREmployee."Shortcut Dimension 1 Code";
                end;
            end;
        }
        field(50002; Password; Text[100])
        {
            Caption = 'Password';
        }
        field(50003; Role; Code[30])
        {
            TableRelation = "Portal Roles"."Role ID";
        }
        field(50004; Blocked; Boolean)
        {

        }
        field(50005; "Portal OTP Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Portal OTP Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Portal OTP Device"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Portal Reset Token"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Portal Reset Token Expired"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "OTP Code Used Today"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Portal Session ID"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Portal Sessions"."Session ID" where("User ID" = field("User ID")));
        }
        field(50012; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50013; "Staff Name"; Text[200])
        {

        }
        field(50014; "Staff E-mail"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HR-Employee"."Company E-Mail" where("No." = field("Staff No")));
        }
        field(50015; "Staff Phone No."; Text[30])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("HR-Employee"."Work Phone Number" where("No." = field("Staff No")));
        }
        field(50016; "Doctor ID"; Code[30])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}
