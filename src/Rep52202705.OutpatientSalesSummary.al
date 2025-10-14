namespace PTL.Hospital;

report 52202705 "Outpatient Sales Summary"
{
    ApplicationArea = All;
    Caption = 'Outpatient Sales Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SalesSummaryOP.rdl';
    dataset
    {
        dataitem(HMSAppointmentFormHeader; "HMS Appointment Form Header")
        {
            DataItemTableView = where(Status = filter('Completed'));
            RequestFilterFields = Branch, "Appointment Date";
            column(AppointmentNo; "Appointment No.")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            column(Status; Status)
            {
            }
            column(PostedInvoiceNo; "Posted Invoice No")
            {
            }
            column(InvoiceNo; "Invoice No")
            {
            }
            column(InvoicePosted; "Invoice Posted")
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
}
