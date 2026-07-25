table 85136 "Visits with Unsynced Charges"
{
    Caption = 'Visits with Unsynced Charges';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; "Visit No"; Code[30])
        {
            Caption = 'Visit No';
            trigger OnValidate()
            var
                HMSPatientCharges: Record "HMS Patient Charges";
                SalesInvoiceLine: Record "Sales Invoice Line";
                TotalMissingAmount: Decimal;
                InsuranceNoMissing: Integer;
                TotalSalesLines: Decimal;

            begin
                if "Visit No" <> '' then begin
                    TotalMissingAmount := 0;
                    InsuranceNoMissing := 0;
                    TotalSalesLines := 0;
                    "Visit Amount" := 0;

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange("Visit No", "Visit No");
                    HMSPatientCharges.SetRange(Posted, true);
                    if HMSPatientCharges.FindFirst() then begin
                        "Patient Number" := HMSPatientCharges."Patient No.";
                        HMSPatientCharges.CalcFields("Posted Invoice No.");
                        "Posted Invoice Number" := HMSPatientCharges."Posted Invoice No.";
                        "First Invoice number" := HMSPatientCharges."Invoice Number";
                        "Insurance No" := HMSPatientCharges."Insurance No";

                        SalesInvoiceLine.Reset();
                        SalesInvoiceLine.SetRange("Document No.", "First Invoice number");
                        if SalesInvoiceLine.FindSet() then
                            repeat
                                TotalSalesLines += SalesInvoiceLine."Line Amount";
                            until SalesInvoiceLine.Next() = 0;
                    end;

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange("Visit No", "Visit No");
                    HMSPatientCharges.SetRange(Posted, true);
                    HMSPatientCharges.SetRange("Invoice Number", '');
                    "No of Charges Missing" := HMSPatientCharges.Count();
                    if HMSPatientCharges.FindSet() then
                        repeat
                            if HMSPatientCharges.Code <> 'REBATES' then
                                TotalMissingAmount += HMSPatientCharges."Total Amount";
                            if HMSPatientCharges."Insurance No" = '' then
                                InsuranceNoMissing += 1;

                        until HMSPatientCharges.Next() = 0;

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange("Visit No", "Visit No");
                    if HMSPatientCharges.FindSet() then
                        repeat
                            "Visit Amount" := HMSPatientCharges."Visit Amount" + "Visit Amount";
                        until HMSPatientCharges.Next() = 0;

                    "Missing Insurance No" := InsuranceNoMissing;
                    "Missing Charges Amount" := TotalMissingAmount;
                    "Amount in Invoice" := TotalSalesLines;
                end;
            end;
        }
        field(50002; "Patient Number"; Code[30])
        {
            Caption = 'Patient Number';
            TableRelation = "HMS Patient"."Patient No.";
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Patient Charges"."Patient No." where("Visit No" = field("Visit No")));
        }
        field(50003; "Posted Invoice Number"; Code[20])
        {
            Caption = 'Posted Invoice Number';
        }
        field(50004; "Synched with sales Invoice"; Boolean)
        {
            Caption = 'Synched with sales Invoice';
        }
        field(50005; "First Invoice number"; Code[20])
        {
            // fieldclass = FlowField;
            // CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Visit No" = field("Visit No"), Posted = filter(true), "Invoice Number" = filter(<> '')));
        }
        field(50006; "No of Charges Missing"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = count("HMS Patient Charges" where("Visit No" = field("Visit No"), Posted = filter(true), "Invoice Number" = filter('')));
        }
        field(50007; "Missing Charges Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Visit No" = field("Visit No"), Posted = filter(true), "Invoice Number" = filter(''), Code = filter(<>'REBATES')));
        }
        field(50008; "Insurance No"; Code[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Patient Charges"."Insurance No" where("Visit No" = field("Visit No"), Posted = filter(true), "Invoice Number" = filter(<> '')));
        }
        field(50009; "Missing Insurance No"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = count("HMS Patient Charges" where("Visit No" = field("Visit No"), Posted = filter(true), "Insurance No" = filter('')));
        }
        field(50010; "Visit Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Visit No" = field("Visit No")));
        }
        field(50011; "Amount in Invoice"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("Sales Invoice Line"."Line Amount" where("Document No." = field("First Invoice number")));
        }
        field(50012; "For Review"; Boolean)
        {

        }
        field(50013; "Confirmed to Sync"; Boolean)
        {

        }
        field(50014; "Review Comments"; text[150])
        {

        }
        field(50015; "Settlement Type"; Code[30])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Patient Charges"."Shortcut Dimension 4 Code" where("Visit No" = field("Visit No")));
        }
    }
    keys
    {
        key(PK; "Line No", "Visit No")
        {
            Clustered = true;
        }
    }
}
