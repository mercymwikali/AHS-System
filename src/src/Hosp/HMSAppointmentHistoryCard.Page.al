page 52202711 "HMS Appointment History Card"
{
    PageType = Document;
    SourceTable = "HMS Appointment Form Header";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Appointment No."; Rec."Appointment No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                    trigger OnValidate()
                    begin
                        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';

                    trigger OnValidate()
                    begin
                        Rec.GetPatientName(Rec."Patient No.");
                        //GetPatientNo("Patient No.","Student No.","Employee No.","Relative No.");
                        GetAppointmentStats(Rec."Patient No.");
                    end;
                }
                field(SearchNames; Rec.SearchNames)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SearchNames field.';
                }
                field("Special Clinics"; Rec."Special Clinics")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Special Clinics field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor field.';
                    trigger OnValidate()
                    begin
                        Rec.GetDoctorName(Rec.Doctor);
                    end;
                }
                field("Doctors Name"; Rec."Doctors Name")
                {
                    Caption = 'Doctor Name';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Type field.';
                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;

                }
                field("Visit Balance"; Rec."Charges Count")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Visit Balance';
                    ToolTip = 'Specifies the value of the Visit Balance field.';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No field.';
                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin
                        cust.Get(Rec."Insurance No");
                        if cust.Minet = true then
                            Message('Minet MVC No. is required');
                    end;
                }
                field("Insurance Member No"; Rec."Insurance Member No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Member No field.';
                }
                field("MCC No."; Rec."MVC No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'LOU No';
                    ToolTip = 'Specifies the value of the LOU No field.';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Dispatch To"; Rec."Dispatch To")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dispatch To field.';
                }
                group("Appointment Statistics")
                {
                    Caption = 'Appointment Statistics';
                    field(IntScheduled; IntScheduled)
                    {
                        Caption = 'No. of appointments scheduled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments scheduled field.';
                    }
                    field(IntCompleted; IntCompleted)
                    {
                        Caption = 'No. of appointments completed';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments completed field.';
                    }
                    field(IntRescheduled; IntRescheduled)
                    {
                        Caption = 'No. of appointments rescheduled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments rescheduled field.';
                    }
                    field(IntCancelled; IntCancelled)
                    {
                        Caption = 'No. of appointments cancelled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments cancelled field.';
                    }
                }
            }
            part(Control1102760014; "HMS Appointment Form Line")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Patient No." = FIELD("Patient No.");
            }
        }
    }

    actions
    {
        area(processing)
        {


            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                                  "Appointment No." = FIELD("Appointment No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
            action("Posted Charges")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Posted Charges action.';
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Image = ReOpen;
                Promoted = true;
                caption = 'Re Open Visit';
                ToolTip = 'Executes the Re Open Visit action.';
                trigger OnAction()
                var
                    AppRec: Record "HMS Appointment Form Header";
                    PatRec: Record "HMS Patient";
                    CurrAppNo: Code[20];
                begin
                    if confirm('Do you really want to re-open the visit?', false) then begin
                        patrec.get(Rec."Patient No.");
                        if (Rec."Appointment Date" <> today) and (PatRec.Inpatient = false) then error('Please note that you can only open today visits');
                        CurrAppNo := Rec."Appointment No.";
                        Rec.status := Rec.status::New;
                        Rec."Re-Opened" := true;
                        Rec."Re-Opened Date" := today;
                        Rec."Re-Opened UserID" := UserId;
                        Rec.modify();
                        if AppRec.get(CurrAppNo) then
                            page.Run(Page::"HMS Appointment Form Header", AppRec);
                    end;
                end;
            }
            action("Dispatch To Doctor")
            {
                Caption = 'Dispatch To Triage';
                Image = ReleaseDoc;
                visible = false;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Triage action.';
                trigger OnAction()
                begin

                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Observation?', false) = false then exit;
                    begin
                        Rec.TestField("Settlement Type");
                        Rec.TestField("Appointment Date");
                        Rec.TestField("Appointment Time");
                        Rec.TestField("Patient Type");
                        Rec.TestField(Doctor);
                        Rec.TestField("Patient No.");
                        Rec.TestField("Appointment Type");
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        TreatmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);

                        AppType.Reset();
                        AppType.SetRange(AppType.Code, Rec."Appointment Type");
                        AppType.SetRange(AppType."Bill Consultancy Fee", true);
                        if AppType.Find('-') then begin

                            DoctorsRec.Reset();
                            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                            if DoctorsRec.Find('-') then
                                DoctorsRec.TestField("Consultation Code");
                            HMSPatientsCharges.Init();
                            //HMSPatientsCharges."Line No":=1;
                            HMSPatientsCharges."Patient No." := Rec."Patient No.";
                            HMSPatientsCharges."Link No" := NewNo;
                            HMSPatientsCharges."Treatment No." := NewNo;
                            HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                            Patient.Get(Rec."Patient No.");
                            if (Rec."Appointment Type" = 'NORMAL') and (Rec."Patient Type" = Rec."Patient Type"::Cash) then begin
                                HMSCharges.Get(DoctorsRec."Consultation Code Cash");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code Cash";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                                //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                            end else begin
                                HMSCharges.Get(DoctorsRec."Consultation Code");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";

                            end;
                            Patient.Get(Rec."Patient No.");
                            HMSPatientsCharges.Validate(Amount);
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                            HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                            HMSPatientsCharges."User ID" := UserId;
                            HMSPatientsCharges."Creation Date" := Today;
                            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                            if PatRec.Get(Rec."Patient No.") then begin
                                HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                                HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                            end;

                            HMSPatientsCharges.Insert();
                        end;
                        if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                            Rec.TestField("Insurance Member No");

                            recInsurance.Get(Rec."Insurance No");
                            if recInsurance.Minet = true then
                                if Rec."MVC No." = '' then Error('Minet MVC No. is required');

                            //LabHeader.RESET;

                            ObservHeader.Init();
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Patient No." := Rec."Patient No.";
                            ObservHeader."Observation Date" := Today;
                            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                            //ObservHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := Rec."Appointment No.";
                            ObservHeader.Doctor := Rec.Doctor;
                            ObservHeader."Treatment No" := TreatmentNo;
                            ObservHeader.Insert();

                            docHeader.Init();
                            docHeader."Treatment No." := TreatmentNo;
                            docHeader."Treatment Date" := Today;
                            docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                            docHeader."Doctor ID" := Rec.Doctor;
                            docHeader."Patient No." := Rec."Patient No.";
                            docHeader.Direct := true;
                            docHeader."Link No." := Rec."Appointment No.";
                            docHeader.Clinic := docHeader.Clinic;

                            docHeader."Link Type" := 'Outpatient';

                            docHeader.Insert();
                            //*************** for review cash to create and no need to send to cashier
                        end else
                            if Rec."Settlement Type" = Rec."Settlement Type"::Cash then begin
                                AppType.Reset();
                                AppType.SetRange(AppType.Code, Rec."Appointment Type");
                                AppType.SetRange(AppType."Bill Consultancy Fee", false);
                                if AppType.Find('-') then begin
                                    //LabHeader.RESET;
                                    if ObservHeader.Get(NewNo) then
                                        Message('Patient already at triage')
                                    else begin
                                        ObservHeader.Init();
                                        ObservHeader."Observation No." := NewNo;
                                        ObservHeader."Patient No." := Rec."Patient No.";
                                        ObservHeader."Observation Date" := Today;
                                        ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                                        ObservHeader."Treatment No" := TreatmentNo;
                                        //ObservHeader."Request Area"::Doctor;
                                        ObservHeader."Link Type" := 'Observation';
                                        ObservHeader.Doctor := Rec.Doctor;
                                        ObservHeader."Link No." := Rec."Appointment No.";
                                        ObservHeader.Insert();
                                    end;
                                    if docHeader.Get(TreatmentNo) then
                                        Message('Patient already at triage')
                                    else begin
                                        docHeader.Init();
                                        docHeader."Treatment No." := TreatmentNo;
                                        docHeader."Treatment Date" := Today;
                                        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                                        docHeader."Doctor ID" := Rec.Doctor;
                                        docHeader."Patient No." := Rec."Patient No.";
                                        docHeader.Direct := true;
                                        docHeader."Link No." := Rec."Appointment No.";
                                        docHeader.Clinic := docHeader.Clinic;

                                        docHeader."Link Type" := 'Outpatient';

                                        docHeader.Insert();
                                    end
                                end;
                            end;
                        //***************

                        //-------------------------
                        if Rec."Settlement Type" = Rec."Settlement Type"::Credit then begin

                            //LabHeader.RESET;
                            ObservHeader.Init();
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Patient No." := Rec."Patient No.";
                            ObservHeader."Observation Date" := Today;
                            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                            ObservHeader."Treatment No" := TreatmentNo;
                            ObservHeader.Doctor := Rec.Doctor;
                            //ObservHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := Rec."Appointment No.";
                            ObservHeader.Insert();
                        end;
                        //--------------------------
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec.Status := Rec.Status::Dispatched;
                        Rec."Triage Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec."Link No" := NewNo;
                        Rec.Modify();
                        if Rec."Settlement Type" = Rec."Settlement Type"::Cash then
                            CreateReceipt(Rec."Patient No.", Patient."Active Visit No")
                        else
                            Message('Selected Appointment has been dispatched to the Observation Room.');
                    end;

                    Message(Format(Today) + Format(Rec.Time));
                end;
            }
            action("Dispatch To Optical")
            {
                Caption = 'Dispatch To Optical';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                visible = false;
                ToolTip = 'Executes the Dispatch To Optical action.';
                trigger OnAction()
                begin

                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Observation?', false) = false then begin exit end;
                    begin
                        Rec.TestField("Settlement Type");
                        Rec.TestField("Appointment Date");
                        Rec.TestField("Appointment Time");
                        Rec.TestField("Patient Type");
                        Rec.TestField(Doctor);
                        Rec.TestField("Patient No.");
                        Rec.TestField("Appointment Type");
                        HMSSetup.Reset();
                        HMSSetup.Get();

                        TreatmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);

                        if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                            Rec.TestField("Insurance Member No");

                            recInsurance.Get(Rec."Insurance No");
                            if recInsurance.Minet = true then
                                if Rec."MVC No." = '' then Error('Minet MCC No. is required');
                            //LabHeader.RESET;

                        end;
                        if not ObservHeader.Get(NewNo) then
                            ObservHeader.Init();
                        ObservHeader."Observation No." := NewNo;
                        ObservHeader."Patient No." := Rec."Patient No.";
                        ObservHeader."Observation Date" := Today;
                        ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                        ObservHeader."Treatment No" := TreatmentNo;
                        ObservHeader.Doctor := Rec.Doctor;
                        //ObservHeader."Request Area"::Doctor;
                        ObservHeader."Link Type" := 'Observation';
                        ObservHeader."Link No." := Rec."Appointment No.";
                        ObservHeader.Insert();


                        AppType.Reset();
                        AppType.SetRange(AppType.Code, Rec."Appointment Type");
                        AppType.SetRange(AppType."Bill Consultancy Fee", true);
                        if AppType.Find('-') then begin

                            DoctorsRec.Reset();
                            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                            if DoctorsRec.Find('-') then
                                DoctorsRec.TestField("Consultation Code");
                            HMSPatientsCharges.Init();
                            //HMSPatientsCharges."Line No":=1;
                            HMSPatientsCharges."Patient No." := Rec."Patient No.";
                            HMSPatientsCharges."Link No" := NewNo;
                            HMSPatientsCharges."Treatment No." := NewNo;
                            HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                            Patient.Get(Rec."Patient No.");
                            if (Rec."Appointment Type" = 'NORMAL') and (Rec."Patient Type" = Rec."Patient Type"::Cash) then begin
                                HMSCharges.Get(DoctorsRec."Consultation Code Cash");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code Cash";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                                //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                            end
                            else begin
                                HMSCharges.Get(DoctorsRec."Consultation Code");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";

                                Patient.Get(Rec."Patient No.");
                            end;

                            HMSPatientsCharges.Validate(Amount);
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                            HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                            HMSPatientsCharges."User ID" := UserId;
                            HMSPatientsCharges."Creation Date" := Today;
                            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                            if PatRec.Get(Rec."Patient No.") then begin
                                HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                                HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                            end;

                            HMSPatientsCharges.Insert();
                        end;

                        //*************** for review cash to create and no need to send to cashier
                        if Rec."Settlement Type" = Rec."Settlement Type"::Cash then begin
                            AppType.Reset();
                            AppType.SetRange(AppType.Code, Rec."Appointment Type");
                            AppType.SetRange(AppType."Bill Consultancy Fee", false);
                            if AppType.Find('-') then begin
                                //LabHeader.RESET;
                                ObservHeader.Init();
                                ObservHeader."Observation No." := NewNo;
                                ObservHeader."Patient No." := Rec."Patient No.";
                                ObservHeader."Observation Date" := Today;
                                ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                                ObservHeader."Treatment No" := TreatmentNo;
                                ObservHeader.Doctor := Rec.Doctor;
                                //ObservHeader."Request Area"::Doctor;
                                ObservHeader."Link Type" := 'Observation';
                                ObservHeader."Link No." := Rec."Appointment No.";
                                ObservHeader.Insert();
                            end;
                        end;
                        //***************

                        //-------------------------
                        if Rec."Settlement Type" = Rec."Settlement Type"::Credit then begin

                            //LabHeader.RESET;
                            ObservHeader.Init();
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Patient No." := Rec."Patient No.";
                            ObservHeader."Observation Date" := Today;
                            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                            ObservHeader."Treatment No" := TreatmentNo;
                            ObservHeader.Doctor := Rec.Doctor;
                            //ObservHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := Rec."Appointment No.";
                            ObservHeader.Insert();
                        end;
                        //--------------------------
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec.Status := Rec.Status::Dispatched;
                        Rec."Triage Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec."Link No" := NewNo;
                        Rec.Modify();

                        docHeader.Init();
                        docHeader."Treatment No." := TreatmentNo;
                        docHeader."Treatment Date" := Today;
                        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                        docHeader."Doctor ID" := Rec.Doctor;
                        docHeader."Patient No." := Rec."Patient No.";
                        docHeader.Direct := true;
                        docHeader."Link No." := Rec."Appointment No.";
                        docHeader.Clinic := docHeader.Clinic;

                        docHeader."Link Type" := 'Outpatient';

                        docHeader.Insert();
                        Message('Selected Appointment has been dispatched to the Observation Room.');
                    end;
                    Message(Format(Today) + Format(Rec.Time));
                end;
            }
            action("Dispatch To Dental")
            {
                Caption = 'Dispatch To Dental';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                visible = false;
                ToolTip = 'Executes the Dispatch To Dental action.';
                trigger OnAction()
                begin

                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Observation?', false) = false then begin exit end;
                    begin
                        Rec.TestField("Settlement Type");
                        Rec.TestField("Appointment Date");
                        Rec.TestField("Appointment Time");
                        Rec.TestField("Patient Type");
                        Rec.TestField(Doctor);
                        Rec.TestField("Patient No.");
                        Rec.TestField("Appointment Type");

                        HMSSetup.Reset();
                        HMSSetup.Get();
                        // 1. Get Treatment and Nos
                        TreatmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
                        if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                            Rec.TestField("Insurance Member No");

                            recInsurance.Get(Rec."Insurance No");
                            if recInsurance.Minet = true then
                                if Rec."MVC No." = '' then Error('Minet MVC No. is required');
                            //LabHeader.RESET;
                            ObservHeader.Init();
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Patient No." := Rec."Patient No.";
                            ObservHeader."Observation Date" := Today;
                            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                            ObservHeader.Doctor := Rec.Doctor;
                            ObservHeader."Treatment No" := TreatmentNo;
                            ObservHeader.Doctor := Rec.Doctor;
                            //ObservHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := Rec."Appointment No.";
                            ObservHeader.Insert();

                            docHeader.Init();
                            docHeader."Treatment No." := TreatmentNo;
                            docHeader."Treatment Date" := Today;
                            docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                            docHeader."Doctor ID" := Rec.Doctor;
                            docHeader."Patient No." := Rec."Patient No.";
                            docHeader.Direct := true;
                            docHeader."Link No." := Rec."Appointment No.";
                            docHeader.Clinic := docHeader.Clinic;

                            docHeader."Link Type" := 'Outpatient';

                            docHeader.Insert();

                        end;

                        AppType.Reset();
                        AppType.SetRange(AppType.Code, Rec."Appointment Type");
                        AppType.SetRange(AppType."Bill Consultancy Fee", true);
                        if AppType.Find('-') then begin

                            DoctorsRec.Reset();
                            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                            if DoctorsRec.Find('-') then
                                DoctorsRec.TestField("Consultation Code");
                            HMSPatientsCharges.Init();
                            //HMSPatientsCharges."Line No":=1;
                            HMSPatientsCharges."Patient No." := Rec."Patient No.";
                            HMSPatientsCharges."Link No" := NewNo;
                            HMSPatientsCharges."Treatment No." := NewNo;
                            HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                            Patient.Get(Rec."Patient No.");
                            if (Rec."Appointment Type" = 'NORMAL') and (Rec."Patient Type" = Rec."Patient Type"::Cash) then begin
                                HMSCharges.Get(DoctorsRec."Consultation Code Cash");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code Cash";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                                //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                            end else begin
                                HMSCharges.Get(DoctorsRec."Consultation Code");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";


                            end;
                            Patient.Get(Rec."Patient No.");
                            HMSPatientsCharges.Validate(Amount);
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                            HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                            HMSPatientsCharges."User ID" := UserId;
                            HMSPatientsCharges."Creation Date" := Today;
                            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                            if PatRec.Get(Rec."Patient No.") then begin
                                HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                                HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                            end;

                            HMSPatientsCharges.Insert();
                        end;

                        //*************** for review cash to create and no need to send to cashier
                        if Rec."Settlement Type" = Rec."Settlement Type"::Cash then begin
                            AppType.Reset();
                            AppType.SetRange(AppType.Code, Rec."Appointment Type");
                            AppType.SetRange(AppType."Bill Consultancy Fee", false);
                            if AppType.Find('-') then begin
                                //LabHeader.RESET;
                                ObservHeader.Init();
                                ObservHeader."Observation No." := NewNo;
                                ObservHeader."Patient No." := Rec."Patient No.";
                                ObservHeader."Observation Date" := Today;
                                ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                                ObservHeader."Treatment No" := TreatmentNo;
                                ObservHeader.Doctor := Rec.Doctor;
                                //ObservHeader."Request Area"::Doctor;
                                ObservHeader."Link Type" := 'Observation';
                                ObservHeader."Link No." := Rec."Appointment No.";
                                ObservHeader.Insert();
                            end;
                        end;
                        //***************

                        //-------------------------
                        if Rec."Settlement Type" = Rec."Settlement Type"::Credit then begin

                            //LabHeader.RESET;
                            ObservHeader.Init();
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Patient No." := Rec."Patient No.";
                            ObservHeader."Observation Date" := Today;
                            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
                            ObservHeader."Treatment No" := TreatmentNo;
                            ObservHeader.Doctor := Rec.Doctor;
                            //ObservHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := Rec."Appointment No.";
                            ObservHeader.Insert();
                        end;
                        //--------------------------
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec."Triage Time In" := System.CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec.Status := Rec.Status::Dispatched;
                        Rec."Link No" := NewNo;
                        Rec.Modify();



                        Message('Selected Appointment has been dispatched to the Observation Room.');
                    end;
                    Message(Format(Today) + Format(Rec.Time));
                end;
            }
            action(Action7)
            {
                Caption = 'Dispatch To MCH';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                visible = false;
                ToolTip = 'Executes the Dispatch To MCH action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Doctor?', false) = false then exit;

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Appointment Date");
                    Rec.TestField("Appointment Time");
                    Rec.TestField("Patient Type");
                    Rec.TestField(Doctor);
                    Rec.TestField("Patient No.");
                    Rec.TestField("Appointment Type");
                    // TestField("Special Clinics", "Special Clinics"::MCH); TODO Implement new Dispatch action
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                    if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                        Rec.TestField("Insurance Member No");
                        docHeader.Init();
                        docHeader."Treatment No." := NewNo;
                        docHeader."Treatment Date" := Today;
                        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                        docHeader."Doctor ID" := Rec.Doctor;
                        docHeader."Patient No." := Rec."Patient No.";
                        docHeader.Direct := true;
                        docHeader."Link No." := Rec."Appointment No.";
                        docHeader.Clinic := docHeader.Clinic;
                        // docHeader."Special Clinics" := "Special Clinics"::MCH; TODO Implement new Dispatch action
                        docHeader."Link Type" := 'Outpatient';

                        docHeader.Insert();
                    end;
                    if AppType.Get(Rec."Appointment Type") then begin
                        DoctorsRec.Reset();
                        DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                        if DoctorsRec.Find('-') then DoctorsRec.TestField("Consultation Code");
                        HMSPatientsCharges.Init();
                        //HMSPatientsCharges."Line No":=1;
                        HMSPatientsCharges."Patient No." := Rec."Patient No.";
                        HMSPatientsCharges."Link No" := NewNo;
                        HMSPatientsCharges."Treatment No." := NewNo;
                        HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                        Patient.Get(Rec."Patient No.");
                        if (Rec."Appointment Type" = 'NORMAL') and (Rec."Patient Type" = Rec."Patient Type"::Cash) then begin
                            HMSCharges.Get(DoctorsRec."Consultation Code Cash");
                            HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                            HMSPatientsCharges.Validate("Transaction Type");
                            HMSPatientsCharges.Code := DoctorsRec."Consultation Code Cash";
                            HMSPatientsCharges.Validate(Code);
                            HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                            //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                        end else begin
                            HMSCharges.Get(DoctorsRec."Consultation Code");
                            HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                            HMSPatientsCharges.Validate("Transaction Type");
                            HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                            HMSPatientsCharges.Validate(Code);
                            HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";

                            Patient.Get(Rec."Patient No.");

                        end;
                        HMSPatientsCharges.Validate(Amount);
                        HMSPatientsCharges.Date := Today;
                        HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                        HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                        HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                        HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                        HMSPatientsCharges."User ID" := UserId;
                        HMSPatientsCharges."Creation Date" := Today;
                        HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                        if PatRec.Get(Rec."Patient No.") then begin
                            HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                            HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                        end;

                        // HMSPatientsCharges.Insert;
                    end;


                    //"Dispatch To":="Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                    Rec."User ID" := UserId;
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Triage Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    Message('Selected Appointment has been dispatched to the MCH.')
                end;
            }
            action(Action9)
            {
                Caption = 'Dispatch To Day Case';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                visible = false;
                ToolTip = 'Executes the Dispatch To Day Case action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Doctor?', false) = false then begin
                        exit
                    end;
                    Rec.TestField("Settlement Type");
                    Rec.TestField("Appointment Date");
                    Rec.TestField("Appointment Time");
                    Rec.TestField("Patient Type");
                    Rec.TestField(Doctor);
                    Rec.TestField("Patient No.");
                    Rec.TestField("Appointment Type");
                    // TestField("Special Clinics", "Special Clinics"::"Day Case"); TODO Implement new Dispatch action
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                    if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                        Rec.TestField("Insurance Member No");
                        docHeader.Init();
                        docHeader."Treatment No." := NewNo;
                        docHeader."Treatment Date" := Today;
                        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                        docHeader."Doctor ID" := Rec.Doctor;
                        docHeader."Patient No." := Rec."Patient No.";
                        docHeader.Direct := true;
                        docHeader."Link No." := Rec."Appointment No.";
                        docHeader.Clinic := docHeader.Clinic;
                        // docHeader."Special Clinics" := "Special Clinics"::"Day Case"; TODO Implement new Dispatch action
                        docHeader."Link Type" := 'Outpatient';

                        docHeader.Insert();
                    end;
                    /*     if AppType.Get("Appointment Type") then begin
                            DoctorsRec.Reset;
                            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
                            if DoctorsRec.Find('-') then DoctorsRec.TestField("Consultation Code");
                            HMSPatientsCharges.Init;
                            //HMSPatientsCharges."Line No":=1;
                            HMSPatientsCharges."Patient No." := "Patient No.";
                            HMSPatientsCharges."Link No" := NewNo;
                            HMSPatientsCharges."Treatment No." := NewNo;
                            HMSPatientsCharges."Appointment No." := "Appointment No.";
                            Patient.Get("Patient No.");
                            if ("Appointment Type" = 'NORMAL') and ("Patient Type" = "Patient Type"::Cash) then begin
                                HMSCharges.Get(DoctorsRec."Consultation Code Cash");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code Cash";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                                //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                            end else begin
                                HMSCharges.Get(DoctorsRec."Consultation Code");
                                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                                HMSPatientsCharges.Validate("Transaction Type");
                                HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                                HMSPatientsCharges.Validate(Code);
                                HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";

                                Patient.Get("Patient No.");

                            end;
                            HMSPatientsCharges.Validate(Amount);
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                            HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                            HMSPatientsCharges."User ID" := UserId;
                            HMSPatientsCharges."Creation Date" := Today;
                            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                            if PatRec.Get("Patient No.") then begin
                                HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                                HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                            end;

                             HMSPatientsCharges.Insert;
                        end; */


                    //"Dispatch To":="Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                    Rec."User ID" := UserId;
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Triage Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    Message('Selected Appointment has been dispatched to the Day Case')
                end;
            }
            action(CreateDirectAdmission)
            {
                Caption = 'Dispatch to Admission (Direct)';
                Image = SetPriorities;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                visible = false;
                ToolTip = 'Executes the Dispatch to Admission (Direct) action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Rec."Patient No.");
                    Patient.SetRange(Patient.Inpatient, true);
                    if Patient.Find('-') then Error('the patient is in the wards currently no need to re-admit');


                    if Confirm('Send the admission request?', false) = false then begin exit end;

                    //---Insert into Treatment Table---------------------------------------------------------------------
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                    //IF "Settlement Type"="Settlement Type"::Insurance THEN BEGIN
                    Rec.TestField("Insurance Member No");
                    docHeader.Init();
                    docHeader."Treatment No." := NewNo;
                    docHeader."Treatment Date" := Today;
                    docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                    docHeader."Doctor ID" := Rec.Doctor;
                    docHeader."Treatment Type" := docHeader."Treatment Type"::Inpatient;
                    docHeader."Patient No." := Rec."Patient No.";
                    docHeader.Direct := true;
                    docHeader."Link No." := Rec."Appointment No.";
                    //:=LabHeader."Request Area"::Doctor;
                    docHeader."Link Type" := 'InPatient';
                    //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
                    docHeader.Insert();
                    //END;

                    if AppType.Get(Rec."Appointment Type") then begin
                        //DoctorsRec.GET(Doctor);
                        DoctorsRec.Reset();
                        DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                        if DoctorsRec.Find('-') then
                            DoctorsRec.TestField("Consultation Code");
                        HMSPatientsCharges.Init();
                        //HMSPatientsCharges."Line No":=1;
                        HMSPatientsCharges."Transaction Type" := 'ADMISSION';
                        HMSPatientsCharges.Validate("Transaction Type");
                        HMSPatientsCharges."Patient No." := Rec."Patient No.";
                        HMSPatientsCharges."Link No" := NewNo;
                        HMSPatientsCharges."Treatment No." := NewNo;
                        HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                        HMSPatientsCharges.Code := 'ADMISSION FEE';
                        HMSPatientsCharges.Description := DoctorsRec."Consultation Code";
                        //HMSCharges.GET(DoctorsRec."Consultation Code");
                        HMSPatientsCharges.Amount := HMSCharges.Amount;
                        HMSPatientsCharges.Validate(Amount);
                        HMSPatientsCharges.Date := Today;
                        // HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
                        ///HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                        HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                        HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                        HMSPatientsCharges."User ID" := UserId;
                        HMSPatientsCharges."Creation Date" := Today;
                        HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                        HMSPatientsCharges."Visit No" := Rec."Appointment No.";
                        //  HMSPatientsCharges.Insert;
                    end;



                    Rec."Dispatch To" := Rec."Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := System.DT2TIME(CurrentDateTime);
                    Rec."User ID" := UserId;
                    Rec."Triage Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    //--------------------------------------------------------------------------


                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

                    begin

                        AdmissionHeader.Reset();
                        AdmissionHeader.Init();
                        AdmissionHeader."Admission No." := NewNo;
                        AdmissionHeader."Admission Date" := Today;
                        AdmissionHeader."Admission Time" := DT2TIME(System.CurrentDateTime);
                        AdmissionHeader."Admission Area" := AdmissionHeader."Admission Area"::Referral;
                        AdmissionHeader."Patient No." := Rec."Patient No.";
                        AdmissionHeader.Doctor := Rec.Doctor;
                        AdmissionHeader.Status := AdmissionHeader.Status::New;
                        AdmissionHeader.Remarks := 'Direct Admission';
                        AdmissionHeader."Admission Reason" := 'Direct Admission';
                        AdmissionHeader."Link Type" := 'Direct Admission';
                        AdmissionHeader."Link No." := docHeader."Treatment No.";
                        AdmissionHeader.Insert();
                    end;

                    //  PatientCU.AssignCurrentAdmNo("Patient No.", NewNo);
                    if AdmissionHeader.get(NewNo) then
                        PAGE.Run(51812, AdmissionHeader);

                end;
            }
            action(Action5)
            {
                Caption = 'Dispatch To Doctor';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Doctor action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Doctor?', false) = false then begin
                        exit
                    end;
                    Rec.TestField("Settlement Type");
                    Rec.TestField("Appointment Date");
                    Rec.TestField("Appointment Time");
                    Rec.TestField("Patient Type");
                    Rec.TestField(Doctor);
                    Rec.TestField("Patient No.");
                    Rec.TestField("Appointment Type");
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                    if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then begin
                        Rec.TestField("Insurance Member No");
                        docHeader.Init();
                        docHeader."Treatment No." := NewNo;
                        docHeader."Treatment Date" := Today;
                        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
                        docHeader."Doctor ID" := Rec.Doctor;
                        docHeader."Patient No." := Rec."Patient No.";
                        docHeader.Direct := true;
                        docHeader."Link No." := Rec."Appointment No.";
                        docHeader.Clinic := docHeader.Clinic;

                        docHeader."Link Type" := 'Outpatient';

                        docHeader.Insert();
                    end;
                    if AppType.Get(Rec."Appointment Type") then begin
                        DoctorsRec.Reset();
                        DoctorsRec.SetRange(DoctorsRec."Doctor ID", Rec.Doctor);
                        if DoctorsRec.Find('-') then DoctorsRec.TestField("Consultation Code");
                        HMSPatientsCharges.Init();
                        //HMSPatientsCharges."Line No":=1;
                        HMSPatientsCharges."Patient No." := Rec."Patient No.";
                        HMSPatientsCharges."Link No" := NewNo;
                        HMSPatientsCharges."Treatment No." := NewNo;
                        HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                        HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                        HMSPatientsCharges."Transaction Type" := 'CONSULTATION';
                        HMSPatientsCharges.Validate("Transaction Type");
                        HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";
                        HMSCharges.Get(DoctorsRec."Consultation Code");
                        HMSPatientsCharges.Amount := HMSCharges.Amount;
                        HMSPatientsCharges.Validate(Amount);
                        // HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
                        //  HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                        HMSPatientsCharges.Date := Today;
                        HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                        HMSPatientsCharges."User ID" := UserId;
                        HMSPatientsCharges."Creation Date" := Today;
                        HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                        HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                        if PatRec.Get(Rec."Patient No.") then begin
                            HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                            HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                        end;
                        HMSPatientsCharges.Insert();
                    end;


                    //"Dispatch To":="Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                    Rec."User ID" := UserId;
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Triage Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    Message('Selected Appointment has been dispatched to the Doctor.')
                end;
            }
            action("Dispatch To Physio")
            {
                Caption = 'Dispatch To Physio';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Physio action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    if Confirm('Dispatch selected Appointment to Physiotheraphy?', false) = false then begin exit end;
                    Rec.TestField("Settlement Type");
                    Rec.TestField("Appointment Date");
                    Rec.TestField("Appointment Time");
                    Rec.TestField("Patient Type");
                    Rec.TestField("Patient No.");
                    Rec.TestField("Appointment Type");

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Physio Nos", 0D, true);
                    TreatmentHeader.Reset();
                    TreatmentHeader.Get(Rec."Appointment No.");
                    LabHeader.Reset();
                    PhysioHeader.Init();
                    PhysioHeader."No." := NewNo;
                    PhysioHeader."Physio Date" := Today;
                    PhysioHeader."Physio Time" := DT2TIME(System.CurrentDateTime);
                    PhysioHeader."Patient No." := TreatmentHeader."Patient No.";
                    PhysioHeader."Link Type" := 'Observation';
                    PhysioHeader."Link No." := TreatmentHeader."Appointment No.";
                    PhysioHeader.Insert();

                    HMSSetup.testfield("Physio Fee Code");
                    HMSPatientsCharges.Init();
                    //HMSPatientsCharges."Line No":=1;
                    HMSPatientsCharges."Patient No." := Rec."Patient No.";
                    HMSPatientsCharges."Link No" := NewNo;
                    HMSPatientsCharges."Treatment No." := NewNo;
                    HMSPatientsCharges."Appointment No." := Rec."Appointment No.";
                    Patient.Get(Rec."Patient No.");

                    HMSCharges.Get(HMSSetup."Physio Fee Code");
                    HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                    HMSPatientsCharges.Validate("Transaction Type");
                    HMSPatientsCharges.Code := HMSSetup."Physio Fee Code";
                    HMSPatientsCharges.Validate(Code);
                    HMSPatientsCharges.Description := DoctorsRec."Consultation Code Cash" + ' - ' + DoctorsRec."Doctor ID";
                    //  HMSPatientsCharges.Amount := HMSCharges.Amount;

                    HMSPatientsCharges.Validate(Amount);
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                    HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                    HMSPatientsCharges."User ID" := UserId;
                    HMSPatientsCharges."Creation Date" := Today;
                    HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                    if PatRec.Get(Rec."Patient No.") then begin
                        HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                        HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                    end;

                    HMSPatientsCharges.Insert();
                    //END;
                    //"Dispatch To":="Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Triage Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    Message('Selected Appointment has been dispatched to the Physiotheraphy Room.')
                end;
            }
            action("Dispatch To Lab")
            {
                Caption = 'Dispatch To Lab';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Lab action.';
                trigger OnAction()
                begin
                    /*DocLabRequestLines.RESET;
                    DocLabRequestLines.SETRANGE(DocLabRequestLines."Laboratory No.","Appointment No.");
                    IF DocLabRequestLines.FIND('-') THEN BEGIN
                      //Procees
                    END ELSE BEGIN
                      ERROR('Please enter the lab tests to be done so as to proceed');
                    END;
                    */
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    if Confirm('Send Laboratory Test Request Now?', false) = true then begin
                        Rec.TestField("Settlement Type");
                        Rec.TestField("Appointment Date");
                        Rec.TestField("Appointment Time");
                        Rec.TestField("Patient Type");
                        Rec.TestField("Patient No.");
                        Rec.TestField("Appointment Type");

                        if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then
                            Rec.TestField("Insurance Member No");
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
                        TreatmentHeader.Reset();
                        TreatmentHeader.Get(Rec."Appointment No.");
                        LabHeader.Reset();
                        LabHeader.Init();
                        LabHeader."Laboratory No." := NewNo;
                        LabHeader."Laboratory Date" := Today;
                        LabHeader."Laboratory Time" := DT2TIME(System.CurrentDateTime);
                        LabHeader."Patient No." := TreatmentHeader."Patient No.";
                        LabHeader."Request Area" := LabHeader."Request Area"::Doctor;
                        LabHeader."Link Type" := 'Appointment';
                        LabHeader."Link No." := TreatmentHeader."Appointment No.";
                        labheader2.Reset();
                        labheader2.SetRange(labheader2."Link No.", TreatmentHeader."Appointment No.");
                        if labheader2.Find('-') then begin
                            if Confirm('Record already exist,Confirm Continue?') then LabHeader.Insert();
                        end
                        else begin
                            LabHeader.Insert();
                        end;
                        DocLabRequestLines.Reset();
                        DocLabRequestLines.SetRange(DocLabRequestLines."Laboratory No.", Rec."Appointment No.");
                        //DocLabRequestLines.SETRANGE(DocLabRequestLines.Status,DocLabRequestLines.Status::New);
                        if DocLabRequestLines.Find('-') then begin
                            repeat

                                LabTestLines.Init();
                                LabTestLines."Laboratory No." := NewNo;
                                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Code";
                                LabTestLines."Specimen Code" := DocLabRequestLines."Specimen Code";
                                LabTestLines."Measuring Unit Code" := DocLabRequestLines."Measuring Unit Code";
                                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Name";
                                LabTestLines."Specimen Name" := DocLabRequestLines."Specimen Name";
                                LabTestLines.Insert();

                            until DocLabRequestLines.Next() = 0;
                        end;

                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec.Status := Rec.Status::Dispatched;
                        Rec."Lab Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec.Modify();
                    end;
                    //END;

                end;
            }

            action("Dispatch To Phamarcy")
            {
                Caption = 'Dispatch To Phamarcy';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Phamarcy action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    if Confirm('Alert Pharmacy About Prescription?') = false then begin exit end;
                    /*
                    TESTFIELD("Settlement Type");
                    TESTFIELD("Appointment Date");
                    TESTFIELD("Appointment Time");
                    TESTFIELD("Patient Type");
                    TESTFIELD("Patient No.");
                    TESTFIELD("Appointment Type");
                    */
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                    /*Get the treatment from the database*/
                    TreatmentHeader.Reset();
                    if TreatmentHeader.Get(Rec."Appointment No.") then begin
                        PharmHeader.Reset();
                        PharmHeader.Init();
                        PharmHeader."Pharmacy No." := NewNo;
                        PharmHeader."Pharmacy Date" := Today;
                        PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                        PharmHeader."Request Area" := PharmHeader."Request Area"::Doctor;
                        PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                        PharmHeader."Student No." := TreatmentHeader."Student No.";
                        PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                        PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                        PharmHeader."Link Type" := 'Appointment';
                        PharmHeader."Link No." := TreatmentHeader."Appointment No.";
                        PharmHeader.Insert();

                        //"Dispatch To":="Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec."Pharmacy Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec.Status := Rec.Status::Dispatched;
                        Rec.Modify();
                        if Confirm('The Prescription has been sent to pharmacy,Do you want to open the issue form?', true) then
                            page.Run(70135118, PharmHeader);
                        //Message('The Prescription has been sent to the Pharmacy for Issuance');
                    end;

                end;
            }
            action("Dispatch To Radiology")
            {
                Caption = 'Dispatch To Radiology';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Radiology action.';
                trigger OnAction()
                begin
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    if Confirm('Send Radiology Request?', false) = false then begin exit end;

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Radiology Nos", 0D, true);
                    RadiologyHeader.Reset();
                    RadiologyHeader.Init();
                    RadiologyHeader."Radiology No." := NewNo;
                    RadiologyHeader."Radiology Date" := Today;
                    RadiologyHeader."Radiology Time" := DT2TIME(System.CurrentDateTime);
                    RadiologyHeader."Radiology Area" := RadiologyHeader."Radiology Area"::Doctor;
                    RadiologyHeader."Patient No." := Rec."Patient No.";
                    RadiologyHeader."Link No." := NewNo;

                    RadiologyHeader."Link Type" := 'Doctor';
                    RadiologyHeader.Insert();

                    //END;

                    //"Dispatch To":="Dispatch To";
                    Rec."Dispatch Date" := Today;
                    Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                    Rec.Status := Rec.Status::Dispatched;
                    Rec."Imaging Time In" := CurrentDateTime;
                    Rec."Waiting At" := Rec."Waiting At";
                    Rec."Link No" := NewNo;
                    Rec.Modify();
                    //  REPORT.RUN(70135008,TRUE,TRUE,TreatmentHeader);
                    Message('Radiology Test Request Forwarded');
                end;
            }
            separator(Separator3)
            {
            }


        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.GetDoctorName(Rec.Doctor);
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then Rec."Settlement Type" := Rec."Settlement Type"::Insurance;
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
        "Relative No.Visible" := true;
        "Employee No.Visible" := true;
        Rec."User ID" := UserId;
    end;

    procedure CreateReceipt(PatientNo: code[20]; VisitNo: code[20])
    var
        CashOfficeSetup: Record "Cash Office Setup";
        RecHeader: Record "Receipts Header";
        UserSetup: Record "User Setup";
        ReceiptNo: code[20];
    begin
        if Usersetup.get(Database.UserId) then;

        CashOfficeSetup.get();
        CashOfficeSetup.TestField("Receipts No");
        ReceiptNo := NoSeriesMgt.GetNextNo(CashOfficeSetup."Receipts No", 0D, true);
        RecHeader.init();
        RecHeader."No." := ReceiptNo;
        RecHeader.Date := today;
        RecHeader.Cashier := database."UserID";
        RecHeader."Global Dimension 1 Code" := userSetup."Branch Code";
        RecHeader."Patient No." := PatientNo;
        RecHeader."Patient Appointment No" := VisitNo;
        RecHeader.insert();
        if RecHeader.get(ReceiptNo) then begin
            RecHeader.validate("Patient Appointment No");
            page.run(70135338, RecHeader);
        end;

    end;

    var
        AdmissionHeader: Record "HMS Admission Form Header";
        AppType: Record "HMS Setup Appointment Type";
        docHeader: Record "HMS Treatment Form Header";
        DocLabRequestLines: Record "HMS Laboratory Test Line";
        DoctorsRec: Record "HMS Setup Doctor";
        HMSCharges: Record "HMS Charges";
        HMSPatientsCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        labheader2: Record "HMS Laboratory Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        LabTestLines: Record "HMS Laboratory Test Line";
        ObservHeader: Record "HMS Observation Form Header";
        Patient: Record "HMS Patient";
        PatRec: Record "HMS Patient";
        PharmHeader: Record "HMS Pharmacy Header";
        PhysioHeader: Record "HMS Physiotheraphy Form Header";
        RadiologyHeader: Record "HMS Radiology Form Header";
        recInsurance: Record Customer;
        TreatH: Record "HMS Treatment Form Header";
        TreatmentHeader: Record "HMS Appointment Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PatientCU: Codeunit "HMS Patient-integration";
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Employee No.Visible": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        [InDataSet]
        "Relative No.Visible": Boolean;
        [InDataSet]
        "Student No.Enable": Boolean;
        LastAppointmentDoctor: Code[20];
        LastAppointmentType: Code[20];
        NewNo: Code[20];
        TreatmentNo: Code[20];
        LastDate: Date;
        IntCancelled: Integer;
        IntCompleted: Integer;
        IntRescheduled: Integer;
        IntScheduled: Integer;
        Age: Text[100];
        AppointmentTypeName: Text[100];
        DoctorName: Text[100];
        PatientName: Text[100];
        LastTime: Time;

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
            "Student No.Enable" := false;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
            "Employee No.Visible" := false;
            "Relative No.Visible" := false;
        end
        else begin
            "Student No.Enable" := false;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
            "Employee No.Visible" := true;
            "Relative No.Visible" := true;

        end;
    end;

    procedure GetAppointmentTypeName(var AppointmentTypeName: Text[100]; var AppointmentTypeCode: Code[20])
    var
        AppType: Record "HMS Setup Appointment Type";
    begin
        AppType.Reset();
        if AppType.Get(AppointmentTypeCode) then begin AppointmentTypeName := AppType.Description end;
    end;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
        end;
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
            if Rec."Patient Type" = Rec."Patient Type"::Corporate then Rec."Settlement Type" := Rec."Settlement Type"::Insurance;
        end;
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        Patient: Record "HMS Patient";
        HRDates: Codeunit "HR Dates";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
            if Patient."Date Of Birth" = 0D then begin
                Age := '';
            end
            else begin
                Age := HRDates.DetermineAge(Patient."Date Of Birth", Today);
            end;
        end;
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS Setup Doctor";
    begin
        Doctor.Reset();
        Doctor.SetRange(Doctor."Doctor ID", DoctorCode);
        if Doctor.Find('-') then begin
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
        end;
    end;

    procedure GetAppointmentStats(var PatientNo: Code[20])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
            Patient.CalcFields(Patient."Appointments Scheduled", Patient."Appointments Completed", Patient."Appointments Rescheduled");
            IntScheduled := Patient."Appointments Scheduled";
            IntCompleted := Patient."Appointments Completed";
            IntRescheduled := Patient."Appointments Rescheduled";
            Patient.CalcFields(Patient."Appointments Cancelled");
            IntCancelled := Patient."Appointments Cancelled";
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
        Rec.GetDoctorName(Rec.Doctor);
        Rec.GetPatientName(Rec."Patient No.");
        Rec.GetPatientAge(Rec."Patient No.", Age);
        GetAppointmentStats(Rec."Patient No.");
    end;
}

