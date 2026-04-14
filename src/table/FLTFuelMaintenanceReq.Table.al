Table 85005 "FLT-Fuel & Maintenance Req."
{
    //  DrillDownPageID = UnknownPage70135516;
    //   LookupPageID = UnknownPage70135516;

    fields
    {
        field(50000; "Requisition No"; Code[20])
        {
        }
        field(50001; "Vehicle Reg No"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";

            trigger OnValidate()
            begin
                WshpFA.Reset();
                WshpFA.SetRange(WshpFA."Registration No.", "Vehicle Reg No");
                if WshpFA.Find('-') then
                    "Fixed Asset No" := WshpFA."No.";
            end;
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
            trigger OnValidate()
            begin
                "Total Price of Fuel" := "Quantity of Fuel(Litres)" * "Price/Litre";
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50004; "Total Price of Fuel"; Decimal)
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
            OptionMembers = Open,"Pending Approval",Approved,Closed,Cancelled;
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
            OptionMembers = " ",Maintenance,Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Fuel;
        }
        field(50020; "Type of Maintenance"; Option)
        {
            OptionMembers = " ",Repair,"Scheduled Service",Tyre;
        }
        field(50021; Driver; Code[10])
        {
            TableRelation = "Flt Driver";

            trigger OnValidate()
            begin
                if Drivers.Get(Driver) then
                    "Driver Name" := Drivers."Driver Name";
            end;
        }
        field(50022; "Driver Name"; Text[100])
        {
        }
        field(50023; "Fixed Asset No"; Code[20])
        {
        }
        field(50024; Oil; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50025; "Quote No"; Code[20])
        {
        }
        field(50026; "Price/Litre"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Price of Fuel" := "Quantity of Fuel(Litres)" * "Price/Litre";
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50027; "Type of Fuel"; Option)
        {
            OptionMembers = " ",Petrol,Diesel;
        }
        field(50028; Coolant; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50029; "Battery Water"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50030; "Wheel Alignment"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50031; "Wheel Balancing"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50032; "Car Wash"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Cost" := "Total Price of Fuel" + Oil + Coolant + "Battery Water" + "Wheel Alignment" + "Wheel Balancing" + "Car Wash";
            end;
        }
        field(50033; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin
                /*
               TESTFIELD(Status,Status::Open);
               IF NOT UserMgt.CheckRespCenter(1,Department) THEN
                 ERROR(
                   Text001,
                   RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                */
            end;
        }
        field(50034; "Maintenance Description"; Text[200])
        {
        }
        field(50035; "Total Cost"; Decimal)
        {
        }
        field(50036; "Oil Type"; Option)
        {
            OptionCaption = ' ,Engine Oil,Brake Fluid,Gear Box Oil';
            OptionMembers = " ","Engine Oil","Brake Fluid","Gear Box Oil";
        }
        field(50037; "Oil Litres"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Requisition No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //  ERROR('Test');
        //IF Type=Type::Fuel THEN BEGIN
        // IF "Requisition No" = '' THEN BEGIN
        FltMgtSetup.Get();
        FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
        NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Register", xRec."No. Series", 0D, "Requisition No", "No. Series");

        // END;
        //END ELSE BEGIN
        if Type = Type::Interbank then
            if "Requisition No" = '' then begin
                FltMgtSetup.Get();
                FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
                NoSeriesMgt.InitSeries(FltMgtSetup."Maintenance Request", xRec."No. Series", 0D, "Requisition No", "No. Series");
            end;
        //END;
    end;

    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        WshpFA: Record "FLT-Vehicle Header";
        Drivers: Record "Flt Driver";
        Vendor: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
