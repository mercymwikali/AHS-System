Table 52202922 "Receipts Disbursment"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Receipt No"; Code[20])
        {
        }
        field(2; "Student No"; Code[20])
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
        field(3; Type; Code[20])
        {
        }
        field(4; Names; Text[100])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Posting Date"; Date)
        {
        }
        field(8; "Posted By"; Code[20])
        {
        }
        field(9; "Cheque No"; Code[20])
        {
        }
        field(10; Description; Text[30])
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
