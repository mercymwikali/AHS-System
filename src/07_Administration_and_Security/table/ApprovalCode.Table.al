Table 85151 "Approval Code"
{
    Caption = 'Approval Code';
    // DrillDownPageID = UnknownPage657;
    // LookupPageID = UnknownPage657;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50002; "Linked To Table Name"; Text[50])
        {
            Caption = 'Linked To Table Name';
        }
        field(50003; "Linked To Table No."; Integer)
        {
            Caption = 'Linked To Table No.';
            // TableRelation = Object.ID where(Type = const('Table'));

            trigger OnValidate()
            begin
                /*
                Objects.SetRange(Type, Objects.Type::Table);
                Objects.SetRange(ID, "Linked To Table No.");
                if Objects.FindFirst then
                    "Linked To Table Name" := Objects.Name
                else
                    "Linked To Table Name" := '';
                    */
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //   Objects: Record "Object";
}
