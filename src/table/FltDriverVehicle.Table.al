Table 85101 "Flt Driver Vehicle"
{
    DrillDownPageID = "Flt Driver Vehicle List";
    LookupPageID = "Flt Driver Vehicle List";

    fields
    {
        field(50000; Driver; Code[10])
        {
            TableRelation = "Flt Driver";

            trigger OnValidate()
            begin
                Drv.Reset();
                Drv.Get(Driver);
                "Driver Name" := Drv."Driver Name";
                "License Number" := Drv."Driver License Number";
                "License Expiry" := Drv."Next License Renewal";
            end;
        }
        field(50001; "Driver Name"; Text[100])
        {
        }
        field(50002; "License Number"; Code[10])
        {
        }
        field(50003; "License Expiry"; Date)
        {
        }
        field(50004; Vehicle; Code[10])
        {
            TableRelation = "FLT-Vehicle Header"."No." where(Type = const(Vehicle));

            trigger OnValidate()
            begin
                Vhcl.Reset();
                Vhcl.Get(Vehicle);
                "Vehicle Make" := Vhcl.Make;
                "Vehicle Model" := Vhcl.Model;
                "Vehicle Registration No." := Vhcl."Registration No.";
            end;
        }
        field(50005; "Vehicle Make"; Code[10])
        {
        }
        field(50006; "Vehicle Model"; Code[10])
        {
        }
        field(50007; "Vehicle Registration No."; Code[10])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(50008; "From Date"; Date)
        {
        }
        field(50009; "To Date"; Date)
        {
        }
        field(50010; "Rotation No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Rotation No", Driver)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vhcl: Record "FLT-Vehicle Header";
        Drv: Record "Flt Driver";
}
