Page 85426 "HMS Referral Header List"
{
    CardPageID = "HMS Referral Header Active";
    PageType = List;
    SourceTable = "HMS Referral Header";
    SourceTableView = where(Status = const(Referred));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Treatmentno; Rec."Treatment no.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Treatment no. field.';
                }
                field(DateReferred; Rec."Date Referred")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Referred field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the PatientName field.';
                }
                field(HospitalNo; Rec."Hospital No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Hospital No. field.';
                }
                field(HospitalName; HospitalName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the HospitalName field.';
                }
                field(ReferralReason; Rec."Referral Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Referral Reason field.';
                }
                field(ReferralRemarks; Rec."Referral Remarks")
                {
                    Editable = false;
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
            group(Functions)
            {
                Caption = '&Functions';
                action(ReferralCompleted)
                {
                    Caption = 'Referral Completed';
                    Image = Refresh;
                    Promoted = true;
                    ToolTip = 'Executes the Referral Completed action.';

                    trigger OnAction()
                    begin
                        if Confirm('Referrral Confirmed?', true) = false then
                            exit;

                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        Message('The Referral has been confirmed');
                    end;
                }
                action(ProgressNotes)
                {
                    Caption = 'Progress Notes';
                    Image = PutawayLines;
                    Promoted = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(15),
                                  "No." = field("Treatment no.");
                    ToolTip = 'Executes the Progress Notes action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        Patient: Record "HMS Patient";
        Hospital: Record Vendor;
        HospitalName: Text[100];
        PatientName: Text[100];

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        PatientName := '';
        HospitalName := '';

        Patient.Reset();
        if Patient.Get(Rec."Patient No.") then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";

        Hospital.Reset();
        if Hospital.Get(Rec."Hospital No.") then
            HospitalName := Hospital.Name;
    end;
}
