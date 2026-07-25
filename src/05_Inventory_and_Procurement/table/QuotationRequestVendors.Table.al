Table 85039 "Quotation Request Vendors"
{
    fields
    {
        field(50000; "Document Type"; Option)
        {
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(50001; "Requisition Document No."; Code[20])
        {
        }
        field(50002; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50003; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50004; "Description 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Category".Code;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Requisition Document No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
