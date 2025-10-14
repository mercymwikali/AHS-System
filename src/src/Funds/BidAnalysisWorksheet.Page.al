Page 52203052 "Bid Analysis Worksheet"
{
    DeleteAllowed = false;
    PageType = Worksheet;
    SourceTable = "Bid Analysis";
    ApplicationArea = Basic, Suite;
    //SourceTableView = sorting("RFQ No.", "Item No.", Amount);

    layout
    {
        area(content)
        {
            group(Control1102755012)
            {
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Vendor Code Filter';
                    ToolTip = 'Specifies the value of the Vendor Code Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendList: Page "Vendor List";
                    begin
                        begin
                            VendList.LookupMode := true;
                            if VendList.RunModal() = Action::LookupOK then
                                Text := VendList.GetSelectionFilter()
                            else
                                exit(false);
                        end;

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate();
                    end;
                }
                field(ItemNoFilter; ItemNoFilter)
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List.";
                    begin
                        ItemList.LookupMode := true;
                        if ItemList.RunModal() = Action::LookupOK then
                            Text := ItemList.GetSelectionFilter()
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate();
                    end;
                }
                field(RFQNoFilter; RFQNoFilter)
                {
                    ToolTip = 'Specifies the value of the RFQNoFilter field.';
                }
                field(Total; Rec.Total)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total field.';
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(RFQNo; Rec."RFQ No.")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the RFQ No. field.';
                }
                field(RFQLineNo; Rec."RFQ Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the RFQ Line No. field.';
                }
                field(QuoteNo; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the value of the Quote No. field.';
                }
                field(VendorNo; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Vendor Name';
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(ItemNo; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UnitOfMeasure; Rec."Unit Of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(LineAmount; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Action1102755014)
            {
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Get Vendor Quotations action.';

                trigger OnAction()
                begin
                    GetVendorQuotes();
                end;
            }
            action("Bid Report")
            {
                Caption = 'Print';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print action.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("RFQ No.", Rec."RFQ No.");
                    Report.Run(70135526, true, true, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Vendor.Get(Rec."Vendor No.");
        VendorName := Vendor.Name;
        CalcTotals();
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        Vendor: Record Vendor;
        InsertCount: Integer;
        VendorName: Text;
        ItemNoFilter: Text[250];
        RFQNoFilter: Text[250];
        SalesCodeFilter: Text[250];

    procedure SetRecFilters()
    begin
        if SalesCodeFilter <> '' then
            Rec.SetFilter("Vendor No.", SalesCodeFilter)
        else
            Rec.SetRange("Vendor No.");

        if ItemNoFilter <> '' then
            Rec.SetFilter("Item No.", ItemNoFilter)
        else
            Rec.SetRange("Item No.");

        CalcTotals();

        CurrPage.Update(false);
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord();
        SetRecFilters();
    end;

    procedure GetVendorQuotes()
    begin
        //insert the quotes from vendors
        if RFQNoFilter = '' then
            Error('Specify the RFQ No.');

        PurchHeader.SetRange(PurchHeader."No.", RFQNoFilter);
        PurchHeader.FindSet();
        repeat
            PurchLines.Reset();
            PurchLines.SetRange("Document No.", PurchHeader."No.");
            if PurchLines.FindSet() then
                repeat
                    Rec.Init();
                    Rec."RFQ No." := PurchHeader."No.";
                    Rec."RFQ Line No." := PurchLines."Line No.";
                    Rec."Quote No." := PurchLines."Document No.";
                    Rec."Vendor No." := PurchLines."Buy-from Vendor No.";
                    Rec."Item No." := PurchLines."No.";
                    Rec.Description := PurchLines.Description;
                    Rec.Quantity := PurchLines.Quantity;
                    Rec."Unit Of Measure" := PurchLines."Unit of Measure";
                    Rec.Amount := PurchLines."Direct Unit Cost";
                    Rec."Line Amount" := Rec.Quantity * Rec.Amount;
                    Rec.Insert(true);
                    InsertCount := +1;
                until PurchLines.Next() = 0;
        until PurchHeader.Next() = 0;
        Message('%1 records have been inserted to the bid analysis');
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord();
        SetRecFilters();
    end;

    procedure CalcTotals()
    var
        BidAnalysisRec: Record "Bid Analysis";
    begin
        BidAnalysisRec.SetRange("RFQ No.", Rec."RFQ No.");
        if SalesCodeFilter <> '' then
            BidAnalysisRec.SetRange("Vendor No.", SalesCodeFilter);
        if ItemNoFilter <> '' then
            BidAnalysisRec.SetRange("Item No.", ItemNoFilter);
        BidAnalysisRec.FindSet();
        BidAnalysisRec.CalcSums("Line Amount");
        Rec.Total := BidAnalysisRec."Line Amount";
    end;
}
