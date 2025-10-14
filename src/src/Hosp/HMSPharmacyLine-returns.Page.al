Page 52202713 "HMS Pharmacy Line-returns"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Worksheet;
    SourceTable = "HMS Pharmacy Line";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(PharmacyNo; Rec."Pharmacy No.")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(Location; Rec.Location)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(DrugsCategory; Rec."Drugs Category")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Drugs Category field.';
                }
                field(No; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field(DrugName; Rec."Drug Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(ReturnsQuantity; Rec."Returns Quantity")
                {
                    ToolTip = 'Specifies the value of the Returns Quantity field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Dosage1; Rec.Dosage)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(MeasuringUnit; Rec."Measuring Unit")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Measuring Unit field.';
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field(ActualQty; Rec."Actual Qty")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Actual Qty field.';
                }
                field(ActualPrice; Rec."Actual Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Actual Price field.';
                }
                field(IssuedQuantity; Rec."Issued Quantity")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Issued Quantity field.';
                }
                field(IssuedUnits; Rec."Issued Units")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued Units field.';
                }
                field(IssuedPrice; Rec."Issued Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued Price field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(Take; Rec.Take)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Take field.';
                }
                field(Route; Rec.Route)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Route field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(NumberofDays; Rec."Number of Days")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Number of Days field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = '&Functions';
                action(PostDrugReturn)
                {
                    Caption = 'Post Drug Return';
                    Image = Post;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Post Drug Return action.';

                    trigger OnAction()
                    var
                        HMSPharmacyLine: Record "HMS Pharmacy Line";
                        PharmacyProcesses: Codeunit "HMS Pharmacy Processes";
                    begin
                        HMSPharmacyLine.Reset();
                        HMSPharmacyLine.SetRange("Pharmacy No.", Rec."Pharmacy No.");
                        HMSPharmacyLine.SetRange("Returns Posted", false);
                        if HMSPharmacyLine.FindSet() then
                            repeat
                                if HMSPharmacyLine."Returns Quantity" <> 0 then begin
                                    if PharmacyProcesses.PostPharmacyReturns(HMSPharmacyLine) then
                                        Message('Pharmacy Returns posted successfully')
                                    else
                                        Message('Something went wrong while posting the Pharmacy Returns');
                                end;
                            until HMSPharmacyLine.Next() = 0;


                    end;
                }
                separator(Action2)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*ItemUnitOfMeasure.RESET;
        ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.","No.");
        ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code,"Measuring Unit");
        IF ItemUnitOfMeasure.FIND('-') THEN
          BEGIN
            //"Issued Units":=ItemUnitOfMeasure."Qty. per Unit of Measure" * "Issued Quantity";
            Item.RESET;
          IF Item.GET("No.") THEN BEGIN
          "Unit Price":=Item."Unit Price";
          //"Actual Price":=Item."Unit Price";
          IF HMSApp.GET("Link No.") THEN
          IF HMSApp."Settlement Type"=HMSApp."Settlement Type"::Insurance THEN
          "Actual Price":=Item."Unit Price"*1.5 ELSE
          "Actual Price":=Item."Unit Price"*1.33;
          END;
         END;   */
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Location := 'CENTRAL';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Location := 'CENTRAL';
    end;

    var
        HmsPat: Record "HMS Patient";
        Patient: Record "HMS Patient";
        HMSPatientsCharges: Record "HMS Patient Charges";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;

    procedure PostItems()
    begin

        if Confirm('Do you wish to post the record?', false) = false then
            exit;
        if PharmHeader.Get(Rec."Pharmacy No.") then begin
            /*
             IF PharmHeader."Cash Sale"=TRUE THEN BEGIN
              PharmHeader.CALCFIELDS("Receipt Count");
              IF PharmHeader."Receipt Count"=0 THEN ERROR('Please note that the selected Record has not been receipted');
             END;
             */
            //check visit
            HMSPatientsCharges.Reset();
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PharmHeader."Patient No.");
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, Rec."No.");
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, PharmHeader."Pharmacy Date");
            if HMSPatientsCharges.Find('-') then begin
                if HMSPatientsCharges.Posted = true then
                    Error('This charge has already been posted to the relevent GL. Kindly reverse the charge first');
                //CALCFIELDS("Patient Type");
                HmsPat.SetRange(HmsPat."Patient No.", PharmHeader."Patient No.");
                if HmsPat.Find('-') then
                    if HmsPat."Patient Type" = HmsPat."patient type"::Corporate then
                        if HMSPatientsCharges."Posted Invoice No." <> '' then
                            Error('Invoice already posted');
                /*
                 END ELSE IF HmsPat."Patient Type" = HmsPat."Patient Type"::Cash THEN BEGIN

                 ERROR ('Drugs paid for cannot be returned');
              END;
              */

                ReturnStock();
                ReverseChargePatient;
            end;
        end;
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    local procedure ReverseChargePatient()
    var
        HMSPatCharges: record "HMS Patient Charges";
        Ln: Integer;
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN
        HMSPatientsCharges.Reset();
        ln := HMSPatientsCharges.count;

        HMSPatientsCharges.Reset();
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PharmHeader."Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, Rec."No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, PharmHeader."Pharmacy Date");
        if HMSPatientsCharges.Find('-') then begin
            HMSPatCharges.init();
            HMSPatCharges."Line No" := ln;
            HMSPatCharges."Link No" := HMSPatientsCharges."Link No";
            HMSPatCharges."Patient No." := HMSPatientsCharges."Patient No.";
            HMSPatCharges.code := HMSPatientsCharges.code;
            HMSPatCharges."Visit No" := HMSPatientsCharges."Visit No";
            HMSPatCharges.Remarks := 'Reversal';
            HMSPatCharges.Description := 'Rev- ' + HMSPatientsCharges.Description;
            HMSPatCharges.date := today;
            HMSPatCharges."Shortcut Dimension 1 Code" := HMSPatientsCharges."Shortcut Dimension 1 Code";
            HMSPatCharges."Shortcut Dimension 2 Code" := HMSPatientsCharges."Shortcut Dimension 2 Code";
            HMSPatCharges."Shortcut Dimension 3 Code" := HMSPatientsCharges."Shortcut Dimension 3 Code";
            HMSPatCharges."Shortcut Dimension 4 Code" := HMSPatientsCharges."Shortcut Dimension 4 Code";
            HMSPatCharges.Amount := HMSPatientsCharges.Amount * -1;
            HMSPatCharges.Quantity := HMSPatientsCharges.Quantity;
            HMSPatCharges."Total Amount" := HMSPatientsCharges."Total Amount" * -1;
            HMSPatCharges."Insurance No" := HMSPatientsCharges."Insurance No";
            HMSPatCharges."Insurance Amount" := HMSPatientsCharges."Insurance Amount";
            HMSPatCharges."Transaction Type" := HMSPatientsCharges."Transaction Type";
            HMSPatCharges."G/L Account No" := HMSPatientsCharges."G/L Account No";
            HMSPatCharges."G/L Account" := HMSPatientsCharges."G/L Account";
            HMSPatCharges.Closed := true;
            HMSPatCharges.insert();
            HMSPatientsCharges.Closed := true;
            HMSPatientsCharges.modify();
        end;
    end;

    local procedure ReturnStock()
    begin
        HMSSetup.Reset();
        HMSSetup.Get();
        Patient.get(Rec."Patient No");
        HMSSetup.TestField("Pharmacy Department");
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then
            ItemJnlLine.DeleteAll();
        LineNo := 0;
        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", Rec."Pharmacy No.");
        PharmLine.SetRange(PharmLine."No.", Rec."No.");
        //PharmLine.SETFILTER(PharmLine."Returns Quantity",'>%1',0);
        if PharmLine.Find('-') then begin

            repeat
                if PharmLine."Returns Quantity" > 0 then begin
                    if PharmLine."Issued Quantity" < PharmLine."Issued Quantity" then
                        Error('You cannot return more than you gave issued');
                    if PharmLine.Quantity < PharmLine.Quantity then
                        Error('You cannot return more than you gave issued');
                    if PharmLine."Issued Units" < PharmLine."Issued Units" then
                        Error('You cannot return more than you gave issued');

                    PharmLine.TestField(PharmLine.Location);
                    LineNo := LineNo + 1000;
                    ItemJnlLine.Init();
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Positive Adjmt.";
                    ItemJnlLine."Document No." := PharmLine."Pharmacy No." + ':' + PharmLine."No.";
                    ItemJnlLine."Item No." := PharmLine."No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                    ItemJnlLine."Location Code" := PharmLine.Location;
                    ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    ItemJnlLine."Gen. Prod. Posting Group" := 'DRUGS';
                    if PharmLine."Returns Quantity" <= 0 then
                        Error('Please enter returns quantity');
                    ItemJnlLine.Quantity := PharmLine."Returns Quantity";
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                    ItemJnlLine."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                    ItemJnlLine."Shortcut Dimension 2 Code" := HMSSetup."Pharmacy Department";
                    // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine."Source Code" := 'Return';
                    ItemJnlLine.Insert();

                    ReverseChargePatient(); //Modify bill

                    PharmLine.Remaining := PharmLine.Remaining + PharmLine."Returns Quantity";
                    PharmLine."Issued Quantity" := PharmLine."Issued Quantity" - PharmLine."Returns Quantity";
                    PharmLine.Quantity := PharmLine.Quantity - PharmLine."Returns Quantity";
                    PharmLine."Issued Units" := PharmLine."Issued Units" - PharmLine."Returns Quantity";
                    //PharmLine.
                    PharmLine.Modify();
                    LineNo := LineNo + 1;
                    /*Update the treatment lines*/
                    TreatmentLine.Reset();
                    TreatmentLine.SetRange(TreatmentLine."Treatment No.", PharmHeader."Link No.");
                    TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                    if TreatmentLine.Find('-') then begin
                        TreatmentLine.Issued := true;
                        TreatmentLine.Modify();
                    end;
                end;
            until PharmLine.Next() = 0;
            ItemJnlLine.Reset();
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
            //ERROR('Mtg');
            PharmHeader.Status := PharmHeader.Status::Completed;
            PharmHeader.Modify();
        end;
    end;
}
