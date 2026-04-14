Table 85179 "HMS Beds Transfer"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
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
        field(50001; Date; Date)
        {
        }
        field(50002; "Current Ward"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(50003; "Current Bed No"; Code[20])
        {
            TableRelation = "HMS Beds";
        }
        field(50004; "New Ward"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(50005; "New Bed No"; Code[20])
        {
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field("New Ward"));
        }
        field(50006; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50007; "Posted By"; Code[20])
        {
        }
        field(50008; "Posting Date"; Date)
        {
        }
        field(50009; Posted; Boolean)
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
