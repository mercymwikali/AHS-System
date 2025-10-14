Table 52202482 "Invoice Dispatch Linesd"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Invoice No"; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." where(Dispatched = const(false),
                                                                "Sell-to Customer No." = field("Customer No"));

            trigger OnValidate()
            begin
                InvH.Reset();
                InvH.SetRange(InvH."No.", "Invoice No");
                if InvH.Find('-') then begin
                    InvH.CalcFields("Amount Including VAT");
                    "Patient No" := InvH."Patient No.";
                    "Original Amount" := Round(InvH."Amount Including VAT", 0, '=');
                    "Invoice Date" := InvH."Posting Date";

                    if HMSPat.Get("Patient No") then begin
                        "Patient Name" := HMSPat.Surname + ' ' + HMSPat."Last Name" + ' ' + HMSPat."Middle Name";
                        "Member No" := HMSPat."Membership No";
                    end;
                end;
            end;
        }
        field(3; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(4; "Patient Name"; Text[100])
        {
        }
        field(5; "Original Amount"; Decimal)
        {
        }
        field(6; "Invoice Date"; Date)
        {
        }
        field(7; "Curr Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Variance := "Original Amount" - "Curr Amount";
            end;
        }
        field(8; Variance; Decimal)
        {
        }
        field(9; "Member No"; Code[50])
        {
        }
        field(10; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(11; "MCC No."; Code[20])
        {
        }
        field(12; "Undertaking Amount"; Decimal)
        {
        }
        field(13; "Undertaking Variance"; Decimal)
        {
        }
        field(14; "Customer Name"; Text[200])
        {
        }
        field(15; "Select"; Boolean)
        {
        }
        field(16; "Appointment Date"; date)
        {
            FieldClass = FlowFilter;
        }
        field(17; Remarks; Text[100])
        {

        }
        field(18; "Shortcut Dimension 3 Code"; Code[20])

        {
            Caption = 'Patient Type';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('PATIENT TYPE'));
        }
    }

    keys
    {
        key(Key1; No, "Invoice No", "Customer No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HMSPat: Record "HMS Patient";
        InvH: Record "Sales Invoice Header";
}
