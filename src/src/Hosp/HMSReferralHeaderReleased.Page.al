Page 52202905 "HMS Referral Header Released"
{
    PageType = Document;
    SourceTable = "HMS Referral Header";
    SourceTableView = where(Status = const(Released));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
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
