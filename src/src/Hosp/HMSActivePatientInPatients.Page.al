Page 52202664 "HMS Active Patient InPatients"
{
    CardPageID = "HMS Patients Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Patient";
    SourceTableView = where(Inpatient = const(true),
                            Activated = const(true),
                            "Exist in Discharge" = filter(0));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AdmissionDate; Rec."Admission Date")
                {
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field(AdmittingDoctor; Rec."Admitting Doctor")
                {
                    ToolTip = 'Specifies the value of the Admitting Doctor field.';
                }
                field(AdmittingDoctorName; DoctRec."Doctors Name")
                {
                    Caption = 'Admitting Doctor Name';
                    ToolTip = 'Specifies the value of the Admitting Doctor Name field.';
                }
                field(AdmissionType; Rec."Admission Type")
                {
                    ToolTip = 'Specifies the value of the Admission Type field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(InsName; InsName)
                {
                    Caption = 'Insurance Name';
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Patient Names';
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(TelephoneNo2; Rec."Telephone No. 2")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 2 field.';
                }
                field(NextOfkinFullName; Rec."Next Of kin Full Name")
                {
                    ToolTip = 'Specifies the value of the Next Of kin Full Name field.';
                }
                field(NextOfkinAddress1; Rec."Next Of kin Address 1")
                {
                    ToolTip = 'Specifies the value of the Next Of kin Address 1 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(PatientCurrentLocation; Rec."Patient Current Location")
                {
                    ToolTip = 'Specifies the value of the Patient Current Location field.';
                }
                field(InvoiceAmount; Rec."Invoice Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(ReceiptAmount; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field(Balance; Rec."Invoice Amount" + Rec."Receipt Amount")
                {
                    Caption = 'Balance';
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field(ExistinAdmission; Rec."Exist in Admission")
                {
                    ToolTip = 'Specifies the value of the Exist in Admission field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AdmissionDetails)
            {
                Caption = 'Admission Details';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Admission Header Admitted";
                RunPageLink = "Patient No." = FIELD("Patient No."), "Admission No." = field("Current Adm No");
                ToolTip = 'Executes the Admission Details action.';
            }
            action("Create Splitting Invoince No")
            {
                Image = SplitChecks;
                ToolTip = 'Executes the Create Splitting Invoince No action.';
                trigger OnAction()
                var
                    HMSAPP: Record "HMS Appointment Form Header";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    NewNo: code[20];
                begin
                    if Patients.Get(Rec."Patient No.") then begin
                        NewNo := NoSeriesMgt.GetNextNo('APSP', 0D, true);
                        HmsAPP.Init();
                        HmsAPP."Appointment No." := NewNo;
                        HmsAPP."Appointment Date" := Today;
                        HmsAPP."Appointment Time" := Time;
                        HmsAPP."Appointment Type" := 'SPLIT INVOICE';
                        HmsAPP."Patient No." := Rec."Patient No.";
                        HmsAPP.Doctor := '';
                        HmsAPP.Validate("Patient No.");
                        HmsAPP."Settlement Type" := HmsAPP."Settlement Type"::Insurance;
                        HmsAPP."Patient Type" := HmsAPP."Patient Type"::Corporate;
                        HmsAPP."User ID" := UserId;
                        HmsAPP.Status := HmsAPP.Status::Rescheduled;
                        HmsAPP."No. Series" := 'APSP';
                        HmsAPP."Dispatch To" := HmsAPP."Dispatch To";
                        HmsAPP."Insurance No" := Patients."Insurance No.";
                        HmsAPP."Insurance Member No" := Patients."Membership No";
                        HmsAPP."Global Dimension 1" := Patients."Global Dimension 1 Code";
                        HmsAPP.Gender := Patients.Gender;
                        HmsAPP.Insert();
                    end;

                    HmsAPP.Reset();
                    HmsAPP.SetRange(HmsAPP."Appointment No.", NewNo);
                    if HmsAPP.Find('-') then
                        PAGE.Run(51964, HmsAPP);
                end;
            }

            action("Dispatch To Phamarcy")
            {
                Caption = 'Dispatch To Phamarcy';
                Image = ReleaseDoc;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                ToolTip = 'Executes the Dispatch To Phamarcy action.';
                trigger OnAction()
                var
                    PharmHeader: Record "HMS Pharmacy Header";
                    HMSSetup: Record "HMS Setup";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    NewNo: code[20];
                begin

                    if Confirm('Alert Pharmacy About Prescription?') = false then
                        exit;

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                    /*Get the treatment from the database*/

                    PharmHeader.Reset();
                    PharmHeader.Init();
                    PharmHeader."Pharmacy No." := NewNo;
                    PharmHeader."Pharmacy Date" := Today;
                    PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                    PharmHeader."Request Area" := PharmHeader."Request Area"::Doctor;
                    PharmHeader."Patient No." := Rec."Patient No.";
                    PharmHeader."Link Type" := 'Appointment';
                    PharmHeader."Link No." := Rec."Active Visit No";
                    PharmHeader.Insert();

                    Rec.Modify();
                    if Confirm('The Prescription has been sent to pharmacy,Do you want to open the issue form?', true) then
                        page.Run(70135118, PharmHeader);
                    //Message('The Prescription has been sent to the Pharmacy for Issuance');
                end;
            }
            action(Charges)
            {
                Caption = 'Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Charges action.';
            }
            action(Receipt)
            {
                Caption = 'Generate Receipt';
                Image = Receipt;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Generate Receipt action.';
                trigger OnAction()
                begin
                    HMS.CreateReceipt(Rec."Patient No.", Rec."Active Visit No");
                end;
            }
            action(PrintInvoive)
            {
                Caption = '&Print Invoive';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Invoive action.';
            }
            action(PostCharges)
            {
                Caption = 'Post Charges';
                Image = PostedPayment;
                Promoted = true;
                ToolTip = 'Executes the Post Charges action.';
            }
            separator(Action26)
            {
            }
            separator(Action28)
            {
            }
            action("Calculate Reccuring Charges")
            {
                Image = Calculate;
                ToolTip = 'Executes the Calculate Reccuring Charges action.';

                trigger OnAction()
                begin

                    HMS.CalculateReccuringCharges(Rec."Patient No.");
                    /*
                    HMSPatientCharges.RESET;
                    HMSPatientCharges.SETRANGE(HMSPatientCharges."Patient No.","Patient No.");
                    HMSPatientCharges.SETRANGE(HMSPatientCharges."Billing Type",HMSPatientCharges."Billing Type"::Reccuring);
                    HMSPatientCharges.SETCURRENTKEY(HMSPatientCharges."Patient No.",HMSPatientCharges."Billing Type",HMSPatientCharges."Reccuring Type",HMSPatientCharges.Date,HMSPatientCharges."Creation Time");
                    HMSPatientCharges.ASCENDING:=FALSE;
                    IF HMSPatientCharges.FIND('-') THEN BEGIN
                      LastBillDate:=HMSPatientCharges.Date;
                      Ln:=HMSPatientCharges."Line No";
                      REPEAT
                      IF HMSPatientCharges."Reccuring Type"=HMSPatientCharges."Reccuring Type"::Daily THEN BEGIN
                      IF TODAY<>LastBillDate THEN BEGIN
                      BillDays:=TODAY-LastBillDate;
                      FOR i:=1 TO BillDays DO BEGIN
                      Ln:=Ln+1;
                      LastBillDate:=LastBillDate+1;
                      HMSPatientCharges1.INIT;
                      HMSPatientCharges1."Transaction Type":='BED CHARGES';
                      HMSPatientCharges1.VALIDATE("Transaction Type");
                      HMSPatientCharges1."Line No":=Ln;
                      HMSPatientCharges1."Patient No.":="Patient No.";
                      HMSPatientCharges1."Link No":=HMSPatientCharges."Link No";
                      HMSPatientCharges1."Treatment No.":=HMSPatientCharges."Treatment No.";
                      HMSPatientCharges1."Shortcut Dimension 1 Code":=HMSPatientCharges."Shortcut Dimension 1 Code";
                      HMSPatientCharges1."Transaction Type":=HMSPatientCharges."Transaction Type";
                      HMSPatientCharges1.Code:=HMSPatientCharges.Code;
                      HMSPatientCharges1.Description:=HMSPatientCharges.Description;
                      HMSPatientCharges1.Amount:=HMSPatientCharges.Amount;
                      HMSPatientCharges1.VALIDATE(Amount);
                      HMSPatientCharges1.Date:=LastBillDate;
                      HMSPatientCharges1."Billing Type":=HMSPatientCharges."Billing Type";
                      HMSPatientCharges1."Reccuring Type":=HMSPatientCharges."Reccuring Type";
                      HMSPatientCharges1.Quantity:=1;
                      HMSPatientCharges1.INSERT;
                      END;
                      END;
                      END;
                       IF HMSPatientCharges."Reccuring Type"=HMSPatientCharges."Reccuring Type"::Hourly THEN BEGIN
                      IF TODAY>=LastBillDate THEN BEGIN
                      BillDays:=TODAY-LastBillDate;
                      FOR i:=1 TO BillDays DO BEGIN
                      Ln:=Ln+1;
                      LastBillDate:=LastBillDate+1;
                      HMSPatientCharges1.INIT;
                      HMSPatientCharges1."Line No":=Ln;
                      HMSPatientCharges1."Transaction Type":=HMSPatientCharges."Transaction Type";
                      HMSPatientCharges1.VALIDATE("Transaction Type");
                      HMSPatientCharges1.Quantity:=1;
                      HMSPatientCharges1."Patient No.":="Patient No.";
                      HMSPatientCharges1."Link No":=HMSPatientCharges."Link No";
                      HMSPatientCharges1."Treatment No.":=HMSPatientCharges."Treatment No.";
                      HMSPatientCharges1."Shortcut Dimension 1 Code":=HMSPatientCharges."Shortcut Dimension 1 Code";
                      HMSPatientCharges1."Transaction Type":=HMSPatientCharges."Transaction Type";
                      HMSPatientCharges1.Code:=HMSPatientCharges.Code;
                      HMSPatientCharges1.Description:=HMSPatientCharges.Description;
                      IF TODAY<>LastBillDate THEN
                        HMSPatientCharges1.Quantity:=24
                      ELSE
                      HMSPatientCharges1.Quantity:=(TIME-HMSPatientCharges."Creation Time");
                      HMSPatientCharges1.Amount:=HMSPatientCharges.Amount*HMSPatientCharges1.Quantity;
                      HMSPatientCharges1.VALIDATE(Amount);
                      HMSPatientCharges1.Date:=LastBillDate;
                      HMSPatientCharges1."Billing Type":=HMSPatientCharges."Billing Type";
                      HMSPatientCharges1."Reccuring Type":=HMSPatientCharges."Reccuring Type";
                      HMSPatientCharges1.INSERT;
                      END;
                      END;
                      END;
                      UNTIL HMSPatientCharges.NEXT=0;
                    END;
                    */
                    Message('Completed Successfully');
                end;
            }
            action("Generate Insurance Invoice")
            {
                Image = Invoice;
                ToolTip = 'Executes the Generate Insurance Invoice action.';
                trigger OnAction()
                begin

                    Rec.TestField("Active Visit No");
                    Rec.TestField("Insurance No.");

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Active Visit No");
                    //HMSPatientCharges.SETRANGE(HMSPatientCharges.Posted, FALSE);
                    if HMSPatientCharges.Find('-') then
                        REPORT.Run(51932, true, true, HMSPatientCharges);
                    //HMS.GenerateInvoice("Patient No.");
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    //HMSPatientCharges.SETRANGE(HMSPatientCharges."Visit No","Active Visit No");
                    HMSPatientCharges.SetRange(HMSPatientCharges."Invoice Number", '');
                    if HMSPatientCharges.Find('-') then
                        Rec.Activated := true
                        // Modify;
                    else
                        ;
                        //Activated := false;
                        // Modify;
                end;
            }
            separator(Action30)
            {
            }
        }
        area(reporting)
        {
            action(PrintInterimInvoice)
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim Invoice action.';

                trigger OnAction()
                begin
                    /*
                    HMSPatientCharges.RESET;
                    HMSPatientCharges.SETFILTER(HMSPatientCharges."Patient No.","Patient No.");
                    IF HMSPatientCharges.FIND('-') THEN
                    REPORT.RUN(39005476,TRUE,TRUE,HMSPatientCharges);
                    */
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Active Visit No");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(70135521, true, true, HMSPatientCharges);
                end;
            }
            action(PrintSummaryInterimInvoice)
            {
                Caption = '&Print Summary Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Summary Invoice action.';

                trigger OnAction()
                begin

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Active Visit No");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(56509, true, true, HMSPatientCharges);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if DoctRec.Get(Rec."Admitting Doctor") then;
        if Rec."Patient Type" = Rec."patient type"::Corporate then
            InsName := Rec."Insurance Name"
        else
            InsName := 'Cash';

        if Patients.get(Rec."Patient No.") then
            PatientName := Patients."Search Name";
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then
            if UserRec."Branch Code" <> '' then
                Rec.setfilter("Global Dimension 1 Code", UserRec."Branch Code");
    end;

    var
        Patients: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        DoctRec: Record "HMS Setup Doctor";
        HMS: Codeunit "HMS Patient-integration";
        InsName: Text[100];
        PatientName: Text[200];
}
