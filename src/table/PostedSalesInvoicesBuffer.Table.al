table 85135 "Posted Sales Invoices Buffer"
{
    Caption = 'Posted Sales Invoices Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; "Invoice No"; Integer)
        {
            Caption = 'Invoice No';
        }
        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50003; "Admission Date"; Date)
        {
            Caption = 'Admission Date';
        }
        field(50004; "Discharge Date"; Date)
        {
            Caption = 'Discharge Date';
        }
        field(50005; "Patient Type"; Code[10])
        {
            Caption = 'Patient Type';
        }
        field(50006; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(50007; "Encounter No"; Code[30])
        {
            Caption = 'Encounter No';
        }
        field(50008; "Insurance Name"; Code[100])
        {
            Caption = 'Insurance Name';
        }
        field(50009; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
        }
        field(50010; "Patient Name"; Text[250])
        {
            Caption = 'Patient Name';
        }
        field(50011; "Member No"; Code[40])
        {
            Caption = 'Member No';
        }
        field(50012; "Scheme Name"; Code[300])
        {
            Caption = 'Scheme Name';
        }
        field(50013; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
        }
        field(50014; "For Review"; Boolean)
        {

        }
        field(50015; "Review Comments"; Text[150])
        {

        }
        field(50016; "For Reversal"; Boolean)
        {

        }
        field(50017; "Last Unique Inv No"; Integer)
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
