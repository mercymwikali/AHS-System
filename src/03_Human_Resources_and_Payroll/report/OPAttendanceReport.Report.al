report 85147 "OP Attendance Report"
{
    ApplicationArea = All;
    Caption = 'OutPatient Attendance Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(HMSAppointmentFormHeader; "HMS Appointment Form Header")
        {
            column(AppointmentNo; "Appointment No.")
            {
            }
            column(AppointmentDate; "Appointment Date")
            {
            }
            column(AppointmentTime; "Appointment Time")
            {
            }
            column(AppointmentType; "Appointment Type")
            {
            }
            column(Status; Status)
            {
            }
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
        CompInf: Record "Company Information";
}
