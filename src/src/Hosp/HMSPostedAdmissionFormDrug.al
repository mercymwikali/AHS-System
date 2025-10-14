page 52202690 "HMS Posted Admission Form Drug"
{
    PageType = List;
    SourceTable = "HMS Admission Drug Prescribe";
    SourceTableView = WHERE(Posted = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field(Reverse; Rec.Reverse)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reverse field.';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Date field.';
                }
                field("Date Administered"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Drug No."; Rec."Drug No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(Take; Rec.Take)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Take field.';
                }
                field(Route; Rec.Route)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Route field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field("Number of Days"; Rec."Number of Days")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Number of Days field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Marked as Incompatible"; Rec."Marked as Incompatible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Marked as Incompatible field.';
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued field.';
                }
                field("Actual Quantity Issued"; Rec."Actual Quantity Issued")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Actual Quantity Issued field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Inventory Group"; Rec."Inventory Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Inventory Group field.';
                }
                field(SystemId; SystemId)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Prescribe Drugs")
            {
                Caption = '&Prescribe Drugs';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the &Prescribe Drugs action.';

                trigger OnAction()
                begin
                    if Confirm('Alert Pharmacy About Prescription?') = false then
                        exit;
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                    /*Get the treatment from the database*/
                    AdmissionHeader.Reset();
                    if AdmissionHeader.Get(Rec."Admission No.") then begin
                        PharmHeader.Reset();
                        PharmHeader.Init();
                        PharmHeader."Pharmacy No." := NewNo;
                        PharmHeader."Pharmacy Date" := Today;
                        PharmHeader."Pharmacy Time" := Time;
                        PharmHeader."Request Area" := PharmHeader."Request Area"::Doctor;
                        PharmHeader."Patient No." := AdmissionHeader."Patient No.";
                        PharmHeader."Student No." := AdmissionHeader."Student No.";
                        PharmHeader."Employee No." := AdmissionHeader."Employee No.";
                        PharmHeader."Relative No." := AdmissionHeader."Relative No.";
                        PharmHeader."Link Type" := 'Admission';
                        PharmHeader."Link No." := Rec."Admission No.";
                        PharmHeader.Insert();

                        AdmissionLine.Reset();
                        AdmissionLine.SetRange(AdmissionLine."Admission No.", Rec."Admission No.");
                        AdmissionLine.SetRange(AdmissionLine.Posted, false);
                        if AdmissionLine.Find('-') then
                            repeat
                                PharmLine.Init();
                                PharmLine.Location := HMSSetup."Pharmacy In Patient Location";
                                PharmLine."Pharmacy No." := NewNo;
                                PharmLine."No." := AdmissionLine."Drug No.";
                                PharmLine.Quantity := AdmissionLine.Quantity;
                                PharmLine.Validate(PharmLine.Quantity);
                                PharmLine."Measuring Unit" := AdmissionLine."Unit Of Measure";
                                PharmLine.Validate(PharmLine.Quantity);
                                PharmLine.Dosage := AdmissionLine.Dosage;
                                //PharmLine.t
                                PharmLine.Pharmacy := AdmissionLine."Location Code";
                                PharmLine.Insert();

                                //AdmissionLine.Posted,FALSE
                                AdmissionLine.Posted := true;
                                AdmissionLine."Posted By" := UserId;
                                AdmissionLine."Posted Date" := Today;
                                AdmissionLine.Modify();
                            until AdmissionLine.Next() = 0;
                        Message('The Prescription has been sent to the Pharmacy for Issuance');
                    end;
                end;
            }
            action("Reverse Prescriptions")
            {
                ApplicationArea = Basic, Suite;
                Image = ReverseLines;
                ToolTip = 'Executes the Reverse Prescriptions action.';
                trigger OnAction()
                begin

                    if Confirm('Do you really want to Reverse the Prescriptions?') = false then
                        exit;
                    AdmissionLine.Reset();
                    AdmissionLine.SetRange(AdmissionLine."Admission No.", Rec."Admission No.");
                    AdmissionLine.SetRange(AdmissionLine.Posted, false);
                    AdmissionLine.SetRange(AdmissionLine.Reverse, true);
                    if AdmissionLine.Find('-') then
                        repeat
                            AdmissionLine.TestField("Drug No.");
                            AdmissionLine.TestField("Location Code");
                            AdmissionLine.TestField("Transaction Type");
                            if AdmissionLine.Quantity = 0 then
                                Error('Please enter Quantity in all Lines');
                            if AdmissionLine."Unit Price" = 0 then
                                Error('Please enter Unit Price in all Lines');
                        until AdmissionLine.Next() = 0;
                    ReverseConsumablesItems();

                    Message('Prescription Reversed successfully');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PharmacyCodeOnFormat();
        DrugNoOnFormat();
        DrugNameOnFormat();
        QuantityOnFormat();
        UnitOfMeasureOnFormat();
        DosageOnFormat();
        RemarksOnFormat();
        ActualQuantityIssuedOnFormat();
        RemainingQuantityOnFormat();
    end;

    var
        AdmissionLine: Record "HMS Admission Drug Prescribe";
        HAdmissionLine: Record "HMS Admission Drug Prescribe";
        AdmissionHeader: Record "HMS Admission Form Header";
        ObservationH: Record "HMS Observation Form Header";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        PhysioHeader: Record "HMS Physiotheraphy Form Header";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        LineNo: Integer;

    local procedure PharmacyCodeOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure DrugNoOnFormat()
    begin
        //IF "Marked as Incompatible"=TRUE THEN;
    end;

    local procedure DrugNameOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure QuantityOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure UnitOfMeasureOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure DosageOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure RemarksOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure ActualQuantityIssuedOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure RemainingQuantityOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    procedure ReverseConsumablesItems()
    var
        AdmHeader: Record "HMS Admission Form Header";
        PatRec: Record "HMS Patient";
        ItemJnlLine: Record "Item Journal Line";
    begin

        HMSSetup.Reset();
        HMSSetup.Get();
        HMSSetup.TestField("Pharmacy Department");
        if AdmHeader.get(Rec."Admission No.") then
            PatRec.get(AdmHeader."Patient No.");

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then
            ItemJnlLine.DeleteAll();

        AdmissionLine.Reset();
        AdmissionLine.SetRange(AdmissionLine."Admission No.", Rec."Admission No.");
        AdmissionLine.SetRange(AdmissionLine.Posted, true);
        AdmissionLine.SetRange(AdmissionLine.Reverse, true);
        //AdmissionLine.SETRANGE(AdmissionLine."Drug No.",DrugNo);
        if AdmissionLine.Find('-') then begin
            repeat
                AdmissionLine.CalcFields("Inventory Group");
                if AdmissionLine."Inventory Group" <> 'DRUGS' then begin
                    LineNo := LineNo + 1;
                    ItemJnlLine.Init();
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
                    ItemJnlLine."Document No." := Rec."Admission No." + ':' + AdmissionLine."Drug No.";
                    ItemJnlLine."Item No." := AdmissionLine."Drug No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                    ItemJnlLine."Location Code" := AdmissionLine."Location Code";
                    ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    ItemJnlLine.Quantity := AdmissionLine.Quantity;
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := AdmissionLine."Unit Of Measure";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Unit Amount" := AdmissionLine."Unit Price";
                    ItemJnlLine."Shortcut Dimension 1 Code" := PatRec."Global Dimension 1 Code";
                    ItemJnlLine."Shortcut Dimension 2 Code" := HMSSetup."Pharmacy Department";
                    // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine.Insert();
                end;
            until AdmissionLine.Next() = 0;
            ItemJnlLine.Reset();
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJnlLine.Find('-') then
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);

            HAdmissionLine.Reset();
            HAdmissionLine.SetRange(HAdmissionLine."Admission No.", Rec."Admission No.");
            HAdmissionLine.SetRange(HAdmissionLine.Posted, true);
            HAdmissionLine.SetRange(HAdmissionLine.Reverse, true);
            if HAdmissionLine.Find('-') then
                repeat
                    HAdmissionLine.CalcFields("Inventory Group");
                    if HAdmissionLine."Inventory Group" <> 'DRUGS' then begin
                        if ObservationH.Get(Rec."Admission No.") then
                            ReversePatientCharges(HAdmissionLine."Admission No.", HAdmissionLine."Drug No.", HAdmissionLine."Line No", HAdmissionLine."Transaction Type", ObservationH."Patient No.", ObservationH."Link No.");
                        if PhysioHeader.Get(Rec."Admission No.") then
                            ReversePatientCharges(HAdmissionLine."Admission No.", HAdmissionLine."Drug No.", HAdmissionLine."Line No", HAdmissionLine."Transaction Type", PhysioHeader."Patient No.", PhysioHeader."Link No.");
                        if AdmissionHeader.Get(Rec."Admission No.") then
                            ReversePatientCharges(HAdmissionLine."Admission No.", HAdmissionLine."Drug No.", HAdmissionLine."Line No", HAdmissionLine."Transaction Type", AdmissionHeader."Patient No.", AdmissionHeader."Link No.");
                        HAdmissionLine.Posted := false;
                        HAdmissionLine."Posted By" := UserId;
                        HAdmissionLine."Posted Date" := Today;
                        HAdmissionLine.Reverse := false;
                        HAdmissionLine.Modify();
                    end;
                until HAdmissionLine.Next() = 0;
        end;
    end;

    local procedure ReversePatientCharges(AdmNo: Code[20]; DrugNo: Code[20]; LineNo: Integer; TranType: Code[20]; PatientNo: Code[20]; LinkNo: Code[20])
    var
        HMSPatientsCharges: Record "HMS Patient Charges";
        HMSPatCU: Codeunit "HMS Patient-integration";
    begin

        AdmissionLine.Reset();
        AdmissionLine.SetRange(AdmissionLine."Admission No.", AdmNo);
        AdmissionLine.SetRange(AdmissionLine."Line No", LineNo);
        AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
        AdmissionLine.SetRange(AdmissionLine.Reverse, true);
        if AdmissionLine.Find('-') then begin
            // AdmissionHeader.GET(AdmissionLine."Admission No.");
            HMSPatientsCharges.Reset();
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Line No", LineNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, DrugNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, AdmissionLine."Posting Date");
            //HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Visit No",PatRec."Active Visit No");
            // HMSPatientsCharges.SetFilter(HMSPatientsCharges."Posting Document No", '%1<>', '');

            if HMSPatientsCharges.Find('-') then
                if HMSPatientsCharges."Posting Document No" <> '' then
                    HMSPatCU.Post_Reverse_Charge(HMSPatientsCharges."Posting Document No", HMSPatientsCharges."Visit No");

            HMSPatientsCharges.DeleteAll();
            /*
           HMSPatientsCharges.INIT;
           HMSPatientsCharges."Line No":=LineNo;
           HMSPatientsCharges."Patient No."   :=PatientNo;
           HMSPatientsCharges."Transaction Type" :=AdmissionLine."Transaction Type";
           HMSPatientsCharges.VALIDATE("Transaction Type");
           HMSPatientsCharges."Link No":=LinkNo;
           HMSPatientsCharges."Treatment No.":=LinkNo;
           HMSPatientsCharges."Appointment No.":=LinkNo;
           HMSPatientsCharges.Code:=DrugNo;
           HMSPatientsCharges.Description:=AdmissionLine."Drug Name";
           HMSPatientsCharges.Amount:=AdmissionLine."Unit Price";
           HMSPatientsCharges.Quantity :=AdmissionLine.Quantity;
           HMSPatientsCharges.VALIDATE(Quantity);
           HMSPatientsCharges.VALIDATE(Amount);
           HMSPatientsCharges.Date:=AdmissionLine."Posting Date";
           HMSPatientsCharges."Bill Section":=HMSPatientsCharges."Bill Section"::Admissions;
           HMSPatientsCharges."Shortcut Dimension 1 Code" := 'PHARMACY';
           HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
           IF PatRec.GET(PatientNo) THEN BEGIN
            HMSPatientsCharges."Admission No" := PatRec."Adm No.";
            HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
            END;
           HMSPatientsCharges.INSERT;
           */
        end;
        //END;
    end;
}
