namespace PTL.HMISBC;
using PTL.HMIS;

page 52203216 "Nurse Order Sheet "
{
    ApplicationArea = All;
    Caption = 'Nurse Order Sheet ';
    PageType = List;
    SourceTable = "Nurse Order Sheet";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.', Comment = '%';
                }
                field("Admission No"; Rec."Admission No")
                {
                    ToolTip = 'Specifies the value of the Admission No field.', Comment = '%';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.', Comment = '%';
                }
                field("Drug No"; Rec."Drug No")
                {
                    ToolTip = 'Specifies the value of the Drug No field.', Comment = '%';
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ToolTip = 'Specifies the value of the Drug Name field.', Comment = '%';
                }
                field(Route; Rec.Route)
                {
                    ToolTip = 'Specifies the value of the Route field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Prescription Dose"; Rec."Prescription Dose")
                {
                    ToolTip = 'Specifies the value of the Prescription Dose field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Requesting Nurse"; Rec."Requesting Nurse")
                {
                    ToolTip = 'Specifies the value of the Requesting Nurse field.', Comment = '%';
                }
                field(Dosage; Rec.Dosage)
                {
                    ToolTip = 'Specifies the value of the Dosage field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendPharmarcy)
            {
                ApplicationArea = All;
                Image = SendConfirmation;
                ToolTip = 'Executes the Print Notes action.';

                trigger OnAction()
                var
                    HMSPharmacyProcesses: Codeunit "HMS Pharmacy Processes";
                begin
                    if HMSPharmacyProcesses.SendInpatientOrdersheetToPharmacy(Rec."Admission No") then
                        Message('done');
                end;
            }
        }
    }
}
