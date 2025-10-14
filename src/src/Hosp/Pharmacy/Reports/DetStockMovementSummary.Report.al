namespace PTL.HMISBC;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Company;

report 52202707 "Det. Stock Movement Summary"
{
    ApplicationArea = All;
    Caption = 'Detailed Stock Movement Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/DetailedStockSummary.rdl';
    Description = 'This report Should be filtered using one Item.';

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Posting Date", "Location Code", "Global Dimension 2 Code", "Item Category Code","Lot No.";
            column(ItemNo_ItemLedgerEntry; "Item No.")
            {
            }
            column(ItemCategoryCode_ItemLedgerEntry; "Item Category Code")
            {
            }
            column(Description_ItemLedgerEntry; Description)
            {
            }
            column(PatientName_ItemLedgerEntry; "Patient Name")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Source No.")
            {
            }
            column(SourceType_ItemLedgerEntry; "Source Type")// TODO: Extend Analysis Source type to include Patient
            {
            }
            column(Quantity_ItemLedgerEntry; Quantity)
            {
            }
            column(PostingDate_ItemLedgerEntry; "Posting Date")
            {
            }
            column(ExpirationDate_ItemLedgerEntry; "Expiration Date")
            {
            }
            column(LotNo_ItemLedgerEntry; "Lot No.")
            {
            }
            column(EntryType_ItemLedgerEntry; "Entry Type")
            {
            }
            column(TransactionType_ItemLedgerEntry; "Transaction Type")
            {
            }


            column(OpeningBal; OpeningBal) { }
            column(StockIn; StockIn) { }
            column(StockOut; StockOut) { }
            column(ClosingBal; ClosingBal) { }
            column(RunningBalance; RunningBalance) { }
            column(Location_Code; "Location Code") { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }


            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_picture; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_city; CompanyInformation.City) { }
            column(CompanyInformation_postCode; CompanyInformation."Post Code") { }
            column(CompanyInformation_phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_email; CompanyInformation."E-Mail") { }

            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
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
        StartDate: Date;
        EndDate: Date;
        StockIn: Decimal;
        StockOut: Decimal;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        RunningBalance: Decimal;
}
