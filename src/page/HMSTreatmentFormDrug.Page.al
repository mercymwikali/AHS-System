Page 85469 "HMS Treatment Form Drug"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Drug";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(DrugGroup; Rec."Product Group")
                {
                    Caption = 'Drug Group';
                    ToolTip = 'Specifies the value of the Drug Group field.';
                }
                field(DrugNo; Rec."Drug No.")
                {
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field(DrugName; Rec."Drug Name")
                {
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UnitOfMeasure; Rec."Unit Of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Issued; Rec.Issued)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued field.';
                }
                field(MarkedasIncompatible; Rec."Marked as Incompatible")
                {
                    ToolTip = 'Specifies the value of the Marked as Incompatible field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrescribeDrugs)
            {
                Caption = '&Prescribe Drugs';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Prescribe Drugs action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnPrescribeDrugs(rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DrugNoOnFormat();
        DrugNameOnFormat();
        QuantityOnFormat();
        UnitOfMeasureOnFormat();
        DosageOnFormat();
    end;

    var
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        TreatmentLine: Record "HMS Treatment Form Drug";
        TreatmentHeader: Record "HMS Treatment Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];

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
}
