namespace PTL.HMIS;

query 52202618 QyPharmacyLines
{
    Caption = 'QyPharmacyLines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSPharmacyLine; "HMS Pharmacy Line")
        {
            column(PharmacyNo; "Pharmacy No.")
            {
            }
            column(No; "No.")
            {
            }
            column(DrugName; "Drug Name")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(MeasuringUnit; "Measuring Unit")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(ActualQty; "Actual Qty")
            {
            }
            column(ActualPrice; "Actual Price")
            {
            }
            column(IssuedQuantity; "Issued Quantity")
            {
            }
            column(IssuedUnits; "Issued Units")
            {
            }
            column(IssuedPrice; "Issued Price")
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Pharmacy; Pharmacy)
            {
            }
            column(Remaining; Remaining)
            {
            }
            column("Date"; "Date")
            {
            }
            column(LinkingNo; "Linking No.")
            {
            }
            column(LinkType; "Link Type")
            {
            }
            column(DrugsCategory; "Drugs Category")
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(Invoiced; Invoiced)
            {
            }
            column(Paid; Paid)
            {
            }
            column(InvoiceCounter; "Invoice Counter")
            {
            }
            column(LinkCode; "Link Code")
            {
            }
            column(LinkTypeLK; "Link Type LK")
            {
            }
            column(PostedDocNo; "Posted Doc No")
            {
            }
            column(Location; Location)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Take; Take)
            {
            }
            column(Route; Route)
            {
            }
            column(Frequency; Frequency)
            {
            }
            column(InsuranceNo1; "Insurance No1")
            {
            }
            column(SaleType; "Sale Type")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Insurancecode; "Insurance code")
            {
            }
            column(Branch; Branch)
            {
            }
            column(CapitationAmount; "Capitation Amount")
            {
            }
            column(MinimumPrice; "Minimum Price")
            {
            }
            column(MaximumPrice; "Maximum Price")
            {
            }
            column(NumberofDays; "Number of Days")
            {
            }
            column(ReturnsQuantity; "Returns Quantity")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(lineno; "line no")
            {
            }
            column(TotalPrice; "Total Price")
            {
            }
            column(Status; Status)
            {
            }
            column(IssueDate; "Issue Date")
            {
            }
            column(Names; Names)
            {
            }
            column(InsuranceAmount; "Insurance Amount")
            {
            }
            column(InsuranceTotalAmount; "Insurance Total Amount")
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(PrescriptionDose; "Prescription Dose")
            {
            }
            column(ItemJournal; "Item Journal")
            {
            }
            column(GlobalDimension1; "Global Dimension Code 1")
            {
            }
            column(Description2; Description2)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
