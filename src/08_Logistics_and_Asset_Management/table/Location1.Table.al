Table 85061 Location1
{
    Caption = 'Location';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = "Location List";
    LookupPageID = "Location List";

    fields
    {
        field(50000; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(50001; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(50002; "Default Bin Code"; Code[20])
        {
            Caption = 'Default Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));
        }
        field(50003; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(50004; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50005; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50006; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Postcode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50007; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50008; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(50009; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(50010; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50011; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(50012; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50013; County; Text[30])
        {
            Caption = 'County';
        }
        field(50014; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50015; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(50016; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50017; "Use As In-Transit"; Boolean)
        {
            AccessByPermission = TableData "Transfer Header" = R;
            Caption = 'Use As In-Transit';

            trigger OnValidate()
            begin
                if "Use As In-Transit" then begin
                    TestField("Require Put-away", false);
                    TestField("Require Pick", false);
                    TestField("Use Cross-Docking", false);
                    TestField("Require Receive", false);
                    TestField("Require Shipment", false);
                    TestField("Bin Mandatory", false);
                end;
            end;
        }
        field(50018; "Require Put-away"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Require Put-away';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
            begin
                WhseRcptHeader.SetCurrentkey("Location Code");
                WhseRcptHeader.SetRange("Location Code", Code);
                if WhseRcptHeader.FindFirst() then
                    Error(Text008, FieldCaption("Require Put-away"), xRec."Require Put-away", WhseRcptHeader.TableCaption);

                if not "Require Put-away" then begin
                    TestField("Directed Put-away and Pick", false);
                    WhseActivHeader.SetRange(Type, WhseActivHeader.Type::"Put-away");
                    WhseActivHeader.SetRange("Location Code", Code);
                    if WhseActivHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Put-away"), true, WhseActivHeader.TableCaption);
                    "Use Cross-Docking" := false;
                    "Cross-Dock Bin Code" := '';
                end;
            end;
        }
        field(50019; "Require Pick"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Require Pick';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
            begin
                WhseShptHeader.SetCurrentkey("Location Code");
                WhseShptHeader.SetRange("Location Code", Code);
                if WhseShptHeader.FindFirst() then
                    Error(Text008, FieldCaption("Require Pick"), xRec."Require Pick", WhseShptHeader.TableCaption);

                if not "Require Pick" then begin
                    TestField("Directed Put-away and Pick", false);
                    WhseActivHeader.SetRange(Type, WhseActivHeader.Type::Pick);
                    WhseActivHeader.SetRange("Location Code", Code);
                    if WhseActivHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Pick"), true, WhseActivHeader.TableCaption);
                    "Use Cross-Docking" := false;
                    "Cross-Dock Bin Code" := '';
                    "Pick According to FEFO" := false;
                end;
            end;
        }
        field(50020; "Cross-Dock Due Date Calc."; DateFormula)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Cross-Dock Due Date Calc.';
        }
        field(50021; "Use Cross-Docking"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Use Cross-Docking';

            trigger OnValidate()
            begin
                if "Use Cross-Docking" then begin
                    TestField("Require Receive");
                    TestField("Require Shipment");
                    TestField("Require Put-away");
                    TestField("Require Pick");
                end else
                    "Cross-Dock Bin Code" := '';
            end;
        }
        field(50022; "Require Receive"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Receipt Header" = R;
            Caption = 'Require Receive';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
            begin
                if not "Require Receive" then begin
                    TestField("Directed Put-away and Pick", false);
                    WhseRcptHeader.SetCurrentkey("Location Code");
                    WhseRcptHeader.SetRange("Location Code", Code);
                    if WhseRcptHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Receive"), true, WhseRcptHeader.TableCaption);
                    "Receipt Bin Code" := '';
                    "Use Cross-Docking" := false;
                    "Cross-Dock Bin Code" := '';
                end else begin
                    WhseActivHeader.SetRange(Type, WhseActivHeader.Type::"Put-away");
                    WhseActivHeader.SetRange("Location Code", Code);
                    if WhseActivHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Receive"), false, WhseActivHeader.TableCaption);
                end;
            end;
        }
        field(50023; "Require Shipment"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Shipment Header" = R;
            Caption = 'Require Shipment';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
            begin
                if not "Require Shipment" then begin
                    TestField("Directed Put-away and Pick", false);
                    WhseShptHeader.SetCurrentkey("Location Code");
                    WhseShptHeader.SetRange("Location Code", Code);
                    if WhseShptHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Shipment"), true, WhseShptHeader.TableCaption);
                    "Shipment Bin Code" := '';
                    "Use Cross-Docking" := false;
                    "Cross-Dock Bin Code" := '';
                end else begin
                    WhseActivHeader.SetRange(Type, WhseActivHeader.Type::Pick);
                    WhseActivHeader.SetRange("Location Code", Code);
                    if WhseActivHeader.FindFirst() then
                        Error(Text008, FieldCaption("Require Shipment"), false, WhseActivHeader.TableCaption);
                end;
            end;
        }
        field(50024; "Bin Mandatory"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Bin Mandatory';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseEntry: Record "Warehouse Entry";
                WhseRcptHeader: Record "Warehouse Receipt Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
                Window: Dialog;
            begin
                if "Bin Mandatory" and not xRec."Bin Mandatory" then begin
                    Window.Open(Text010);
                    ItemLedgEntry.SetRange(Open, true);
                    ItemLedgEntry.SetRange("Location Code", Code);
                    if not ItemLedgEntry.IsEmpty then
                        Error(Text009, FieldCaption("Bin Mandatory"));

                    "Default Bin Selection" := "default bin selection"::"Fixed Bin";
                end;

                WhseActivHeader.SetRange("Location Code", Code);
                if not WhseActivHeader.IsEmpty then
                    Error(Text008, FieldCaption("Bin Mandatory"), xRec."Bin Mandatory", WhseActivHeader.TableCaption);

                WhseRcptHeader.SetCurrentkey("Location Code");
                WhseRcptHeader.SetRange("Location Code", Code);
                if not WhseRcptHeader.IsEmpty then
                    Error(Text008, FieldCaption("Bin Mandatory"), xRec."Bin Mandatory", WhseRcptHeader.TableCaption);

                WhseShptHeader.SetCurrentkey("Location Code");
                WhseShptHeader.SetRange("Location Code", Code);
                if not WhseShptHeader.IsEmpty then
                    Error(Text008, FieldCaption("Bin Mandatory"), xRec."Bin Mandatory", WhseShptHeader.TableCaption);

                if not "Bin Mandatory" and xRec."Bin Mandatory" then begin
                    WhseEntry.SetRange("Location Code", Code);
                    WhseEntry.CalcSums("Qty. (Base)");
                    if WhseEntry."Qty. (Base)" <> 0 then
                        Error(Text002, FieldCaption("Bin Mandatory"));
                end;

                if not "Bin Mandatory" then begin
                    "Open Shop Floor Bin Code" := '';
                    "To-Production Bin Code" := '';
                    "From-Production Bin Code" := '';
                    "Adjustment Bin Code" := '';
                    "Receipt Bin Code" := '';
                    "Shipment Bin Code" := '';
                    "Cross-Dock Bin Code" := '';
                    "To-Assembly Bin Code" := '';
                    "From-Assembly Bin Code" := '';
                    //  WhseIntegrationMgt.CheckLocationOnManufBins(Rec);
                end;
            end;
        }
        field(50025; "Directed Put-away and Pick"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Directed Put-away and Pick';

            trigger OnValidate()
            var
                WhseActivHeader: Record "Warehouse Activity Header";
                WhseRcptHeader: Record "Warehouse Receipt Header";
                WhseShptHeader: Record "Warehouse Shipment Header";
            begin
                WhseActivHeader.SetRange("Location Code", Code);
                if not WhseActivHeader.IsEmpty then
                    Error(Text014, FieldCaption("Directed Put-away and Pick"), WhseActivHeader.TableCaption);

                WhseRcptHeader.SetCurrentkey("Location Code");
                WhseRcptHeader.SetRange("Location Code", Code);
                if not WhseRcptHeader.IsEmpty then
                    Error(Text014, FieldCaption("Directed Put-away and Pick"), WhseRcptHeader.TableCaption);

                WhseShptHeader.SetCurrentkey("Location Code");
                WhseShptHeader.SetRange("Location Code", Code);
                if not WhseShptHeader.IsEmpty then
                    Error(Text014, FieldCaption("Directed Put-away and Pick"), WhseShptHeader.TableCaption);

                if "Directed Put-away and Pick" then begin
                    TestField("Use As In-Transit", false);
                    TestField("Bin Mandatory");
                    Validate("Require Receive", true);
                    Validate("Require Shipment", true);
                    Validate("Require Put-away", true);
                    Validate("Require Pick", true);
                    Validate("Use Cross-Docking", true);
                    "Default Bin Selection" := "default bin selection"::" ";
                end else
                    Validate("Adjustment Bin Code", '');

                if (not "Directed Put-away and Pick") and xRec."Directed Put-away and Pick" then begin
                    "Default Bin Selection" := "default bin selection"::"Fixed Bin";
                    "Use Put-away Worksheet" := false;
                    Validate("Use Cross-Docking", false);
                end;
            end;
        }
        field(50026; "Default Bin Selection"; Option)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Default Bin Selection';
            OptionCaption = ' ,Fixed Bin,Last-Used Bin';
            OptionMembers = " ","Fixed Bin","Last-Used Bin";

            trigger OnValidate()
            begin
                if ("Default Bin Selection" <> xRec."Default Bin Selection") and ("Default Bin Selection" = "default bin selection"::" ") then
                    TestField("Directed Put-away and Pick");
            end;
        }
        field(50027; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Outbound Whse. Handling Time';
        }
        field(50028; "Inbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Inbound Whse. Handling Time';
        }
        field(50029; "Put-away Template Code"; Code[10])
        {
            Caption = 'Put-away Template Code';
            TableRelation = "Put-away Template Header";
        }
        field(50030; "Use Put-away Worksheet"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Use Put-away Worksheet';
        }
        field(50031; "Pick According to FEFO"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Pick According to FEFO';
        }
        field(50032; "Allow Breakbulk"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Allow Breakbulk';
        }
        field(50033; "Bin Capacity Policy"; Option)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Bin Capacity Policy';
            OptionCaption = 'Never Check Capacity,Allow More Than Max. Capacity,Prohibit More Than Max. Cap.';
            OptionMembers = "Never Check Capacity","Allow More Than Max. Capacity","Prohibit More Than Max. Cap.";
        }
        field(50034; "Open Shop Floor Bin Code"; Code[20])
        {
            Caption = 'Open Shop Floor Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "Open Shop Floor Bin Code",
                  FieldCaption("Open Shop Floor Bin Code"),
                 Code);
            end;
        }
        field(50035; "To-Production Bin Code"; Code[20])
        {
            Caption = 'To-Production Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "To-Production Bin Code",
                  FieldCaption("To-Production Bin Code"),
                  Code);
            end;
        }
        field(50036; "From-Production Bin Code"; Code[20])
        {
            Caption = 'From-Production Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "From-Production Bin Code",
                  FieldCaption("From-Production Bin Code"),
                   Code);
            end;
        }
        field(50037; "Adjustment Bin Code"; Code[20])
        {
            Caption = 'Adjustment Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            begin
                if "Adjustment Bin Code" <> xRec."Adjustment Bin Code" then begin
                    if "Adjustment Bin Code" = '' then
                        CheckEmptyBin(
                          xRec."Adjustment Bin Code", FieldCaption("Adjustment Bin Code"))
                    else
                        CheckEmptyBin(
                          "Adjustment Bin Code", FieldCaption("Adjustment Bin Code"));

                    CheckWhseAdjmtJnl();
                end;
            end;
        }
        field(50038; "Always Create Put-away Line"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Always Create Put-away Line';
        }
        field(50039; "Always Create Pick Line"; Boolean)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Always Create Pick Line';
        }
        field(50040; "Special Equipment"; Option)
        {
            AccessByPermission = TableData "Warehouse Source Filter" = R;
            Caption = 'Special Equipment';
            OptionCaption = ' ,According to Bin,According to SKU/Item';
            OptionMembers = " ","According to Bin","According to SKU/Item";
        }
        field(50041; "Receipt Bin Code"; Code[20])
        {
            Caption = 'Receipt Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));
        }
        field(50042; "Shipment Bin Code"; Code[20])
        {
            Caption = 'Shipment Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));
        }
        field(50043; "Cross-Dock Bin Code"; Code[20])
        {
            Caption = 'Cross-Dock Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));
        }
        field(50044; "To-Assembly Bin Code"; Code[20])
        {
            Caption = 'To-Assembly Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "To-Assembly Bin Code",
                  FieldCaption("To-Assembly Bin Code"),
                 Code);
            end;
        }
        field(50045; "From-Assembly Bin Code"; Code[20])
        {
            Caption = 'From-Assembly Bin Code';
            TableRelation = Bin.Code where("Location Code" = field(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
                  
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "From-Assembly Bin Code",
                  FieldCaption("From-Assembly Bin Code"),
                   Code);
            end;
        }
        field(50046; "Asm.-to-Order Shpt. Bin Code"; Code[20])
        {
            Caption = 'Asm.-to-Order Shpt. Bin Code';
            TableRelation = Bin.Code where("Location Code" = FIELD(Code));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                WhseIntegrationMgt.CheckBinCodeForLocation(Code,
                  "Asm.-to-Order Shpt. Bin Code",
                  FieldCaption("Asm.-to-Order Shpt. Bin Code"),
                  Code);
            end;
        }
        field(50047; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(50048; "Use ADCS"; Boolean)
        {
            AccessByPermission = TableData "Miniform Header" = R;
            Caption = 'Use ADCS';
        }
        field(50049; "Stock Limit"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; "Use As In-Transit", "Bin Mandatory")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        TransferRoute: Record "Transfer Route";
        WhseEmployee: Record "Warehouse Employee";
        WorkCenter: Record "Work Center";
    begin
        WMSCheckWarehouse();

        TransferRoute.SetRange("Transfer-from Code", Code);
        TransferRoute.DeleteAll();
        TransferRoute.Reset();
        TransferRoute.SetRange("Transfer-to Code", Code);
        TransferRoute.DeleteAll();

        WhseEmployee.SetRange("Location Code", Code);
        WhseEmployee.DeleteAll(true);

        WorkCenter.SetRange("Location Code", Code);
        if WorkCenter.FindSet(true) then
            repeat
                WorkCenter.Validate("Location Code", '');
                WorkCenter.Modify(true);
            until WorkCenter.Next() = 0;
    end;

    var
        Bin: Record Bin;
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        Postcode: Record "Post Code";
        WhseSetup: Record "Warehouse Setup";
        Text000: label 'You cannot delete the %1 %2, because they contain items.';
        Text001: label 'You cannot delete the %1 %2, because one or more Warehouse Activity Lines exist for this %1.';
        Text002: label '%1 must be Yes, because the bins contain items.';
        Text003: label 'Cancelled.';
        Text004: label 'The total quantity of items in the warehouse is 0, but the Adjustment Bin contains a negative quantity and other bins contain a positive quantity.\';
        Text005: label 'Do you still want to delete this %1?';
        Text006: label 'You cannot change the %1 until the inventory stored in %2 %3 is 0.';
        Text007: label 'You have to delete all Adjustment Warehouse Journal Lines first before you can change the %1.';
        Text008: label '%1 must be %2, because one or more %3 exist.';
        Text009: label 'You cannot change %1 because there are one or more open ledger entries on this location.';
        Text010: label 'Checking item ledger entries for open entries...';
        Text011: label 'You cannot change the %1 to %2 until the inventory stored in this bin is 0.';
        Text012: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text013: label 'You cannot delete %1 because there are one or more ledger entries on this location.';
        Text014: label 'You cannot change %1 because one or more %2 exist.';

    procedure RequireShipment(LocationCode: Code[10]): Boolean
    begin
        if Location.Get(LocationCode) then
            exit(Location."Require Shipment");
        WhseSetup.Get();
        exit(WhseSetup."Require Shipment");
    end;

    procedure RequirePicking(LocationCode: Code[10]): Boolean
    begin
        if Location.Get(LocationCode) then
            exit(Location."Require Pick");
        WhseSetup.Get();
        exit(WhseSetup."Require Pick");
    end;

    procedure RequireReceive(LocationCode: Code[10]): Boolean
    begin
        if Location.Get(LocationCode) then
            exit(Location."Require Receive");
        WhseSetup.Get();
        exit(WhseSetup."Require Receive");
    end;

    procedure RequirePutaway(LocationCode: Code[10]): Boolean
    begin
        if Location.Get(LocationCode) then
            exit(Location."Require Put-away");
        WhseSetup.Get();
        exit(WhseSetup."Require Put-away");
    end;

    procedure GetLocationSetup(LocationCode: Code[10]; var Location2: Record Location): Boolean
    begin
        if not Get(LocationCode) then begin
            Location2.Init();
            WhseSetup.Get();
            Location2.Code := LocationCode;
            Location2."Use As In-Transit" := false;
            Location2."Require Put-away" := WhseSetup."Require Put-away";
            Location2."Require Pick" := WhseSetup."Require Pick";
            Location2."Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            Location2."Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
            Location2."Require Receive" := WhseSetup."Require Receive";
            Location2."Require Shipment" := WhseSetup."Require Shipment";
            exit(false);
        end;

        //Location2 := Rec;
        exit(true);
    end;

    local procedure WMSCheckWarehouse()
    var
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        ItemLedgerEntry: Record "Item Ledger Entry";
        WhseActivLine: Record "Warehouse Activity Line";
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseEntry2: Record "Warehouse Entry";
        WhseJnlLine: Record "Warehouse Journal Line";
        Zone: Record Zone;
    begin
        ItemLedgerEntry.SetRange("Location Code", Code);
        ItemLedgerEntry.SetRange(Open, true);
        if not ItemLedgerEntry.IsEmpty then
            Error(Text013, Code);

        WarehouseEntry.SetRange("Location Code", Code);
        WarehouseEntry.CalcSums("Qty. (Base)");
        if WarehouseEntry."Qty. (Base)" = 0 then begin
            if "Adjustment Bin Code" <> '' then begin
                WarehouseEntry2.SetRange("Bin Code", "Adjustment Bin Code");
                WarehouseEntry2.SetRange("Location Code", Code);
                WarehouseEntry2.CalcSums("Qty. (Base)");
                if WarehouseEntry2."Qty. (Base)" < 0 then
                    if not Confirm(Text004 + Text005, false, TableCaption) then
                        Error(Text003)
            end;
        end else
            Error(Text000, TableCaption, Code);

        WhseActivLine.SetRange("Location Code", Code);
        WhseActivLine.SetRange("Activity Type", WhseActivLine."activity type"::Movement);
        WhseActivLine.SetFilter("Qty. Outstanding", '<>0');
        if not WhseActivLine.IsEmpty then
            Error(Text001, TableCaption, Code);

        WhseJnlLine.SetRange("Location Code", Code);
        WhseJnlLine.SetFilter(Quantity, '<>0');
        if not WhseJnlLine.IsEmpty then
            Error(Text001, TableCaption, Code);

        Zone.SetRange("Location Code", Code);
        Zone.DeleteAll();
        Bin.SetRange("Location Code", Code);
        Bin.DeleteAll();
        BinContent.SetRange("Location Code", Code);
        BinContent.DeleteAll();
    end;

    local procedure CheckEmptyBin(BinCode: Code[20]; CaptionOfField: Text[30])
    var
        WarehouseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
    begin
        WarehouseEntry.SetCurrentkey("Bin Code", "Location Code", "Item No.");
        WarehouseEntry.SetRange("Bin Code", BinCode);
        WarehouseEntry.SetRange("Location Code", Code);
        if WarehouseEntry.FindFirst() then
            repeat
                WarehouseEntry.SetRange("Item No.", WarehouseEntry."Item No.");

                WhseEntry2.SetCurrentkey("Item No.", "Bin Code", "Location Code");
                WhseEntry2.CopyFilters(WarehouseEntry);
                WhseEntry2.CalcSums("Qty. (Base)");
                if WhseEntry2."Qty. (Base)" <> 0 then begin
                    if (BinCode = "Adjustment Bin Code") and (xRec."Adjustment Bin Code" = '') then
                        Error(Text011, CaptionOfField, BinCode);

                    Error(Text006, CaptionOfField, Bin.TableCaption, BinCode);
                end;

                WarehouseEntry.FindLast();
                WarehouseEntry.SetRange("Item No.");
            until WarehouseEntry.Next() = 0;
    end;

    local procedure CheckWhseAdjmtJnl()
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        WhseJnlTemplate: Record "Warehouse Journal Template";
    begin
        WhseJnlTemplate.SetRange(Type, WhseJnlTemplate.Type::Item);
        if WhseJnlTemplate.Find('-') then
            repeat
                WhseJnlLine.SetRange("Journal Template Name", WhseJnlTemplate.Name);
                WhseJnlLine.SetRange("Location Code", Code);
                if WhseJnlLine.FindFirst() then
                    Error(
                      Text007,
                      FieldCaption("Adjustment Bin Code"));
            until WhseJnlTemplate.Next() = 0;
    end;

    procedure GetRequirementText(FieldNumber: Integer): Text[50]
    var
        Text000: label 'Shipment,Receive,Pick,Put-Away';
    begin
        case FieldNumber of
            FieldNo("Require Shipment"):
                exit(SelectStr(1, Text000));
            FieldNo("Require Receive"):
                exit(SelectStr(2, Text000));
            FieldNo("Require Pick"):
                exit(SelectStr(3, Text000));
            FieldNo("Require Put-away"):
                exit(SelectStr(4, Text000));
        end;
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst() then
            MapMgt.MakeSelection(Database::Location, GetPosition())
        else
            Message(Text012);
    end;

    procedure IsBWReceive(): Boolean
    begin
        exit("Bin Mandatory" and (not "Directed Put-away and Pick") and "Require Receive");
    end;

    procedure IsBWShip(): Boolean
    begin
        exit("Bin Mandatory" and (not "Directed Put-away and Pick") and "Require Shipment");
    end;

    procedure IsBinBWReceiveOrShip(BinCode: Code[20]): Boolean
    begin
        exit(("Receipt Bin Code" <> '') and (BinCode = "Receipt Bin Code") or
          ("Shipment Bin Code" <> '') and (BinCode = "Shipment Bin Code"));
    end;

    procedure IsInTransit(LocationCode: Code[10]): Boolean
    begin
        if Location.Get(LocationCode) then
            exit(Location."Use As In-Transit");
        exit(false);
    end;

    procedure GetBinCode(UseFlushingMethod: Boolean; FlushingMethod: Option Manual,Forward,Backward,"Pick + Forward","Pick + Backward"): Code[20]
    begin
        if not UseFlushingMethod then
            exit("From-Production Bin Code");

        case FlushingMethod of
            Flushingmethod::Manual,
          Flushingmethod::"Pick + Forward",
          Flushingmethod::"Pick + Backward":
                exit("To-Production Bin Code");
            Flushingmethod::Forward,
          Flushingmethod::Backward:
                exit("Open Shop Floor Bin Code");
        end;
    end;
}
