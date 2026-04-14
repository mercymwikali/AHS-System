Report 85182 "HMS Observation Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/HMSObservationListingReport.rdl';

    dataset
    {
        dataitem("HMS Observation Form Header"; "HMS Observation Form Header")
        {
            DataItemTableView = sorting("Observation No.");
            RequestFilterFields = "Observation No.";
            column(ReportForNavId_8630; 8630)
            {
            }
            column(DATE_PRINTED_____UPPERCASE_FORMAT_TODAY_0_4__; 'DATE PRINTED:' + UpperCase(Format(Today, 0, 4)))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(PRINTED_BY____USERID; 'PRINTED BY:' + UserId)
            {
            }
            column(HMS_Observation_Form_Header__Observation_No__; "Observation No.")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Date_; "Observation Date")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Time_; "Observation Time")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Remarks_; "Observation Remarks")
            {
            }
            column(HMS_Observation_Form_Header_Closed; Closed)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(OBSERVATIONS_LISTED_____FORMAT__HMS_Observation_Form_Header__COUNT_; 'OBSERVATIONS LISTED: ' + Format("HMS Observation Form Header".Count))
            {
            }
            column(UNIVERSITY_HEALTH_SERVICESCaption; UNIVERSITY_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(HMS_Observation_Form_Header_ClosedCaption; FieldCaption(Closed))
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(OBSERVATION_LISTING_REPORTCaption; OBSERVATION_LISTING_REPORTCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.Reset();
                PatientName := '';
                PFNo := '';
                if Patient.Get("Patient No.") then begin
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    if Patient."Patient Type" = Patient."patient type2"::Private then
                        PFNo := Patient."Employee No."
                    else
                        if Patient."Patient Type" = Patient."patient type"::" " then
                            PFNo := Patient."Patient No."
                        else
                            PFNo := Patient."Employee No.";
                end;
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
        PFNo: Code[20];
        CurrReport_PAGENOCaptionLbl: label 'Page';
        DateCaptionLbl: label 'Date';
        No_CaptionLbl: label 'No.';
        OBSERVATION_LISTING_REPORTCaptionLbl: label 'OBSERVATION LISTING REPORT';
        Patient_nameCaptionLbl: label 'Patient name';
        PF_No_CaptionLbl: label 'PF No.';
        RemarksCaptionLbl: label 'Remarks';
        TimeCaptionLbl: label 'Time';
        UNIVERSITY_HEALTH_SERVICESCaptionLbl: label 'UNIVERSITY HEALTH SERVICES';
        PatientName: Text[100];
}
