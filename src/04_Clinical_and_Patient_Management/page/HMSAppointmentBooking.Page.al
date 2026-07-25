Page 85279 "HMS Appointment Booking"
{
    CardPageID = "HMS Appointment Booking Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "HMS Patient Appointmnt Bookng";
    SourceTableView = sorting("Appointment Date") order(ascending);
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppointmentBookingNo; Rec."Appointment Booking No")
                {
                    ToolTip = 'Specifies the value of the Appointment Booking No field.';
                }
                field(AppointmentDate; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field(AppointmentTime; Rec."Appointment Time")
                {
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Therapy Session"; Rec."Therapy Session")
                {
                    Visible = TherapyMode;
                    ToolTip = 'Specifies the value of the Therapy Session field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(Ward; Rec.Ward)
                {
                    Visible = TherapyMode;
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    Visible = NonTherapy;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(DoctorsName; Rec."Doctors Name")
                {
                    Visible = NonTherapy;
                    ToolTip = 'Specifies the value of the Doctors Name field.';
                }
                field(AppointmentType; Rec."Appointment Type")
                {
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(AppointmentReason; Rec."Appointment Reason")
                {
                    ToolTip = 'Specifies the value of the Appointment Reason field.';
                }
                field(TCADate; Rec."TCA Date")
                {
                    ToolTip = 'Specifies the value of the TCA Date field.';
                }
                field(VisitNo; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field(BookedBy; Rec."Booked By")
                {
                    ToolTip = 'Specifies the value of the Booked By field.';
                }
                field(BookedDate; Rec."Booked Date")
                {
                    ToolTip = 'Specifies the value of the Booked Date field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send SMS")
            {
                Image = Alerts;
                ToolTip = 'Executes the Send SMS action.';

                trigger OnAction()
                begin
                    Pat.SetRange("Patient No.", Rec."Patient No");
                    if Pat.Find('-') then begin
                        Sms.Init();
                        Sms."Phone No" := '254' + DelChr(Pat."Telephone No. 1", '<', '0');
                        Sms.Message := 'You have an appointment for ' + Format(Rec."Appointment Date") + ' at ' + Format(Rec."Appointment Time") + ' with ' + Rec."Doctors Name" + ' for ' + Rec."Appointment Type" + ' at' + CompanyName;
                        Sms.Status := Sms.Status::Pending;
                        Sms.Date := Today;
                        Sms.Insert();
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        HmsSetup.Get();
        if HmsSetup."View Therapy" = true then
            TherapyMode := true
        else
            TherapyMode := false;
        if HmsSetup."View Therapy" = true then
            NonTherapy := false
        else
            NonTherapy := true;
        if UserRec.get(Database.UserId) then
            if userrec."Branch Code" <> '' then
                Rec.setfilter(Branch, UserRec."Branch Code");
    end;

    var
        Pat: Record "HMS Patient";
        HmsSetup: Record "HMS Setup";
        Sms: Record "SMS Sender";
        UserRec: Record "User Setup";
        TherapyMode: Boolean;
        NonTherapy: Boolean;
}
