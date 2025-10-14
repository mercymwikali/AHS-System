namespace PTL.HMISBC;
using Microsoft.Foundation.Company;

report 52202700 "Prescription Label"
{
    ApplicationArea = All;
    Caption = 'Prescription Label';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/PrescriptionLabel.rdl';

    dataset
    {
        dataitem(HMSPharmacyLine; "HMS Pharmacy Line")
        {
            CalcFields = "Global Dimension Code 1";

            column(CompanyInformation_Logo; CompanyInformation.Picture) { }
            column(CompanyInformation; CompanyInformation.Name) { }
            column(CompanyInformation_Address; CompanyInformation.Address) { }
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
            column(Take; Take)
            {
            }
            column(NumberofDays; "Number of Days")
            {
            }
            column(PrescriptionDose; "Prescription Dose")
            {
            }
            column(ActualQty; "Actual Qty")
            {
            }
            column(GlobalDimension1_HMSPharmacyLine; "Global Dimension Code 1")
            {
            }
            column(DisclaimerLbl; DisclaimerLbl) { }

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
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        DisclaimerLbl: Label 'This is a computer generated document and does not require a signature.';
}
