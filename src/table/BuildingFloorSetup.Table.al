table 85154 "Building Floor Setup"
{
    Caption = 'Building Floor Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Floor No."; Integer)
        {
            Caption = 'Line No';
        }
        field(50001; "Global Dimension 1 Code"; Code[30])
        {
            Caption = 'Global Dimension 1 Code';
        }
        field(50002; "Floor Name"; Code[30])
        {
            Caption = 'Floor Name';
        }
        field(50003; "Total Rooms"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula  = count("Floor Room Setup" where("Floor No" = field("Floor No.")));
        }
    }
    keys
    {
        key(PK; "Floor No.")
        {
            Clustered = true;
        }
    }
}
