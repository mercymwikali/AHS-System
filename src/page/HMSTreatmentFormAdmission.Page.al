Page 85467 "HMS Treatment Form Admission"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Admission";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(DateOfAdmission; Rec."Date Of Admission")
                {
                    ToolTip = 'Specifies the value of the Date Of Admission field.';
                }
                field(AdmissionReason; Rec."Admission Reason")
                {
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field(AdmissionRemarks; Rec."Admission Remarks")
                {
                    ToolTip = 'Specifies the value of the Admission Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PlaceRequest)
            {
                Caption = '&Place Request';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Place Request action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnRequestPatientAdmission(Rec);
                end;
            }
        }
    }

    var
        AdmissionHeader: Record "HMS Admission Form Header";
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        TreatmentHeader: Record "HMS Treatment Form Header";
        PatientCU: Codeunit "HMS Patient-integration";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
}
