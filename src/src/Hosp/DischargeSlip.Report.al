Report 52202507 "Discharge Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DischargeSlip.rdl';

    dataset
    {
        dataitem("HMS Admission Discharge Header"; "HMS Admission Discharge Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(cname; CompanyInformation.Name)
            {
            }
            column(caddress; CompanyInformation.Address)
            {
            }
            column(ccity; CompanyInformation.City)
            {
            }
            column(cphone; CompanyInformation."Phone No.")
            {
            }
            column(cpicture; CompanyInformation.Picture)
            {
            }
            column(Cemail; CompanyInformation."E-Mail")
            {
            }
            column(chomepage; CompanyInformation."Home Page")
            {
            }
            column(AdmissionNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Admission No.")
            {
            }
            column(PatientNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Patient No.")
            {
            }
            column(DischargeDate_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Discharge Date")
            {
            }
            column(DischargeTime_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Discharge Time")
            {
            }
            column(DoctorID_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Doctor ID")
            {
            }
            column(NurseID_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Nurse ID")
            {
            }
            column(WardNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Ward No.")
            {
            }
            column(BedNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Bed No.")
            {
            }
            column(DateofAdmission_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Date of Admission")
            {
            }
            column(SecurityCode_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Security Code")
            {
            }
            column(document; docName)
            {
            }
            column(Patient_Name; PatientName)
            {
            }
            column(BedCategory; BedCategory)
            {
            }
            column(Gender; Gender_a)
            {
            }
            column(WardName; WardName)
            {
            }
            column(Doctor_Name; DoctorName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // if "HMS Admission Discharge Header"."Discharge Date" < Today then
                    // Error('Dear' + ' ' + UserId + ' ' + 'the allowable printing period for this document has elapsed');

                HMSWardSetup.Reset();
                HMSWardSetup.SetRange(HMSWardSetup."Ward Code", "HMS Admission Discharge Header"."Ward No.");
                if HMSWardSetup.Find('-') then
                    WardName := HMSWardSetup."Ward Name";
                HMSBeds.Reset();
                HMSBeds.SetRange(HMSBeds."Bed No", "HMS Admission Discharge Header"."Bed No.");
                if HMSBeds.Find('-') then
                    BedCategory := 'General Bed';

                HMSSetupDoctor.Reset();
                HMSSetupDoctor.SetRange(HMSSetupDoctor."Doctor ID", "HMS Admission Discharge Header"."Doctor ID");
                if HMSSetupDoctor.FindFirst() then
                    DoctorName := HMSSetupDoctor."Doctors Name";
                if HMSPatient.Get("HMS Admission Discharge Header"."Patient No.") then begin
                    Gender_a := Format(HMSPatient.Gender);
                    PatientName := HMSPatient."Search Name";
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
                docName := 'GATEPASS SLIP';
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
        CompanyInformation: Record "Company Information";
        HMSBeds: Record "HMS Beds";
        HMSPatient: Record "HMS Patient";
        HMSSetupDoctor: Record "HMS Setup Doctor";
        HMSWardSetup: Record "HMS Ward Setup";
        Separator: label '#';
        BedCategory: Text;
        docName: Text;
        DoctorName: Text;
        Gender_a: Text;
        PatientName: Text;
        WardName: Text;

    local procedure CalcQRCode()
    begin
    end;

    local procedure ConcatContent()
    begin
    end;

    local procedure AddToSeparator(InText: Text): Text
    begin
        exit(InText + Separator);
    end;
}
