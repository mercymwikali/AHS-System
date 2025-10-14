Table 52202857 "Quotation Request Vendors"
{
    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Requisition Document No."; Code[20])
        {
        }
        field(3; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(4; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(8; "Description 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vendor Category"; Code[20])
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
