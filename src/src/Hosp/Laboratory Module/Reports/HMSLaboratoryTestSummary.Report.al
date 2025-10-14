Report 52202515 "HMS Laboratory Test Summary"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lab/HMSLaboratoryTestSummary.rdl';

    dataset
    {
        dataitem("HMS Laboratory Form Header"; "HMS Laboratory Form Header")
        {
            DataItemTableView = sorting("Laboratory No.");
            RequestFilterFields = "Laboratory No.";
            column(ReportForNavId_7278; 7278)
            {
            }
            column(Date_Printed______FORMAT_TODAY_0_4_; 'Date Printed: ' + Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(Printed_By______USERID; 'Printed By: ' + UserId)
            {
            }
            column(HMS_Laboratory_Form_Header__Laboratory_No__; "Laboratory No.")
            {
            }
            column(HMS_Laboratory_Form_Header__Laboratory_Date_; "Laboratory Date")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Laboratory_Form_Header__Supervisor_ID_; "Supervisor ID")
            {
            }
            column(HMS_Laboratory_Form_Header_Status; Status)
            {
            }
            column(HMS_Laboratory_Form_Header__Patient_Type_; "Patient Type")
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(Number_of_Laboratory_Tests_Listed______FORMAT__HMS_Laboratory_Form_Header__COUNT_; 'Number of Laboratory Tests Listed: ' + Format("HMS Laboratory Form Header".Count))
            {
            }
            column(UNIVERSITY_HEALTH_SERVICESCaption; UNIVERSITY_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(LABORATORY_TESTS_LISTINGCaption; LABORATORY_TESTS_LISTINGCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(ResponsibleCaption; ResponsibleCaptionLbl)
            {
            }
            column(HMS_Laboratory_Form_Header_StatusCaption; FieldCaption(Status))
            {
            }
            column(HMS_Laboratory_Form_Header__Patient_Type_Caption; FieldCaption("Patient Type"))
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.Reset();
                PatientName := '';
                PFNo := '';
                if Patient.Get("Patient No.") then begin
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    if Patient."Patient Type" = Patient."patient type"::Corporate then
                        PFNo := Patient."Patient No."
                    else
                        if Patient."Patient Type" = Patient."patient type"::" " then
                            PFNo := Patient."Patient No."
                        else
                            PFNo := Patient."Patient No.";
                end
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Laboratory No.");
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
        LastFieldNo: Integer;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        DateCaptionLbl: label 'Date';
        LABORATORY_TESTS_LISTINGCaptionLbl: label 'LABORATORY TESTS LISTING';
        No_CaptionLbl: label 'No.';
        Patient_nameCaptionLbl: label 'Patient name';
        PF_No_CaptionLbl: label 'PF/No.';
        ResponsibleCaptionLbl: label 'Responsible';
        UNIVERSITY_HEALTH_SERVICESCaptionLbl: Label '';
        PatientName: Text[200];
}
