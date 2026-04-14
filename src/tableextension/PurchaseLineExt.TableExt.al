TableExtension 85005 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST("Fixed Asset")) "Fixed Asset" where(Acquired = filter(false));

            trigger OnBeforeValidate()
            begin
                IF Type = Type::"Fixed Asset" THEN
                    if FA.get("No.") then begin
                        if FA.Acquired = true then
                            Error('Create another fixed asset this has already been acquired');
                        IF FAPostSetup.GET(FA."FA Posting Group") THEN
                            "G/L Account" := FAPostSetup."Acquisition Cost Account";
                    end;
            end;

            trigger OnAfterValidate()
            var
                BudgetControl: Record "Budgetary Control Setup";
                Item: Record item;
            begin

                IF Type = Type::Item THEN BEGIN
                    IF Item.GET("No.") THEN BEGIN
                        if BudgetControl.get() then
                            if BudgetControl.Mandatory = true then
                                item.TestField("Item G/L Budget Account");
                        "G/L Account" := Item."Item G/L Budget Account";
                        /*
                          invPostSetup.RESET;
                          invPostSetup.SETRANGE(invPostSetup."Invt. Posting Group Code", Item."Inventory Posting Group");
                          invPostSetup.SETRANGE(invPostSetup."Location Code", "Location Code");
                          IF invPostSetup.FIND('-') THEN
                              "G/L Account" := invPostSetup."Inventory Account";
                              */
                    END;
                END ELSE
                    IF Type = Type::"Fixed Asset" THEN BEGIN
                        if FA.get("No.") then begin
                            if FA.Acquired = true then
                                Error('Create another fixed asset this has aleady been acquired');
                            IF FAPostSetup.GET(FA."FA Posting Group") THEN
                                "G/L Account" := FAPostSetup."Acquisition Cost Account";
                        end;
                    END ELSE
                        IF Type = Type::"G/L Account" THEN
                            "G/L Account" := "No.";
                //End Budget

                //----------

                BudgetAmount := 0;

                BCSetup.RESET();
                BCSetup.GET();
                IF BCSetup.Mandatory THEN//budgetary control is mandatory
                  BEGIN
                    BudgetAmount := 0;
                    Budget.RESET();
                    Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
                    Budget.SETFILTER(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                    Budget.SETRANGE(Budget."G/L Account No.", "G/L Account");
                    Budget.SETRANGE(Budget."Global Dimension 1 Code", "Shortcut Dimension 1 Code");
                    // IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                    Budget.SETRANGE(Budget."Global Dimension 2 Code", "Shortcut Dimension 2 Code");
                    IF Budget.FIND('-') THEN
                        REPEAT
                            BudgetAmount := BudgetAmount + Budget.Amount;
                        UNTIL Budget.NEXT() = 0;
                END;

                "Budgeted Amount" := BudgetAmount;

                //Committment
                CommitmentAmount := 0;
                Commitments.RESET();
                Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
                Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code");
                Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
                Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", Purchline."Shortcut Dimension 1 Code");
                //                    IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", Purchline."Shortcut Dimension 2 Code");
                IF Commitments.FIND('-') THEN BEGIN
                    Commitments.CALCSUMS(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;
                END;

                "Committed Amount" := CommitmentAmount;
            end;
        }
        modify("FA Posting Type")
        {
            OptionCaption = ' ,Acquisition Cost,Maintenance';

            //Unsupported feature: Property Modification (OptionString) on ""FA Posting Type"(Field 5601)".
        }
        modify(Description)
        {
            trigger OnBeforeValidate()
            begin
                If Type <> Type::"G/L Account" then
                    Error('Description cannot be edited');
            end;

            trigger OnAfterValidate()
            begin
                If Type <> Type::"G/L Account" then
                    Error('Description cannot be edited');
            end;
        }
        modify(Nonstock)
        {
            Caption = 'Nonstock';
        }

        //Unsupported feature: Property Modification (ObsoleteState) on ""Product Group Code"(Field 5712)".

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".

        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchSetup;
        IF PurchSetup."Create Item from Item No." THEN
          "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestStatusOpen;
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
        #7..25
            Text044,
            FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

        OnValidateNoOnAfterChecks(Rec,xRec,CurrFieldNo);

        IF "No." <> xRec."No." THEN BEGIN
          IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
            ReservePurchLine.VerifyChange(Rec,xRec);
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)",0);
            IF Type = Type::Item THEN
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            OnValidateNoOnAfterVerifyChange(Rec,xRec);
          END;
          IF Type = Type::Item THEN
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          IF Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        END;

        OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
        TempPurchLine := Rec;
        INIT;
        IF xRec."Line Amount" <> 0 THEN
        #50..90

        IF HasTypeToFillMandatoryFields THEN BEGIN
          Quantity := xRec.Quantity;
          OnValidateNoOnAfterAssignQtyFromXRec(Rec,TempPurchLine);
          VALIDATE("Unit of Measure Code");
          IF Quantity <> 0 THEN BEGIN
            InitOutstanding;
        #98..111
          END;
        END;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");

        PurchHeader.GET("Document Type","Document No.");
        UpdateItemReference;
        #123..125
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
          UpdateDimensionsFromJobTask;
        END;

        PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");
        #4..28
        #31..37
        #39..44
        #47..93
        #95..114
        IF NOT ISTEMPORARY THEN
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");
        #120..128
        #130..133

        //Budget
        IF Type = Type::Item THEN BEGIN
          IF Item_.GET("No.") THEN BEGIN
             invPostSetup.RESET;
             invPostSetup.SETRANGE(invPostSetup."Invt. Posting Group Code",Item_."Inventory Posting Group");
             invPostSetup.SETRANGE(invPostSetup."Location Code","Location Code");
             IF invPostSetup.FIND('-') THEN
               "G/L Account" := invPostSetup."Inventory Account";
          END;
        END ELSE IF Type = Type::"Fixed Asset" THEN BEGIN
          IF FAPostSetup.GET(FA."FA Posting Group") THEN
               "G/L Account" := FAPostSetup."Acquisition Cost Account";
        END ELSE IF Type = Type::"G/L Account" THEN BEGIN
           "G/L Account" := "No.";
        END;
        //End Budget

        //----------

        BudgetAmount:=0;

        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.","G/L Account");
            Budget.SETRANGE(Budget."Global Dimension 1 Code","Shortcut Dimension 1 Code");
          // IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
            Budget.SETRANGE(Budget."Global Dimension 2 Code","Shortcut Dimension 2 Code");
              IF Budget.FIND('-') THEN BEGIN
              REPEAT
              BudgetAmount:=BudgetAmount+Budget.Amount;
              UNTIL Budget.NEXT=0;
              END;
        END;

        "Budgeted Amount" := BudgetAmount;

        //Committment
                      CommitmentAmount:=0;
                      Commitments.RESET;
                      Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                      Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code");
                      Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                      Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                      Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                      Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",Purchline."Shortcut Dimension 1 Code");
        //                    IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                      Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",Purchline."Shortcut Dimension 2 Code");
                      IF Commitments.FIND('-') THEN BEGIN
                          Commitments.CALCSUMS(Commitments.Amount);
                          CommitmentAmount:= Commitments.Amount;
                      END;

        "Committed Amount" := CommitmentAmount;

        //Committemtn
        //----------
        */
        //end;

        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Location Code" <> '' THEN
          IF IsNonInventoriableItem THEN BEGIN
            GetItem(Item);
            Item.TESTFIELD(Type,Item.Type::Inventory);
          END;
        IF xRec."Location Code" <> "Location Code" THEN BEGIN
          IF "Prepmt. Amt. Inv." <> 0 THEN
            IF NOT ConfirmManagement.ConfirmProcess(
                 STRSUBSTNO(
                   Text046,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL),TRUE)
            THEN BEGIN
              "Location Code" := xRec."Location Code";
              EXIT;
            END;
          TESTFIELD("Qty. Rcd. Not Invoiced",0);
          TESTFIELD("Receipt No.",'');

          TESTFIELD("Return Qty. Shipped Not Invd.",0);
          TESTFIELD("Return Shipment No.",'');
        END;

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Sales Order No.");
        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Special Order Sales No.");

        IF "Location Code" <> xRec."Location Code" THEN
          InitItemAppl;

        IF (xRec."Location Code" <> "Location Code") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          UpdateWithWarehouseReceive;
          PostingSetupMgt.CheckInvtPostingSetupInventoryAccount("Location Code","Posting Group");
        END;
        "Bin Code" := '';

        IF Type = Type::Item THEN
          UpdateDirectUnitCost(FIELDNO("Location Code"));

        IF "Location Code" = '' THEN BEGIN
          IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        END ELSE
          IF Location.GET("Location Code") THEN
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";

        UpdateLeadTimeFields;
        UpdateDates;

        GetDefaultBin;
        CheckWMS;

        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          IF IsServiceItem THEN
            Item.TESTFIELD(Type,Item.Type::Inventory);
        IF xRec."Location Code" <> "Location Code" THEN BEGIN
          IF "Prepmt. Amt. Inv." <> 0 THEN
            IF NOT CONFIRM(Text046,FALSE,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL) THEN BEGIN
        #14..61

        //Budget Start
        //Budget
        IF Type = Type::Item THEN BEGIN
          IF Item_.GET("No.") THEN BEGIN
             invPostSetup.RESET;
             invPostSetup.SETRANGE(invPostSetup."Invt. Posting Group Code",Item_."Inventory Posting Group");
             invPostSetup.SETRANGE(invPostSetup."Location Code","Location Code");
             IF invPostSetup.FIND('-') THEN
               "G/L Account" := invPostSetup."Inventory Account";
          END;
        END ELSE IF Type = Type::"Fixed Asset" THEN BEGIN
          IF FAPostSetup.GET(FA."FA Posting Group") THEN
               "G/L Account" := FAPostSetup."Acquisition Cost Account";
        END ELSE IF Type = Type::"G/L Account" THEN BEGIN
           "G/L Account" := "No.";
        END;
        //End Budget

        //----------

        BudgetAmount:=0;

        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.","G/L Account");
            Budget.SETRANGE(Budget."Global Dimension 1 Code","Shortcut Dimension 1 Code");
          // IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
            Budget.SETRANGE(Budget."Global Dimension 2 Code","Shortcut Dimension 2 Code");
              IF Budget.FIND('-') THEN BEGIN
              REPEAT
              BudgetAmount:=BudgetAmount+Budget.Amount;
              UNTIL Budget.NEXT=0;
              END;
        END;

        "Budgeted Amount" := BudgetAmount;

        //Committment
                      CommitmentAmount:=0;
                      Commitments.RESET;
                      Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                      Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code");
                      Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                      Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                      Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                      Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",Purchline."Shortcut Dimension 1 Code");
        //                    IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                      Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",Purchline."Shortcut Dimension 2 Code");
                      IF Commitments.FIND('-') THEN BEGIN
                          Commitments.CALCSUMS(Commitments.Amount);
                          CommitmentAmount:= Commitments.Amount;
                      END;

        "Committed Amount" := CommitmentAmount;

        //Committemtn
        //----------
        //Budget End
        */
        //end;

        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

        IF "Expected Receipt Date" <> 0D THEN
          VALIDATE(
            "Planned Receipt Date",
            CalendarMgmt.CalcDateBOC2(ReversedInternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
              CalChange."Source Type"::Location,"Location Code",'',
              CalChange."Source Type"::Location,"Location Code",'',FALSE))
        ELSE
          VALIDATE("Planned Receipt Date","Expected Receipt Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
            CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
        #8..11
        */
        //end;

        //Unsupported feature: Code Modification on "Description(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::" " THEN
          EXIT;

        IF ("No." <> '') AND (Type IN [Type::Item,Type::"Charge (Item)"]) THEN BEGIN
          CASE Type OF
            Type::Item:
              BEGIN
                IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
                  DescriptionIsNo := Item.GET(Description)
                ELSE
                  DescriptionIsNo := FALSE;

        #13..17
                    EXIT;
                  IF IsReceivedFromOcr THEN
                    EXIT;
                  IF ConfirmManagement.ConfirmProcess(
                       STRSUBSTNO(AnotherItemWithSameDescrQst,Item."No.",Item.Description),TRUE)
                  THEN
                    VALIDATE("No.",Item."No.");
                  EXIT;
                END;
        #27..39
                  EXIT;
                IF ItemCharge."No." = "No." THEN
                  EXIT;
                IF ConfirmManagement.ConfirmProcess(
                     STRSUBSTNO(AnotherChargeItemWithSameDescQst,ItemCharge."No.",ItemCharge.Description),TRUE)
                THEN
                  VALIDATE("No.",ItemCharge."No.");
              END;
          END;
        END ELSE
          IF "No." = '' THEN BEGIN
            ReturnValue := FindRecordMgt.FindNoByDescription(Type,Description,TRUE);
            IF ReturnValue <> '' THEN BEGIN
              CurrFieldNo := FIELDNO("No.");
              VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
            END;
          END;

        IF ("No." = '') AND GUIALLOWED AND ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          IF "Document Type" IN ["Document Type"::Order] THEN
            ERROR(CannotFindDescErr,Type,Description);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
                 // DescriptionIsNo := Item.GET(Description)
                  DescriptionIsNo := Item.GET(Item."Search Description")
        #10..20
                  IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
        #24..42
                IF CONFIRM(AnotherChargeItemWithSameDescQst,FALSE,ItemCharge."No.",ItemCharge.Description) THEN
        #46..49
          IF "No." = '' THEN
            IF FindRecordMgt.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
        #53..55

        IF ("No." = '') AND GUIALLOWED AND ApplicationAreaSetup.IsFoundationEnabled THEN
          IF "Document Type" IN ["Document Type"::Order] THEN
            ERROR(STRSUBSTNO(CannotFindDescErr,Type,Description));
        */
        //end;

        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IsHandled := FALSE;
        OnValidateQuantityOnBeforeDropShptCheck(Rec,xRec,CurrFieldNo,IsHandled);
        IF NOT IsHandled THEN
          IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
            ERROR(
              Text001,FIELDCAPTION(Quantity),"Sales Order No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          IF (Quantity * "Return Qty. Shipped" < 0) OR
        #11..85
        END;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
          ERROR(
            Text001,
            FIELDCAPTION(Quantity),"Sales Order No.");
        #8..88
        */
        //end;

        //Unsupported feature: Code Modification on ""Qty. to Receive"(Field 18).OnValidate".

        //trigger  to Receive"(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND (NOT "Drop Shipment") THEN BEGIN
          IF Location."Require Receive" AND ("Qty. to Receive" <> 0) THEN
            CheckWarehouse;
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        END;
        OnValidateQtyToReceiveOnAfterCheck(Rec,CurrFieldNo);

        IF "Qty. to Receive" = Quantity - "Quantity Received" THEN
          InitQtyToReceive
        #11..31

        IF "Job Planning Line No." <> 0 THEN
          VALIDATE("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetLocation("Location Code");
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           (NOT "Drop Shipment")
        THEN BEGIN
          IF Location."Require Receive" AND
             ("Qty. to Receive" <> 0)
          THEN
        #4..6
        #8..34
        */
        //end;

        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("No.");
        TESTFIELD(Quantity);
        #4..8

        IF CurrFieldNo = FIELDNO("Unit Cost (LCY)") THEN
          IF Type = Type::Item THEN BEGIN
            GetItem(Item);
            IF Item."Costing Method" = Item."Costing Method"::Standard THEN
              ERROR(
                Text010,
        #16..28
              GLSetup."Unit-Amount Rounding Precision");
        END;

        "Indirect Cost %" := 0;
        IF ("Direct Unit Cost" <> 0) AND
           ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
        THEN BEGIN
          IndirectCostPercent :=
            ROUND(
              (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
              ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001);
          IF IndirectCostPercent >= 0 THEN
            "Indirect Cost %" := IndirectCostPercent;
        END;

        UpdateSalesCost;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
            GetItem;
        #13..31
        #33..39
          IF IndirectCostPercentCheck(IndirectCostPercent) THEN
            "Indirect Cost %" := IndirectCostPercent
          ELSE
            ERROR(CannotBeNegativeErr,FIELDCAPTION("Indirect Cost %"));
        END ELSE
          "Indirect Cost %" := 0;
        #43..50
        */
        //end;

        //Unsupported feature: Code Modification on ""Line Discount %"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateLineDiscountPercent(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        GetPurchHeader;
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
            "Line Discount %" / 100,
            Currency."Amount Rounding Precision");
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;

        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          UpdateLineDiscPct;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" /
                ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
                0.00001)
          ELSE
            "Line Discount %" := 0;
        #7..10
        */
        //end;

        //Unsupported feature: Code Modification on ""Indirect Cost %"(Field 54).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("No.");
        TestStatusOpen;

        IF Type = Type::"Charge (Item)" THEN
          TESTFIELD("Indirect Cost %",0);

        IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
          GetItem(Item);
          Item.TESTFIELD(Type,Item.Type::Inventory);
          IF Item."Costing Method" = Item."Costing Method"::Standard THEN
            ERROR(
              Text010,
              FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
        END;

        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          GetItem;
        #10..16
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Order No."(Field 65)".

        //Unsupported feature: Deletion (FieldCollection) on ""Order Line No."(Field 66)".

        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        IF "Blanket Order Line No." <> 0 THEN BEGIN
          PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          PurchLine2.TESTFIELD(Type,Type);
          PurchLine2.TESTFIELD("No.","No.");
          PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
          PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
          IF "Drop Shipment" THEN BEGIN
            PurchLine2.TESTFIELD("Variant Code","Variant Code");
            PurchLine2.TESTFIELD("Location Code","Location Code");
            PurchLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
          END ELSE BEGIN
            VALIDATE("Variant Code",PurchLine2."Variant Code");
            VALIDATE("Location Code",PurchLine2."Location Code");
            VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
          END;
          VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
          VALIDATE("Line Discount %",PurchLine2."Line Discount %");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          VALIDATE("Variant Code",PurchLine2."Variant Code");
          VALIDATE("Location Code",PurchLine2."Location Code");
          VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
        #17..19
        */
        //end;

        //Unsupported feature: Code Modification on ""IC Partner Ref. Type"(Field 107).OnValidate".

        //trigger  Type"(Field 107)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Partner Code" <> '' THEN
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        IF "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" THEN
          "IC Partner Reference" := '';
        IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN BEGIN
          GetItem(Item);
          Item.TESTFIELD("Common Item No.");
          "IC Partner Reference" := Item."Common Item No.";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          IF Item."No." <> "No." THEN
            Item.GET("No.");
        #7..9
        */
        //end;

        //Unsupported feature: Code Modification on ""Prepayment %"(Field 109).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePrepmtSetupFields;

        IF HasTypeToFillMandatoryFields THEN
          UpdateAmounts;
        UpdateBaseAmounts(Amount,"Amount Including VAT","VAT Base Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Pmt. Discount Amount"(Field 145)".

        //Unsupported feature: Code Modification on ""Variant Code"(Field 5402).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" <> '' THEN
          TESTFIELD(Type,Type::Item);
        TestStatusOpen;
        #4..26
        UpdateLeadTimeFields;
        UpdateDates;
        GetDefaultBin;
        IF Type = Type::Item THEN
          UpdateItemReference;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..29
        UpdateItemReference;
        #32..36
        */
        //end;

        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Qty. Received (Base)",0);
        #4..11
          ERROR(
            Text001,
            FIELDCAPTION("Unit of Measure Code"),"Sales Order No.");
        IF (xRec."Unit of Measure Code" <> "Unit of Measure Code") AND (Quantity <> 0) THEN
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        UpdateDirectUnitCost(FIELDNO("Unit of Measure Code"));
        IF "Unit of Measure Code" = '' THEN
        #19..27
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          END;
        END;
        IF Type = Type::Item THEN
          UpdateItemReference;
        IF "Prod. Order No." = '' THEN BEGIN
          IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            GetItem(Item);
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
            "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
        #39..47
          "Qty. per Unit of Measure" := 0;

        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
        IF (xRec."Unit of Measure" <> "Unit of Measure") AND (Quantity <> 0) THEN
        #16..30
        UpdateItemReference;
        IF "Prod. Order No." = '' THEN BEGIN
          IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            GetItem;
        #36..50
        */
        //end;

        //Unsupported feature: Code Insertion (VariableCollection) on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger (Variable: ReturnedCrossRef)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;

        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
        ValidateCrossReferenceNo(ItemCrossReference,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";

        ReturnedCrossRef.INIT;
        IF "Cross-Reference No." <> '' THEN BEGIN
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef);
          VALIDATE("No.",ReturnedCrossRef."Item No.");
          SetVendorItemNo;
          IF ReturnedCrossRef."Variant Code" <> '' THEN
            VALIDATE("Variant Code",ReturnedCrossRef."Variant Code");
          IF ReturnedCrossRef."Unit of Measure" <> '' THEN
            VALIDATE("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
          UpdateDirectUnitCost(FIELDNO("Cross-Reference No."));
        END;

        "Unit of Measure (Cross Ref.)" := ReturnedCrossRef."Unit of Measure";
        "Cross-Reference Type" := ReturnedCrossRef."Cross-Reference Type";
        "Cross-Reference Type No." := ReturnedCrossRef."Cross-Reference Type No.";
        "Cross-Reference No." := ReturnedCrossRef."Cross-Reference No.";

        IF ReturnedCrossRef.Description <> '' THEN
          Description := ReturnedCrossRef.Description;

        UpdateICPartner;
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Copied From Posted Doc."(Field 6610)".

        //Unsupported feature: Deletion (FieldCollection) on ""Attached Doc Count"(Field 7010)".

        field(50100; Committed; Boolean)
        {
            Editable = true;
        }
        field(50101; "Vote Book"; Code[10])
        {
        }
        field(50102; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code".code;
        }
        field(50103; "RFQ No."; Code[20])
        {
            Description = 'ADDED THIS FIELD';
        }
        field(50104; "RFQ Line No."; Integer)
        {
            Description = 'ADDED THIS FIELD';
            // TableRelation = "Student Charges".Code;
        }
        field(50105; Select; Boolean)
        {
        }
        field(50106; "RFQ Created"; Boolean)
        {
        }
        field(50107; "Project Code"; Code[10])
        {
            // CalcFormula = lookup ("Purchase Header"."Budget Name" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50108; Status; Option)
        {
            CalcFormula = lookup("Purchase Header".Status where("No." = field("Document No."),
                                                                 "Document Type" = field("Document Type")));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(50109; "Asset No."; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(50110; "Document Type 2"; Option)
        {
            OptionMembers = Requisition,Quote,"Order";
        }
        field(50111; "Procurement Plan Item No"; Code[20])
        {
            TableRelation = "Procurement Plan Lines"."Type No" where(Department = field("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin
                TestField("Shortcut Dimension 2 Code");
                PrPlan.Reset();
                PrPlan.SetRange(PrPlan.Department, "Shortcut Dimension 2 Code");
                PrPlan.SetRange(PrPlan."Type No", "Procurement Plan Item No");
                if PrPlan.Find('-') then begin
                    if Quantity > PrPlan."Remaining Qty" then
                        Error('The selected items is more than items on procurement plan');
                    PrPlan."Remaining Qty" := PrPlan."Remaining Qty" - Quantity;
                    PrPlan.Modify();
                end;
            end;
        }
        field(50112; "Request for Quote No."; Code[20])
        {
            // CalcFormula = lookup ("Purchase Header"."Budget Name" where("Document Type" = field("Document Type"),
            //                                                             "No." = field("Document No.")));
            FieldClass = FlowField;
            TableRelation = "Purchase Quote Header"."No.";

            trigger OnValidate()
            begin
                /*   //CHECK WHETHER HAS LINES AND DELETE
                 IF NOT CONFIRM('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?',FALSE)
                 THEN
                     ERROR('You have selected to abort the process') ;

                     PurchLine.RESET;
                     PurchLine.SETRANGE(PurchLine."Document No.","No.");
                     PurchLine.DELETEALL;

                 RFQ.RESET;
                 RFQ.SETRANGE(RFQ."Document No.","Request for Quote No.");
                 IF RFQ.FIND('-') THEN BEGIN
                   REPEAT
                       PurchLine.INIT;
                       PurchLine."Document Type":="Document Type";
                       PurchLine."Document No.":="No.";
                       PurchLine."Line No.":=RFQ."Line No.";
                       PurchLine.Type:=RFQ.Type;
                       PurchLine."Document Type 2":="Document Type 2";
                       PurchLine."No.":=RFQ."No.";
                       PurchLine.VALIDATE("No.");
                       PurchLine."Location Code":=RFQ."Location Code";
                       PurchLine.VALIDATE("Location Code");
                       PurchLine.Quantity:=RFQ.Quantity;
                       PurchLine.VALIDATE(Quantity);
                       PurchLine."Direct Unit Cost":=RFQ."Direct Unit Cost";
                       PurchLine.VALIDATE("Direct Unit Cost");
                       PurchLine.Amount:=RFQ.Amount;
                       PurchLine.INSERT;
                   UNTIL RFQ.NEXT=0;
                 END;
                */
            end;
        }
        field(50113; "Line Created"; Boolean)
        {
        }
        field(50114; "Budgeted Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50115; "Actual Expenditure"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("G/L Account"),
                                                        "Global Dimension 1 Code" = field("Shortcut Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50116; "Committed Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50117; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50118; "Budget Balance"; Decimal)
        {
        }
        field(50119; "Description 3"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Description 2")));
            FieldClass = FlowField;
        }
        field(50120; "Reason for Request"; Code[800])
        {
        }
        field(50121; "RFQ Remarks"; Text[50])
        {
        }
        field(50122; "Requisition No"; Code[20])
        {
        }
        field(50123; "Expiry Date"; Date)
        {
        }
        field(50124; "Manually Added"; Boolean)
        {
        }
        field(50126; "Procurement Type Code"; Code[20])
        {
            // TableRelation = "prEmployee Trans PCA";
        }
        field(50127; "Manual Requisition No"; Code[20])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Quote),
                                                           Status = const(Released));

            trigger OnValidate()
            begin
                "Manually Added" := true;
            end;
        }
        field(50128; "PO Number Track"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "G/L Account"; Code[10])
        {
            FieldClass = Normal;
        }
        field(50125; "Patient No"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "HMS Patient"."Patient No.";
        }
    }

    var

    var
        BCSetup: Record "Budgetary Control Setup";
        Commitments: Record Committment;
        FAPostSetup: Record "FA Posting Group";
        FA: Record "Fixed Asset";
        Budget: Record "G/L Budget Entry";
        PrPlan: Record "Procurement Plan Lines";
        Purchline: Record "Purchase Line";
        BudgetGL: Code[20];
        LastDay: Date;
        BudgetAmount: Decimal;
        CommitmentAmount: Decimal;
}
