Page 85297 "HMS Admission Form Drug"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HMS Admission Drug Prescribe";
    SourceTableView = where(Posted = filter(false));
    // TODO: Use this Table to post COnsumables and Treatment form drug to do presciptions?

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document No.';
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(DrugNo; Rec."Drug No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field(DrugName; Rec."Drug Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UnitOfMeasure; Rec."Unit Of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field("Prescription Dose"; Rec."Prescription Dose")
                {
                    ToolTip = 'Specifies the value of the Prescription Dose field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(MarkedasIncompatible; Rec."Marked as Incompatible")
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
                field(ActualQuantityIssued; Rec."Actual Quantity Issued")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Actual Quantity Issued field.';
                }
                field(RemainingQuantity; Rec."Remaining Quantity")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
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
        area(Processing)
        {
            action(PrescribeDrugs)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Post';
                Image = Database;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Post action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    if Confirm('Do you wish to  Post Prescription?') = false then
                        exit;
                    CuHMSProcesses.FnInpatientPostDrugPrescriptions(Rec."Admission No.", UserId);
                end;
            }
            action(PostedPrescriptions)
            {
                Caption = 'Posted Prescriptions';
                Image = PostedDeposit;
                RunObject = Page "HMS Posted Admission Form Drug";
                RunPageLink = "Admission No." = FIELD("Admission No.");
                ToolTip = 'Executes the Posted Consumables action.';
            }
        }
    }

    /* trigger OnAfterGetRecord()
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
    end; */

    var
        AdmissionHeader: Record "HMS Admission Form Header";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];

    local procedure PharmacyCodeOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
    end;

    local procedure DrugNoOnFormat()
    begin
        if Rec."Marked as Incompatible" = true then;
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
}
