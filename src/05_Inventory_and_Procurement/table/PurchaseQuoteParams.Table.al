Table 85038 "Purchase Quote Params"
{
    fields
    {
        field(50000; "Document Type"; Option)
        {
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(50001; "Document No."; Code[20])
        {
        }
        field(50002; Specification; Code[20])
        {
            TableRelation = "Quote Specification".Code;

            trigger OnValidate()
            begin
                Spec.Reset();
                Spec.SetRange(Spec.Code, Specification);
                if Spec.FindFirst() then
                    Description := Spec.Description;
            end;
        }
        field(50003; Description; Text[60])
        {
        }
        field(50004; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(50005; Value; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", Specification, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Spec: Record "Quote Specification";
}
