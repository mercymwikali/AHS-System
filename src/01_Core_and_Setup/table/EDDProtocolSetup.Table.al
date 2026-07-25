table 85299 "EDD Protocol Setup"
{
    Caption = 'EDD Protocol Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(50001; "Psychiatry Condition"; Text[100])
        {
            Caption = 'Psychiatry Condition';
        }
        field(50002; "Expected Discharge Date"; DateFormula)
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
