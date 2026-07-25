namespace HospitalSystem.HospitalSystem;

using Microsoft.Sales.History;
using Microsoft.Sales.Customer;

query 85229 PostedPatientInvoices
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'PostedPatientInvoice';
    EntitySetName = 'PostedPatientInvoices';
    QueryType = API;

    elements
    {
        dataitem(salesInvoiceHeader; "Sales Invoice Header")
        {
            // --- Invoice Header Details ---
            column(id; SystemId) { }
            column(invoiceNo; "No.") { }
            column(postingDate; "Posting Date") { }
            column(documentDate; "Document Date") { }
            
            // --- Patient Information (From Header Extensions) ---
            column(patientNo; "Patient No.") { }
            column(patientName; "Patient Name") { }
            column(patientSearchNames; "Patient Search Names") { }
            column(appointmentNo; "Appointment No") { }
            column(treatmentNo; "Treatment No") { }
            column(diagnosis; "Diagnosis") { }
            column(nhifNo; "NHIF No") { }

            // --- Invoice Totals ---
            column(amount; Amount) { }
            column(amountIncludingVAT; "Amount Including VAT") { }
            column(paid; Paid) { }
            column(paidAmount; "Paid Amount") { }

            // --- Linked Insurance Provider Details ---
            dataitem(insuranceCustomer; Customer)
            {
                DataItemLink = "No." = salesInvoiceHeader."Bill-to Customer No.";
                SqlJoinType = LeftOuterJoin;

                column(insuranceProviderNo; "No.") { }
                column(insuranceProviderName; Name) { }
                column(genBusPostingGroup; "Gen. Bus. Posting Group") { }
                
                // Custom Corporate Health Cover Configurations
                column(insurancePackage; "NHIF Package") { }
                column(insuranceCapitation; "NHIF Capitation") { }
                column(minetCoverCode; Minet) { }
                column(visitCeiling; "Visit Ceiling") { }
                column(coPayAmount; "Co-Pay Amount") { }
                column(coPayPercentage; "Co-Pay Percentage") { }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}