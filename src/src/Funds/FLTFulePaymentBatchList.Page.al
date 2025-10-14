Page 52202504 "FLT Fule Payment Batch List"
{
    CardPageID = "FLT Fule Payment Batch";
    PageType = List;
    SourceTable = "FLT-Fuel Payment Batch";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(BatchNo; Rec."Batch No")
                {
                    ToolTip = 'Specifies the value of the Batch No field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Createdby; Rec."Created by")
                {
                    ToolTip = 'Specifies the value of the Created by field.';
                }
                field(VendorNo; Rec."Vendor No")
                {
                    ToolTip = 'Specifies the value of the Vendor No field.';
                }
                field(DateClosed; Rec."Date Closed")
                {
                    ToolTip = 'Specifies the value of the Date Closed field.';
                }
                field(ClosedBy; Rec."Closed By")
                {
                    ToolTip = 'Specifies the value of the Closed By field.';
                }
                field(TotalPayable; Rec."Total Payable")
                {
                    ToolTip = 'Specifies the value of the Total Payable field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(VendorName; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(DTo; Rec.DTo)
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ToolTip = 'Specifies the value of the Invoiced field.';
                }
                field(InvoiceNo; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field(InvoicedBy; Rec."Invoiced By")
                {
                    ToolTip = 'Specifies the value of the Invoiced By field.';
                }
            }
        }
    }

    actions
    {
    }
}
