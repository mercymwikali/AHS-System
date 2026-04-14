TableExtension 85018 "Vendor Ext" extends Vendor
{
    DrillDownPageId = "Vendor List.";
    //Unsupported feature: Property Modification (Permissions) on "Vendor(Table 23)".

    LookupPageID = "Vendor List.";
    fields
    {
        //Unsupported feature: Property Modification (Data type) on ""No."(Field 1)".

        //Unsupported feature: Property Modification (Data type) on "Name(Field 2)".

        //Unsupported feature: Property Modification (Data type) on ""Search Name"(Field 3)".

        //Unsupported feature: Property Modification (Data type) on "Address(Field 5)".

        //Unsupported feature: Property Modification (Data type) on ""Address 2"(Field 6)".

        //Unsupported feature: Property Modification (Data type) on ""Phone No."(Field 9)".

        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due"(Field 66)".

        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due (LCY)"(Field 67)".

        //Unsupported feature: Property Insertion (Numeric) on ""Creditor No."(Field 170)".

        //Unsupported feature: Deletion on "City(Field 7).OnLookup".

        //Unsupported feature: Code Modification on "Contact(Field 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Vendor,"No.") THEN
          Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        ELSE
          Cont.SETRANGE("Company No.",'');

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          TempVend.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempVend,FALSE);
          VALIDATE("Primary Contact No.",Cont."No.");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;

        //Unsupported feature: Deletion on ""Phone No."(Field 9).OnValidate".

        //Unsupported feature: Deletion on ""Purchaser Code"(Field 29).OnValidate".

        //Unsupported feature: Code Modification on ""Country/Region Code"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");

        IF "Country/Region Code" <> xRec."Country/Region Code" THEN
          VATRegistrationValidation;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCountryCode(City,"Post Code",County,"Country/Region Code");
        IF "Country/Region Code" <> xRec."Country/Region Code" THEN
          VATRegistrationValidation;
        */
        //end;

        //Unsupported feature: Deletion on "Blocked(Field 39).OnValidate".

        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 82).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.","No.");
        IF PurchPrice.FIND('-') THEN BEGIN
          IF VATPostingSetup.GET('','') THEN;
          IF ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(
                 Text002,
                 FIELDCAPTION("Prices Including VAT"),"Prices Including VAT",PurchPrice.TABLECAPTION),TRUE)
        #9..33
              END;
            UNTIL PurchPrice.NEXT = 0;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          IF CONFIRM(
        #6..36
        */
        //end;

        //Unsupported feature: Property Deletion (ObsoleteState) on "Picture(Field 89)".

        //Unsupported feature: Property Deletion (ObsoleteReason) on "Picture(Field 89)".

        //Unsupported feature: Deletion on ""Post Code"(Field 91).OnLookup".

        //Unsupported feature: Property Deletion (CaptionClass) on "County(Field 92)".

        //Unsupported feature: Code Modification on ""E-Mail"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        MailManagement.ValidateEmailAddressField("E-Mail");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //MailManagement.ValidateEmailAddressField("E-Mail");
        */
        //end;

        //Unsupported feature: Code Modification on ""IC Partner Code"(Field 119).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
          IF NOT VendLedgEntry.SETCURRENTKEY("Vendor No.",Open) THEN
            VendLedgEntry.SETCURRENTKEY("Vendor No.");
        #4..12
          IF AccountingPeriod.FINDFIRST THEN BEGIN
            VendLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
            IF VendLedgEntry.FINDFIRST THEN
              IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text009,TABLECAPTION),TRUE) THEN
                "IC Partner Code" := xRec."IC Partner Code";
          END;
        END;
        #20..29
          ICPartner."Vendor No." := '';
          ICPartner.MODIFY;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15
              IF NOT CONFIRM(Text009,FALSE,TABLECAPTION) THEN
        #17..32
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Privacy Blocked"(Field 150)".

        //Unsupported feature: Deletion (FieldCollection) on ""Disable Search by Name"(Field 160)".

        //Unsupported feature: Code Modification on ""Primary Contact No."(Field 5049).OnValidate".

        //trigger "(Field 5049)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Contact := '';
        IF "Primary Contact No." <> '' THEN BEGIN
          Cont.GET("Primary Contact No.");

          ContBusRel.FindOrRestoreContactBusinessRelation(Cont,Rec,ContBusRel."Link to Table"::Vendor);

          IF Cont."Company No." <> ContBusRel."Contact No." THEN
            ERROR(Text004,Cont."No.",Cont.Name,"No.",Name);
        #9..14
          IF Cont."E-Mail" <> '' THEN
            "E-Mail" := Cont."E-Mail";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          ContBusRel.SETCURRENTKEY("Link to Table","No.");
          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
          ContBusRel.SETRANGE("No.","No.");
          ContBusRel.FINDFIRST;
        #6..17
        */
        //end;
        field(50103; "Vendor Credit Limit(LCY)"; Decimal)
        {
        }
        field(50104; "Requisition Default Vendor"; Boolean)
        {
        }
        field(50105; "Vendor Retention Account"; Code[20])
        {
            TableRelation = Vendor."No." where(Retention = const(true));
        }
        field(50106; Retention; Boolean)
        {
        }
        field(50107; "PIN No."; Code[20])
        {
        }
        field(50108; "Vendor Bank Account"; Code[20])
        {
        }
        field(50109; "Vendor Bank Branch Code"; Code[20])
        {
        }
        field(50110; "AGPO No"; Code[50])
        {
        }
        field(50111; "Vendor Type"; Option)
        {
            OptionCaption = ' ,Implementing Partner,Goods,Services,Contract,Goods & Services';
            OptionMembers = " ","Implementing Partner",Goods,Services,Contract,"Goods & Services";

            trigger OnValidate()
            begin

                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Vendor Type"));
            end;
        }
        field(50112; "Property Code"; Code[30])
        {
            TableRelation = "Request For Qoute Line"."Line No";
        }
        field(50113; "Employee Responsible"; Code[30])
        {
        }
        field(50114; "Landlord No."; Code[10])
        {
            trigger OnValidate()
            begin
                /*//generates Landlords No(for property)
                IF "Landlord No." <> xRec."Landlord No." THEN BEGIN
                  GenSetup.GET;
                  NoSeriesMgt.TestManual(GenSetup."Landlord Nos.");
                  "No. Series" := '';
                END;
                 */
            end;
        }
        field(50115; No2; Code[20])
        {
        }
        field(50116; "No. of Vendor Cateories"; Integer)
        {
            Editable = false;
        }
        field(50117; "Main Sub/Sub"; Option)
        {
            Caption = 'Main Sub/Sub';
            Editable = false;
            OptionCaption = ' ,Main Sub,Sub';
            OptionMembers = " ","Main Sub",Sub;
        }
        field(50118; Sub; Code[20])
        {
            Caption = 'Sub Of Sub';
            Editable = false;
            TableRelation = Vendor;
        }
        field(50119; "Compliance Passed"; Boolean)
        {
        }
        field(50100; "Vendor Category"; code[20])
        {
            TableRelation = "Vendor Category";
        }
        field(50101; "Street"; Text[250])
        {
        }
        field(50102; "Building"; Text[250])
        {
        }
    }

    keys
    {
        //Unsupported feature: Deletion (KeyCollection) on "Blocked(Key)".
    }

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);

    MoveEntries.MoveVendorEntries(Rec);
    #4..17
    ItemCrossReference.DELETEALL;

    PurchOrderLine.SETCURRENTKEY("Document Type","Pay-to Vendor No.");
    PurchOrderLine.SETRANGE("Pay-to Vendor No.","No.");
    IF PurchOrderLine.FINDFIRST THEN
      ERROR(
    #24..63
    PurchPrepmtPct.DELETEALL(TRUE);

    VATRegistrationLogMgt.DeleteVendorLog(Rec);

    IntrastatSetup.CheckDeleteIntrastatContact(IntrastatSetup."Intrastat Contact Type"::Vendor,"No.");

    CalendarManagement.DeleteCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Vendor,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
    PurchOrderLine.SETFILTER(
      "Document Type",'%1|%2',
      PurchOrderLine."Document Type"::Order,
      PurchOrderLine."Document Type"::"Return Order");
    #21..66
    */
    //end;

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      PurchSetup.GET;
      PurchSetup.TESTFIELD("Vendor Nos.");
    #4..16
      DATABASE::Vendor,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");

    UpdateReferencedIds;
    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF UserRec.GET(DATABASE.USERID) THEN BEGIN
      IF UserRec."Can Create Vendor"=FALSE THEN ERROR('Please note that you dont have the rights create the vendor');
    END ELSE BEGIN ERROR('Please note that you dont have the rights create the vendor');
    END;

    #1..19
    SetLastModifiedDateTime;
    */
    //end;

    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateReferencedIds;
    SetLastModifiedDateTime;

    IF IsContactUpdateNeeded THEN BEGIN
      MODIFY;
      UpdateContFromVend.OnModify(Rec);
      IF NOT FIND THEN BEGIN
        RESET;
        IF FIND THEN;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetLastModifiedDateTime;
    #4..11
    */
    //end;

    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnRenameRecordInApprovalRequest(xRec.RECORDID,RECORDID);
    DimMgt.RenameDefaultDim(DATABASE::Vendor,xRec."No.","No.");
    SetLastModifiedDateTime;
    IF xRec."Invoice Disc. Code" = xRec."No." THEN
      "Invoice Disc. Code" := "No.";

    CalendarManagement.RenameCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Vendor,"No.",xRec."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ApprovalsMgmt.OnRenameRecordInApprovalRequest(xRec.RECORDID,RECORDID);
    #3..5
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".

    //Unsupported feature: Code Modification on "ShowContact(PROCEDURE 1)".

    //procedure ShowContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OfficeMgt.GetContact(OfficeContact,"No.") AND (OfficeContact.COUNT = 1) THEN
      PAGE.RUN(PAGE::"Contact Card",OfficeContact)
    ELSE BEGIN
    #4..7
      ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
      ContBusRel.SETRANGE("No.","No.");
      IF NOT ContBusRel.FINDFIRST THEN BEGIN
        IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text003,TABLECAPTION,"No."),TRUE) THEN
          EXIT;
        UpdateContFromVend.InsertNewContact(Rec,FALSE);
        ContBusRel.FINDFIRST;
    #15..18
      Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
      PAGE.RUN(PAGE::"Contact List",Cont);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
        IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
    #12..21
    */
    //end;

    //Unsupported feature: Code Modification on "CheckBlockedVendOnDocs(PROCEDURE 4)".

    //procedure CheckBlockedVendOnDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Vend2."Privacy Blocked" THEN
      VendPrivacyBlockedErrorMessage(Vend2,Transaction);

    IF Vend2.Blocked = Vend2.Blocked::All THEN
      VendBlockedErrorMessage(Vend2,Transaction);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Vend2.Blocked = Vend2.Blocked::All THEN
      VendBlockedErrorMessage(Vend2,Transaction);
    */
    //end;

    //Unsupported feature: Code Modification on "CheckBlockedVendOnJnls(PROCEDURE 5)".

    //procedure CheckBlockedVendOnJnls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH Vend2 DO BEGIN
      IF "Privacy Blocked" THEN
        VendPrivacyBlockedErrorMessage(Vend2,Transaction);

      IF (Blocked = Blocked::All) OR
         (Blocked = Blocked::Payment) AND (DocType = DocType::Payment)
      THEN
        VendBlockedErrorMessage(Vend2,Transaction);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH Vend2 DO BEGIN
    #5..9
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".

    //Unsupported feature: Code Modification on "IsContactUpdateNeeded(PROCEDURE 48)".

    //procedure IsContactUpdateNeeded();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateNeeded :=
      (Name <> xRec.Name) OR
      ("Search Name" <> xRec."Search Name") OR
    #4..19
      ("E-Mail" <> xRec."E-Mail") OR
      ("Home Page" <> xRec."Home Page");

    IF NOT UpdateNeeded AND NOT ISTEMPORARY THEN
      UpdateNeeded := VendContUpdate.ContactNameIsBlank("No.");

    OnBeforeIsContactUpdateNeeded(Rec,xRec,UpdateNeeded);
    EXIT(UpdateNeeded);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
    OnBeforeIsContactUpdateNeeded(Rec,xRec,UpdateNeeded);
    EXIT(UpdateNeeded);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAddress(PROCEDURE 40)".

    //Unsupported feature: Property Deletion (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".

    //Unsupported feature: Property Deletion (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".

    //Unsupported feature: Property Deletion (Attributes) on "UpdatePaymentMethodId(PROCEDURE 17)".

    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        ItemLedgEntry: Record "Vendor Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentkey("Vendor No.");
        ItemLedgEntry.SetRange("Vendor No.", "No.");
        if ItemLedgEntry.Find('-') then
            Error(
              Text012,
              CurrentFieldName);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowContact(PROCEDURE 1).ConfirmManagement(Variable 1004)".

    //Unsupported feature: Property Modification (Length) on "GetVendorNo(PROCEDURE 19).VendorText(Parameter 1000)".

    //Unsupported feature: Property Modification (Length) on "GetVendorNoOpenCard(PROCEDURE 56).VendorText(Parameter 1000)".

    //Unsupported feature: Property Modification (Length) on "CreateNewVendor(PROCEDURE 59).VendorName(Parameter 1000)".

    //Unsupported feature: Deletion (VariableCollection) on "IsContactUpdateNeeded(PROCEDURE 48).VendContUpdate(Variable 1001)".

    //Unsupported feature: Property Modification (Length) on "SetAddress(PROCEDURE 40).VendorAddress(Parameter 1001)".

    //Unsupported feature: Property Modification (Length) on "SetAddress(PROCEDURE 40).VendorContact(Parameter 1006)".

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.get(Database.UserId) then begin
            if UserSetup."Can Create Vendor" = false then
                error('Please note that you dont have the rights to create/Edit Suppliers');
        end else
            error('Please note that you dont have the rights to create/Edit Suppliers');
    end;

    var
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more posted ledger entries.';
}
