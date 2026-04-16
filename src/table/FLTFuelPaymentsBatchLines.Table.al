Table 85102 "FLTFuel Payments Batch Lines"
{
    DrillDownPageID = "Appraisal Types";
    LookupPageID = "Appraisal Types";

    fields
    {
        field(50000; "Requisition No"; Code[20])
        {
        }
        field(50001; "Vehicle Reg No"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(50002; "Vendor(Dealer)"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor(Dealer)") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(50003; "Quantity of Fuel(Litres)"; Decimal)
        {
        }
        field(50004; "Value of Fuel"; Decimal)
        {
        }
        field(50005; "Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50006; "Request Date"; Date)
        {
        }
        field(50007; "Date Taken for Fueling"; Date)
        {
        }
        field(50008; Status; Option)
        {
            OptionMembers = Open,Submitted,Approved,Closed,Cancelled;
        }
        field(50009; "Prepared By"; Code[20])
        {
        }
        field(50010; "Closed By"; Code[20])
        {
        }
        field(50011; "Date Closed"; Date)
        {
        }
        field(50012; "Vendor Invoice No"; Code[20])
        {
        }
        field(50013; "Posted Invoice No"; Code[20])
        {
        }
        field(50014; Description; Text[250])
        {
        }
        field(50015; Department; Code[20])
        {
        }
        field(50016; "No. Series"; Code[10])
        {
        }
        field(50017; "Vendor Name"; Text[100])
        {
        }
        field(50018; "Date Taken for Maintenance"; Date)
        {
        }
        field(50019; Type; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel;
        }
        field(50020; "Type of Maintenance"; Option)
        {
            OptionMembers = " ",Repair,"Scheduled Service",Tyre;
        }
        field(50021; Driver; Code[10])
        {
            TableRelation = "Flt Driver";
        }
        field(50022; "Driver Name"; Text[100])
        {
        }
        field(50023; "Fixed Asset No"; Code[20])
        {
        }
        field(50024; "Litres of Oil"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50025; "Quote No"; Code[20])
        {
        }
        field(50026; Invoiced; Boolean)
        {
        }
        field(50027; "Invoice No."; Code[20])
        {
        }
        field(50028; "Payment Batch No"; Code[20])
        {
        }
        field(50029; "Invoiced By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Payment Batch No", "Requisition No")
        {
            Clustered = true;
            SumIndexFields = "Value of Fuel";
        }
        key(Key2; "Vehicle Reg No")
        {
            SumIndexFields = "Value of Fuel", "Quantity of Fuel(Litres)";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Type = Type::Order then begin
            if "Requisition No" = '' then begin
                FltMgtSetup.Get();
                FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
                NoSeriesMgt.GetNextNo(FltMgtSetup."Fuel Register");
            end;
        end else
            if Type = Type::Invoice then
                if "Requisition No" = '' then begin
                    FltMgtSetup.Get();
                    FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
                    NoSeriesMgt.GetNextNo(FltMgtSetup."Maintenance Request");
                end;
    end;

    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        Vendor: Record Vendor;
        NoSeriesMgt: Codeunit "No. Series";
}
