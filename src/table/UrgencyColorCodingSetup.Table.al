table 85351 "Urgency Color Coding Setup"
{
    Caption = 'Urgency Color Coding Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        } 
        field(50001; "Urgency Status"; Enum "Urgency Status Enum")
        {
            Caption = 'Urgency Status';
        }
        field(50002; "Color HexCode"; Code[10])
        {
            Caption = 'Color HexCode';
        }
        field(50003; StyleExpr; Code[30])
        {
            Caption = 'Style Expr';
        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
