namespace PTL.HMISBC;
using System.Utilities;

report 52202718 "Get Encounters"
{
    ApplicationArea = All;
    Caption = 'Get Encounters';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(2));

            trigger OnAfterGetRecord()
            var
                HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
                VisitswithUnsyncedCharges: Record "Visits with Unsynced Charges";
                HMSPatientCharges: Record "HMS Patient Charges";
            begin
                if startDate = 0D then
                    startDate := WorkDate();
                if EndDate = 0D then
                    EndDate := WorkDate();
                HMSAppointmentFormHeader.Reset();
                HMSAppointmentFormHeader.SetRange("Appointment Date", startDate, EndDate);
                HMSAppointmentFormHeader.SetRange("Status", HMSAppointmentFormHeader."Status"::Completed);
                if HMSAppointmentFormHeader.FindSet() then
                    repeat
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetRange("Visit No", HMSAppointmentFormHeader."Appointment No.");
                        HMSPatientCharges.SetRange("Shortcut Dimension 4 Code", 'Corporate');
                        if HMSPatientCharges.FindFirst() then begin
                            VisitswithUnsyncedCharges.Init();
                            VisitswithUnsyncedCharges."Visit No" := HMSAppointmentFormHeader."Appointment No.";
                            VisitswithUnsyncedCharges.Validate("Visit No");
                            VisitswithUnsyncedCharges.Insert();
                        end;
                    until HMSAppointmentFormHeader.Next() = 0;

                HMSAdmissionFormHeader.Reset();
                HMSAdmissionFormHeader.SetRange("Admission Date", startDate, EndDate);
                HMSAdmissionFormHeader.SetRange("Status", HMSAdmissionFormHeader."Status"::Discharged);
                if HMSAdmissionFormHeader.FindSet() then
                    repeat
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetRange("Visit No", HMSAppointmentFormHeader."Appointment No.");
                        HMSPatientCharges.SetRange("Shortcut Dimension 4 Code", 'Corporate');
                        if HMSPatientCharges.FindFirst() then begin
                            VisitswithUnsyncedCharges.Init();
                            VisitswithUnsyncedCharges."Visit No" := HMSAdmissionFormHeader."Admission No.";
                            VisitswithUnsyncedCharges.Validate("Visit No");
                            VisitswithUnsyncedCharges.Insert();
                        end;
                    until HMSAdmissionFormHeader.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                    field(startDate; startDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Enter the start date for the report.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date for the report.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        startDate: Date;
        EndDate: Date;
}
