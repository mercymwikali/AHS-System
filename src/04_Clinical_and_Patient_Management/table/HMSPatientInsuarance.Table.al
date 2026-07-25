Table 85333 "HMS Patient Insuarance"
{
    DrillDownPageID = "HMS Patient Insurance";
    LookupPageID = "HMS Patient Insurance";

    fields
    {
        field(50000; "Patient No"; Code[20])
        {
        }
        field(50001; "Insurance No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Insurance No") then
                    "Insurance Name" := Cust.Name;
            end;
        }
        field(50002; "Insurance Name"; Text[100])
        {
        }
        field(50003; "Member No"; Code[100])
        {
        }
        field(50004; "Open Invoices"; Decimal)
        {
            CalcFormula = lookup("HMS Patient Charges"."Insurance Amount" where("Patient No." = field("Patient No"),
                                                                                 Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50005; "Vist No"; Code[20])
        {
        }
        field(50006; "Scheme Name"; Code[100])
        {
        }
        field(50007; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(50008; Default; Boolean)
        {
            Caption = 'Default';
        }
    }

    keys
    {
        key(Key1; "Patient No", "Insurance No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}
