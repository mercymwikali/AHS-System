namespace PTL.HMISBC;
using Microsoft.Sales.History;

report 85003 "Check post dated invoice"
{
    ApplicationArea = All;
    Caption = 'Check post dated invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Funds/CheckPostDatedInvoices.rdl';
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where(Code = filter('Admission Fee'), "Shortcut Dimension 4 Code" = filter('Corporate'));
            RequestFilterFields = Date;
            column(PatientNo; "Patient No.")
            {
            }
            column(Code; "Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Date; "Date")
            {
            }
            column(PostedInvoiceNo; "Posted Invoice No.")
            {
            }
            column(Invoice_Number;"Invoice Number")
            {

            }
            column(admisionDate;admisionDate){}
            column(DischargeDate;DischargeDate){}

            dataitem("Sales Invoice Header";"Sales Invoice Header")
            {
                DataItemLink =  "No." = field("Invoice Number");

                column(No_SalesInvoiceHeader; "No.")
                {
                }
                column(DocumentDate_SalesInvoiceHeader; "Document Date")
                {
                }
                column(PostingDate_SalesInvoiceHeader; "Posting Date")
                {
                }
                column(DueDate_SalesInvoiceHeader; "Due Date")
                {
                }
                column(PostedCount_SalesInvoiceHeader; "Posted Count")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                admisionDate := 0D;
                DischargeDate := 0D;
                HMSAdmissionDischargeHeader.Reset();
                HMSAdmissionDischargeHeader.SetRange("Admission No.", "Visit No");
                HMSAdmissionDischargeHeader.SetRange(Status, HMSAdmissionDischargeHeader.Status::Completed);
                if HMSAdmissionDischargeHeader.FindFirst() then begin
                    admisionDate := HMSAdmissionDischargeHeader."Date of Admission";
                    DischargeDate := HMSAdmissionDischargeHeader."Discharge Date";
                end;
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
    HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
    admisionDate: Date;
    DischargeDate: Date;
}
