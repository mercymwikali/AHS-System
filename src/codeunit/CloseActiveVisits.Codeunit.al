namespace PTL.HMIS;

codeunit 85032 "Close Active Visits"
{
    var
        HMSPatient: Record "HMS Patient";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        HMSPatientCharges: Record "HMS Patient Charges";
        CurrentDate: Date;
        CurrentTime: Time;

    trigger OnRun()
    begin
        CurrentDate := CalcDate('<-1D>', Today);
        CurrentTime := Time;

        HMSAppointmentFormHeader.Reset();
        HMSAppointmentFormHeader.SetRange("Appointment Date", 0D, CurrentDate);
        HMSAppointmentFormHeader.SetRange("ReAppointment Time", 0T, CurrentTime);
        HMSAppointmentFormHeader.SetFilter(Status, '%1|%2', HMSAppointmentFormHeader.status::New, HMSAppointmentFormHeader.status::Dispatched);
        if HMSAppointmentFormHeader.FindSet() then
            repeat
                HMSPatientCharges.Reset();
                HMSPatientCharges.SetRange("Visit No", HMSAppointmentFormHeader."Appointment No.");
                HMSPatientCharges.SetRange(Posted, true);
                HMSPatientCharges.SetRange(Closed, false);
                if HMSPatientCharges.FindSet() then
                    repeat
                        HMSPatientCharges."Closed" := true;
                        HMSPatientCharges.Modify();
                    until HMSPatientCharges.Next() = 0;

                // Deactivate Patients with no active visit on current date;

                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", HMSAppointmentFormHeader."Patient No.");
                HMSPatient.SetRange(Inpatient, false);
                if HMSPatient.FindFirst() then
                    if HMSPatient."Active Appointment date" <> Today then begin
                        HMSPatient.Activated := false;
                        HMSPatient."Active Visit No" := '';
                        HMSPatient.Modify();
                    end;

                HMSAppointmentFormHeader.Status := HMSAppointmentFormHeader.Status::Completed;
                HMSAppointmentFormHeader.Modify();
            until HMSAppointmentFormHeader.Next() = 0;
    end;

}
