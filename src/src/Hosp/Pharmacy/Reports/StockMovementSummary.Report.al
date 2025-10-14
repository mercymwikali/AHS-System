namespace PTL.HMISBC;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Company;

report 52202730 "Stock Movement Summary"
{
    ApplicationArea = All;
    Caption = 'Stock Movement Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/StockMovementSummary.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Location Filter";
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(BaseUnitofMeasure; "Base Unit of Measure")
            {
            }
            column(InventoryPostingGroup; "Inventory Posting Group")
            {
            }
            column(ReorderPoint; "Reorder Point")
            {
            }
            column(ReorderQuantity; "Reorder Quantity")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(LocationFilter; LocationFilter)
            {

            }
            column(OpeningBal; OpeningBal) { }
            column(StockIn; StockIn) { }
            column(StockOut; StockOut) { }
            column(ClosingBal; ClosingBal) { }
            column(RunningBalance; RunningBalance) { }
            column(Location_Code; LocationFilter) { }
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

                OpeningBal := 0;
                RunningBalance := 0;

                if StartDate = 0D then StartDate := Today;
                if EndDate = 0D then EndDate := Today;
            end;

            trigger OnAfterGetRecord()
            begin
                StockIn := 0;
                StockOut := 0;
                ClosingBal := 0;

                LocationFilter := GetFilter("Location Filter");


                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", Item."No.");
                ItemLedgerEntry.SetRange("Posting Date", 0D, StartDate);
                if LocationFilter <> '' then
                    ItemLedgerEntry.SetRange("Location Code", LocationFilter);
                if ItemLedgerEntry.Find('-') then begin
                    ItemLedgerEntry.CalcSums(Quantity);
                    OpeningBal := ItemLedgerEntry.Quantity;
                    RunningBalance := ItemLedgerEntry.Quantity;
                end;

                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", Item."No.");
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                if LocationFilter <> '' then
                    ItemLedgerEntry.SetRange("Location Code", LocationFilter);
                if ItemLedgerEntry.Find('-') then begin
                    ItemLedgerEntry.CalcSums(Quantity);
                    if ItemLedgerEntry.Quantity > 0 then
                        StockIn := ItemLedgerEntry.Quantity
                    else
                        StockOut := ItemLedgerEntry.Quantity;
                end;

                ClosingBal := OpeningBal + StockIn + StockOut;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilters)
                {
                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Start Date field.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the End Date field.';

                    }
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
        ItemLedgerEntry: Record "Item Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        StockIn: Decimal;
        StockOut: Decimal;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        RunningBalance: Decimal;
        LocationFilter: Text;
}
