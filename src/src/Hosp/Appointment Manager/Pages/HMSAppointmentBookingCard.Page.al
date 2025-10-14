Page 52202686 "HMS Appointment Booking Card"
{
    DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = Card;
    SourceTable = "HMS Patient Appointmnt Bookng";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(AppointmentBookingNo; Rec."Appointment Booking No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Booking No field.';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(AppointmentDate; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field(AppointmentTime; Rec."Appointment Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field(AppointmentType; Rec."Appointment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                }
                field("Appointment Slot"; Rec."Appointment Slot")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Appointment slot field';
                }
                field(Ward; Rec.Ward)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = Inpatient;
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = Inpatient;
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(DoctorsName; Rec."Doctors Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctors Name field.';
                }
                field(AppointmentReason; Rec."Appointment Reason")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Reason field.';
                }
                field(TelephoneNo; Rec."Telephone No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone No field.';
                }
                field(TCADate; Rec."TCA Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the TCA Date field.';
                }
                field(TCATime; Rec."TCA Time")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the TCA Time field.';
                }
                field("Booked Sessions"; Rec."Booked Sessions")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Booked Sessions field.';
                }
            }
            part("HMS Appointment Booking Lines"; "HMS Appointment Booking Lines")
            {
                Caption = 'Future Session Booking';
                SubPageLink = "Booking No." = field("Appointment Booking No"), "Patient No." = field("Patient No");
            }
            group(TCA)
            {
                field(ApppointmentRemarks; Rec."Apppointment Remarks")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Apppointment Remarks field.';
                }
                field(VisitNo; Rec."Visit No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field(BookedDate; Rec."Booked Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Booked Date field.';
                }
                field(BookedBy; Rec."Booked By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Booked By field.';
                }
                field(TreatmentNo; Rec."Treatment No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment No field.';
                }
                field(BookedTime; Rec."Booked Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Booked Time field.';
                }
            }
            group(ReminderNotifications)
            {
                field(Reminder; Rec.Reminder)
                {

                }
                field("Reminder Unit"; Rec."Reminder Unit")
                {

                }
                field("Notification Option"; Rec."Notification Option")
                {

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = Calculate;
                ToolTip = 'Executes the Schedule action.';

                trigger OnAction()
                var
                    Booking: Record "HMS Appointment Booking Lines";
                    AppBk: Record "HMS Patient Appointmnt Bookng";
                    SMSSenderCodeunit: Codeunit "SMS Integration Management";
                    smsMsg: text;
                    HMSPatient: Record "HMS Patient";
                begin
                    /*  Booking.Reset();
                     Booking.SetRange(Booking."Booking No.", Rec."Appointment Booking No");
                     Booking.SetRange(Booking.Status, Booking.Status::" ");
                     if Booking.Find('-') then
                         repeat
                             AppBk.Init();
                             HmsSetup.Get();
                             AppBk."Appointment Booking No" := NoSeriesMgt.GetNextNo(HmsSetup."Appointment Booking Nos", 0D, true);
                             AppBk."Patient No" := Rec."Patient No";
                             AppBk."Appointment Date" := Booking."Booked Date";
                             AppBk."Appointment Time" := Booking."Booked Time";
                             AppBk."Appointment Type" := Rec."Appointment Type";
                             AppBk.Section := Booking.Section;
                             AppBk.Branch := Booking.Branch;
                             AppBk.Ward := Booking."Booked Ward";
                             AppBk.Bed := Booking.Bed;
                             AppBk."Therapy Session" := Booking."Therapy Session";
                             AppBk.Validate("Patient No");
                             AppBk.Validate(Bed);
                             AppBk.Status := AppBk.Status::Booked;
                             AppBk.Insert();

                             Booking.Status := Booking.Status::Booked;
                             Booking.Modify();
                         until Booking.Next() = 0; */
                    if HMSPatient.Get(Rec."Patient No") then begin
                        smsMsg := 'Hello ' + HMSPatient.Surname + ', You have an appointment booked on ' + Format(Rec."Appointment Date") + ' at ' + Format(Rec."Appointment Time");
                        if HMSPatient."Telephone No. 1" <> '' then
                            SMSSenderCodeunit.SendSMS(HMSPatient."Telephone No. 1", smsMsg);
                    end;

                    Rec.TestField("Appointment Date");
                    Rec.Status := Rec.Status::Booked;
                    Rec.Modify();

                    Message('Scheduled Successfully');
                end;
            }
            action("Activate Visit")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check-In';
                Image = ActivateDiscounts;
                ToolTip = 'Executes the Check-In action.';

                trigger OnAction()
                begin
                    Rec.TestField("Appointment Date");
                    if Confirm('Do you wish to activate the visit for' + Rec."Patient No" + ' : ' + Rec."Search Name", false) then begin
                        if Rec."Appointment Date" <> Today then
                            Error('You can only activate todays appointments');
                        Apponitment.SETRANGE(Apponitment."Patient No.", Rec."Patient No");
                        Apponitment.SETRANGE(Apponitment."Appointment Date", TODAY);
                        // Apponitment.SETRANGE(Apponitment."Patient Type", "Patient Type");
                        // Apponitment.SETRANGE(Apponitment.Status,Apponitment.Status::New);
                        IF Apponitment.FIND('-') THEN
                            ERROR('The patient already has an open visit for today! Go to appointment to dispatch patient');

                        myNoSeries := '';

                        HMSSetup.GET();
                        HMSSetup.TESTFIELD("Appointment Nos");
                        myNoSeries := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, TRUE);

                        objPAtient.RESET();
                        objPAtient.SETRANGE(objPAtient."Patient No.", Rec."Patient No");
                        IF objPAtient.FIND('-') THEN BEGIN
                            objPAtient.Activated := TRUE;
                            objPAtient."Active Visit No" := myNoSeries;
                            objPAtient."Age in Years" := DATE2DMY(TODAY, 3) - DATE2DMY(objPAtient."Date Of Birth", 3);
                            objPAtient.MODIFY();

                            Apponitment.INIT();

                            Apponitment."Appointment No." := myNoSeries;
                            IF objPAtient."Patient Type" = objPAtient."Patient Type"::Corporate THEN
                                Apponitment."Settlement Type" := Apponitment."Settlement Type"::Credit;
                            IF objPAtient."Patient Type" = objPAtient."Patient Type"::Cash THEN
                                Apponitment."Settlement Type" := Apponitment."Settlement Type"::Cash;
                            IF objPAtient."Patient Type" = objPAtient."Patient Type"::Cash THEN
                                Apponitment."Settlement Type" := Apponitment."Settlement Type"::Cash;

                            Apponitment."Patient No." := Rec."Patient No";
                            Apponitment."Appointment Date" := TODAY;
                            Apponitment."Appointment Time" := TIME;

                            Apponitment."Appointment Type" := Rec."Appointment Type";

                            Apponitment."Visit Type" := Apponitment."Appointment Type";
                            Apponitment."Insurance No" := objPAtient."Insurance No.";
                            Apponitment."Insurance Member No" := objPAtient."Membership No";
                            Apponitment."Patient Type" := objPAtient."Patient Type";
                            Apponitment.visitType := ItsNew;
                            Apponitment."Age in Years" := objPAtient."Age in Years";
                            Apponitment.Gender := objPAtient.Gender;
                            Apponitment."User ID" := USERID;
                            Apponitment.Status := Apponitment.Status::New;
                            Apponitment.Names := objPAtient."Search Name";
                            IF (Apponitment.Names = '') THEN
                                Apponitment.Names := objPAtient.Surname + '  ' + objPAtient."Middle Name" + ' ' + objPAtient."Last Name";
                            Apponitment.SearchNames := objPAtient.Surname + '  ' + objPAtient."Middle Name" + ' ' + objPAtient."Last Name";
                            Apponitment.Branch := objPAtient."Global Dimension 1 Code";

                            Apponitment.INSERT();
                        END;
                        Rec.Status := Rec.Status::Attended;
                        Rec.Modify();

                        PAGE.RUN(Page::"HMS Appointment Form Header", Apponitment);
                    end;

                    Message('Appointment activated succefully');
                end;
            }
            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = Alerts;
                ToolTip = 'Executes the Send SMS action.';

                trigger OnAction()
                begin
                    Pat.SetRange("Patient No.", Rec."Patient No");
                    if Pat.Find('-') then begin

                        SMSS.Reset();
                        if SMSS.Find('+') then
                            Ln := SMSS."Entry No";
                        Sms.Init();
                        Sms."Entry No" := Ln + 1;
                        Sms."Phone No" := '254' + DelChr(Pat."Telephone No. 1", '<', '0');
                        Sms.Message := 'You have an appointment for ' + Format(Rec."Appointment Date") + ' at ' + Format(Rec."Appointment Time") + ' with ' + Rec."Doctors Name" + ' for ' + Rec."Appointment Type" + ' at ST. Lukes Orthopaedic Hospital';
                        Sms.Status := Sms.Status::Pending;
                        Sms.Date := Today;
                        Sms.Insert();
                    end;
                    Message('SMS Sent Succesfully');
                end;
            }

            action("Forfeit Booking")
            {
                ApplicationArea = Basic, Suite;
                Image = CalendarChanged;
                ToolTip = 'Executes the Forfeit Booking action.';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Rec.TestField("Appointment Date");
                    if Rec."Appointment Date" > Today then
                        Error('You can not forfeit a future booking');
                    Rec.Status := Rec.Status::"Failed To Attend";
                    Rec.Modify();
                    Message('Appointment forfeited successfully');
                end;
            }
            action("Cancel Booking")
            {
                ApplicationArea = Basic, Suite;
                Image = Cancel;
                ToolTip = 'Executes the Cancel Booking action.';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Appointment Date");
                    if Rec."Appointment Date" < Today then
                        Error('You can only cancel a future booking');
                    Rec.Status := Rec.Status::Cancelled;
                    Rec.Modify();
                    Message('Appointment forfeited successfully');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        HmsSetup.Get();
        HmsSetup.TestField("Appointment Booking Nos");
        if Rec."Appointment Booking No" = '' then
            Rec."Appointment Booking No" := NoSeriesMgt.GetNextNo(HmsSetup."Appointment Booking Nos", 0D, true);
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        Apponitment: Record "HMS Appointment Form Header";
        objPAtient: Record "HMS Patient";
        Pat: Record "HMS Patient";
        HmsSetup: Record "HMS Setup";
        Sms: Record "SMS Sender";
        SMSS: Record "SMS Sender";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TherapyMode: Boolean;
        Inpatient: Boolean;
        NonDialysis: Boolean;

        myNoSeries: Code[20];
        Ln: Integer;
        ItsNew: Option New,Revisit;
}
