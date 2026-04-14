Table 85096 "FLT-Fuel Payment Batch"
{
    DrillDownPageID = "HR Posting Groups";
    LookupPageID = "HR Posting Groups";

    fields
    {
        field(50000; "Batch No"; Code[20])
        {
            Editable = false;
        }
        field(50001; "Date Created"; Date)
        {
        }
        field(50002; "Created by"; Code[20])
        {
        }
        field(50003; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(50004; "Date Closed"; Date)
        {
        }
        field(50005; "Closed By"; Code[20])
        {
        }
        field(50006; "Total Payable"; Decimal)
        {
            CalcFormula = sum("FLTFuel Payments Batch Lines"."Value of Fuel" where("Payment Batch No" = field("Batch No")));
            FieldClass = FlowField;
        }
        field(50007; "No. Series"; Code[20])
        {
        }
        field(50008; Closed; Boolean)
        {
        }
        field(50009; "Vendor Name"; Text[100])
        {
        }
        field(50010; From; Date)
        {
        }
        field(50011; DTo; Date)
        {
            Caption = 'To';
        }
        field(50012; Invoiced; Boolean)
        {
        }
        field(50013; "Invoice No."; Code[20])
        {
        }
        field(50014; "Invoiced By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Batch No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Batch No" = '' then begin
            fleetmgt.Get();
            fleetmgt.TestField("Fuel Payment Batch No");

            NoSeriesMgt.InitSeries(fleetmgt."Fuel Payment Batch No", xRec."No. Series", 0D, "Batch No", "No. Series")
        end;
    end;

    var
        fleetmgt: Record "FLT-Fleet Mgt Setup";
        Vendor: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
