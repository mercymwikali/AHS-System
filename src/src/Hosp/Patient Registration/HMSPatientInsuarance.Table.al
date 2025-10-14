Table 52202478 "HMS Patient Insuarance"
{
    DrillDownPageID = "HMS Patient Insurance";
    LookupPageID = "HMS Patient Insurance";

    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; "Insurance No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Insurance No") then
                    "Insurance Name" := Cust.Name;
            end;
        }
        field(3; "Insurance Name"; Text[100])
        {
        }
        field(4; "Member No"; Code[100])
        {
        }
        field(5; "Open Invoices"; Decimal)
        {
            CalcFormula = lookup("HMS Patient Charges"."Insurance Amount" where("Patient No." = field("Patient No"),
                                                                                 Posted = const(false)));
            FieldClass = FlowField;
        }
        field(6; "Vist No"; Code[20])
        {
        }
        field(7; "Scheme Name"; Code[100])
        {
        }
        field(8; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(9; Default; Boolean)
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
