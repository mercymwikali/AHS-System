report 52202522 "HMS Pharmacy Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/HMS Pharmacy Sales.rdl';

    dataset
    {
        dataitem("HMS Pharmacy Line"; "HMS Pharmacy Line")
        {
            RequestFilterFields = Date, Branch;
            column(No_HMSPharmacyLine; "HMS Pharmacy Line"."No.")
            {
            }
            column(Date_HMSPharmacyLine; "HMS Pharmacy Line".Date)
            {
            }
            column(DrugName_HMSPharmacyLine; "HMS Pharmacy Line"."Drug Name")
            {
            }
            column(IssuedQuantity_HMSPharmacyLine; "HMS Pharmacy Line".Quantity)
            {
            }
            column(IssuedUnits_HMSPharmacyLine; "HMS Pharmacy Line"."Measuring Unit")
            {
            }
            column(IssuedPrice_HMSPharmacyLine; "HMS Pharmacy Line"."Unit Price")
            {
                DecimalPlaces = 2 : 2;
            }
            column(decUnitCost; decUnitCost)
            {
            }
            column(totPrice; "HMS Pharmacy Line".Quantity * "HMS Pharmacy Line"."Unit Price")
            {
            }
            column(Logo; Logo.Picture)
            {
            }
            column(tocost; "HMS Pharmacy Line".Quantity * decUnitCost)
            {
            }
            column(InsuranceAmount_HMSPharmacyLine; "HMS Pharmacy Line"."Insurance Amount")
            {
                DecimalPlaces = 2 : 2;
            }
            column(tprice; "HMS Pharmacy Line".Quantity * "HMS Pharmacy Line"."Insurance Amount")
            {
                DecimalPlaces = 2 : 2;
            }
            column(IssueDate_HMSPharmacyLine; "HMS Pharmacy Line".GETFILTER("HMS Pharmacy Line".Date))
            {
            }

            trigger OnAfterGetRecord()
            begin
                decUnitCost := 0;

                IF Item.GET("No.") THEN
                    decUnitCost := Item."Unit Cost";
            end;
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

    trigger OnPreReport()
    begin
        Logo.get();
        Logo.CALCFIELDS(Picture);
    end;

    var
        Logo: Record "Company Information";
        Item: Record "Item";
        decUnitCost: Decimal;
}
