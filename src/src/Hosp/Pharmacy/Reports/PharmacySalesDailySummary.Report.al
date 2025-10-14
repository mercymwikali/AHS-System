namespace PTL.HMISBC;

report 52202703 "Pharmacy Sales Daily Summary"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Sales Daily Summary';
    UsageCategory = ReportsAndAnalysis;
    Defaultlayout = RDLC;
    Rdlclayout = './Layouts/Pharmacy/SalesDailySummary.rdl';
    dataset
    {
        dataitem(HMSPharmacyHeader; "HMS Pharmacy Header")
        {
            RequestFilterFields = "Transaction Type", "Issuing Location", "Pharmacy Date";
            // CalcFields = InPatient;
            DataItemTableView = where(Status = filter('Completed'));
            column(PharmacyNo_HMSPharmacyHeader; "Pharmacy No.")
            {
            }
            column(PharmacyDate_HMSPharmacyHeader; "Pharmacy Date")
            {
            }
            column(PharmacyType_HMSPharmacyHeader; "Pharmacy Type")
            {
            }
            column(SearchName_HMSPharmacyHeader; "Search Name")
            {
            }
            column(PatientNo_HMSPharmacyHeader; "Patient No.")
            {
            }
            column(InPatient_HMSPharmacyHeader; InPatient)
            {
            }
            dataitem(HMSPharmacyLine; "HMS Pharmacy Line")
            {
                dataitemlink = "Pharmacy No." = field("Pharmacy No.");
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
                column(Date; "Date")
                {
                }
                column(PatientNo; "Patient No")
                {
                }
                column(Branch; Branch)
                {
                }
                column(IssueDate; "Issue Date")
                {
                }
                column(IssuedPrice_HMSPharmacyLine; "Issued Price")
                {
                }
                column(IssuedQuantity_HMSPharmacyLine; "Issued Quantity")
                {
                }
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
