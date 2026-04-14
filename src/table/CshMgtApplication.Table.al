Table 85085 "CshMgt Application"
{
    fields
    {
        field(50000; "Document Type"; Option)
        {
            OptionMembers = PV,Receipt;
        }
        field(50001; "Document No."; Code[20])
        {
        }
        field(50002; "Line No."; Integer)
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; "Amount Applied"; Decimal)
        {
        }
        field(50005; "Appl. Doc. Type"; Text[30])
        {
        }
        field(50006; "Appl. Doc. No"; Code[20])
        {
        }
        field(50007; "Appl. Ext Doc. Ref"; Code[20])
        {
        }
        field(50008; "Appl. Description"; Text[100])
        {
        }
        field(50009; "Line Number"; Integer)
        {
            AutoIncrement = true;
        }
        field(50010; "Appl. Doc. Original Amount"; Decimal)
        {
        }
        field(50011; "Appl. Doc. Amount"; Decimal)
        {
        }
        field(50012; "Appl.Doc. Amount Including VAT"; Decimal)
        {
        }
        field(50013; "Appl. Doc. VAT Amount"; Decimal)
        {
        }
        field(50014; "Appl. Doc. VAT Rate"; Decimal)
        {
        }
        field(50015; "Appl. Doc. Remaining Amount"; Decimal)
        {
        }
        field(50016; "Appl. Doc. VAT Paid"; Decimal)
        {
            Description = 'this is theoretical';
        }
        field(50017; "Appl. Doc. VAT To Pay"; Decimal)
        {
            Description = 'this is far-fetched but can work';
        }
        field(50018; "Appl. Doc Date"; Date)
        {
        }
        field(50019; "VAT Base Amount"; Decimal)
        {
        }
        field(50020; "Customer No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Appl. Doc. No", "Document Type", "Appl. Doc. Type")
        {
            SumIndexFields = "Amount Applied";
        }
    }

    fieldgroups
    {
    }
}
