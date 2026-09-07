Page 85319 "HMS Appointment List-Therapy"
{
    CardPageID = "HMS Appointment Form Header";
    PageType = List;
    SourceTable = "HMS Appointment Form Header";
   // SourceTableView = where(Status = filter(Status::new), isTherapy = filter(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(AppointmentNo; Rec."Appointment No.")
                {
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field(AppointmentDate; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field(AppointmentTime; Rec."Appointment Time")
                {
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field(AppointmentType; Rec."Appointment Type")
                {
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(MembershipNo; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field(InsuranceName; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SearchNames; Rec.SearchNames)
                {
                    Caption = 'Names';
                    ToolTip = 'Specifies the value of the Names field.';
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Visit Summary")
            {
                RunObject = Report "HMS Visit Summary";
                ToolTip = 'Executes the Visit Summary action.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SearchNames := '';
        if PatientRec.Get(Rec."Patient No.") then begin
            Rec.SearchNames := PatientRec.Surname + ' ' + PatientRec."Middle Name" + ' ' + PatientRec."Last Name";
            Rec.Modify();
        end;
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    var
        PatientRec: Record "HMS Patient";
}
