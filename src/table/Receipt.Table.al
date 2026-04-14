table 85573 Receipt
{
    fields
    {
        field(50000; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50001; "Receipt No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "Receipt No." <> xRec."Receipt No." then begin
                    GenSetup.Get();
                    NoSeriesMgt.TestManual(GenSetup."Receipt Nos.");
                    "No. Series" := '';
                end;

                if "Receipt No." = '' then begin
                    GenSetup.Get();
                    GenSetup.TestField(GenSetup."Receipt Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Receipt Nos.", xRec."No. Series", 0D, "Receipt No.", "No. Series");
                end;
            end;
        }
        field(50002; Date; Date)
        {
        }
        field(50003; "Payment Mode"; Option)
        {
            OptionCaption = ' ,Bank Slip,Cheque,Banker''s Cheque,Cash,Mpesa,PDQ,Unreferenced,Money Order,Direct Bank Deposit,Staff Invoice,Weiver,HELB,CDF';
            OptionMembers = " ","Bank Slip",Cheque,"Banker's Cheque",Cash,Mpesa,PDQ,Unreferenced,"Money Order","Direct Bank Deposit","Staff Invoice",Weiver,HELB,CDF;
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; "No. Series"; Code[20])
        {
        }
        field(50006; "Payment By"; Text[150])
        {
        }
        field(50007; "User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50008; "Transaction Date"; Date)
        {
        }
        field(50009; "Transaction Time"; Time)
        {
        }
        field(50010; "Student Name"; Text[150])
        {
        }
        field(50011; "Source Rcpt No"; Code[30])
        {
            trigger OnValidate()
            begin
                // Rcpt.RESET;
                // Rcpt.SETCURRENTKEY(Rcpt."KCA Rcpt No");
                // Rcpt.SETRANGE(Rcpt."KCA Rcpt No","KCA Rcpt No");
                // IF Rcpt.FIND('-') THEN BEGIN
                // REPEAT
                // IF "Receipt No." <> Rcpt."Receipt No." THEN
                // ERROR('KCA Receipt No. already exists.');
                //
                // UNTIL Rcpt.NEXT = 0;
                // END;
            end;
        }
        field(50012; "Amount Applied"; Decimal)
        {
            CalcFormula = sum("Receipt Items".Amount where("Receipt No" = field("Receipt No.")));
            FieldClass = FlowField;
        }
        field(50013; "Un Posted"; Boolean)
        {
        }
        field(50014; Posted; Boolean)
        {
        }
        field(50015; Reversed; Boolean)
        {
        }
        field(50016; "Auto Receipt"; Boolean)
        {
        }
        field(50017; "Auto  Receipt Date"; Date)
        {
        }
        field(50018; "Auto  Receipted"; Boolean)
        {
        }
        field(50019; Unallocated; Boolean)
        {
        }
        field(50020; "Bank Slip Date"; Date)
        {
        }
        field(50021; "Bank Code"; Code[20])
        {
        }
        field(50022; Unreff; Boolean)
        {
        }
        field(50023; "Unreff Transaction No"; Code[20])
        {
        }
        field(50024; "Auto Reversed"; Boolean)
        {
            CalcFormula = exist("Bank Account Ledger Entry" where("Document No." = field("Receipt No."),
                                                                   "Posting Date" = field(Date),
                                                                   Reversed = const(true)));
            FieldClass = FlowField;
        }
        field(50025; "Bank Slip/Cheque No"; Code[50])
        {
        }
        field(50026; "Reg ID"; Code[20])
        {
        }
        field(50027; "Bank Account"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Bank Account"."No.";
        }
        field(50028; "Room No"; Code[20])
        {
        }
        field(50029; "Entry Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Document No." = field("Receipt No.")));
            FieldClass = FlowField;
        }
        field(50030; Stage; Code[20])
        {
            CalcFormula = lookup(Customer."No." where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(50031; "Unreff G/L Account"; Code[20])
        {
        }
        field(50032; "Unreff Entry No"; Integer)
        {
        }
        field(50033; "Posted Bank"; Code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("External Document No." = field("Bank Slip/Cheque No")));
            FieldClass = FlowField;
            TableRelation = "Bank Account"."No.";
        }
        field(50034; Names; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
            Clustered = true;
        }
        key(Key2; "User ID")
        {
        }
        key(Key3; "Student Name")
        {
        }
        key(Key4; "Student No.")
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Payment Mode")
        {
        }
        key(Key6; "Student No.", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Student No.", "Reg ID")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //GenSetup.GET;
        //IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        //ERROR('Modification or deletion out of the allowed range not allowed.')
    end;

    trigger OnModify()
    begin
        GenSetup.Get();
        if (Date > GenSetup."Allow Posting To") or (Date < GenSetup."Allow Posting From") then
            ;
    end;

    var
        GenSetup: Record "General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
