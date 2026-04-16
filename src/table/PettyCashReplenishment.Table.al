table 85459 "Petty Cash Replenishment"
{
    Caption = 'Petty Cash Replenishment';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Replenishement No"; Code[30])
        {
            Caption = 'Replenishment No';
        }
        field(50001; "Requesting User"; Code[30])
        {
            Caption = 'Requesting User';
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get("Requesting User");
                UserSetup.TestField("Petty Cash Account No");
                "Bank Code" := UserSetup."Petty Cash Account No";
                "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            end;
        }
        field(50002; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
        }
        field(50003; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Account"."No.";

        }
        field(50004; "Bank Name"; Text[150])
        {
            Caption = 'Bank Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Bank Account"."Bank Account Name" where("No." = field("Bank Code")));
        }
        field(50005; "Max Cashier Holding"; Decimal)
        {
            Caption = 'Max Cashier Holding';
            FieldClass = FlowField;
            CalcFormula = lookup("Bank Account"."Maximum Cashier Holding" where("No." = field("Bank Code")));
        }
        field(50006; "Approval Status"; Enum "Approval Status")
        {
            Caption = 'Approval Status';
        }
        field(50007; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(50008; "Posted InterBank Transfer No"; Code[30])
        {
            Caption = 'Posted InterBank Transfer No';
        }
        field(50009; "Posted By"; Code[30])
        {
            Caption = 'Posted By';
        }
        field(50010; "Requisition Date"; Date)
        {
            Caption = 'Requisition Date';
        }
        field(50011; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(50012; "Request Amount"; Decimal)
        {
            Caption = 'Request Amount';

            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
                BalanceAfterRequest: Decimal;
                MaximumRequestAmount: Decimal;
            begin
                TestField("Bank Code");
                CalcFields("Max Cashier Holding");
                MaximumRequestAmount := 0;
                BalanceAfterRequest := 0;
                BankAccount.Get("Bank Code");
                BankAccount.CalcFields(Balance);

                BalanceAfterRequest := "Request Amount" + BankAccount.Balance;
                MaximumRequestAmount := "Max Cashier Holding" - "Bank Balance";

                if BalanceAfterRequest > BankAccount."Maximum Cashier Holding" then
                    Error('You can not Request an amount above ' + ' ' + Format(MaximumRequestAmount) + ' ' + 'Your current balance is ' + ' ' + Format(BankAccount.Balance));
            end;
        }
        field(50013; "Bank Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Code")));
        }
        field(50014; "Start Date"; Date)
        {
            Caption = 'Rep Start Date';
        }
        field(50015; "End Date"; Date)
        {
            Caption = 'Rep End Date';
        }
        field(50016; "Total Amount "; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Replenshment Line".Amount where("Replinshment No" = field("Replenishement No")));
        }
        field(50017; "Get Voucher "; Boolean)
        {
            trigger OnValidate()
            var
                Replines: Record "Replenshment Line";
                pettycash: record "Payments Header";
                Repline: Record "Replenshment Line";
                Entryno: Integer;
            begin
                Repline.Reset();
                Repline.SetRange("Replinshment No", "Replenishement No");
                if Repline.Find('-') then begin

                    Repline.DeleteAll();
                end else begin

                    pettycash.Reset();
                    pettycash.SetRange("Paying Bank Account", "Bank Code");
                    pettycash.SetRange(Posted, true);
                    pettycash.SetFilter(Date, '%1..%2', "Start Date", "End Date");
                    if pettycash.Find('-') then begin
                        //IF (pettycash."Date Posted" >= "Start Date") then
                        repeat

                            Replines.Reset();
                            IF Replines.FindLast() then
                                Entryno := Replines."Line No";
                            Replines.Init();
                            Replines."Line No" := Entryno + 1;
                            Replines."Petty cash No" := pettycash."No.";
                            Replines.Payee := pettycash.Payee;
                            pettycash.CalcFields("Total Net Amount");
                            replines.Amount := pettycash."Total Net Amount";
                            Replines."Transaction Date" := pettycash."Date Posted";
                            Replines."Petty cash Account" := pettycash."Paying Bank Account";
                            Replines."Replinshment No" := "Replenishement No";

                            Replines.Insert(TRUE);

                        until pettycash.NEXT = 0;

                    end;
                    Message('Voucher Successfully Generated');
                end;
            end;

        }
    }
    keys
    {
        key(PK; "Replenishement No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        PettyCashReplenishment: Record "Petty Cash Replenishment";
        cashofficesetup: Record "Cash Office Setup";
        noseries: Codeunit "No. Series";
    begin
        if "Replenishement No" = '' then begin
            cashofficesetup.Get();
            cashofficesetup.TestField("Payment Schedule No");
            "Replenishement No" := noseries.GetNextNo(cashofficesetup."Payment Schedule No", Today, true);
        end;

        if "Requesting User" = '' then
            "Requesting User" := UserId;

        Validate("Requesting User");
    end;
}