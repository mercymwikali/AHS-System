table 85347 "Insurance Receipts Payments"
{
    Caption = 'Insurance Receipts Payments';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Customer No"; Code[20])
        {
            Caption = 'Customer No';
            TableRelation = Customer;
        }
        field(50001; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No';
            // TableRelation = "Sales Invoice Header";
            // TestTableRelation= false;
            trigger OnValidate()
            var
                CustLed: Record "Cust. Ledger Entry";
            begin
                if SalesH.Get("Invoice No") then begin
                    SalesH.CalcFields(Amount);
                    "Invoice Amount" := SalesH.Amount;
                    "Patient No" := SalesH."Patient No.";
                    Validate("Patient No");
                end else begin
                    CustLed.Reset();
                    CustLed.SetRange("Customer No.", "Customer No");
                    CustLed.SetRange("Document No.", "Invoice No");
                    CustLed.SetRange(CustLed."Document Type", CustLed."Document Type"::Invoice);
                    if CustLed.Find('-') then
                        "Invoice Amount" := CustLed.Amount;
                end;
            end;
        }
        field(50002; "Member No"; Code[20])
        {
            Caption = 'Member No';
        }
        field(50003; "Patient No"; Code[20])
        {
            Caption = 'Patient No';
            //TableRelation = "HMS Patient";
            trigger OnValidate()
            begin
                if HmsPat.get("Patient No") then
                    "Patient Name" := HMSPat."Search Name";
            end;
        }
        field(50004; "Patient Name"; Text[200])
        {
            Caption = 'Patient Name';
        }
        field(50005; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
        }
        field(50006; "Amount Payed"; Decimal)
        {
            Caption = 'Amount Payed';
        }
        field(50007; Applied; Boolean)
        {
            Caption = 'Applied';
        }
        field(50008; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(50009; "Created By"; Code[20])
        {
            Caption = 'Created By';
            TableRelation = "User Setup";
        }
        field(50010; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(50011; "Time Created"; Time)
        {
            Caption = 'Time Created';
        }
        field(50012; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            TableRelation = "User Setup";
        }
        field(50013; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(50014; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
        }
        field(50015; "Receipt No"; Code[20])
        {
            Caption = 'Receipt No';
        }
    }
    keys
    {
        key(PK; "Customer No", "Invoice No", "Member No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := Today;
    end;

    var
        HMSPat: Record "HMS Patient";
        SalesH: Record "Sales Invoice Header";
}
