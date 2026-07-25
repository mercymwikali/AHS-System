namespace HospitalSystem.HospitalSystem;

using Microsoft.Sales.Document;

query 85228 "HmsPatientInvoice"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HmsPatientInvoice';
    EntitySetName = 'HmsPatientInvoice';
    QueryType = API;
    
    elements
    {
        dataitem(salesHeader; "Sales Header")
        {
            column(allowLineDisc; "Allow Line Disc.")
            {
            }
            column(altGenBusPostingGroup; "Alt. Gen. Bus Posting Group")
            {
            }
            column(altVATBusPostingGroup; "Alt. VAT Bus Posting Group")
            {
            }
            column(altVATRegistrationNo; "Alt. VAT Registration No.")
            {
            }
            column(amount; Amount)
            {
            }
            column(amountIncludingVAT; "Amount Including VAT")
            {
            }
            column(amtShipNotInvLCY; "Amt. Ship. Not Inv. (LCY)")
            {
            }
            column(amtShipNotInvLCYBase; "Amt. Ship. Not Inv. (LCY) Base")
            {
            }
            column(appliesToDocNo; "Applies-to Doc. No.")
            {
            }
            column(appliesToDocType; "Applies-to Doc. Type")
            {
            }
            column(appliesToID; "Applies-to ID")
            {
            }
            column(appointmentNo; "Appointment No")
            {
            }
            column("area"; "Area")
            {
            }
            column(assignedUserID; "Assigned User ID")
            {
            }
            column(balAccountNo; "Bal. Account No.")
            {
            }
            column(balAccountType; "Bal. Account Type")
            {
            }
            column(billToAddress; "Bill-to Address")
            {
            }
            column(billToAddress2; "Bill-to Address 2")
            {
            }
            column(billToCity; "Bill-to City")
            {
            }
            column(billToContact; "Bill-to Contact")
            {
            }
            column(billToContactNo; "Bill-to Contact No.")
            {
            }
            column(billToCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(billToCounty; "Bill-to County")
            {
            }
            column(billToCustomerNo; "Bill-to Customer No.")
            {
            }
            column(billToCustomerTemplCode; "Bill-to Customer Templ. Code")
            {
            }
            column(billToICPartnerCode; "Bill-to IC Partner Code")
            {
            }
            column(billToName; "Bill-to Name")
            {
            }
            column(billToName2; "Bill-to Name 2")
            {
            }
            column(billToPostCode; "Bill-to Post Code")
            {
            }
            column(campaignNo; "Campaign No.")
            {
            }
            column(combineShipments; "Combine Shipments")
            {
            }
            // column(comment; Comment)
            // {
            // }
            column(companyBankAccountCode; "Company Bank Account Code")
            {
            }
            // column(completelyShipped; "Completely Shipped")
            // {
            // }
            column(compressPrepayment; "Compress Prepayment")
            {
            }
            column(correction; Correction)
            {
            }
            // column(coupledToDataverse; "Coupled to Dataverse")
            // {
            // }
            column(currencyCode; "Currency Code")
            {
            }
            column(currencyFactor; "Currency Factor")
            {
            }
            column(customerDiscGroup; "Customer Disc. Group")
            {
            }
            column(customerPostingGroup; "Customer Posting Group")
            {
            }
            column(customerPriceGroup; "Customer Price Group")
            {
            }
            column(diagnosis; Diagnosis)
            {
            }
            column(dimensionSetID; "Dimension Set ID")
            {
            }
            column(directDebitMandateID; "Direct Debit Mandate ID")
            {
            }
            column(dispatchNo; "Dispatch No")
            {
            }
            column(dispatched; Dispatched)
            {
            }
            column(docNoOccurrence; "Doc. No. Occurrence")
            {
            }
            column(documentDate; "Document Date")
            {
            }
            column(documentType; "Document Type")
            {
            }
            column(dueDate; "Due Date")
            {
            }
            column(eu3PartyTrade; "EU 3-Party Trade")
            {
            }
            column(exitPoint; "Exit Point")
            {
            }
            column(externalDocumentNo; "External Document No.")
            {
            }
            column(formatRegion; "Format Region")
            {
            }
            column(genBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(getShipmentUsed; "Get Shipment Used")
            {
            }
            column(icDirection; "IC Direction")
            {
            }
            column(icReferenceDocumentNo; "IC Reference Document No.")
            {
            }
            column(icStatus; "IC Status")
            {
            }
            column(incomingDocumentEntryNo; "Incoming Document Entry No.")
            {
            }
            column(invoice; Invoice)
            {
            }
            column(invoiceDiscCode; "Invoice Disc. Code")
            {
            }
            column(invoiceDiscountAmount; "Invoice Discount Amount")
            {
            }
            column(invoiceDiscountCalculation; "Invoice Discount Calculation")
            {
            }
            column(invoiceDiscountValue; "Invoice Discount Value")
            {
            }
            column(isTest; IsTest)
            {
            }
            column(jobQueueEntryID; "Job Queue Entry ID")
            {
            }
            column(jobQueueStatus; "Job Queue Status")
            {
            }
            column(journalTemplName; "Journal Templ. Name")
            {
            }
            column(languageCode; "Language Code")
            {
            }
            // column(lastEmailSentMessageId; "Last Email Sent Message Id")
            // {
            // }
            // column(lastEmailSentTime; "Last Email Sent Time")
            // {
            // }
            column(lastPostingNo; "Last Posting No.")
            {
            }
            column(lastPrepaymentNo; "Last Prepayment No.")
            {
            }
            column(lastPrepmtCrMemoNo; "Last Prepmt. Cr. Memo No.")
            {
            }
            column(lastReturnReceiptNo; "Last Return Receipt No.")
            {
            }
            // column(lastShipmentDate; "Last Shipment Date")
            // {
            // }
            column(lastShippingNo; "Last Shipping No.")
            {
            }
            // column(lateOrderShipping; "Late Order Shipping")
            // {
            // }
            column(locationCode; "Location Code")
            {
            }
            column(nhifNo; "NHIF No")
            {
            }
            column(noOfServices; "No of Services")
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
            // column(noOfArchivedVersions; "No. of Archived Versions")
            // {
            // }
            column(onHold; "On Hold")
            {
            }
            column(opportunityNo; "Opportunity No.")
            {
            }
            column(orderClass; "Order Class")
            {
            }
            column(orderDate; "Order Date")
            {
            }
            column(outboundWhseHandlingTime; "Outbound Whse. Handling Time")
            {
            }
            column(packageTrackingNo; "Package Tracking No.")
            {
            }
            column(paid; Paid)
            {
            }
            column(paidAmount; "Paid Amount")
            {
            }
            column(patientName; "Patient Name")
            {
            }
            column(patientNo; "Patient No.")
            {
            }
            column(patientSearchNames; "Patient Search Names")
            {
            }
            column(paymentDate; "Payment Date")
            {
            }
            column(paymentDiscount; "Payment Discount %")
            {
            }
            column(paymentMethodCode; "Payment Method Code")
            {
            }
            column(paymentServiceSetID; "Payment Service Set ID")
            {
            }
            column(paymentTermsCode; "Payment Terms Code")
            {
            }
            column(pmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(postedBy; "Posted By")
            {
            }
            column(postedCount; "Posted Count")
            {
            }
            column(postingDate; "Posting Date")
            {
            }
            column(postingDescription; "Posting Description")
            {
            }
            column(postingNo; "Posting No.")
            {
            }
            column(postingNoSeries; "Posting No. Series")
            {
            }
            column(postingFromWhseRef; "Posting from Whse. Ref.")
            {
            }
            column(prepayment; "Prepayment %")
            {
            }
            column(prepaymentDueDate; "Prepayment Due Date")
            {
            }
            column(prepaymentNo; "Prepayment No.")
            {
            }
            column(prepaymentNoSeries; "Prepayment No. Series")
            {
            }
            column(prepmtCrMemoNo; "Prepmt. Cr. Memo No.")
            {
            }
            column(prepmtCrMemoNoSeries; "Prepmt. Cr. Memo No. Series")
            {
            }
            column(prepmtPaymentDiscount; "Prepmt. Payment Discount %")
            {
            }
            column(prepmtPaymentTermsCode; "Prepmt. Payment Terms Code")
            {
            }
            column(prepmtPmtDiscountDate; "Prepmt. Pmt. Discount Date")
            {
            }
            column(prepmtPostingDescription; "Prepmt. Posting Description")
            {
            }
            column(priceCalculationMethod; "Price Calculation Method")
            {
            }
            column(pricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(printPostedDocuments; "Print Posted Documents")
            {
            }
            column(promisedDeliveryDate; "Promised Delivery Date")
            {
            }
            column(quoteAccepted; "Quote Accepted")
            {
            }
            column(quoteAcceptedDate; "Quote Accepted Date")
            {
            }
            column(quoteNo; "Quote No.")
            {
            }
            column(quoteSentToCustomer; "Quote Sent to Customer")
            {
            }
            column(quoteValidUntilDate; "Quote Valid Until Date")
            {
            }
            column(rcvdFromCountRegionCode; "Rcvd.-from Count./Region Code")
            {
            }
            column(reasonCode; "Reason Code")
            {
            }
            // column(recalculateInvoiceDisc; "Recalculate Invoice Disc.")
            // {
            // }
            column(receiptNo; "Receipt No")
            {
            }
            column(receive; Receive)
            {
            }
            column(registrationNumber; "Registration Number")
            {
            }
            column(requestedDeliveryDate; "Requested Delivery Date")
            {
            }
            column(reserve; Reserve)
            {
            }
            column(responsibilityCenter; "Responsibility Center")
            {
            }
            column(returnReceiptNo; "Return Receipt No.")
            {
            }
            column(returnReceiptNoSeries; "Return Receipt No. Series")
            {
            }
            column(reversedBy; "Reversed By")
            {
            }
            column(reversedOnDate; "Reversed On Date")
            {
            }
            column(salespersonCode; "Salesperson Code")
            {
            }
            column(searchName; "Search Name")
            {
            }
            column(sellToAddress; "Sell-to Address")
            {
            }
            column(sellToAddress2; "Sell-to Address 2")
            {
            }
            column(sellToCity; "Sell-to City")
            {
            }
            column(sellToContact; "Sell-to Contact")
            {
            }
            column(sellToContactNo; "Sell-to Contact No.")
            {
            }
            column(sellToCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(sellToCounty; "Sell-to County")
            {
            }
            column(sellToCustomerName; "Sell-to Customer Name")
            {
            }
            column(sellToCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(sellToCustomerNo; "Sell-to Customer No.")
            {
            }
            column(sellToCustomerTemplCode; "Sell-to Customer Templ. Code")
            {
            }
            column(sellToEMail; "Sell-to E-Mail")
            {
            }
            column(sellToICPartnerCode; "Sell-to IC Partner Code")
            {
            }
            column(sellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(sellToPostCode; "Sell-to Post Code")
            {
            }
            column(sendICDocument; "Send IC Document")
            {
            }
            column(ship; Ship)
            {
            }
            column(shipToAddress; "Ship-to Address")
            {
            }
            column(shipToAddress2; "Ship-to Address 2")
            {
            }
            column(shipToCity; "Ship-to City")
            {
            }
            column(shipToCode; "Ship-to Code")
            {
            }
            column(shipToContact; "Ship-to Contact")
            {
            }
            column(shipToCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(shipToCounty; "Ship-to County")
            {
            }
            column(shipToName; "Ship-to Name")
            {
            }
            column(shipToName2; "Ship-to Name 2")
            {
            }
            column(shipToPhoneNo; "Ship-to Phone No.")
            {
            }
            column(shipToPostCode; "Ship-to Post Code")
            {
            }
            column(shipmentDate; "Shipment Date")
            {
            }
            column(shipmentMethodCode; "Shipment Method Code")
            {
            }
            // column(shipped; Shipped)
            // {
            // }
            // column(shippedNotInvoiced; "Shipped Not Invoiced")
            // {
            // }
            column(shippingAdvice; "Shipping Advice")
            {
            }
            column(shippingAgentCode; "Shipping Agent Code")
            {
            }
            column(shippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(shippingNo; "Shipping No.")
            {
            }
            column(shippingNoSeries; "Shipping No. Series")
            {
            }
            column(shippingTime; "Shipping Time")
            {
            }
            column(shortcutDimension1Code; "Shortcut Dimension 1 Code")
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
            column(status; Status)
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
            column(taxAreaCode; "Tax Area Code")
            {
            }
            column(taxLiable; "Tax Liable")
            {
            }
            column(transactionSpecification; "Transaction Specification")
            {
            }
            column("transactionType"; "Transaction Type")
            {
            }
            column(transportMethod; "Transport Method")
            {
            }
            column(treatmentNo; "Treatment No")
            {
            }
            column(vatBaseDiscount; "VAT Base Discount %")
            {
            }
            column(vatBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(vatCountryRegionCode; "VAT Country/Region Code")
            {
            }
            column(vatRegistrationNo; "VAT Registration No.")
            {
            }
            column(vatReportingDate; "VAT Reporting Date")
            {
            }
            column(workDescription; "Work Description")
            {
            }
            column(yourReference; "Your Reference")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
