namespace HospitalSystem.HospitalSystem;

query 85227 HmsReceiptsList
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HmsReceiptsList';
    EntitySetName = 'HmsReceiptsList';
    QueryType = API;
    
    elements
    {
        dataitem(receiptsHeader; "Receipts Header")
        {
            column(amountRecieved; "Amount Recieved")
            {
            }
            column(applicantName; "Applicant Name")
            {
            }
            column(applicationNo; "Application No")
            {
            }
            column(bankBalance; "Bank Balance")
            {
            }
            column(bankCode; "Bank Code")
            {
            }
            column(bankName; "Bank Name")
            {
            }
            column(cashier; Cashier)
            {
            }
            column(chequeNo; "Cheque No.")
            {
            }
            column(coPay; "Co-Pay")
            {
            }
            column(createdBy; "Created By")
            {
            }
            column(createdDateTime; "Created Date Time")
            {
            }
            column(currencyCode; "Currency Code")
            {
            }
            column(currencyFactor; "Currency Factor")
            {
            }
            column(customerNo; "Customer No")
            {
            }
            column("date"; "Date")
            {
            }
            column(datePosted; "Date Posted")
            {
            }
            column(dim3; Dim3)
            {
            }
            column(dim4; Dim4)
            {
            }
            column(disbursableAmount; "Disbursable Amount")
            {
            }
            column(disbursedAmount; "Disbursed Amount")
            {
            }
            column(documentDate; "Document Date")
            {
            }
            column(fromEntryNo; "From Entry No.")
            {
            }
            column(fullyDisbursed; "Fully Disbursed")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(imprestNo; "Imprest No")
            {
            }
            column(interBankNo; "InterBank No")
            {
            }
            column(laboratoryNo; "Laboratory No")
            {
            }
            column(manualRefNumber; "Manual Ref.Number")
            {
            }
            column(mobileMoneyType; "Mobile Money Type")
            {
            }
            column(no; "No.")
            {
            }
            column(noPrinted; "No. Printed")
            {
            }
            column(noSeries; "No. Series")
            {
            }
            column(onBehalfOf; "On Behalf Of")
            {
            }
            column(patientAppointmentNo; "Patient Appointment No")
            {
            }
            column(patientNo; "Patient No.")
            {
            }
            column(payMode; "Pay Mode")
            {
            }
            column(payModeLk; "Pay Mode Lk")
            {
            }
            column(pharmacyNo; "Pharmacy No")
            {
            }
            column(posted; Posted)
            {
            }
            column(postedBy; "Posted By")
            {
            }
            column(postedCount; "Posted Count")
            {
            }
            column(printNo; "Print No.")
            {
            }
            column(receiptReference; "Receipt Reference")
            {
            }
            column(receiptSplitAmount; "Receipt Split Amount")
            {
            }
            column(receivedFrom; "Received From")
            {
            }
            column(registerNo; "Register No.")
            {
            }
            column(remarks; Remarks)
            {
            }
            column(responsibilityCenter; "Responsibility Center")
            {
            }
            column(reversalDate; "Reversal Date")
            {
            }
            column(reversed; Reversed)
            {
            }
            column(reversedBy; "Reversed By")
            {
            }
            column(reversedPosted; "Reversed Posted")
            {
            }
            column(shortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(shortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(shortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(splitAmount; "Split Amount")
            {
            }
            column(staffNumber; "Staff Number")
            {
            }
            column(status; Status)
            {
            }
            column(surrenderNo; "Surrender No")
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(systemCreatedBy; SystemCreatedBy)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
            }
            column(systemModifiedBy; SystemModifiedBy)
            {
            }
            column(timePosted; "Time Posted")
            {
            }
            column(toEntryNo; "To Entry No.")
            {
            }
            column(totalAmount; "Total Amount")
            {
            }
            column(transactionCode; "Transaction Code")
            {
            }
            column(isPartialPayment; isPartialPayment)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
