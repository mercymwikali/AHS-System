Table 85082 "Cash Office User Template"
{
    DataCaptionFields = UserID;

    fields
    {
        field(50000; UserID; Code[30])
        {
            Description = 'Stores the reference of the user in the database';
            NotBlank = true;
            TableRelation = "User Setup"."User ID";
        }
        field(50001; "Receipt Journal Template"; Code[20])
        {
            Description = 'Stores the reference of the receipt journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(50002; "Receipt Journal Batch"; Code[20])
        {
            Description = 'Stores the reference of the receipt journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Receipt Journal Template", "Receipt Journal Template");
                UserTemp.SetRange(UserTemp."Receipt Journal Batch", "Receipt Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50003; "Payment Journal Template"; Code[20])
        {
            Description = 'Stores the reference of the payment journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50004; "Payment Journal Batch"; Code[20])
        {
            Description = 'Stores the reference of the payment journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange(UserTemp."Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50005; "Petty Cash Template"; Code[20])
        {
            Description = 'Stores the reference to the petty cash payment voucher in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50006; "Petty Cash Batch"; Code[20])
        {
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Petty Cash Template", "Petty Cash Template");
                UserTemp.SetRange(UserTemp."Petty Cash Batch", "Petty Cash Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50007; "Inter Bank Template Name"; Code[20])
        {
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50008; "Inter Bank Batch Name"; Code[20])
        {
            Description = 'Stores the reference to the inter bank transfer batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Inter Bank Template Name"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Inter Bank Template Name", "Inter Bank Template Name");
                UserTemp.SetRange(UserTemp."Inter Bank Batch Name", "Inter Bank Batch Name");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50009; "Default Receipts Bank"; Code[20])
        {
            Description = 'Stores the reference to the default receipts bank deposit account';
            TableRelation = "Bank Account"."No." where("Bank Type" = filter(Cash | "Chq Collection"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Receipts Bank", "Default Receipts Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then;
                            //  ERROR('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50010; "Default Payment Bank"; Code[20])
        {
            Description = 'Stores the reference to the default payments bank deposit account';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /* UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Payment Bank", "Default Payment Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0; */
            end;
        }
        field(50011; "Default Petty Cash Bank"; Code[20])
        {
            Description = 'Stores the reference to the default petty cash account in the database';
            TableRelation = "Bank Account"."No." where("Bank Type" = const(Cash));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Petty Cash Bank", "Default Petty Cash Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50012; "Max. Cash Collection"; Decimal)
        {
        }
        field(50013; "Max. Cheque Collection"; Decimal)
        {
        }
        field(50014; "Max. Deposit Slip Collection"; Decimal)
        {
        }
        field(50015; "Supervisor ID"; Code[20])
        {
            Description = 'Stores the reference for the supervisor for the specific teller';

            trigger OnLookup()
            begin
                // LoginMgt.LookupUserID("Supervisor ID");
            end;

            trigger OnValidate()
            begin
                // LoginMgt.ValidateUserID("Supervisor ID");
            end;
        }
        field(50016; "Bank Pay In Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(50017; "Bank Pay In Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Pay In Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Template", "Bank Pay In Journal Template");
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Batch", "Bank Pay In Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(50018; "Imprest Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50019; "Imprest  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(50020; "Claim Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50021; "Claim  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Claim Template"));
        }
        field(50022; "Advance Template"; Code[20])
        {
            Caption = 'Other Advance Template';
            TableRelation = "Gen. Journal Template";
        }
        field(50023; "Advance  Batch"; Code[20])
        {
            Caption = 'Other Advance  Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Template"));
        }
        field(50024; "Advance Surr Template"; Code[20])
        {
            Caption = 'Other Advance Surr Template';
            TableRelation = "Gen. Journal Template";
        }
        field(50025; "Advance Surr Batch"; Code[20])
        {
            Caption = 'Other Advance Surr Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Surr Template"));
        }
        field(50026; "Default Branch Code"; Code[20])
        {
            Caption = 'Default Branch Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50027; "Default Mpesa Bank"; Code[20])
        {
            Caption = 'Default Mpesa bank Code';
            TableRelation = "Bank Account"."No.";
        }
        field(50028; "Default PDQ Bank"; Code[20])
        {
            Caption = 'Default PDQ bank Code';
            TableRelation = "Bank Account"."No.";
        }
        field(50029; "Default Cheque Bank"; Code[20])
        {
            Caption = 'Default Cheque bank Code';
            TableRelation = "Bank Account"."No.";            
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserTemp: Record "Cash Office User Template";
}
