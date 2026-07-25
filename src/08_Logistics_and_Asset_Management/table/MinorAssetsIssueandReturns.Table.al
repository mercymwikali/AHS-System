Table 85109 "Minor Assets Issue and Returns"
{
    fields
    {
        field(50000; "Minor Asset No"; Code[20])
        {
            Editable = false;
            TableRelation = "Fixed Asset";
        }
        field(50001; "Issued To"; Code[20])
        {
            Editable = false;
        }
        field(50002; "Date Issued"; Date)
        {
            Editable = false;
        }
        field(50003; "Date Returned"; Date)
        {
        }
        field(50004; "Issued By"; Code[20])
        {
            Editable = false;
        }
        field(50005; "Received By"; Code[20])
        {
            Editable = false;
        }
        field(50006; "Inspection Done By"; Code[20])
        {
        }
        field(50007; Remarks; Text[250])
        {
        }
        field(50008; Description; Text[250])
        {
        }
        field(50009; "Requisition No."; Code[20])
        {
            Editable = false;
        }
        field(50010; Select; Boolean)
        {
        }
        field(50011; Returned; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Minor Asset No", "Requisition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
