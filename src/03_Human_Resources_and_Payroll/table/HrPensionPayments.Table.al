Table 85427 "Hr Pension Payments"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(50001; "Date Collected"; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';
        }
        field(50002; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50003; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(50004; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(50005; Cashier; Code[20])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(50006; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionCaption = 'Pending,In Progress,Processed,Paid';
            OptionMembers = Pending,"In Progress",Processed,Paid;
        }
        field(50007; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(50008; "Cheque No."; Code[20])
        {
        }
        field(50009; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT;
        }
        field(50010; "Collected By"; Option)
        {
            OptionCaption = ' ,Self,Other';
            OptionMembers = " ",Self,Other;
        }
        field(50011; "Benefit Type"; Option)
        {
            OptionCaption = ' ,Insuarance,Pension,Nssf,Gratuity';
            OptionMembers = " ",Insuarance,Pension,Nssf,Gratuity;
        }
        field(50012; "Name of Insurance"; Text[50])
        {
        }
        field(50013; "ID Number"; Code[8])
        {
        }
        field(50014; Amount; Decimal)
        {
        }
        field(50015; Principal; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Hremp.SetRange(Hremp."No.", Principal);
                if Hremp.Find('-') then
                    "Principal's Names" := Hremp."First Name" + ' ' + Hremp."Middle Name" + ' ' + Hremp."Last Name";
            end;
        }
        field(50016; "Principal's Names"; Text[30])
        {
            Editable = false;
        }
        field(50017; "Date Prepared"; Date)
        {
        }
        field(50018; "Collected By (Name)"; Text[50])
        {
        }
        field(50019; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Casuals,Contract';
            OptionMembers = Permanent,Casuals,Contract;
        }
        field(50020; "Employee Terms Of Service"; Option)
        {
            OptionCaption = 'Temporary Appointment,Designee,Consultant,Pre-Service trainee';
            OptionMembers = "Temporary Appointment",Designee,Consultant,"Pre-Service trainee";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Pension Nos.");
            NoseriesMgt.GetNextNo(HRSetup."Pension Nos.");
        end;

        "Date Prepared" := Today;
    end;

    var
        Hremp: Record "HR-Employee";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
