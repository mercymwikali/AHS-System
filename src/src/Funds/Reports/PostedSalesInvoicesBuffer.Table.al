table 52202990 "Posted Sales Invoices Buffer"
{
    Caption = 'Posted Sales Invoices Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Invoice No"; Integer)
        {
            Caption = 'Invoice No';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Admission Date"; Date)
        {
            Caption = 'Admission Date';
        }
        field(5; "Discharge Date"; Date)
        {
            Caption = 'Discharge Date';
        }
        field(6; "Patient Type"; Code[10])
        {
            Caption = 'Patient Type';
        }
        field(7; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(8; "Encounter No"; Code[30])
        {
            Caption = 'Encounter No';
        }
        field(9; "Insurance Name"; Code[100])
        {
            Caption = 'Insurance Name';
        }
        field(10; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
        }
        field(11; "Patient Name"; Text[250])
        {
            Caption = 'Patient Name';
        }
        field(12; "Member No"; Code[40])
        {
            Caption = 'Member No';
        }
        field(13; "Scheme Name"; Code[300])
        {
            Caption = 'Scheme Name';
        }
        field(14; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
        }
        field(15; "For Review"; Boolean)
        {

        }
        field(16; "Review Comments"; Text[150])
        {

        }
        field(17; "For Reversal"; Boolean)
        {

        }
        field(18; "Last Unique Inv No"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Posted Sales Invoices Buffer"."Line No" where("Encounter No" = field("Encounter No")));
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
