Page 52202904 "HMS Referral Header Active"
{
    PageType = Document;
    SourceTable = "HMS Referral Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(HospitalNo; Rec."Hospital No.")
                {
                    ToolTip = 'Specifies the value of the Hospital No. field.';
                }
                field(HospitalName; Rec."Hospital Name")
                {
                    ToolTip = 'Specifies the value of the Hospital Name field.';
                }
                field(DateReferred; Rec."Date Referred")
                {
                    ToolTip = 'Specifies the value of the Date Referred field.';
                }
                field(ReferralReason; Rec."Referral Reason")
                {
                    ToolTip = 'Specifies the value of the Referral Reason field.';
                }
                field(ReferralRemarks; Rec."Referral Remarks")
                {
                    ToolTip = 'Specifies the value of the Referral Remarks field.';
                }
                field(CorrespondenceAddress1; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Diagnosis; Rec.Diagnosis)
                {
                    ToolTip = 'Specifies the value of the Diagnosis field.';
                }
                field("Brief History"; Rec."Brief History")
                {
                    ToolTip = 'Specifies the value of the Brief History field.', Comment = '%';
                }
                field("Investigation Done"; Rec."Investigation Done")
                {
                    ToolTip = 'Specifies the value of the Investigation Done field.', Comment = '%';
                }
                field(Treatment; Rec.Treatment)
                {
                    ToolTip = 'Specifies the value of the Treatment field.', Comment = '%';
                }
                field("Case Urgency"; Rec."Case Urgency")
                {
                    ToolTip = 'Specifies the value of the Case Urgency field.';
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
