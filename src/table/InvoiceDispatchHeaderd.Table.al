Table 85308 "Invoice Dispatch Headerd"
{
    fields
    {
        field(50000; No; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Customer No") then
                    Description := Cust.Name;
            end;
        }
        field(50003; Description; Text[50])
        {
        }
        field(50004; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50005; "User ID"; Code[50])
        {
        }
        field(50006; "Posting Date"; Date)
        {
        }
        field(50007; Posted; Boolean)
        {
        }
        field(50008; "Date To"; Date)
        {
        }
        field(50009; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(50010; "Batch Amount"; Decimal)
        {
            CalcFormula = sum("Invoice Dispatch Linesd"."Original Amount" where(No = field(No), Select = filter(true)));
            FieldClass = FlowField;
        }
        field(50011; "Invoice Counter"; Integer)
        {
            CalcFormula = count("Invoice Dispatch Linesd" where(No = field(No), Select = filter(true)));
            FieldClass = FlowField;
        }
        field(50012; "Shortcut Dimension 3 Code"; Code[20])

        {
            Caption = 'Patient Type';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('PATIENT TYPE'));
        }
        field(50013; Status; Enum "Approval Status")

        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        UserRec: Record "User Setup";
    begin
        if No = '' then
            SalesSetup.Get();
        NoSeriesMgt.GetNextNo(SalesSetup."Invoice Dispatch Nos");
        if UserRec.get("User ID") then
            "Branch Code" := UserRec."Branch Code";
    end;

    var
        SalesSetup: Record "Cash Office Setup";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit "No. Series";
}
