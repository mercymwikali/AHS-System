Page 52202739 "HMS Triage List Therapy"
{
    CardPageID = "HMS Observation Form Header";
    PageType = List;
    SourceTable = "HMS Observation Form Header";
    SourceTableView = where(Closed = filter(false), isTherapy = filter(true));
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
    }

    trigger OnAfterGetRecord()
    begin
        GetPatientName(Rec."Patient No.", PatientName);
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    var
        Patient: Record "HMS Patient";
        PatientName: Text[100];

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        //PatientName:='';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;
}
