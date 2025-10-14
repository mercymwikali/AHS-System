pageextension 52202434 "Purchasing RoleCenter ext" extends "Purchasing Manager Role Center"
{
    layout
    {
        // addafter
    }

    actions
    {
        addafter(Items)
        {
            action(Item)
            {
                ApplicationArea = all;
                Caption = 'Items';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item List.";
                ToolTip = 'Executes the Items action.';
            }
        }
        modify(Items)
        {
            Visible = false;
        }
        modify(Orders)
        {
            Visible = false;
        }
        modify(vendors)
        {
            Visible = false;
        }
        modify(Quotes)
        {
            Visible = false;
        }
        modify("Credit Memos")
        {
            Visible = false;
        }
        addafter(Orders)
        {
            action(orders4)
            {
                ApplicationArea = all;
                Caption = 'Purchase Orders';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Order List.";
                ToolTip = 'Executes the Purchase Orders action.';
            }
            action(pQuote)
            {
                ApplicationArea = all;
                Caption = 'Purchase Quotes';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Quotes.";
                ToolTip = 'Executes the Purchase Quotes action.';
            }
            action(pCMemos)
            {
                ApplicationArea = all;
                Caption = 'Credit Memos';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memos.";
                ToolTip = 'Executes the Credit Memos action.';
            }
        }
        addafter("Posted Purchase Invoices")
        {
            action(PostedPurchInv)
            {
                ApplicationArea = all;
                Caption = 'Posted Purchase Invoice';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Purchase Invoices.";
                ToolTip = 'Executes the Posted Purchase Invoice action.';
            }
        }
        addafter(Vendors)
        {
            action(Vend)
            {
                ApplicationArea = all;
                Caption = 'Vendors';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor List.";
                ToolTip = 'Executes the Vendors action.';
            }

            action("Purchase Requisition")
            {
                ApplicationArea = all;
                Caption = 'Purchase Requisition';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Requisition";
                ToolTip = 'Executes the Purchase Requisition action.';
            }
            action("Approved Purchase Requisition")
            {
                ApplicationArea = all;
                Caption = 'Approved Purchase Requisition';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Requisition-Approved";
                ToolTip = 'Executes the Approved Purchase Requisition action.';
            }
            action("Request for Quote")
            {
                ApplicationArea = all;
                Caption = 'Request for Quote';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Quote List";
                ToolTip = 'Executes the Request for Quote action.';
            }
        }
        addafter("Credit Memos")
        {
            action("Procurement Plan")
            {
                ApplicationArea = all;
                Caption = 'Procurement Plan';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Procurement Plan list";
                ToolTip = 'Executes the Procurement Plan action.';
            }
        }
        addafter(Items)
        {
            action("Store Requisition")
            {
                ApplicationArea = all;
                Caption = 'Store Requisition';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Store Requisition";
                ToolTip = 'Executes the Store Requisition action.';
            }
        }
        addafter("Posted Purchase Receipts")
        {
            action("Posted Store Requisition")
            {
                ApplicationArea = all;
                Caption = 'Posted Store Requisition';
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Page "Posted Store Requisitions";
                ToolTip = 'Executes the Posted Store Requisition action.';
            }
        }
        addafter("Inventory Purchase Orders")
        {
            action("Consolidated Procurement Plan")
            {
                ApplicationArea = all;
                Caption = 'Consolidated Procurement Plan';
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report "Consolidated Procurement Plan";
                ToolTip = 'Executes the Consolidated Procurement Plan action.';
            }
        }
    }
}