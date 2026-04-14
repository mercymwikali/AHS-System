Table 85140 "Store Requistion Lines"
{
    fields
    {
        field(50000; "Requistion No"; Code[20])
        {
            trigger OnValidate()
            begin
                /*
                  IF ReqHeader.GET("Requistion No") THEN BEGIN
                    IF ReqHeader."Global Dimension 1 Code"='' THEN
                       ERROR('Please Select the Global Dimension 1 Requisitioning')
                  END;
                 */
            end;
        }
        field(50001; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50002; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Minor Asset';
            OptionMembers = " ",Item,"Minor Asset";
        }
        field(50003; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item."No."
            else
            if (Type = const("Minor Asset")) "Fixed Asset"."No." where("FA Location Code" = field("Issuing Store"));

            trigger OnValidate()
            begin

                //Control: Don't Post Same Item Twice NOT GL's
                if Type = Type::" " then begin
                    RequisitionLine.Reset();
                    RequisitionLine.SetRange(RequisitionLine."Requistion No", "Requistion No");
                    RequisitionLine.SetRange(RequisitionLine."No.", "No.");
                    if RequisitionLine.Find('-') then
                        Error('You Cannot enter two lines for the same Item');
                end;
                //

                "Action Type" := "action type"::"Ask for Quote";

                if Type = Type::Item then begin
                    if QtyStore.Get("No.") then
                        Description := QtyStore.Description;
                    "Unit of Measure" := QtyStore."Base Unit of Measure";
                    "Unit Cost" := QtyStore."Unit Cost";
                    "Line Amount" := "Unit Cost" * Quantity;
                    QtyStore.CalcFields(QtyStore.Inventory);
                    "Qty in store" := QtyStore.Inventory;
                    if ((QtyStore.Inventory <= 0)) then
                        Message('There are no  ''' + QtyStore.Description + '''  on stock.');
                    //   IF ((QtyStore.Inventory<=0)) THEN ERROR('There are no '''+QtyStore.Description+''' in the Store to be issued!!\Please consult the store Manager for advice.');
                end;

                if Type = Type::Item then
                    if Item.Get("No.") then
                        Description := Item.Description;

                if Type = Type::"Minor Asset" then
                    if FA.Get("No.") then
                        Description := FA.Description;

                /*
                {Modified}
                         //Validate Item
                      GLAccount.GET(QtyStore."Item G/L Budget Account");
                      GLAccount.CheckGLAcc;

                */
            end;
        }
        field(50004; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(50005; "Description 2"; Text[150])
        {
            Caption = 'Description 2';
        }
        field(50006; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin

                if Type = Type::" " then
                    "Line Amount" := "Unit Cost" * Quantity;

                if QtyStore.Get("No.") then
                    QtyStore.CalcFields(QtyStore.Inventory);
                "Qty in store" := QtyStore.Inventory;
                //CheckStocklevel;
            end;
        }
        field(50007; "Qty in store"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50008; "Request Status"; Option)
        {
            Editable = true;
            OptionMembers = Pending,Released,"Director Approval","Budget Approval","FD Approval","CEO Approval",Approved,Closed;
        }
        field(50009; "Action Type"; Option)
        {
            OptionMembers = " ",Issue,"Ask for Quote";

            trigger OnValidate()
            begin
                if Type = Type::" " then
                    if "Action Type" = "action type"::Issue then
                        Error('You cannot Issue a G/L Account please order for it');

                //Compare Quantity in Store and Qty to Issue
                if Type = Type::" " then
                    if "Action Type" = "action type"::Issue then
                        if Quantity > "Qty in store" then
                            Error('You cannot Issue More than what is available in store');
            end;
        }
        field(50010; "Unit of Measure"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(50011; "Total Budget"; Decimal)
        {
        }
        field(50012; "Current Month Budget"; Decimal)
        {
        }
        field(50013; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                // IF Type=Type::Item THEN
                "Line Amount" := "Unit Cost" * Quantity;
            end;
        }
        field(50014; "Line Amount"; Decimal)
        {
        }
        field(50015; "Quantity Requested"; Decimal)
        {
            Caption = 'Quantity Requested';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Quantity := "Quantity Requested";
                "Quantity To Issue" := Quantity;

                Validate(Quantity);
                "Line Amount" := "Unit Cost" * Quantity;
            end;
        }
        field(50016; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50017; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50018; "Current Actuals Amount"; Decimal)
        {
        }
        field(50019; Committed; Boolean)
        {
        }
        field(50020; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50021; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50022; "Issuing Store"; Code[20])
        {
            TableRelation = if (Type = const(Item)) Location
            else
            if (Type = const("Minor Asset")) "FA Location";
        }
        field(50023; "Quantity To Issue"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Quantity To Issue" > "Quantity Requested" then
                    Error('You cannot Issue more than requested.');
                if ("Quantity Issued" + "Quantity To Issue") > "Quantity Requested" then
                    Error('Total Issued Items cannot exceed the Total Requested..');
                "Issue Quantity" := "Quantity To Issue";
                "Line Amount" := "Unit Cost" * "Quantity Issued";
            end;
        }
        field(50024; "Quantity Issued"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50025; "Issue Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50026; "Budgeted Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("Budget Name" = field("Budget Name"),
                                                               "G/L Account No." = field("Vote Account"),
                                                               "Global Dimension 1 Code" = field("Shortcut Dimension 1 Code"),
                                                               "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50027; "Actual Expenditure"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50028; "Committed Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("G/L Account No." = field("Vote Account"),
                                                        Budget = field("Budget Name"),
                                                        "Shortcut Dimension 1 Code" = field("Shortcut Dimension 1 Code"),
                                                        "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50029; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50030; "Budget Balance"; Decimal)
        {
        }
        field(50031; "Vote Account"; Code[20])
        {
        }
        field(50032; "Posted Count"; Integer)
        {
            CalcFormula = count("Item Ledger Entry" where("Item No." = field("No."),
                                                           "Document No." = field("Requistion No")));
            FieldClass = FlowField;
        }
        field(50033; "Last Date of Issue"; date)
        {
        }
        field(50034; "Last Quantity Issued"; Decimal)
        {
        }
        field(50035; "Lot No."; code[20])
        {
        }
        field(50036; "Remarks"; text[200])
        {
        }
        field(50037; "Temp. Journal No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Requistion No", "No.")
        {
            Clustered = true;
            SumIndexFields = "Line Amount";
        }
        key(Key2; "No.", Type, "Request Status")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ReqHeader.Reset();
        ReqHeader.SetRange(ReqHeader."No.", "Requistion No");
        if ReqHeader.Find('-') then
            if ReqHeader.Status <> ReqHeader.Status::Open then
                Error('You Cannot Delete Entries if status is not Pending')
    end;

    trigger OnInsert()
    begin

        "Line Amount" := "Unit Cost" * Quantity;

        ReqHeader.Reset();
        ReqHeader.SetRange(ReqHeader."No.", "Requistion No");
        if ReqHeader.Find('-') then begin
            "Shortcut Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ReqHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ReqHeader."Shortcut Dimension 4 Code";
            // IF ReqHeader.Status<>ReqHeader.Status::Open THEN
            //     ERROR('You Cannot Enter Entries if status is not Pending')
        end;
    end;

    trigger OnModify()
    begin

        if Type = Type::" " then
            "Line Amount" := "Unit Cost" * Quantity;

        ReqHeader.Reset();
        ReqHeader.SetRange(ReqHeader."No.", "Requistion No");
        if ReqHeader.Find('-') then begin
            "Shortcut Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ReqHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ReqHeader."Shortcut Dimension 4 Code";
            if ReqHeader.Status <> ReqHeader.Status::Open then
                if (("Quantity To Issue" = xRec."Quantity To Issue") and (xRec."Quantity Issued" = "Quantity Issued")
                and ("Issue Quantity" = xRec."Issue Quantity")) then
                    Error('You Cannot Modify Entries if status is not Pending')
        end;

        /* ReqHeader.RESET;
         ReqHeader.SETRANGE(ReqHeader."No.","Requistion No");
         IF ReqHeader.FIND('-') THEN BEGIN
          "Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ReqHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ReqHeader."Shortcut Dimension 4 Code";
          IF ReqHeader.Status<>ReqHeader.Status::Open THEN
              ERROR('You Cannot Modify Entries if status is not Pending')
         END; */
    end;

    var
        FA: Record "Fixed Asset";
        Item: Record Item;
        QtyStore: Record Item;
        ReqHeader: Record "Store Requistion Header";
        RequisitionLine: Record "Store Requistion Lines";
        qty: Integer;

    procedure CheckStocklevel()
    begin
        Item.Reset();
        Item.Get("No.");
        Item.SetFilter(Item."Location Filter", "Issuing Store");
        Item.CalcFields(Item.Inventory);
        qty := Item.Inventory;
        if (qty - Quantity) < 0 then
            Error('This transaction will result in Negative stock');
    end;
}
