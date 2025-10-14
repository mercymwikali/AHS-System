namespace PTL.HMIS;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 52202706 "Pharmacy Stock Movement"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Stock Movement ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/StockMovement.rdl';
    dataset
    {
        dataitem("HMS Pharmacy Line"; "HMS Pharmacy Line")
        {

            RequestFilterFields = "No.", Date;
            column(No_HMSPharmacyLine; "No.")
            {
            }
            column(PatientNo_HMSPharmacyLine; "Patient No")
            {
            }
            column(PharmacyNo_HMSPharmacyLine; "Pharmacy No.")
            {
            }
            column(Date_HMSPharmacyLine; "Date")
            {
            }
            column(IssueDate_HMSPharmacyLine; "Issue Date")
            {
            }
            column(DrugName_HMSPharmacyLine; "Drug Name")
            {
            }
            column(Insurancecode_HMSPharmacyLine; "Insurance code")
            {
            }
            column(IssuedPrice_HMSPharmacyLine; "Issued Price")
            {
            }
            column(IssuedQuantity_HMSPharmacyLine; "Issued Quantity")
            {
            }
            column(Names_HMSPharmacyLine; Names)
            {
            }
            column(SaleType_HMSPharmacyLine; "Sale Type")
            {
            }
            column(UnitPrice_HMSPharmacyLine; "Unit Price")
            {
            }
            column(Total_Price; "Total Price") { }

            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_picture; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_city; CompanyInformation.City) { }
            column(CompanyInformation_postCode; CompanyInformation."Post Code") { }
            column(CompanyInformation_phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_email; CompanyInformation."E-Mail") { }
            column(InsuranceName; InsuranceName) { }
            column(IssuedBy; IssuedBy) { }

            trigger OnAfterGetRecord()
            begin
                InsuranceName := '';
                IssuedBy := '';
                Customer.Reset();
                Customer.SetRange("No.", "HMS Pharmacy Line"."Insurance code");
                if Customer.FindFirst() then
                    InsuranceName := Customer.Name;

                HMSPharmacyHeader.Reset();
                HMSPharmacyHeader.SetRange("Pharmacy No.", "HMS Pharmacy Line"."Pharmacy No.");
                if HMSPharmacyHeader.FindFirst() then
                    IssuedBy := HMSPharmacyHeader."Issued By";
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
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemList: Record Item;
        StartDate: Date;
        EndDate: Date;
        InsuranceName: Text;
        IssuedBy: Text;
        Customer: Record Customer;
        HMSPharmacyHeader: Record "HMS Pharmacy Header";
}
