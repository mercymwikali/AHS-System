Page 85486 "HMS Walkin Patient Card"
{
    PageType = Card;
    SourceTable = "HMS Patient";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Personaldetails)
            {
                Caption = 'Personal details';
                Editable = true;
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(DateRegistered; Rec."Date Registered")
                {
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field(Branch; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(Department; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Department';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the First/English Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(ModeofPayment; Rec."Patient Type")
                {
                    Caption = 'Mode of Payment';
                    Editable = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Mode of Payment field.';
                    //Visible = false;

                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Activated; Rec.Activated)
                {
                    ToolTip = 'Specifies the value of the Activated field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action(BookVisit)
            {
                Caption = 'Book Appointment';
                Image = BookingsLogo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Book Appointment action.';
                trigger OnAction()
                var
                    HMSAppBk: Record "HMS Patient Appointmnt Bookng";
                    NewNo: Text;
                begin
                    if confirm('Do you want to book an appointment for ' + Rec."Search Name") then begin
                        IF (Rec."Global Dimension 1 Code" = '') THEN
                            ERROR('Please Enter Branch to continue');

                        HmsSetup.Get();
                        HmsSetup.TestField("Appointment Booking Nos");
                        NewNo := NoSeriesMgt.GetNextNo(HmsSetup."Appointment Booking Nos", 0D, true);
                        HMSAppBk.Init();
                        HMSAppBk."Patient No" := Rec."Patient No.";
                        HMSAppBk."Search Name" := Rec."Search Name";
                        HMSAppBk.Surname := Rec.Surname;
                        HMSAppBk."Middle Name" := Rec."Middle Name";
                        HMSAppBk."Last Name" := Rec."Last Name";
                        HMSAppBk."Appointment Booking No" := NewNo;
                        HMSAppBk."Booked By" := UserId;
                        HMSAppBk."Booked Date" := Today;
                        HMSAppBk."Booked Time" := Time;
                        HMSAppBk.Insert();
                        HMSAppBk.Reset();
                        HMSAppBk.SetRange("Appointment Booking No", NewNo);
                        if HMSAppBk.Find('-') then
                            Page.Run(Page::"HMS Appointment Booking Card", HMSAppBk);
                    end;
                end;
            }
            action(CreateVisit)
            {
                Caption = 'Create Pharmacy Visit';
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Pharmacy Visit action.';

                trigger OnAction()
                begin
                    Rec.TestField(Surname);

                    myNoSeries := '';

                    HMSSetup.Get();
                    HMSSetup.TestField("Pharmacy Nos");
                    myNoSeries := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                    Pharmacy.Init();
                    Pharmacy."Pharmacy No." := myNoSeries;
                    Pharmacy."Patient No." := Rec."Patient No.";
                    Pharmacy."Pharmacy Date" := Today;
                    Pharmacy."Pharmacy Time" := Time;
                    Pharmacy."Insurance No" := Rec."Insurance No.";
                    Pharmacy."Patient Type" := Rec."Patient Type";
                    Pharmacy."Cash Sale" := true;
                    Pharmacy."Request Area" := Pharmacy."request area"::Walkin;
                    Pharmacy.Insert();

                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    if Patient.Find('-') then begin
                        Patient.Activated := true;
                        Patient."Active Visit No" := myNoSeries;
                        Patient.Modify();
                    end;

                    Page.Run(Page::"HMS Pharmacy Header", Pharmacy);
                end;
            }
            action(DispatchToObservationRoom)
            {
                Caption = 'Dispatch To Observation Room';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Dispatch To Observation Room action.';

                trigger OnAction()
                begin
                    if Confirm('Dispatch selected Appointment to Observation?', false) = false then
                        exit;
                    begin
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);

                        //LabHeader.RESET;
                        ObservHeader.Init();
                        ObservHeader."Observation No." := NewNo;
                        ObservHeader."Patient No." := Rec."Patient No.";
                        ObservHeader."Observation Date" := Today;
                        ObservHeader."Observation Time" := Time;
                        //ObservHeader."Request Area"::Doctor;
                        ObservHeader."Link Type" := 'Observation';
                        //ObservHeader."Link No.":=;
                        ObservHeader.Insert();
                        /*
                     ObservHeader.RESET;
                     ObservHeader.SETRANGE(ObservHeader."Link No.",TreatmentHeader."Appointment No.");
                     IF ObservHeader.FIND('-') THEN
                       BEGIN
                         IF CONFIRM('Record already exist,Confirm Continue?') THEN   ObservHeader.INSERT
                       END
                     ELSE
                       BEGIN
                        ObservHeader.INSERT;
                       END;
                         */
                    end;

                    /*"Dispatch To":="Dispatch To";
                    "Dispatch Date":=TODAY;
                    "Dispatch Time":=TIME;
                    Status:=Status::Dispatched;
                    "Link No":=NewNo;
                    MODIFY;
                    MESSAGE('Selected Appointment has been dispatched to the Observation Room.');
                    */
                    //END;
                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    if Patient.Find('-') then begin
                        Patient.Activated := true;
                        Patient."Active Visit No" := NewNo;
                        Patient.Modify();
                    end;
                end;
            }
            action(DispatchToPhysio)
            {
                Caption = 'Dispatch To Physio';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Dispatch To Physio action.';

                trigger OnAction()
                begin
                    if Confirm('Dispatch selected Appointment to Physiotheraphy?', false) = false then
                        exit;
                    //TESTFIELD("Settlement Type");
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
                    PhysioHeader.Init();
                    PhysioHeader."No." := NewNo;
                    PhysioHeader."Physio Date" := Today;
                    PhysioHeader."Physio Time" := Time;
                    PhysioHeader."Patient No." := Rec."Patient No.";
                    PhysioHeader."Link Type" := 'Observation';
                    //PhysioHeader."Link No.":=TreatmentHeader."Appointment No.";
                    PhysioHeader.Insert();
                    /*
                    IF "Settlement Type"="Settlement Type"::Insurance THEN BEGIN
                      TESTFIELD("Insurance Member No");
                          PhysioHeader.INIT;
                          PhysioHeader."No.":=NewNo;
                          PhysioHeader."Physio Date":=TODAY;
                          PhysioHeader."Physio Time":=TIME;
                          PhysioHeader."Patient No.":=TreatmentHeader."Patient No.";
                          PhysioHeader."Link Type":='Observation';
                          PhysioHeader."Link No.":=TreatmentHeader."Appointment No.";
                          PhysioHeader.INSERT;
                      END;
                      IF AppType.GET("Appointment Type") THEN BEGIN
                       HMSPatientsCharges.INIT;
                       //HMSPatientsCharges."Line No":=1;
                       HMSPatientsCharges."Patient No."   :="Patient No.";
                       HMSPatientsCharges."Link No":=NewNo;
                       HMSPatientsCharges."Treatment No.":=NewNo;
                       HMSPatientsCharges."Appointment No.":="Appointment No.";
                       HMSPatientsCharges.Code:=DoctorsRec."Consultation Code";
                       HMSPatientsCharges."Transaction Type":='PHYSIOTHERAPHY';
                       HMSPatientsCharges.Description:=DoctorsRec."Consultation Code"+' - '+DoctorsRec."Doctor ID";
                       HMSCharges.GET(DoctorsRec."Consultation Code");
                       HMSPatientsCharges.Amount:=HMSCharges.Amount;
                       HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
                       HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                       HMSPatientsCharges.Date:=TODAY;
                       HMSPatientsCharges."Bill Section":=HMSPatientsCharges."Bill Section"::Appointment;

                       HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                       HMSPatientsCharges.INSERT;
                      END;
                      */
                    //"Dispatch To":="Dispatch To";
                    //"Dispatch Date":=TODAY;
                    //"Dispatch Time":=TIME;
                    //Status:=Status::Dispatched;
                    //"Link No":=NewNo;
                    //MODIFY;
                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    // if Patient.Find('-') then begin
                    //     Patient.Activated := true;
                    //     Patient."Active Visit No" := NewNo;
                    //     Patient.Modify;
                    // end;
                    Message('Selected Appointment has been dispatched to the Physiotheraphy Room.')
                end;
            }
            action(DispatchToLab)
            {
                Caption = 'Dispatch To Lab';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Dispatch To Lab action.';

                trigger OnAction()
                begin
                    /*DocLabRequestLines.RESET;
                    //DocLabRequestLines.SETRANGE(DocLabRequestLines."Laboratory No.","Appointment No.");
                    IF DocLabRequestLines.FIND('-') THEN BEGIN
                      //Procees
                    END ELSE BEGIN
                      ERROR('Please enter the lab tests to be done so as to proceed');
                    END;*/

                    if Confirm('Send Laboratory Test Request Now?', false) = true then begin
                        //IF "Settlement Type"="Settlement Type"::Insurance THEN BEGIN
                        //TESTFIELD("Insurance Member No");
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
                        LabHeader.Init();
                        LabHeader."Laboratory No." := NewNo;
                        LabHeader."Laboratory Date" := Today;
                        LabHeader."Laboratory Time" := Time;
                        LabHeader."Patient No." := Rec."Patient No.";
                        LabHeader."Request Area" := LabHeader."request area"::Doctor;
                        LabHeader."Link Type" := 'Appointment';
                        //LabHeader."Link No.":=TreatmentHeader."Appointment No.";
                        LabHeader.Insert();

                        //"Dispatch To":="Dispatch To";
                        //"Dispatch Date":=TODAY;
                        //"Dispatch Time":=TIME;
                        //Status:=Status::Dispatched;
                        //MODIFY;
                    end;
                    //END;
                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    if Patient.Find('-') then begin
                        Patient.Activated := true;
                        Patient."Active Visit No" := NewNo;
                        Patient.Modify();
                    end;
                end;
            }
            action(DispatchToRadiology)
            {
                Caption = 'Dispatch To Radiology';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Dispatch To Radiology action.';

                trigger OnAction()
                begin
                    if Confirm('Send Radiology Request?', false) = false then
                        exit;

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Radiology Nos", 0D, true);
                    RadiologyHeader.Reset();
                    RadiologyHeader.Init();
                    RadiologyHeader."Radiology No." := NewNo;
                    RadiologyHeader."Radiology Date" := Today;
                    RadiologyHeader."Radiology Time" := Time;
                    RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
                    RadiologyHeader."Patient No." := Rec."Patient No.";
                    //RadiologyHeader."Link No.":=TreatmentHeader."Treatment No.";

                    RadiologyHeader."Link Type" := 'Doctor';
                    RadiologyHeader.Insert();
                    /*-------------------
                        {Insert the lines}
                        TreatmentLine.RESET;
                        TreatmentLine.SETRANGE(TreatmentLine."Treatment No.","Treatment No.");
                        IF TreatmentLine.FIND('-') THEN
                          BEGIN
                            REPEAT
                              RadiologyLine.RESET;
                              RadiologyLine.INIT;
                                RadiologyLine."Radiology no.":=NewNo;
                                RadiologyLine."Radiology Type Code":=TreatmentLine."Radiology Type Code";
                                RadiologyLine."Clinical Summary &  Diagnosis":="Clinical Summary &  Diagnosis";
                               RadiologyLine."Required Investigation":="Required Investigation";
                              RadiologyLine."Previous Investigation":="Previous Investigation";
                              RadiologyLine.INSERT();
                            UNTIL TreatmentLine.NEXT=0;
                          END;
                          --------*/
                    //END;
                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    if Patient.Find('-') then begin
                        Patient.Activated := true;
                        Patient."Active Visit No" := NewNo;
                        Patient.Modify();
                    end;
                end;
            }
            action(CreateAppointment)
            {
                Caption = 'Create Appointment';
                ToolTip = 'Executes the Create Appointment action.';

                trigger OnAction()
                begin
                    myNoSeries := '';

                    HMSSetup.Get();
                    HMSSetup.TestField("Appointment Nos");
                    myNoSeries := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, true);

                    objPAtient.Reset();
                    objPAtient.SetRange(objPAtient."Patient No.", Rec."Patient No.");
                    if objPAtient.Find('-') then begin
                        Rec.Activated := true;
                        Rec."Active Visit No" := myNoSeries;
                        Rec.Modify();

                        Apponitment.Init();
                        Apponitment."Appointment No." := myNoSeries;
                        if Rec."Patient Type" = Rec."patient type"::Corporate then
                            Apponitment."Settlement Type" := Apponitment."settlement type"::Credit;
                        Apponitment."Patient No." := Rec."Patient No.";
                        Apponitment."Appointment Date" := Today;
                        Apponitment."Appointment Time" := Time;
                        Apponitment."Appointment Type" := 'NORMAL';
                        Apponitment."Insurance No" := Rec."Insurance No.";
                        Apponitment."Insurance Member No" := Rec."Membership No";
                        Apponitment."Patient Type" := Rec."Patient Type";
                        Apponitment.visitType := ItsNew;
                        Apponitment."Age in Years" := objPAtient."Age in Years";
                        Apponitment.Gender := objPAtient.Gender;
                        Apponitment.Insert();
                    end;

                    Page.Run(Page::"HMS Appointment Form Header", Apponitment);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."patient type"::Cash;
        Rec."Walk-in" := true;
        Rec.Activated := true;

        if Rec."Patient No." = '' then begin
            HMSSetup.Get();
            if Rec."Walk-in" = false then begin
                HMSSetup.TestField("Patient Nos");
                NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos");
            end
            else
                if Rec."Walk-in" = true then begin
                    HMSSetup.TestField("In Patient No");
                    NoSeriesMgt.GetNextNo(HMSSetup."In Patient No");
                end;
        end;
        Rec."Date Registered" := Today;
        Rec."User ID" := UserId;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Patient Type" := Rec."patient type"::Cash;
        Rec."Walk-in" := true;
        Rec.Activated := true;

        if Rec."Patient No." = '' then begin
            HMSSetup.Get();
            if Rec."Walk-in" = false then begin
                HMSSetup.TestField("Patient Nos");
                NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos");
            end
            else
                if Rec."Walk-in" = true then begin
                    HMSSetup.TestField("Walkin Nos");
                    NoSeriesMgt.GetNextNo(HMSSetup."Walkin Nos");
                end;
        end;
        Rec."Date Registered" := Today;
        Rec."User ID" := UserId;
    end;

    var
        Apponitment: Record "HMS Appointment Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        ObservHeader: Record "HMS Observation Form Header";
        objPAtient: Record "HMS Patient";
        Patient: Record "HMS Patient";
        Pharmacy: Record "HMS Pharmacy Header";
        PhysioHeader: Record "HMS Physiotheraphy Form Header";
        RadiologyHeader: Record "HMS Radiology Form Header";
        HMSSetup: Record "HMS Setup";
        HRDates: Codeunit "HR Dates";
        NoSeriesMgt: Codeunit "No. Series";
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        [InDataSet]
        "Student No.Enable": Boolean;
        myNoSeries: Code[20];
        NewNo: Code[20];
        ItsNew: Option New,Revisit;
        Age: Text[100];

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."patient type"::Corporate then begin
            "Student No.Enable" := true;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
        end
        else begin
            "Student No.Enable" := false;
            "Employee No.Enable" := true;
            "Relative No.Enable" := true;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;

    local procedure isLastVisitDayWithin7days() lastVisitDay: Integer
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;

        appointments.Reset();
        appointments.SetRange(appointments."Patient No.", Rec."Patient No.");
        appointments.SetCurrentkey("Appointment No.");
        if appointments.Find('+') then
            lastVisitDay := Today - appointments."Appointment Date";
    end;
}
