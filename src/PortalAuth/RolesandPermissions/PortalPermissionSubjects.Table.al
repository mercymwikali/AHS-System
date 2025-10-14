table 52202998 "Portal Permission Subjects"
{
    Caption = 'Portal Permission Subjects';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; Subject; Text[30])
        {
            Caption = 'Subject';
            Editable = false;
        }
        field(3; Description; Text[30])
        {
            trigger OnValidate()
            var
                PortalRolesCU: Codeunit "Portal Roles";
            begin
                if Description <> '' then
                    Subject := PortalRolesCU.ToCamelCase(Description);
            end;
        }
    }
    keys
    {
        key(PK; "Line No", Subject)
        {
            Clustered = true;
        }
        key(Key2; Subject)
        {

        }
    }
}
