Table 85139 "Store Requistion Header"
{
    DrillDownPageID = "Store Requisition";
    LookupPageID = "Store Requisition";

    fields
    {
        field(50000; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "No." = '' then
                    if "No." <> xRec."No." then begin
                        GenLedgerSetup.Get();
                        NoSeriesMgt.TestManual(GenLedgerSetup."Stores Requisition No");
                        "No." := '';
                    end;
            end;
        }
        field(50001; "Request date"; Date)
        {
        }
        field(50002; "Required Date"; Date)
        {
        }
        field(50003; "Requester ID"; Code[30])
        {
            Caption = 'Requester ID';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
            end;
        }
        field(50004; "Request Description"; Text[150])
        {
        }
        field(50005; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50006; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Released,Pending Prepayment,Cancelled,Posted';
            OptionMembers = Open,"Pending Approval",Released,"Pending Prepayment",Cancelled,Posted;
        }
        field(50007; Supplier; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50008; "Action Type"; Option)
        {
            OptionMembers = " ","Ask for Tender","Ask for Quote";

            trigger OnValidate()
            begin
                /*
                IF Type=Type::"G/L Account" THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN
                            ERROR('You cannot Issue a G/L Account please order for it')
                END;

               //Compare Quantity in Store and Qty to Issue
                IF Type=Type::Item THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN BEGIN
                    IF Quantity>"Qty in store" THEN
                      ERROR('You cannot Issue More than what is available in store')
                   END;
                END;
                */
            end;
        }
        field(50009; Justification; Text[250])
        {
        }
        field(50010; "User ID"; Code[30])
        {
        }
        field(50011; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimval.Reset();
                Dimval.SetRange(Dimval."Global Dimension No.", 1);
                Dimval.SetRange(Dimval.Code, "Global Dimension 1 Code");
                if Dimval.Find('-') then
                    "Function Name" := Dimval.Name
            end;
        }
        field(50012; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimval.Reset();
                Dimval.SetRange(Dimval."Global Dimension No.", 2);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 2 Code");
                if Dimval.Find('-') then
                    "Budget Center Name" := Dimval.Name
            end;
        }
        field(50013; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(50014; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(50015; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                Dimval.Reset();
                //Dimval.SETRANGE(Dimval."Global Dimension No.",3);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 3 Code");
                if Dimval.Find('-') then
                    Dim3 := Dimval.Name
            end;
        }
        field(50016; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                Dimval.Reset();
                //Dimval.SETRANGE(Dimval."Global Dimension No.",4);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 4 Code");
                if Dimval.Find('-') then
                    Dim4 := Dimval.Name
            end;
        }
        field(50017; Dim3; Text[250])
        {
        }
        field(50018; Dim4; Text[250])
        {
        }
        field(50019; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                // if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                //    Error(
                //       Text001,
                //      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(50020; TotalAmount; Decimal)
        {
            CalcFormula = sum("Store Requistion Lines"."Line Amount" where("Requistion No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50021; "Issuing Store"; Code[10])
        {
            TableRelation = if ("Store Requisition Type" = const(Item)) Location
            else
            if ("Store Requisition Type" = const("Minor Asset")) "FA Location";

            trigger OnValidate()
            begin

                ReqLines.Reset();
                ReqLines.SetRange(ReqLines."Requistion No", "No.");
                if ReqLines.Find('-') then
                    repeat
                        ReqLines."Issuing Store" := "Issuing Store";
                    until ReqLines.Next() = 0;
            end;
        }
        field(50022; "Store Requisition Type"; Option)
        {
            OptionCaption = 'Item,Minor Asset';
            OptionMembers = Item,"Minor Asset";
        }
        field(50023; "Issue Date"; Date)
        {
        }
        field(50024; Committed; Boolean)
        {
        }
        field(50025; "SRN.No"; Code[20])
        {
        }
        field(50026; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50027; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50028; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50029; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
        field(50030; Amount; Decimal)
        {
            CalcFormula = sum("Store Requistion Lines"."Line Amount" where("Requistion No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Requisition Type"; Option)
        {
            OptionCaption = 'Stationery,Others, Dry Goodsf,Grocery,Cereals,Beverages,Fuel, Beef,Meat Products,Eggs,Perishables,Hardware Materials,Building Materials,Drugs,Non-Pharmaceuticals,Teaching Materials,Minor Assets,Assets';
            OptionMembers = Stationery,Others," Dry Goods",Grocery,Cereals,Beverages,Fuel," Beef","Meat Products",Eggs,Perishables,"Hardware Materials","Building Materials",Drugs,"Non-Pharmaceuticals","Teaching Materials","Minor Assets",Assets;
        }
        field(50032; "Department Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('DEPARTMENT'),
                                                               Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50033; "Employee No"; Code[20])
        {
        }
        field(50034; "Posted Count"; Integer)
        {
            CalcFormula = count("Item Ledger Entry" where("Document No." = field("No.")));
            FieldClass = FlowField;
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

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('You Cannot DELETE an already released Requisition')
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Stores Requisition No");
            NoSeriesMgt.GetNextNo(GenLedgerSetup."Stores Requisition No");
        end;

        // "HR-EMP".Reset();
        // "HR-EMP".SetRange("HR-EMP"."User ID", UserId);
        // if "HR-EMP".Find('-') then
        //     "Employee No" := "HR-EMP"."No.";
    end;

    trigger OnModify()
    begin
        if (Status <> Status::Open) and (Status <> Status::Released) then
            Error('You Cannot MODIFY a Pending Approval Requisition');

        ReqLines.Reset();
        ReqLines.SetRange(ReqLines."Requistion No", "No.");
        if ReqLines.Find('-') then
            repeat
                ReqLines."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                ReqLines."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                ReqLines."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                ReqLines."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
            until ReqLines.Next() = 0;
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        Dimval: Record "Dimension Value";
        "HR-EMP": Record "HR-Employee";
        ReqLines: Record "Store Requistion Lines";
        NoSeriesMgt: Codeunit "No. Series";
}
