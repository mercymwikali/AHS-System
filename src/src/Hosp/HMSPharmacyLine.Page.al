Page 52202892 "HMS Pharmacy Line"
{
    PageType = ListPart;
    SourceTable = "HMS Pharmacy Line";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(DrugsCategory; Rec."Drugs Category")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Drugs Category field.';
                }
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field(DrugName; Rec."Drug Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Description2; Rec.Description2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generic Name';
                    ToolTip = 'Specifies the value of the Generic Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(ActualQty; Rec."Actual Qty")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Qty';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Available Qty field.';
                }
                field("Prescription Dose"; Rec."Prescription Dose")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prescription Dose';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Prescription Dose.';
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    // Editable = false;
                }
                field(TotalAmount; Rec."Total Price")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Dose; Rec.Take)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Take field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field("Duration (Days)"; Rec."Number of Days")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Number of Days field.';
                }
                field("Special Instructions"; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Route; Rec.Route)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Route field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(UnitCost; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field(IssuedQuantity; Rec."Issued Quantity")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Issued Quantity field.';
                }
                field(PrescriptionDose; Rec."Prescription Dose")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prescription Dose';
                    ToolTip = 'Specifies the value of the Prescription Dose field.';
                }
                field(MeasuringUnit; Rec."Measuring Unit")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Measuring Unit field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                    Visible = false;
                }
                field("line no"; Rec."line no")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line no field.', Comment = '%';
                    Visible = false;
                }
                //
                field("Returns Quantity"; Rec."Returns Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Returns Quantity field.';
                    Visible = false;
                }
                field(Remaining; Rec.Remaining)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining field.', Comment = '%';
                    Visible = false;
                }

                
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Item Tracking Lines")
            {
                Image = Track;
                RunPageOnRec = false;
                Visible = true;
                ToolTip = 'Executes the Item Tracking Lines action.';

                trigger OnAction()
                begin
                    IF Rec.Location = '' THEN
                        ERROR('Pharmacy location should have a value');
                    hmsTrack.RESET();
                    IF hmsTrack.FINDLAST() THEN
                        ln := hmsTrack."Line No";

                    objTracking.RESET();
                    objTracking.SETRANGE(objTracking."Pharmacy No", Rec."Pharmacy No.");
                    objTracking.SETRANGE(objTracking."Item No", Rec."No.");
                    objTracking.SETRANGE(objTracking."Location Code", Rec.Location);
                    IF objTracking.FIND('-') THEN begin
                        // objTracking."Lot No Entry No"
                        if objTracking.Quantity < Rec.Quantity then begin
                            objTracking.INIT();
                            objTracking."Item No" := Rec."No.";
                            objTracking."Line No" := ln + 1;
                            objTracking."Pharmacy No" := Rec."Pharmacy No.";
                            objTracking.Description := Rec."Drug Name";
                            objTracking."Location Code" := Rec.Location;
                            objTracking.INSERT();
                        end;

                    end else begin
                        objTracking.INIT();
                        objTracking."Item No" := Rec."No.";
                        objTracking."Line No" := ln + 1;
                        objTracking."Pharmacy No" := Rec."Pharmacy No.";
                        objTracking.Description := Rec."Drug Name";
                        objTracking."Location Code" := Rec.Location;
                        objTracking.INSERT();
                    end;
                    objTracking.RESET();
                    objTracking.SETRANGE(objTracking."Pharmacy No", Rec."Pharmacy No.");
                    objTracking.SETRANGE(objTracking."Item No", Rec."No.");
                    objTracking.SETRANGE(objTracking."Location Code", Rec.Location);
                    IF objTracking.FIND('-') THEN
                        PAGE.RUN(51042, objTracking);

                    //ItemTrackingLines.RUNMODAL;
                end;
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
    var
        PharmRec: Record "HMS Pharmacy Header";
    begin
        if PharmRec.get(Rec."Pharmacy No.") then
            Rec.Location := PharmRec."Issuing Location";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PharmRec: Record "HMS Pharmacy Header";
    begin
        if PharmRec.get(Rec."Pharmacy No.") then
            Rec.Location := PharmRec."Issuing Location";
    end;

    var
        hmsTrack: Record "HMS Item Tracking Buffer";
        //ItemTrackingLines : Page "6510";
        objTracking: Record "HMS Item Tracking Buffer";
        ln: Integer;
}
