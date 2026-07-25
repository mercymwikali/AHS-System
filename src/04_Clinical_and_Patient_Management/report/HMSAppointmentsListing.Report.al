Report 85071 "HMS Appointments Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/HMSAppointmentsListing.rdl';

    dataset
    {
        dataitem("HMS Appointment Form Header"; "HMS Appointment Form Header")
        {
            DataItemTableView = sorting("Appointment No.");
            RequestFilterFields = "Global Dimension 1", "Appointment No.", "Appointment Date", "Appointment Time", "Patient Type";
            column(ReportForNavId_8549; 8549)
            {
            }
            column(DATE_PRINTED____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_No__; "Appointment No.")
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Date_; "Appointment Date")
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Type_; "Appointment Type")
            {
            }
            column(HMS_Appointment_Form_Header_Doctor; Doctor)
            {
            }
            column(HMS_Appointment_Form_Header__Patient_Type_; "Patient Type")
            {
            }
            column(UPPERCASE_FORMAT_Status__; UpperCase(Format(Status)))
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Time_; "Appointment Time")
            {
            }
            column(TOTAL_APPOINTMENTS_LISTED_____FORMAT__HMS_Appointment_Form_Header__COUNT_; 'TOTAL APPOINTMENTS LISTED:' + Format("HMS Appointment Form Header".Count))
            {
            }
            column(PRINTED_BY____USERID; 'PRINTED BY:' + UserId)
            {
            }
            column(UNIVERSITY_HEALTH_SERVICESCaption; UNIVERSITY_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(APPOINTMENTS_LISTINGCaption; APPOINTMENTS_LISTINGCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(HMS_Appointment_Form_Header_DoctorCaption; FieldCaption(Doctor))
            {
            }
            column(HMS_Appointment_Form_Header__Patient_Type_Caption; FieldCaption("Patient Type"))
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Patient_NameCaption; Patient_NameCaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(CPicture; companyinfo.Picture)
            {
            }
            column(AppointmentType_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Appointment Type")
            {
            }
            column(SettlementType_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Settlement Type")
            {
            }
            column(InsuranceName_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Insurance Name")
            {
            }
            column(MembershipNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Membership No")
            {
            }
            column(DoctorsName_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Doctors Name")
            {
            }
            column(Gender_HMSAppointmentFormHeader; "HMS Appointment Form Header".Gender)
            {
            }
            column(MCCNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."MVC No.")
            {
            }
            column(GlobalDimension1_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Global Dimension 1")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.Reset();
                PFNo := '';
                PatientName := '';
                if Patient.Get("Patient No.") then begin
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    if Patient."Patient Type" = Patient."patient type"::Corporate then
                        PFNo := Patient."Patient No."
                    else if Patient."Patient Type" = Patient."patient type"::Cash then
                        PFNo := Patient."Patient No."
                    else if Patient."Patient Type" = Patient."patient type"::Corporate then
                        PFNo := Patient."Patient No."
                    else if Patient."Patient Type" = Patient."patient type"::" " then
                        PFNo := Patient."Patient No."
                    else
                        PFNo := Patient."Patient No.";
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Appointment No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        Patient: Record "HMS Patient";
        PFNo: Code[20];
        LastFieldNo: Integer;
        APPOINTMENTS_LISTINGCaptionLbl: label 'APPOINTMENTS LISTING';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        DateCaptionLbl: label 'Date';
        No_CaptionLbl: label 'No.';
        Patient_NameCaptionLbl: label 'Patient Name';
        PF_No_CaptionLbl: label 'PF No.';
        StatusCaptionLbl: label 'Status';
        TimeCaptionLbl: label 'Time';
        TypeCaptionLbl: label 'Type';
        UNIVERSITY_HEALTH_SERVICESCaptionLbl: label 'UNIVERSITY HEALTH SERVICES';
        PatientName: Text[200];
}
