table 85003 "Daily Clinical Reports Header"
{
    Caption = 'Daily Clinical Reports Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50002; "Total Bed Occupancy"; Integer)
        {
            Caption = 'Total Bed Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where("Transaction Type" = filter('BED'), Date = field(Date))); // TODO: Add Inpatient true when adding the charge
        }
        field(50003; "Total Admissions"; Integer)
        {
            Caption = 'Total Admissions';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), Code = filter('ADMISSION FEE'), InPatient = filter(true)));
        }
        field(50004; "Total MAKL Occupancy"; Integer)
        {
            Caption = 'Total MAKL Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Insurance No" = filter('C03415'), InPatient = filter(true)));
        }
        field(50005; "Total MAKL %"; Decimal)
        {
            Caption = 'Total MAKL %';
        }
        field(50006; "Total SHA Occupancy"; Integer)
        {
            Caption = 'Total SHA Occupancy';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Insurance No" = filter('C00010'), InPatient = filter(true)));
        }
        field(50007; "Total SHA %"; Decimal)
        {
            Caption = 'Total SHA %';
        }
        field(50008; "Total Acute"; Integer)
        {
            Caption = 'Total Acute';
        }
        field(50009; "Total IP C.P"; Integer)
        {
            Caption = 'Total IP C.P';
        }
        field(50010; "Total IP C.P %"; Decimal)
        {
            Caption = 'Total IP C.P %';
        }
        field(50011; "Total OP Visits"; Integer)
        {
            Caption = 'Total OP Visits';
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field(Date), "Shortcut Dimension 3 Code" = filter('OP'), "Doctor ID" = filter(<>'')));
        }
        field(50012; "Total OP C.P"; Integer)
        {
            Caption = 'Total OP C.P';
        }
        field(50013; "Total OP C.P %"; Decimal)
        {
            Caption = 'Total OP C.P %';
        }
        field(50014; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50015; "Discharge Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50016; Remarks; Text[30])
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
