Report 52202616 "HMS Referral Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReferralListingReport.rdl';

    dataset
    {
        dataitem("HMS Referral Header"; "HMS Referral Header")
        {
            DataItemTableView = sorting("Treatment no.");
            RequestFilterFields = "Treatment no.";
            column(ReportForNavId_6553; 6553)
            {
            }
            column(Date_Printed_____FORMAT_TODAY_0_4_; 'Date Printed:' + Format(Today, 0, 4))
            {
            }
            column(UPPERCASE_COMPANYNAME_; UpperCase(COMPANYNAME))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(Printed_By_____USERID; 'Printed By:' + UserId)
            {
            }
            column(HMS_Referral_Header__Treatment_no__; "Treatment no.")
            {
            }
            column(HMS_Referral_Header__Hospital_No__; "Hospital No.")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Referral_Header__Date_Referred_; "Date Referred")
            {
            }
            column(HMS_Referral_Header__Referral_Reason_; "Referral Reason")
            {
            }
            column(HMS_Referral_Header_Status; Status)
            {
            }
            column(HospName; HospName)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(REFERRALS_LISTED______FORMAT__HMS_Referral_Header__COUNT_; 'REFERRALS LISTED: ' + Format("HMS Referral Header".Count))
            {
            }
            column(UNIVERSITY_HEALTH_SERVICESCaption; UNIVERSITY_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(REFERRAL_LISTING_REPORTCaption; REFERRAL_LISTING_REPORTCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(HMS_Referral_Header__Hospital_No__Caption; FieldCaption("Hospital No."))
            {
            }
            column(PFNoCaption; PFNoCaptionLbl)
            {
            }
            column(HMS_Referral_Header__Date_Referred_Caption; FieldCaption("Date Referred"))
            {
            }
            column(HMS_Referral_Header__Referral_Reason_Caption; FieldCaption("Referral Reason"))
            {
            }
            column(HMS_Referral_Header_StatusCaption; FieldCaption(Status))
            {
            }
            column(HospitalCaption; HospitalCaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Hosp.Reset();
                HospName := '';
                if Hosp.Get("HMS Referral Header"."Hospital No.") then
                    HospName := Hosp.Name;

                Patient.Reset();
                PatientName := '';
                PFNo := '';
                if Patient.Get("Patient No.") then begin
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    if Patient."Patient Type" = Patient."patient type2"::Private then
                        PFNo := Patient."Student No."
                    else if Patient."Patient Type" = Patient."patient type"::" " then
                        PFNo := Patient."Patient No."
                    else
                        PFNo := Patient."Employee No.";
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Treatment no.");
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

    var
        Patient: Record "HMS Patient";
        Hosp: Record Vendor;
        PFNo: Code[20];
        LastFieldNo: Integer;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        HospitalCaptionLbl: label 'Hospital';
        No_CaptionLbl: label 'No.';
        Patient_nameCaptionLbl: label 'Patient name';
        PFNoCaptionLbl: label 'Label1102760018';
        REFERRAL_LISTING_REPORTCaptionLbl: label 'REFERRAL LISTING REPORT';
        UNIVERSITY_HEALTH_SERVICESCaptionLbl: label 'UNIVERSITY HEALTH SERVICES';
        HospName: Text[100];
        PatientName: Text[200];
}
