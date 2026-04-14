Table 85074 "Bid Analysis"
{
    fields
    {
        field(50000; "RFQ No."; Code[20])
        {
        }
        field(50001; "RFQ Line No."; Integer)
        {
        }
        field(50002; "Quote No."; Code[20])
        {
        }
        field(50003; "Vendor No."; Code[20])
        {
        }
        field(50004; "Item No."; Code[20])
        {
        }
        field(50005; Description; Text[100])
        {
        }
        field(50006; Quantity; Decimal)
        {
        }
        field(50007; "Unit Of Measure"; Code[20])
        {
        }
        field(50008; Amount; Decimal)
        {
        }
        field(50009; "Line Amount"; Decimal)
        {
        }
        field(50010; Total; Decimal)
        {
        }
        field(50011; "Last Direct Cost"; Decimal)
        {
            CalcFormula = lookup(Item."Last Direct Cost" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50012; Remarks; Text[50])
        {
            trigger OnValidate()
            begin
                PurchLine.Reset();
                PurchLine.SetRange(PurchLine."Document Type", PurchLine."document type"::Quote);
                PurchLine.SetRange(PurchLine."Document No.", "Quote No.");
                PurchLine.SetRange(PurchLine."Line No.", "RFQ Line No.");
                if PurchLine.FindSet() then begin
                    PurchLine."RFQ Remarks" := Remarks;
                    PurchLine.Modify();
                end
            end;
        }
    }

    keys
    {
        key(Key1; "RFQ No.", "RFQ Line No.", "Quote No.", "Vendor No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PurchLine: Record "Purchase Line";
}
