namespace PTL.Hospital;

report 52202716 "Dispatch Summary Report"
{
    ApplicationArea = All;
    Caption = 'Dispatch Summary Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(InvoiceDispatchHeaderd; "Invoice Dispatch Headerd")
        {
            column(BatchAmount; "Batch Amount")
            {
            }
            column(BranchCode; "Branch Code")
            {
            }
            column(CustomerNo; "Customer No")
            {
            }
            column(Date; "Date")
            {
            }
            column(DateTo; "Date To")
            {
            }
            column(Description; Description)
            {
            }
            column(InvoiceCounter; "Invoice Counter")
            {
            }
            column(No; No)
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(UserID; "User ID")
            {
            }
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
}
