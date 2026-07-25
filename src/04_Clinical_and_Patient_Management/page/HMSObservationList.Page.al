Page 85366 "HMS Observation List"
{
    CardPageID = "HMS Observation Form Header";
    PageType = List;
    SourceTable = "HMS Observation Form Header";
    SourceTableView = where(Closed = filter(false));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(ObservationNo; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.';
                    StyleExpr = UrgencyStatusColor;
                }
                field(ObservationType; Rec."Observation Type")
                {
                    ToolTip = 'Specifies the value of the Observation Type field.';
                }
                field(ObservationDate; Rec."Observation Date")
                {
                    ToolTip = 'Specifies the value of the Observation Date field.';
                }
                field(ObservationTime; Rec."Observation Time")
                {
                    ToolTip = 'Specifies the value of the Observation Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; PatientName)
                {
                    ToolTip = 'Specifies the value of the PatientName field.';
                }
                field(ObservationUserID; Rec."Observation User ID")
                {
                    ToolTip = 'Specifies the value of the Observation User ID field.';
                }
                field(ObservationRemarks; Rec."Observation Remarks")
                {
                    ToolTip = 'Specifies the value of the Observation Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetBranch)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Get Branches All';
                ToolTip = 'Executes the Get Branches All action.';
                trigger OnAction()
                var
                    HMSObservationFormHeader: Record "HMS Observation Form Header";
                    HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
                    counter: Integer;
                begin
                    counter := 0;
                    HMSObservationFormHeader.Reset();
                    if HMSObservationFormHeader.FindSet() then
                        repeat
                            HMSAppointmentFormHeader.Reset();
                            HMSAppointmentFormHeader.SetRange("Appointment No.", HMSObservationFormHeader."Link No.");
                            if HMSAppointmentFormHeader.FindFirst() then
                                HMSObservationFormHeader.Branch := HMSAppointmentFormHeader.Branch;

                            if HMSObservationFormHeader.Modify() then
                                counter += 1;
                        until HMSObservationFormHeader.Next() = 0;

                    Message('done Modifying %1',counter);
                end;
            }
        }
    }
    var
        Patient: Record "HMS Patient";
        PatientName: Text[250];
        UrgencyStatusColor: Text;

    trigger OnAfterGetRecord()
    begin
        GetPatientName(Rec."Patient No.", PatientName);
        UrgencyStatusColor := GetUrgencyStatusColor(Rec."Urgency Status");
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    procedure GetPatientName(PatNo: Code[20]; PName: Text[250])
    begin
        Patient.Reset();
        if Patient.Get(PatNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    local procedure GetUrgencyStatusColor(UrgencyStatus: Enum "Urgency Status Enum"): Text
    var
        UrgencyColorCodingSetup: Record "Urgency Color Coding Setup";
    begin
        if UrgencyColorCodingSetup.Get(UrgencyStatus) then
            exit(UrgencyColorCodingSetup.StyleExpr)
        else
            exit('');
    end;
}
