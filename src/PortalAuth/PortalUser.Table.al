table 52202995 "Portal User"
{
    Caption = 'Portal User';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(2; "Staff No"; Code[30])
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
        field(3; Password; Text[100])
        {
            Caption = 'Password';
        }
        field(4; Role; Code[30])
        {
            TableRelation = "Portal Roles"."Role ID";
        }
        field(5; Blocked; Boolean)
        {

        }
        field(6; "Portal OTP Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Portal OTP Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Portal OTP Device"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Portal Reset Token"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Portal Reset Token Expired"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "OTP Code Used Today"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Portal Session ID"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Portal Sessions"."Session ID" where("User ID" = field("User ID")));
        }
        field(17; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(18; "Staff Name"; Text[200])
        {

        }
        field(19; "Staff E-mail"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HR-Employee"."Company E-Mail" where("No." = field("Staff No")));
        }
        field(20; "Staff Phone No."; Text[30])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("HR-Employee"."Work Phone Number" where("No." = field("Staff No")));
        }
        field(21; "Doctor ID"; Code[30])
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
