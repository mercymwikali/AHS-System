Table 85068 "A-Vehicle Movement"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Vehicle Reg No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                /*
                  IF FA.GET("Vehicle Reg No.") THEN BEGIN
                 "Vehicle Type":=FA."Vehicle Type";
                 "Current ODO Reading":=FA.Mielage;
                 END ELSE BEGIN
                 "Vehicle Type":='';
                 "Current ODO Reading":=0;
                 END;
               */
            end;
        }
        field(50003; "Vehicle Type"; Code[20])
        {
            TableRelation = "A-Vehicle Types".Code;
        }
        field(50004; "Ticket No"; Code[20])
        {
            TableRelation = "A-Transport Requisition"."No.";

            trigger OnValidate()
            begin
                if TReq.Get("Ticket No") then begin
                    CalcFields("Department Code");
                    CalcFields("Station Code");
                    "Requisition Type" := TReq."Requisition Type";
                    if TReq."Requisition Type" = TReq."requisition type"::Commercial then begin
                        "Client No." := TReq."Client No.";
                        "Client Name" := TReq."Client Name"
                    end;
                end;
            end;
        }
        field(50005; "Client No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Client No.") then
                    "Client Name" := Cust.Name;
            end;
        }
        field(50006; "Client Name"; Text[100])
        {
        }
        field(50007; "Prepared By"; Code[20])
        {
        }
        field(50008; "Checked By"; Code[20])
        {
        }
        field(50009; "Checked On"; Date)
        {
        }
        field(50010; "Verified By"; Code[20])
        {
        }
        field(50011; "Verified On"; Date)
        {
        }
        field(50012; "Department Code"; Code[20])
        {
            CalcFormula = lookup("A-Transport Requisition"."Department Code" where("No." = field("Ticket No")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50013; "Station Code"; Code[20])
        {
            CalcFormula = lookup("A-Transport Requisition"."Station Code" where("No." = field("Ticket No")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50014; "Vehicle Location"; Option)
        {
            OptionCaption = 'In,Out';
            OptionMembers = "In",Out;
        }
        field(50015; "Dispatched By"; Code[20])
        {
        }
        field(50016; "Dispatch Date"; Date)
        {
        }
        field(50017; Closed; Boolean)
        {
        }
        field(50018; "Closed On"; Date)
        {
        }
        field(50019; "Closed By"; Code[20])
        {
        }
        field(50020; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50021; "Dispatch Type"; Option)
        {
            OptionCaption = 'Operational,Commercial';
            OptionMembers = Operational,Commercial;

            trigger OnValidate()
            begin
                if "Dispatch Type" = "dispatch type"::Operational then begin
                    "Client No." := '';
                    "Client Name" := '';
                end else
                    "Ticket No" := '';
            end;
        }
        field(50022; "Current ODO Reading"; Integer)
        {
        }
        field(50023; "Requisition Type"; Option)
        {
            OptionCaption = 'Normal,Commercial';
            OptionMembers = Normal,Commercial;
        }
        field(50024; Distance; Decimal)
        {
            trigger OnValidate()
            begin
                FA.Get("Vehicle Reg No.");
                // OPSetUp.Get(0);
                //  "Estimated Cost":=(Distance*OPSetUp."Est. Driver Cost Per Km.")+(Distance*OPSetUp."Est. Running Cost Per Km")+
                //(Distance*FA."Est. Fuel Cons. Per Km");
            end;
        }
        field(50025; "Estimated Cost"; Decimal)
        {
        }
        field(50026; "Actual Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
            SumIndexFields = "Actual Cost";
        }
        key(Key2; Date, "Vehicle Reg No.")
        {
            SumIndexFields = "Actual Cost";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        IF "No." = '' THEN BEGIN
          OPSetUp.GET(0);
          OPSetUp.TESTFIELD(OPSetUp."Dispatch Nos");
          NoSeriesMgt.GetNextNo(OPSetUp."Dispatch Nos",xRec."No. Series",0D,"No.","No. Series");
        END;
        */
    end;

    var
        TReq: Record "A-Transport Requisition";
        Cust: Record Customer;
        FA: Record "Fixed Asset";
}
