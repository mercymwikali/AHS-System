Page 85388 "HMS Patients Card"
{
    PageType = Card;
    SourceTable = "HMS Patient";

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
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Activated; Rec.Activated)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Activated field.';
                }
                field(DateRegistered; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First/English Name field.';
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Birth field.';

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then begin
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
                        end;
                    end;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nationality field.';
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(StaffNo; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(ModeofPayment; Rec."Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mode of Payment';
                    Editable = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Mode of Payment field.';

                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(NextofKinRelationship; Rec."Next of kin Relationship")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Next of Kin Relationship';
                    ToolTip = 'Specifies the value of the Next of Kin Relationship field.';
                }
                field(NextofKinFullName; Rec."Next Of kin Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Next of Kin Full Name';
                    ToolTip = 'Specifies the value of the Next of Kin Full Name field.';
                }
                field(NextofKinTelephone; Rec."Next Of kin Address 1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Next of Kin Telephone';
                    ToolTip = 'Specifies the value of the Next of Kin Telephone field.';
                }
                field(InsuranceNo; Rec."Insurance No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field(InsuranceName; Rec."Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(PrincipalMemberName; Rec."Mother Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Principal Member Name';
                    ToolTip = 'Specifies the value of the Principal Member Name field.';
                }
                field(MembershipNo; Rec."Membership No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Membership No field.';
                }

                field(FileNo; Rec."File No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the File No field.';
                }
                field(Inpatient; Rec.Inpatient)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Inpatient field.';
                }
            }
            group(CorrespondenceAddress)
            {
                Caption = 'Correspondence Address';
                Editable = true;
                field(Residence; Rec."Place of Birth Village")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Residence';
                    ToolTip = 'Specifies the value of the Residence field.';
                }
                field(NameofChiefAsstChief; Rec."Name of Chief")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Name of Chief/Asst. Chief';
                    ToolTip = 'Specifies the value of the Name of Chief/Asst. Chief field.';
                }
                field(NearestSchoolChurch; Rec."Nearest Police Station")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nearest School/Church';
                    ToolTip = 'Specifies the value of the Nearest School/Church field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(BillBalance; Rec."Bill Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bill Balance field.';
                }
                field(InvoiceAmount; Rec."Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(ReceiptAmount; Rec."Receipt Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field(ActiveVisitNo; Rec."Active Visit No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Active Visit No field.';
                }
                field("Current LOU Amount"; Rec."Current LOU Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Current LOU Amount field.';
                }
                field("Last Billing Date"; Rec."Last Billing Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Billing Date field.';


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
            action(CreateVisit)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Visit';
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Visit action.';
                // Visible = false;

                trigger OnAction()
                var
                    ItsNew: Option New,Revisit;
                begin
                    Rec.testfields;
                    if Rec.Inpatient = true then Error('The selected Patient has an active Inpatient Record');
                    DaysBtwnTodayAndLastVisit := Rec.isLastVisitDayWithin7days(ItsNew);

                    if isLastVisitOpen = true then begin
                        if Confirm('There an open visit which has not been closed do you want to continue and create a new visit?', false) = false then begin
                            exit;
                        end;
                    end;

                    myNoSeries := '';

                    HMSSetup.Get;
                    HMSSetup.TestField("Appointment Nos");
                    myNoSeries := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, true);


                    Rec.Activated := true;
                    Apponitment.Init;
                    Apponitment."Appointment No." := myNoSeries;
                    if Rec."Patient Type" = Rec."patient type"::Corporate then Apponitment."Settlement Type" := Apponitment."settlement type"::Credit;
                    Apponitment."Patient No." := Rec."Patient No.";
                    Apponitment."Appointment Date" := Today;
                    Apponitment."Appointment Time" := Time;
                    if DaysBtwnTodayAndLastVisit <= 7 then
                        Apponitment."Appointment Type" := 'REVIEW' else
                        Apponitment."Appointment Type" := 'NORMAL';
                    Apponitment."Insurance No" := Rec."Insurance No.";
                    Apponitment."Insurance Member No" := Rec."Membership No";
                    Apponitment."Patient Type" := Rec."Patient Type";
                    Apponitment.Insert;

                    Page.Run(39005999, Apponitment);
                end;
            }
            action("Patient Charges")
            {
                ApplicationArea = Basic, Suite;
                Image = "report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Patient Charges action.';

                trigger OnAction()
                begin
                    objPatientCharges.Reset;
                    objPatientCharges.SetRange(objPatientCharges."Patient No.", Rec."Patient No.");
                    objPatientCharges.SetRange(objPatientCharges.Recognized, false);
                    if objPatientCharges.Find('-') then begin
                        Report.Run(39005475, true, true, objPatientCharges);
                    end;
                end;
            }
            action(SmartLink)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'SmartLink Balance Verification';
                Image = Balance;
                ToolTip = 'Executes the SmartLink Balance Verification action.';

                trigger OnAction()
                begin
                    DSLInt.GetSmartData(Rec."Patient No.");
                    //Message(Format(hmsIntegration.PatientBalance()));
                end;
            }
            action("Send Bill Balance Via SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = MailSetup;
                ToolTip = 'Executes the Send Bill Balance Via SMS action.';

                trigger OnAction()
                begin
                    Rec.TestField("Telephone No. 1");
                    Rec.CalcFields(Balance);
                    Rec.CalcFields("Bill Balance SMS");

                    if Rec."Bill Balance SMS" > 0 then begin
                        SMSSend.Reset;
                        if SMSSend.Find('+') then
                            Ln := SMSSend."Entry No";

                        Ln := Ln + 1;
                        SMSSend.Init;
                        SMSSend."Entry No" := Ln;
                        SMSSend."Phone No" := CopyStr(Rec."Telephone No. 1", 1, 15);
                        if CopyStr(Rec."Telephone No. 1", 1, 1) = '7' then
                            SMSSend."Phone No" := '254' + CopyStr(Rec."Telephone No. 1", 1, 10);
                        if CopyStr(Rec."Telephone No. 1", 1, 1) = '0' then
                            SMSSend."Phone No" := '254' + CopyStr(Rec."Telephone No. 1", 2, 9);
                        SMSSend.Message := 'Dear ' + Rec.Surname + ', Please note that your current bill balance is ' + Format(Rec."Bill Balance SMS") + '. Please make an effort to deposit some amount. For further inquiries kindly come to billing station.Thank you, St Lukes Hospital';
                        SMSSend.Status := SMSSend.Status::Pending;
                        SMSSend.Date := Today;
                        SMSSend.Code := 'Balance';
                        SMSSend.Insert;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Date Of Birth" <> 0D then begin
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
        end;
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."patient type"::Cash;
    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        // testfields;
    end;

    var
        HasValue: Boolean;
        HRDates: Codeunit "HR Dates";
        Age: Text[100];
        [InDataSet]
        "Student No.Enable": Boolean;
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        Apponitment: Record "HMS Appointment Form Header";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        myNoSeries: Code[20];
        DaysBtwnTodayAndLastVisit: Integer;
        TreatmentHeader: Record "HMS Treatment Form Header";
        AdmissionHeader: Record "HMS Admission Form Header";
        objPatientCharges: Record "HMS Patient Charges";
        hmsIntegration: Codeunit "HMS Patient-integration";
        decBalance: Decimal;
        SMSSend: Record "SMS Sender";
        Ln: Integer;

        DSLInt: Codeunit "DSL Integrations";

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
        if Rec."Date Of Birth" <> 0D then begin
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
        end;
    end;

    local procedure isLastVisitDayWithin7days() lastVisitDay: Integer
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;

        appointments.Reset;
        appointments.SetRange(appointments."Patient No.", Rec."Patient No.");
        appointments.SetCurrentkey("Appointment No.");
        if appointments.Find('+') then begin
            lastVisitDay := Today - appointments."Appointment Date";
        end;
    end;

    local procedure testfields()
    begin
        /*
        if "Walk-in" = false then begin
            TestField("ID Number");
            TestField(Surname);
            TestField("Middle Name");
            TestField(Gender);
            TestField("Date Of Birth");
            TestField(Nationality);
            if "Patient Type" = "patient type"::Corporate then TestField("Insurance No.") else "Insurance No." := '';
            TestField("Next of kin Relationship");
            TestField("Next Of kin Full Name");
            TestField("Next Of kin Address 1");
            Validate("ID Number");
            if ValidCharacters("ID Number") = false then Error('ID Number Error');

    end;
    */
    end;

    local procedure ValidCharacters(control: Text) valid: Boolean
    var
        NewStrings: Text;
    begin
        valid := true;

        if StrLen(control) = 1 then valid := false;

        NewStrings := DelChr(control, '=', '!@#$%^&*()_+|}{":;''?>><,./-');
        if NewStrings = '' then valid := false;
    end;

    local procedure isLastVisitOpen() lastVisitOpen: Boolean
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitOpen := false;

        appointments.Reset;
        appointments.SetRange(appointments."Patient No.", Rec."Patient No.");
        appointments.SetRange(appointments.Status, appointments.Status::New);
        appointments.SetCurrentkey("Appointment No.");
        if appointments.Find('+') then begin
            lastVisitOpen := true;
        end;
    end;
}

