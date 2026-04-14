namespace PTL.HMISBC;

using Microsoft.Sales.Customer;

page 85043 "Daily Clinical Report Ins."
{
    ApplicationArea = All;
    Caption = 'Customer Daily Report';
    PageType = ListPart;
    SourceTable = Customer;
    SourceTableView = where("In Daily Clinical Report" = filter(true));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer.';
                }
                field("Day IP Count"; Rec."Day IP Count")
                {
                    ToolTip = 'Specifies the value of the Day IP Count field.', Comment = '%';
                }
                field("Day OP Count"; Rec."Day OP Count")
                {
                    ToolTip = 'Specifies the value of the Day OP Count field.', Comment = '%';
                }                
            }
        }
    }
    trigger OnOpenPage()
    begin        
        Rec.SetFilter("Date Filter", '%1..', WorkDate());
        Rec.SetFilter("IP Date Filter", '..%1', WorkDate());
        Rec.SetFilter("Discharge Date Filter", '0D|%1..', WorkDate());
    end;
}
