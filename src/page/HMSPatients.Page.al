page 85387 "HMS Patients"
{
    PageType = Card;
    SourceTable = "HMS Patient";
    PromotedActionCategories = 'New,Process,Report,Charges,Invoicing';

    layout
    {
        area(content)
        {
            group("Personal details")
            {
                Caption = 'Personal details';
                Editable = true;
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("File No"; Rec."File No")
                {

                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the File No field.';
                    // editable = false;
                }
                field("Old File No"; Rec."Old File No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Old File No field.';
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    NotBlank = true;
                    ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(Title; Rec.Title)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First/English Name field.';

                    trigger OnValidate()
                    begin
                        if Rec."Global Dimension 1 Code" = '' then
                            ERROR('Kindly choose branch');
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("Special Clinics"; Rec."Special Clinics")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Special Clinics field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(Dependant; Rec.Dependant)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dependant field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then begin
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
                            Rec."Age in Years" := DATE2DMY(TODAY, 3) - DATE2DMY(Rec."Date Of Birth", 3);

                        end;
                    end;
                }
                field(Age; Age)
                {
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Nationality; Rec.Nationality)
                {

                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nationality field.';
                }
                field(County; Rec."Place of Birth District")
                {
                    Caption = 'County Code';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the County Code field.';
                }

                field("Sub-County code"; Rec."Sub-County code")
                {
                    Caption = 'Sub-County /constituency';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-County /constituency field.';

                }
                field("Sub-County Name  "; Rec."Sub-County Name")
                {
                    Caption = 'Constituency Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Constituency Name field.';

                }
                field("County Ward"; Rec."County Ward")
                {
                    Caption = 'County Ward';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County Ward field.';

                }
                field("County Ward Name"; Rec."County Ward Name")
                {
                    Caption = 'County Ward Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County Ward Name field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }

                field("Staff No"; Rec."Staff No")
                {
                    HideValue = true;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }

                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    Caption = 'Phone No';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
                field("Patient Type"; Rec."Patient Type")
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

                field("Next of kin Relationship"; Rec."Next of kin Relationship")
                {
                    Caption = 'Next of Kin Relationship';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Next of Kin Relationship field.';
                }
                field("Next Of kin Full Name"; Rec."Next Of kin Full Name")
                {
                    Caption = 'Next of Kin Full Name';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Next of Kin Full Name field.';
                }
                field("Next Of kin Address 1"; Rec."Next Of kin Address 1")
                {
                    Caption = 'Next of Kin Telephone';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Next of Kin Telephone field.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Principal Member Name"; Rec."Principal Member Name")
                {
                    Caption = 'Principal Member Name';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Principal Member Name field.';
                }
                field("Depandant Principle Member"; Rec."Depandant Principle Member")
                {
                    Caption = 'Dependant Principle Member';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dependant Principle Member field.';
                }
                field(Principal; Rec.Principal)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Principal field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Scheme Name field.';
                }
                field(Activated; Rec.Activated)
                {
                    Description = '<Activated means the patient can be seen from casheir window>';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Activated field.';
                }

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("How you Knew About Us"; Rec."How you Knew About Us")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the How you Knew About Us field.';
                }
            }
            group("Correspondence Address")
            {
                Caption = 'Correspondence Address';
                Editable = true;
                field("Place of Birth Village"; Rec."Place of Birth Village")
                {
                    Caption = 'Residence';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Residence field.';
                }
                field("Active Visit No"; Rec."Active Visit No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Active Visit No field.';
                }
                field("Name of Chief"; Rec."Name of Chief")
                {
                    Caption = 'Name of Chief/Asst. Chief';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name of Chief/Asst. Chief field.';
                }
                field("Nearest Police Station"; Rec."Nearest Police Station")
                {
                    Caption = 'Nearest School/Church';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nearest School/Church field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("<Address 1>"; Rec."Correspondence Address 1")
                {
                    Caption = 'Address';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Patient Occupation"; Rec."Patient Occupation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Occupation field.';
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
                field(Inpatient; Rec.Inpatient)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Inpatient field.';
                }
                field("Current Adm No"; Rec."Current Adm No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Adm No field.';
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discharge Date field.';
                }
                field("Patient Status"; Rec."Patient Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Status field.';
                }
                field("Debtor Account"; Rec."Debtor Account")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Debtor Account field.';
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
                Caption = 'Create Visit';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Create Visit action.';
                trigger OnAction()
                var
                    Cust: Record customer;
                begin
                    testfield("Global Dimension 1 Code");

                    if (Rec."Date Of Birth" = 0D) then
                        ERROR('Please provide patients Date of birth');
                    if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
                        if Rec."Insurance No." = '' then ERROR('Please provide patients Insurance No');
                        if Rec."Membership No" = '' then ERROR('Please provide patients Insurance Membership Number');
                        if Cust.get(Rec."Insurance No.") then
                            Cust.TestField(Blocked, 0);
                    end;
                    Apponitment.SETRANGE(Apponitment."Patient No.", Rec."Patient No.");
                    Apponitment.SETRANGE(Apponitment."Appointment Date", TODAY);
                    Apponitment.SETRANGE(Apponitment."Patient Type", Rec."Patient Type");
                    Apponitment.SETRANGE(Apponitment.Status, Apponitment.Status::New);
                    if Apponitment.FIND('-') then
                        ERROR('The patient already has an open visit for today! Go to appointment to dispatch patient');

                    Rec.testfields();

                    //Reverse------------


                    DaysBtwnTodayAndLastVisit := Rec.isLastVisitDayWithin7days(ItsNew);

                    if isLastVisitOpen() = true then begin
                        if CONFIRM('There an open visit which has not been closed do you want to continue and create a new visit?', FALSE) = FALSE then begin
                            EXIT;
                        end;
                    end;

                    myNoSeries := '';

                    HMSSetup.GET();
                    HMSSetup.TESTFIELD("Appointment Nos");
                    myNoSeries := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, TRUE);


                    objPAtient.RESET();
                    objPAtient.SETRANGE(objPAtient."Patient No.", Rec."Patient No.");
                    if objPAtient.FIND('-') then begin
                        Rec.Activated := TRUE;
                        Rec."Active Visit No" := myNoSeries;
                        Rec."Age in Years" := DATE2DMY(TODAY, 3) - DATE2DMY(objPAtient."Date Of Birth", 3);
                        Rec.MODIFY();

                        Apponitment.INIT();

                        Apponitment."Appointment No." := myNoSeries;
                        if Rec."Patient Type" = Rec."Patient Type"::Corporate then
                            Apponitment."Settlement Type" := Apponitment."Settlement Type"::Credit;
                        if Rec."Patient Type" = Rec."Patient Type"::Cash then
                            Apponitment."Settlement Type" := Apponitment."Settlement Type"::Cash;
                        if Rec."Patient Type" = Rec."Patient Type"::Cash then
                            Apponitment."Settlement Type" := Apponitment."Settlement Type"::Cash;

                        Apponitment."Patient No." := Rec."Patient No.";
                        Apponitment."Appointment Date" := TODAY;
                        Apponitment."Appointment Time" := TIME;

                        if DaysBtwnTodayAndLastVisit <= 7 then
                            // if objPAtient."Patient Type" = objPAtient."Patient Type"::Corporate then
                            Apponitment."Appointment Type" := 'REVIEW'
                        // ELSE
                        //     Apponitment."Appointment Type" := 'REVIEW'
                        ELSE
                            Apponitment."Appointment Type" := 'REVISIT';

                        if Rec."Date Registered" = Today then
                            Apponitment."Appointment Type" := 'NORMAL';

                        Apponitment."Visit Type" := Apponitment."Appointment Type";
                        Apponitment."Insurance No" := Rec."Insurance No.";
                        Apponitment."Insurance Member No" := Rec."Membership No";
                        Apponitment."Patient Type" := Rec."Patient Type";
                        Apponitment.visitType := ItsNew;
                        Apponitment."Age in Years" := objPAtient."Age in Years";
                        Apponitment.Gender := objPAtient.Gender;
                        Apponitment."User ID" := USERID;
                        Apponitment.Status := Apponitment.Status::New;
                        Apponitment.Names := objPAtient."Search Name";
                        if (Apponitment.Names = '') then
                            Apponitment.Names := objPAtient.Surname + '  ' + objPAtient."Middle Name" + ' ' + objPAtient."Last Name";
                        Apponitment.SearchNames := objPAtient.Surname + '  ' + objPAtient."Middle Name" + ' ' + objPAtient."Last Name";
                        Apponitment.Branch := objPAtient."Global Dimension 1 Code";

                        Apponitment.INSERT();
                    end;

                    PAGE.RUN(Page::"HMS Appointment Form Header", Apponitment);
                end;
            }
            action(BookVisit)
            {
                Caption = 'Book Appointment';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Image = BookingsLogo;
                ToolTip = 'Executes the Book Appointment action.';
                trigger OnAction()
                var
                    Cust: Record customer;
                    NewNo: Text;
                    HMSAppBk: Record "HMS Patient Appointmnt Bookng";
                begin
                    if confirm('Do you want to book an appointment for ' + Rec."Search Name") then begin
                        if (Rec."Global Dimension 1 Code" = '') then
                            ERROR('Please Enter Branch to continue');

                        if (Rec."Date Of Birth" = 0D) then
                            ERROR('Please provide patients Date of birth');
                        ///TestField("ID Number");
                        Rec.testfields();
                        if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
                            if Rec."Insurance No." = '' then ERROR('Please provide patients Insurance No');
                            if Rec."Membership No" = '' then ERROR('Please provide patients Insurance Membership Number');
                            if Cust.get(Rec."Insurance No.") then
                                Cust.TestField(Blocked, 0);
                        end;
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
            action(SmartLink)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'SmartLink Balance Verification';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the SmartLink Balance Verification action.';

                trigger OnAction()
                begin
                    DSLInt.GetSmartData(Rec."Patient No.");
                    //Message(Format(hmsIntegration.PatientBalance()));
                end;
            }
            action("Patient Charges")
            {
                Image = "report";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = field("Patient No."), "Visit No" = field("Active Visit No");
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Patient Charges action.';
            }
            action("Posted Patient Charges")
            {
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = field("Patient No."), "Visit No" = field("Active Visit No");
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Posted Patient Charges action.';
            }
            separator(Separator12)
            {
            }
            action("Refresh Current Charges")
            {
                ApplicationArea = Basic, Suite;
                image = Refresh;
                ToolTip = 'Executes the Refresh Current Charges action.';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    PatientBilling: Codeunit "Patient Billing";
                begin
                    PatientBilling.RefreshPatientChargesAll(Rec."Active Visit No", Rec."Patient No.");
                end;

            }
            action("Patient Insurance")
            {
                ApplicationArea = Basic, Suite;
                Image = Insurance;
                RunObject = Page "HMS Patient Insurance";
                RunPageLink = "Patient No" = field("Patient No.");
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Patient Insurance action.';
            }
            separator(Separator19)
            {
            }
            action("Recurring Charges")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate Recurring Charges';
                Image = Insurance;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Calculate Recurring Charges action.';

                trigger OnAction()
                var
                    CalcRecurringCharges: Report "HMS Reccuring Charges";
                begin
                    CalcRecurringCharges.SetTableView(Rec);
                    CalcRecurringCharges.Run();
                end;
            }
            separator(Separator17)
            {
            }
            action("Interim Invoice")
            {
                ApplicationArea = All;
                Caption = 'Interim Invoice';
                ToolTip = 'Executes the Interim Invoice action.';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    objPatientCharges.RESET();
                    objPatientCharges.SETFILTER(objPatientCharges."Patient No.", Rec."Patient No.");
                    if objPatientCharges.FIND('-') then
                        REPORT.RUN(Report::"HMS Patient Invoice", true, true, objPatientCharges);
                end;
            }
            separator(Separator21)
            {
            }
            action(PostedInvoice)
            {
                Caption = 'Posted Invoice';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Posted Invoice action.';
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    objPatientCharges.RESET();
                    objPatientCharges.SETFILTER(objPatientCharges."Patient No.", Rec."Patient No.");
                    objPatientCharges.SETFILTER(objPatientCharges.Posted, '=%1', true);
                    if objPatientCharges.FIND('-') then
                        REPORT.RUN(Report::"Final Patient Invoice", true, true, objPatientCharges);
                end;
            }
            action("Allocate NHIF Rebates")
            {
                Image = Allocations;
                ToolTip = 'Executes the Allocate NHIF Rebates action.';
                Promoted = true;
                PromotedCategory = Category5;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                HMSProcesses: Codeunit "HMS Processes";
                begin
                    // CuHMSProcesses.FnSHIFRebatesCalculation(TbRec, RebateAmount, ChargeDate, InsuaranceCode)
                    Report.Run(Report::"HMS NHIF Rebates Calculations", true, true, Rec);
                end;
            }
            action("Generate NHIF Cash Rebates Invoice")
            {
                Caption = 'Generate NHIF Cash Rebates Invoice';
                Image = Invoice;
                ToolTip = 'Executes the Generate NHIF Cash Rebates Invoice action.';
                Promoted = true;
                PromotedCategory = Category5;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    HMSPatientCharges: Record "HMS Patient Charges";
                    HMS: Codeunit "HMS Patient-integration";
                begin
                    if Rec."Patient Type" = Rec."Patient Type"::Cash then begin
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Active Visit No");
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Cash Rebates Posted", '%1', false);
                        HMSPatientCharges.SetFilter(HMSPatientCharges.Code, 'REBATES');
                        if HMSPatientCharges.Find('-') then begin
                            HMSPatientCharges.TestField(HMSPatientCharges."Insurance No");
                            HMS.GenerateNHIF_Rebates_Invoice(HMSPatientCharges."Patient No.", HMSPatientCharges."Visit No", HMSPatientCharges."Insurance No");
                        end;
                    end;
                    CurrPage.Update();
                    //HMS.GenerateInvoice("Patient No.");
                end;
            }
            action(PrintSHAInvoice)
            {
                ApplicationArea = all;
                Caption = 'Print SHA Invoice';
                Promoted = true;
                PromotedCategory = Category5;
                // RunObject = report "Final Patient Invoice-NHIF";
                trigger OnAction()
                var
                    HMSPatientCharges: Record "HMS Patient Charges";
                    FinalPatientInvoiceNHIF: Report "Final Patient Invoice-NHIF";
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Active Visit No");
                    if HMSPatientCharges.FindFirst() then begin
                        FinalPatientInvoiceNHIF.SetTableView(HMSPatientCharges);
                        FinalPatientInvoiceNHIF.Run();
                    end;
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := TRUE;
        "Employee No.Enable" := TRUE;
        "Student No.Enable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Patient No." = '' then begin
            HMSSetup.GET();
            RegUser.RESET();
            RegUser.SETRANGE(RegUser."User ID", USERID);
            if RegUser.FIND('-') then begin
                if RegUser."Global Dimension 1 Code" = '' then begin
                    //ERROR('Your account is not setup to register patients');
                    if Rec."Walk-in" = FALSE then begin
                        HMSSetup.TESTFIELD("Patient Nos");
                        NoSeriesMgt.InitSeries(HMSSetup."Patient Nos", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                    end
                    ELSE
                        if Rec."Walk-in" = TRUE then begin
                            HMSSetup.TESTFIELD("In Patient No");
                            NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                        end;
                end;

                if RegUser."Global Dimension 1 Code" = 'KISUMU' then begin
                    if Rec."Walk-in" = FALSE then begin
                        HMSSetup.TESTFIELD("Patient Nos");
                        NoSeriesMgt.InitSeries(HMSSetup."Patient Nos", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                    end
                    ELSE
                        if Rec."Walk-in" = TRUE then begin
                            HMSSetup.TESTFIELD("In Patient No");
                            NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                        end;
                end ELSE
                    if RegUser."Global Dimension 1 Code" = 'ELDORET' then begin
                        if Rec."Walk-in" = FALSE then begin
                            HMSSetup.TESTFIELD("Patient Nos");
                            NoSeriesMgt.InitSeries('PAT RH', xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                        end
                        ELSE
                            if Rec."Walk-in" = TRUE then begin
                                HMSSetup.TESTFIELD("In Patient No");
                                NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                            end;
                    end ELSE
                        if RegUser."Global Dimension 1 Code" = 'ELD TOWN' then begin
                            if Rec."Walk-in" = FALSE then begin
                                HMSSetup.TESTFIELD("Patient Nos");
                                NoSeriesMgt.InitSeries('PAT RH', xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                            end
                            ELSE
                                if Rec."Walk-in" = TRUE then begin
                                    HMSSetup.TESTFIELD("In Patient No");
                                    NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                                end ELSE begin
                                    ERROR('Your account has not been linked to a branch');
                                end;
                        end;

            end;
        end;
        Rec."Date Registered" := TODAY;
        Rec."User ID" := USERID;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Patient No." = '' then begin
            HMSSetup.GET();
            RegUser.RESET();
            RegUser.SETRANGE(RegUser."User ID", USERID);
            if RegUser.FIND('-') then begin
                if RegUser."Global Dimension 1 Code" = '' then begin
                    //ERROR('Your account is not setup to register patients');
                    if Rec."Walk-in" = FALSE then begin
                        HMSSetup.TESTFIELD("Patient Nos");
                        NoSeriesMgt.InitSeries(HMSSetup."Patient Nos", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                    end
                    ELSE
                        if Rec."Walk-in" = TRUE then begin
                            HMSSetup.TESTFIELD("In Patient No");
                            NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                        end;
                end;

                if RegUser."Global Dimension 1 Code" <> '' then begin
                    if Rec."Walk-in" = FALSE then begin
                        HMSSetup.TESTFIELD("Patient Nos");
                        NoSeriesMgt.InitSeries(HMSSetup."Patient Nos", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                    end
                    ELSE
                        if Rec."Walk-in" = TRUE then begin
                            HMSSetup.TESTFIELD("In Patient No");
                            NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, Rec."Patient No.", Rec."No. Series");
                        end;
                end; /* ELSE
                    if RegUser."Global Dimension 1 Code" = 'ELDORET' then begin
                        if "Walk-in" = FALSE then begin
                            HMSSetup.TESTFIELD("Patient Nos");
                            NoSeriesMgt.InitSeries('PAT RH', xRec."No. Series", 0D, "Patient No.", "No. Series");
                        end
                        ELSE
                            if "Walk-in" = TRUE then begin
                                HMSSetup.TESTFIELD("In Patient No");
                                NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, "Patient No.", "No. Series");
                            end;
                    end ELSE
                        if RegUser."Global Dimension 1 Code" = 'ELD TOWN' then begin
                            if "Walk-in" = FALSE then begin
                                HMSSetup.TESTFIELD("Patient Nos");
                                NoSeriesMgt.InitSeries('PAT RH', xRec."No. Series", 0D, "Patient No.", "No. Series");
                            end
                            ELSE
                                if "Walk-in" = TRUE then begin
                                    HMSSetup.TESTFIELD("In Patient No");
                                    NoSeriesMgt.InitSeries(HMSSetup."In Patient No", xRec."No. Series", 0D, "Patient No.", "No. Series");
                                end ELSE begin
                                    ERROR('Your account has not been linked to a branch');
                                end;
                        end; */

            end;
        end;
        Rec."Date Registered" := TODAY;
        Rec."User ID" := USERID;
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
        ItsNew: Option New,Revisit;
        objPAtient: Record "HMS Patient";
        HMSPat: Codeunit "HMS Patient-integration";
        decPAtBalance: Decimal;
        RegUser: Record "User Setup";
        DSLInt: Codeunit "DSL Integrations";

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
            "Student No.Enable" := TRUE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
        end
        ELSE begin
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := TRUE;
            "Relative No.Enable" := TRUE;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        if Rec."Date Of Birth" <> 0D then begin
            Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
        end;
    end;

    local procedure ValidCharacters(control: Text) valid: Boolean
    var
        NewStrings: Text;
    begin
        valid := TRUE;

        if STRLEN(control) = 1 then valid := FALSE;

        NewStrings := DELCHR(control, '=', '!@#$%^&*()_+|}{":;''?>><,./-');
        if NewStrings = '' then valid := FALSE;
    end;

    local procedure isLastVisitOpen() lastVisitOpen: Boolean
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitOpen := FALSE;

        appointments.RESET();
        appointments.SETRANGE(appointments."Patient No.", Rec."Patient No.");
        appointments.SETRANGE(appointments.Status, appointments.Status::New);
        appointments.SETCURRENTKEY("Appointment No.");
        if appointments.FIND('+') then begin
            lastVisitOpen := TRUE;
        end;
    end;
}

