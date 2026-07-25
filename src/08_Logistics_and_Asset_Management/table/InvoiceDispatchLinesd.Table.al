Table 85309 "Invoice Dispatch Linesd"
{
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; "Invoice No"; Code[20])
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
        field(50002; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50003; "Patient Name"; Text[100])
        {
        }
        field(50004; "Original Amount"; Decimal)
        {
        }
        field(50005; "Invoice Date"; Date)
        {
        }
        field(50006; "Curr Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Variance := "Original Amount" - "Curr Amount";
            end;
        }
        field(50007; Variance; Decimal)
        {
        }
        field(50008; "Member No"; Code[50])
        {
        }
        field(50009; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50010; "MCC No."; Code[20])
        {
        }
        field(50011; "Undertaking Amount"; Decimal)
        {
        }
        field(50012; "Undertaking Variance"; Decimal)
        {
        }
        field(50013; "Customer Name"; Text[200])
        {
        }
        field(50014; "Select"; Boolean)
        {
        }
        field(50015; "Appointment Date"; date)
        {
            FieldClass = FlowFilter;
        }
        field(50016; Remarks; Text[100])
        {

        }
        field(50017; "Shortcut Dimension 3 Code"; Code[20])

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
