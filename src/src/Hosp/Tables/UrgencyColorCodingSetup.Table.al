table 52202962 "Urgency Color Coding Setup"
{
    Caption = 'Urgency Color Coding Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        } 
        field(2; "Urgency Status"; Enum "Urgency Status Enum")
        {
            Caption = 'Urgency Status';
        }
        field(3; "Color HexCode"; Code[10])
        {
            Caption = 'Color HexCode';
        }
        field(4; StyleExpr; Code[30])
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
