Report 85017 "Consolidated Procurement Plan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ConsolidatedProcurementPlan.rdl';

    dataset
    {
        dataitem("Procurement Plan Lines"; "Procurement Plan Lines")
        {
            column(ReportForNavId_1102755008; 1102755008)
            {
            }
            column(BudgetName; "Procurement Plan Lines"."Budget Name")
            {
            }
            column(Dptmnt; "Procurement Plan Lines".Department)
            {
            }
            column(CampusCode; "Procurement Plan Lines".Campus)
            {
            }
            column(PlanPeriod; "Procurement Plan Lines"."Procurement Plan Period")
            {
            }
            column(No; "Procurement Plan Lines"."Type No")
            {
            }
            column(Description; "Procurement Plan Lines".Description)
            {
            }
            column(Quantity; "Procurement Plan Lines".Quantity)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(Total; TotalQuantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "Procurement Plan Lines".Department);
                if DimVal.Find('-') then
                    DeptName := DimVal.Name;
                CurrReport.CreateTotals("Procurement Plan Lines".Quantity);
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

    var
        DimVal: Record "Dimension Value";
        TotalQuantity: Decimal;
        DeptName: Text[250];
}
