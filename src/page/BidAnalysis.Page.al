page 85057 "Bid Analysis"
{
    PageType = Document;
    SourceTable = "Bid Analysis";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("RFQ No."; Rec."RFQ No.")
                {
                    ToolTip = 'Specifies the value of the RFQ No. field.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                    begin
                        ItemList.LookupMode := true;
                        if ItemList.RunModal() = ACTION::LookupOK then
                            Text := ItemList.GetSelectionFilter()
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        //ItemNoFilterOnAfterValidate;
                    end;
                }
            }
            part(Control1102755004; "Bid Analysis SubForm")
            {
                SubPageLink = "RFQ No." = FIELD("RFQ No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Vendor Quotations")
            {
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Get Vendor Quotations action.';

                trigger OnAction()
                begin
                    InsertBidAnalysisLines();
                end;
            }
            separator(Separator1)
            {
            }
            action(Worksheet)
            {
                Image = Worksheet;
                RunObject = Page "Bid Analysis Worksheet";
                RunPageLink = "RFQ No." = FIELD("RFQ No.");
                ToolTip = 'Executes the Worksheet action.';
            }
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        InsertCount: Integer;

    procedure InsertBidAnalysisLines()
    var
        BidAnalysisLines: Record "Bid Analysis";
        Ln: Integer;
    begin

        //insert the quotes from vendors
        //IF RFQNoFilter = '' THEN ERROR('Specify the RFQ No.');
        BidAnalysisLines.reset();
        BidAnalysisLines.setrange(BidAnalysisLines."RFQ No.", Rec."RFQ No.");
        if BidAnalysisLines.find('-') then
            BidAnalysisLines.DeleteAll();

        PurchHeader.reset();
        PurchHeader.SetRange(PurchHeader."RFQ No.", Rec."RFQ No.");
        PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
        PurchHeader.SetRange(PurchHeader.Status, PurchHeader.Status::Released);
        if PurchHeader.Find('-') then
            repeat
                PurchLines.Reset();
                PurchLines.SetRange("Document No.", PurchHeader."No.");
                if PurchLines.Find('-') then
                    repeat
                        Ln := Ln + 1;
                        BidAnalysisLines.Init();
                        BidAnalysisLines."RFQ No." := PurchHeader."RFQ No.";
                        BidAnalysisLines."RFQ Line No." := Ln;
                        BidAnalysisLines."Quote No." := PurchLines."Document No.";
                        BidAnalysisLines."Vendor No." := PurchLines."Buy-from Vendor No.";
                        BidAnalysisLines."Item No." := PurchLines."No.";
                        BidAnalysisLines.Description := PurchLines.Description;
                        BidAnalysisLines.Quantity := PurchLines.Quantity;
                        BidAnalysisLines."Unit Of Measure" := PurchLines."Unit of Measure";
                        BidAnalysisLines.Amount := PurchLines."Direct Unit Cost";
                        BidAnalysisLines."Line Amount" := BidAnalysisLines.Quantity * BidAnalysisLines.Amount;
                        BidAnalysisLines.Insert(true);
                        InsertCount := +1;
                    until PurchLines.Next() = 0;
            until PurchHeader.Next() = 0;
    end;
}
