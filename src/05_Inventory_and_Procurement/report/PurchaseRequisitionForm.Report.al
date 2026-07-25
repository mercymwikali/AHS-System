Report 85011 "Purchase Requisition Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PurchaseRequisitionForm.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(PRN_No; "Purchase Header"."No.")
            {
            }
            column(Department; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Date; "Purchase Header"."Document Date")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_5; 5)
                {
                }
                column(ItemNo; "Purchase Line"."No.")
                {
                }
                column(Description; "Purchase Line".Description)
                {
                }
                column(UnitofMeasure; "Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity; "Purchase Line".Quantity)
                {
                }
                column(EstimatedUnitCost; "Purchase Line"."Unit Cost")
                {
                }
                column(EstimatedTotalCost; "Purchase Line"."Amt. Rcd. Not Invoiced")
                {
                }
                column(ActualCost; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(TenderQuotationRef; "Purchase Line"."No.")
                {
                }
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
