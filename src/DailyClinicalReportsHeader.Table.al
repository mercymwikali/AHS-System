table 52202987 "Daily Clinical Reports Header"
{
    Caption = 'Daily Clinical Reports Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Total Bed Occupancy"; Integer)
        {
            Caption = 'Total Bed Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where("Transaction Type" = filter('BED'), Date = field(Date))); // TODO: Add Inpatient true when adding the charge
        }
        field(4; "Total Admissions"; Integer)
        {
            Caption = 'Total Admissions';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), Code = filter('ADMISSION FEE'), InPatient = filter(true)));
        }
        field(5; "Total MAKL Occupancy"; Integer)
        {
            Caption = 'Total MAKL Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Insurance No" = filter('C03415'), InPatient = filter(true)));
        }
        field(6; "Total MAKL %"; Decimal)
        {
            Caption = 'Total MAKL %';
        }
        field(7; "Total SHA Occupancy"; Integer)
        {
            Caption = 'Total SHA Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Insurance No" = filter('C00010'), InPatient = filter(true)));
        }
        field(8; "Total SHA %"; Decimal)
        {
            Caption = 'Total SHA %';
        }
        field(9; "Total Acute"; Integer)
        {
            Caption = 'Total Acute';
        }
        field(10; "Total IP C.P"; Integer)
        {
            Caption = 'Total IP C.P';
        }
        field(11; "Total IP C.P %"; Decimal)
        {
            Caption = 'Total IP C.P %';
        }
        field(12; "Total OP Visits"; Integer)
        {
            Caption = 'Total OP Visits';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Shortcut Dimension 3 Code" = filter('OP'), "Doctor ID" = filter(<>'')));
        }
        field(13; "Total OP C.P"; Integer)
        {
            Caption = 'Total OP C.P';
        }
        field(14; "Total OP C.P %"; Decimal)
        {
            Caption = 'Total OP C.P %';
        }
        field(15; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(16; "Discharge Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(17; Remarks; Text[30])
        {
            
        }
    }
    keys
    {
        key(PK; "Line No", "Date")
        {
            Clustered = true;
        }
    }
}
