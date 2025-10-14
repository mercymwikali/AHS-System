Table 52202686 "HMS Beds Transfer"
{
    fields
    {
        field(1; "Admission No."; Code[20])
        {
            trigger OnValidate()
            begin
                if AdmRec.Get("Admission No.") then begin
                    "Current Ward" := AdmRec.Ward;
                    "Current Bed No" := AdmRec.Bed;
                    Date := Today;
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Current Ward"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(4; "Current Bed No"; Code[20])
        {
            TableRelation = "HMS Beds";
        }
        field(5; "New Ward"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(6; "New Bed No"; Code[20])
        {
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field("New Ward"));
        }
        field(7; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Posted By"; Code[20])
        {
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(10; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Posted, false);
    end;

    trigger OnModify()
    begin
        TestField(Posted, false);
    end;

    var
        AdmRec: Record "HMS Admission Form Header";
}
