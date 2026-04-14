Table 85129 "Receipts Disbursment"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Receipt No"; Code[20])
        {
        }
        field(50001; "Student No"; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type" = const(Student));

            trigger OnValidate()
            begin
                if Cust.Get("Student No") then
                    Names := Cust.Name;
                RecLine.Reset();
                RecLine.SetRange(No, "Receipt No");
                if RecLine.Find('-') then begin
                    Type := RecLine.Type;
                    "Cheque No" := RecLine."Cheque/Deposit Slip No";
                    Description := RecLine."Transaction Name";
                end;
            end;
        }
        field(50002; Type; Code[20])
        {
        }
        field(50003; Names; Text[100])
        {
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; Posted; Boolean)
        {
        }
        field(50006; "Posting Date"; Date)
        {
        }
        field(50007; "Posted By"; Code[20])
        {
        }
        field(50008; "Cheque No"; Code[20])
        {
        }
        field(50009; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Receipt No", "Student No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        RecLine: Record "Receipt Line q";
}
