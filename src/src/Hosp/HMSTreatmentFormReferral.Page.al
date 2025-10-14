Page 52202882 "HMS Treatment Form Referral"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Referral";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(DateReferred; Rec."Date Referred")
                {
                    ToolTip = 'Specifies the value of the Date Referred field.';
                }
                field(HospitalNo; Rec."Hospital No.")
                {
                    ToolTip = 'Specifies the value of the Hospital No. field.';
                }
                field(HospitalName; Rec."Hospital Name")
                {
                    ToolTip = 'Specifies the value of the Hospital Name field.';
                }
                field(Contactperson; Rec."Contact person")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contact person field.';
                }
                field(ReferralReason; Rec."Referral Reason")
                {
                    ToolTip = 'Specifies the value of the Referral Reason field.';
                }
                field(ReferralRemarks; Rec."Referral Remarks")
                {
                    ToolTip = 'Specifies the value of the Referral Remarks field.';
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
            action(RegisterReferral)
            {
                Caption = '&Register Referral';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Register Referral action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnRegisterReferral(Rec);
                end;
            }
        }
    }

    var
        Referral: Record "HMS Referral Header";
        TreatmentHeader: Record "HMS Treatment Form Header";
}
