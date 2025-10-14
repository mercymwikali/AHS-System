namespace PTL.HMISBC;

report 52202708 "Pharmacy Sales Breakdown"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Sales Breakdown';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/PharmSalesBreakdown.rdl';
    dataset
    {
        dataitem(HMSPharmacyLine; "HMS Pharmacy Line")
        {
            column(PharmacyNo; "Pharmacy No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Quantity; Quantity)
            {
            }

            column(IssuedPrice; "Issued Price")
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(UnitPrice_HMSPharmacyLine; "Unit Price")
            {
            }

            column(DrugName; "Drug Name")
            {
            }
            column(Date; "Date")
            {
            }
            column(IssuedCost;IssuedCost)
            {

            }
            column(ProfitMargin;ProfitMargin){}

            trigger OnAfterGetRecord()
            begin
                ProfitMargin := 0;
                IssuedCost := 0;

                IssuedCost := HMSPharmacyLine."Unit Cost" * HMSPharmacyLine."Issued Quantity";

                ProfitMargin := HMSPharmacyLine."Issued Price" - IssuedCost;
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
    ProfitMargin: Decimal;
    IssuedCost: Decimal;
}
