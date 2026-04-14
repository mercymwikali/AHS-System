namespace PTL.HMIS;
using HMISBC.HMISBC;

page 85334 "HMS Doctor Review Request"
{
    ApplicationArea = All;
    Caption = 'HMS Doctor Review Request';
    PageType = List;
    SourceTable = "HMS Doctor Review Request";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.', Comment = '%';
                }
                field("Doctors Name";Rec."Doctors Name")
                {
                    ToolTip = 'Specifies the value of the Doctors Name field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patients Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Review Request No."; Rec."Review Request No.")
                {
                    ToolTip = 'Specifies the value of the Review Request No. field.', Comment = '%';
                }
                
                field("Treatement No."; Rec."Treatement No.")
                {
                    ToolTip = 'Specifies the value of the Treatement No. field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the 1,1,1 field.', Comment = '%';
                }
                field(Clinic; Rec.Clinic)
                {
                    ToolTip = 'Specifies the value of the Clinic field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Requesting Doctor"; Rec."Requesting Doctor")
                {
                    ToolTip = 'Specifies the value of the Requesting Doctor field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Consultation Card")
            {
                Caption = '&View Consultation Card';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &View Consultation Card action.';

                trigger OnAction()
                var
                    HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
                    HMSTreatmentPage: Page "HMS Treatment Form Header";
                begin
                    HMSTreatmentFormHeader.Reset();
                    HMSTreatmentFormHeader.SetRange("Treatment No.", Rec."Treatement No.");
                    if HMSTreatmentFormHeader.FindFirst() then begin
                        HMSTreatmentPage.SetRecord(HMSTreatmentFormHeader);
                        HMSTreatmentPage.Run();
                    end;
                end;
            }
            action("Accept Request")
            {
                Caption = '&Accept Request';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Accept Request action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnAcceptDoctorReviewRequest(Rec);
                end;
            }
            action("Cancel Request")
            {
                Caption = '&Cancel Request';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Cancel Request action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnCancelDoctorReviewRequest(Rec);
                end;
            }
        }
    }
}
