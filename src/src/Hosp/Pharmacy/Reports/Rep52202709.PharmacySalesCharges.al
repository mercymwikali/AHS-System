namespace PTL.Hospital;
using Microsoft.Inventory.Item;

report 52202709 "Pharmacy Posted Charges"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Sales Charges';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Pharmacy/PharmacyPostedCharges.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = sorting(Date) where(Posted = filter(true), "Transaction Type" = filter('Pharmacy'));
            RequestFilterFields = Code, "Patient No.", Date, "Shortcut Dimension 3 Code";
            RequestFilterHeading = 'Enter Filter Details';
            column(VisitNo; "Visit No")
            {
            }

            column(PatientNo; "Patient No.")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Code; "Code")
            {
            }
            column(ShortcutDimension3Code_HMSPatientCharges; "Shortcut Dimension 3 Code")
            {
            }

            column(PatientType_HMSPatientCharges; "Patient Type")
            {
            }
            column(ChargeType_HMSPatientCharges; "Charge Type")
            {
            }

            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Date; "Date")
            {
            }
            column(PharmacyNo; "Pharmacy No")
            {
            }
            column(Location; Location)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
            column(CostPrice; CostPrice) { }
            column(TotalCost; TotalCost) { }
            trigger OnAfterGetRecord()
            begin
                CostPrice := 0;
                TotalCost := 0;
                Item.Reset();
                item.SetRange("No.", HMSPatientCharges.Code);
                if Item.FindFirst() then begin
                    CostPrice := item."Unit Cost";
                    TotalCost := HMSPatientCharges.Quantity * CostPrice;

                    if HMSPatientCharges.Amount < 0 then
                        TotalCost := TotalCost * -1;
                end;
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
        Item: Record Item;
        CostPrice: Decimal;
        TotalCost: Decimal;
}
