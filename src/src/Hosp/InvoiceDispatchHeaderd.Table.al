Table 52202483 "Invoice Dispatch Headerd"
{
    fields
    {
        field(1; No; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Customer No") then
                    Description := Cust.Name;
            end;
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "User ID"; Code[50])
        {
        }
        field(7; "Posting Date"; Date)
        {
        }
        field(8; Posted; Boolean)
        {
        }
        field(9; "Date To"; Date)
        {
        }
        field(10; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(11; "Batch Amount"; Decimal)
        {
            CalcFormula = sum("Invoice Dispatch Linesd"."Original Amount" where(No = field(No), Select = filter(true)));
            FieldClass = FlowField;
        }
        field(12; "Invoice Counter"; Integer)
        {
            CalcFormula = count("Invoice Dispatch Linesd" where(No = field(No), Select = filter(true)));
            FieldClass = FlowField;
        }
        field(13; "Shortcut Dimension 3 Code"; Code[20])

        {
            Caption = 'Patient Type';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('PATIENT TYPE'));
        }
        field(14; Status; Enum "Approval Status")

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
        NoSeriesMgt.InitSeries(SalesSetup."Invoice Dispatch Nos", xRec."No. Series", 0D, No, "No. Series");
        if UserRec.get("User ID") then
            "Branch Code" := UserRec."Branch Code";
    end;

    var
        SalesSetup: Record "Cash Office Setup";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
