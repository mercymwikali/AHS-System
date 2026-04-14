Report 85162 "Pharmacy Sales"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/PharmacySales.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            CalcFields = "Inventory Posting Group";
            DataItemTableView = where("Transaction Type" = filter('NURSING' | 'PHARMACY'));
            RequestFilterFields = Posted, "Transaction Type", Date, "Shortcut Dimension 1 Code", "Inventory Posting Group";
            column(TransactionType_HMSPatientCharges; "HMS Patient Charges"."Transaction Type")
            {
            }
            column(Code_HMSPatientCharges; "HMS Patient Charges".Code)
            {
            }
            column(Quantity_HMSPatientCharges; "HMS Patient Charges".Quantity)
            {
            }
            column(TotalAmount_HMSPatientCharges; "HMS Patient Charges"."Total Amount")
            {
            }
            column(Description_HMSPatientCharges; "HMS Patient Charges".Description)
            {
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}
