namespace HMISBC.HMISBC;

query 85010 HMSPharmacyList
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HMSPharmacyList';
    EntitySetName = 'HMSPharmacyList';
    QueryType = API;
    
    elements
    {
        dataitem(hmsPharmacyHeader; "HMS Pharmacy Header")
        {
            column(admNo; "ADM No")
            {
            }
            column(age; Age)
            {
            }
            column(billToCustomerNo; "Bill To Customer No.")
            {
            }
            column(branch; Branch)
            {
            }
            column(capitationAmount; "Capitation Amount")
            {
            }
            column(cashSale; "Cash Sale")
            {
            }
            column(charged; Charged)
            {
            }
            column(correspondenceAddress1; "Correspondence Address 1")
            {
            }
            column(doctorID; "Doctor ID")
            {
            }
            column(doctorName; "Doctor Name")
            {
            }
            column(email; Email)
            {
            }
            column(employeeNo; "Employee No.")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(idNumber; "ID Number")
            {
            }
            column(inPatient; InPatient)
            {
            }
            column(insuranceAmount; "Insurance Amount")
            {
            }
            column(insuranceNo; "Insurance No")
            {
            }
            column(insuranceNo1; "Insurance No1")
            {
            }
            column(insuranceCode; "Insurance code")
            {
            }
            column(issuedBy; "Issued By")
            {
            }
            column(issuingLocation; "Issuing Location")
            {
            }
            column(lastName; "Last Name")
            {
            }
            column(linkNo; "Link No.")
            {
            }
            column(linkType; "Link Type")
            {
            }
            column(membershipNo; "Membership No")
            {
            }
            column(middleName; "Middle Name")
            {
            }
            column(noSeries; "No. Series")
            {
            }
            column(patientNo; "Patient No.")
            {
            }
            column(patientRefNo; "Patient Ref. No.")
            {
            }
            column(patientType; "Patient Type")
            {
            }
            column(pharmacyDate; "Pharmacy Date")
            {
            }
            column(pharmacyNo; "Pharmacy No.")
            {
            }
            column(pharmacyTime; "Pharmacy Time")
            {
            }
            column(pharmacyType; "Pharmacy Type")
            {
            }
            column(receiptCount; "Receipt Count")
            {
            }
            column(receptionist; Receptionist)
            {
            }
            column(refNo; "Ref No")
            {
            }
            column(relativeNo; "Relative No.")
            {
            }
            column(remarks; Remarks)
            {
            }
            column(requestArea; "Request Area")
            {
            }
            column(searchName; "Search Name")
            {
            }
            column(status; Status)
            {
            }
            column(studentNo; "Student No.")
            {
            }
            column(surname; Surname)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(telephoneNo1; "Telephone No. 1")
            {
            }
            column(totalPrice; "Total Price")
            {
            }
            column(totalReceipts; "Total Receipts")
            {
            }
            column("transactionType"; "Transaction Type")
            {
            }
            column(treatmentNo; "Treatment No.")
            {
            }
            column(userId; "User Id")
            {
            }
            column(visitTotal; "Visit Total")
            {
            }
            column(walkin; Walkin)
            {
            }
            column(pharmCountWalkinCash; "pharm count Walkin Cash")
            {
            }
            column(pharmCountWalkinNormal; "pharm count Walkin Normal")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
