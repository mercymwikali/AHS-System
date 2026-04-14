Report 85103 "HMS Patient Prescription"
{
    Caption = 'Patient Prescription';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './Layouts/HMSPatientPrescription.rdl';

    dataset
    {
        dataitem("HMS Pharmacy Header"; "HMS Pharmacy Header")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Pharmacy No.", "Pharmacy Date", "Link No.";
            column(ReportForNavId_6640; 6640)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(PharmacyNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy No.")
            {
            }
            column(PharmacyDate_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy Date")
            {
            }
            column(PharmacyTime_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy Time")
            {
            }
            column(RequestArea_HMSPharmacyHeader; "HMS Pharmacy Header"."Request Area")
            {
            }
            column(PatientNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Patient No.")
            {
            }
            column(StudentNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Student No.")
            {
            }
            column(EmployeeNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Employee No.")
            {
            }
            column(RelativeNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Relative No.")
            {
            }
            column(BillToCustomerNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Bill To Customer No.")
            {
            }
            column(IssuedBy_HMSPharmacyHeader; "HMS Pharmacy Header"."Issued By")
            {
            }
            column(LinkType_HMSPharmacyHeader; "HMS Pharmacy Header"."Link Type")
            {
            }
            column(LinkNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Link No.")
            {
            }
            column(Status_HMSPharmacyHeader; "HMS Pharmacy Header".Status)
            {
            }
            column(NoSeries_HMSPharmacyHeader; "HMS Pharmacy Header"."No. Series")
            {
            }
            column(Surname_HMSPharmacyHeader; "HMS Pharmacy Header".Surname)
            {
            }
            column(MiddleName_HMSPharmacyHeader; "HMS Pharmacy Header"."Middle Name")
            {
            }
            column(LastName_HMSPharmacyHeader; "HMS Pharmacy Header"."Last Name")
            {
            }
            column(Issuing_Location; "Issuing Location") { }
            column(Issued_By; "Issued By") { }
            
            column(IDNumber_HMSPharmacyHeader; "HMS Pharmacy Header"."ID Number") { }
            column(CorrespondenceAddress1_HMSPharmacyHeader; "HMS Pharmacy Header"."Correspondence Address 1")
            {
            }
            column(TelephoneNo1_HMSPharmacyHeader; "HMS Pharmacy Header"."Telephone No. 1")
            {
            }
            column(Email_HMSPharmacyHeader; "HMS Pharmacy Header".Email)
            {
            }
            column(PatientRefNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Patient Ref. No.")
            {
            }
            column(TotalPrice_HMSPharmacyHeader; "HMS Pharmacy Header"."Total Price")
            {
            }
            column(InsuranceNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Insurance No")
            {
            }
            column(AdmNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Ref No")
            {
            }
            column(CLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code") { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            column(CompanyInfo_phone; CompanyInfo."Phone No.") { }
            column(CompanyInfo_Homepage; CompanyInfo."Home Page") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(PGender; gend)
            {
            }
            column(DName; Docname)
            {
            }
            column(patientWeight; patientWeight) { }
            column(PatientAge; PatientAge) { }
            dataitem("HMS Pharmacy Line"; "HMS Pharmacy Line")
            {
                DataItemLink = "Pharmacy No." = field("Pharmacy No.");
                column(ReportForNavId_7; 7)
                {
                }
                column(DrugName_HMSPharmacyLine; "HMS Pharmacy Line"."Drug Name")
                {
                }
                column(Quantity_HMSPharmacyLine; "HMS Pharmacy Line".Quantity)
                {
                }
                column(Dosage_HMSPharmacyLine; "HMS Pharmacy Line".Dosage)
                {
                }
                column(Frequency_HMSPharmacyLine; Frequency)
                {
                }
                column(NumberofDays_HMSPharmacyLine; "Number of Days")
                {
                }
                column(MeasuringUnit_HMSPharmacyLine; "Measuring Unit")
                {
                }
                column(Take_HMSPharmacyLine; Take)
                {
                }
                column(PrescriptionDose_HMSPharmacyLine; "Prescription Dose")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
                HMSObservationFormLine: Record "HMS Observation Form Line Proc";
                HRDates: Codeunit "HR Dates";
            begin
                PatientAge := '';
                gend := '';
                IF PatientRec.GET("HMS Pharmacy Header"."Patient No.") THEN;
                PatientName := PatientRec."Search Name";
                IF PatientRec.GET("HMS Pharmacy Header"."Patient No.") THEN;
                //gender:=PatientRec.Gender;
                IF PatientRec.Gender = PatientRec.gender::Male THEN
                    gend := 'Male';
                IF PatientRec.Gender = PatientRec.gender::Female THEN
                    gend := 'Female';

                PatientAge := HRDates.DetermineAge(PatientRec."Date Of Birth", Today);

                // "HMS Pharmacy Header".CalcFields(InPatient);
                if not "HMS Pharmacy Header".InPatient then begin
                    HMSTreatmentFormHeader.Reset();
                    HMSTreatmentFormHeader.SetRange("Treatment No.", "Link No.");
                    if HMSTreatmentFormHeader.FindFirst() then begin
                        HMSObservationFormLine.Reset();
                        HMSObservationFormLine.SetRange("Observation No.", HMSTreatmentFormHeader."Observation No");
                        if HMSObservationFormLine.FindFirst() then begin
                            patientWeight := HMSObservationFormLine.Weight;
                        end
                    end;
                end;


                IF docRec.GET("HMS Pharmacy Header"."Doctor ID") THEN
                    Docname := docRec."Doctors Name";
                IF "HMS Pharmacy Line".Frequency = 24 THEN
                    FreqType := 'Hourly';
            end;

            trigger OnPostDataItem()
            begin
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            // ArchiveDocument := SalesSetup."Archive Quotes and Orders";
          //  LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PatientRec: Record "HMS Patient";

        docRec: Record "HMS Setup Doctor";
        SegManagement: Codeunit SegManagement;
        patientWeight: Decimal;
        Age: Text[20];
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        FreqType: Code[50];
        gend: Text[50];
        Docname: Text[100];
        PatientName: Text[100];
        PatientAge: Text;

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean)
    begin
    end;
}
