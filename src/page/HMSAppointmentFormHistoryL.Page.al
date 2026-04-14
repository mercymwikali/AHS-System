page 85313 "HMS Appointment Form History L"
{
    CardPageId = "HMS Appointment History Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(<> new));
    layout
    {
        area(content)
        {
            repeater(Control1)
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
                    /*   trigger OnValidate()
                      begin
                          GetAppointmentTypeName(AppointmentTypeName, "Appointment Type");
                      end; */
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
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
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                    trigger OnValidate()
                    begin
                        Rec."Patient Names" := Rec.GetPatientName(Rec."Patient No.");
                        Rec."Phone No" := GetPatientPhone(Rec."Patient No.");
                        Rec.GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                        GetAppointmentStats(Rec."Patient No.");
                    end;
                }
                field(SearchNames; Rec.SearchNames)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Patient Name';
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Visit Type"; Rec."Visit Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit Type field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor field.';
                    trigger OnValidate()
                    begin
                        DoctorName := Rec.GetDoctorName(Rec.Doctor);
                    end;
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor Name';
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Re-Opened"; Rec."Re-Opened")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Re-Opened field.';
                }
                field("Re-Opened UserID"; Rec."Re-Opened UserID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Re-Opened UserID field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print_Presc)
            {
                Caption = 'Print Prescription';
                Image = PaymentHistory;
                ToolTip = 'Executes the Print Prescription action.';

                trigger OnAction()
                begin
                    HMSPharm.Reset();
                    HMSPharm.SetRange(HMSPharm."Link No.", Rec."Appointment No.");
                    if HMSPharm.Find('-') then
                        REPORT.Run(70135231, true, true, HMSPharm);
                end;
            }
            separator(Separator7)
            {
            }
            action("Appointment Charges")
            {
                Image = CompareCost;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Appointment No Lk" = FIELD("Appointment No.");
                ToolTip = 'Executes the Appointment Charges action.';
            }
            action("Post Income")
            {
                ApplicationArea = All;
                Image = PostBatch;
                ToolTip = 'Executes the Post Income action.';
                trigger OnAction()
                var
                    DimSetID: Record "Dimension Set Entry";
                    GenJnlLine: Record "Gen. Journal Line";
                    Patients: Record "HMS Patient";
                    PatientCharges: Record "HMS Patient Charges";
                    HMSSetup: Record "HMS Setup";
                    HMSTransCode: Record "HMS Transactions code";
                    DocNo: Code[20];
                    JBatch: Code[20];
                    JTemplate: Code[20];
                    LineNo: Integer;
                begin
                    PatientCharges.RESET();
                    // PatientCharges.SETRANGE(PatientCharges."Patient No.", PatientNo);
                    PatientCharges.setfilter(PatientCharges."Insurance No", '<>%1', '');
                    PatientCharges.setfilter(PatientCharges."Posting Document No", '<>%1', '');
                    PatientCharges.SetFilter(PatientCharges."Transaction Type", '<>%1', 'ZRECEIPT');
                    //PatientCharges.SETRANGE(PatientCharges."Visit No", VisitNo);
                    // PatientCharges.SETRANGE(PatientCharges.Closed, true);
                    // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE); //Commented to allow receipts for debtor patient
                    IF PatientCharges.FIND('-') THEN BEGIN
                        REPEAT
                            IF HMSTransCode.GET(PatientCharges."Transaction Type") THEN BEGIN
                                DocNo := PatientCharges."Posting Document No";
                                LineNo := LineNo + 100;
                                //HMSTransCode.TESTFIELD(HMSTransCode."Capitation Cost G/L Account");
                                GenJnlLine.INIT();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := TODAY;
                                GenJnlLine."Document No." := DocNo;
                                // GenJnlLine."Document Date":="Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := PatientCharges."G/L Account No";///HMSTransCode."Capitation Cost G/L Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := PatientCharges."Visit No";
                                // GenJnlLine."Currency Code":="Currency Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := PatientCharges."Total Amount";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := HMSSetup."Cash Control Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := PatientCharges."Patient No." + ' -  ' + Patients.Surname + ' ' + Patients."Last Name";
                                GenJnlLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                DimSetID.RESET();
                                DimSetID.SETRANGE("Dimension Code", 'BRANCH');
                                DimSetID.SETRANGE("Dimension Value Code", PatientCharges."Shortcut Dimension 1 Code");
                                IF DimSetID.FIND('-') THEN
                                    GenJnlLine."Dimension Set ID" := DimSetID."Dimension Set ID";

                                IF GenJnlLine.Amount <> 0 THEN
                                    GenJnlLine.INSERT();
                            END;
                        // PatientCharges."Posting Document No" := DocNo;
                        // PatientCharges.Modify();
                        UNTIL PatientCharges.NEXT() = 0;
                        GenJnlLine.RESET();
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                        IF GenJnlLine.FIND('-') THEN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
                    END;
                    Message('Posted Successfully');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
        "Relative No.Visible" := true;
        "Employee No.Visible" := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Validate(Doctor);
        // Validate("Patient No.");
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.get(database.UserId) then
            if UserSetup."Branch Code" <> '' then
                Rec.setfilter(Branch, UserSetup."Branch Code");
    end;

    var
        HMSPharm: Record "HMS Pharmacy Header";
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
        IntCancelled: Integer;
        IntCompleted: Integer;
        IntRescheduled: Integer;
        IntScheduled: Integer;
        Age: Text[100];
        DoctorName: Text[100];
        PatientName: Text[100];

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."Patient Type"::Cash then begin
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
        if AppType.Get(AppointmentTypeCode) then
            AppointmentTypeName := AppType.Description;
    end;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then
            //  StudentNo := Patient."Student No.";
            EmployeeNo := Patient."Employee No.";
            //  RelativeNo := Patient."Relative No.";
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
    end;

    procedure GetPatientPhone(var PatientNo: Code[20]) PatientTelephone: Text[100]
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then
            PatientTelephone := Patient."Telephone No. 1";
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        Patient: Record "HMS Patient";
        HRDates: Codeunit "HR Dates";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then
            if Patient."Date Of Birth" = 0D then
                Age := ''
            else
                Age := HRDates.DetermineAge(Patient."Date Of Birth", Today);
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS Setup Doctor";
    begin
        Doctor.Reset();
        if Doctor.Get(DoctorCode) then
            //  Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
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

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        //GetAppointmentTypeName(AppointmentTypeName, "Appointment Type");
        DoctorName := Rec.GetDoctorName(Rec.Doctor);
        Rec."Phone No" := GetPatientPhone(Rec."Patient No.");
        Rec.GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
        PatientName := Rec.GetPatientName(Rec."Patient No.");
        Rec.GetPatientAge(Rec."Patient No.", Age);
        GetAppointmentStats(Rec."Patient No.");
    end;
}
