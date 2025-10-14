table 52202949 "EDD Protocol Setup"
{
    Caption = 'EDD Protocol Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Psychiatry Condition"; Text[100])
        {
            Caption = 'Psychiatry Condition';
        }
        field(3; "Expected Discharge Date"; DateFormula)
        {
            Caption = 'Expected Discharge Date';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Psychiatry Condition")
        {
            Clustered = true;
        }
    }
}
