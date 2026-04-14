page 85060 "Purchase Quote Request Header"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Purchase Quote Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Expected Opening Date field.';
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Expected Closing Date field.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Quote No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Control1102756027; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
            part(SF; "Purchase Quote Request Line")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Set Specification")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Set Specification';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Set Specification action.';
                    trigger OnAction()
                    begin
                        PParams.Reset();
                        PParams.SetRange(PParams."Document Type", Rec."Document Type");
                        PParams.SetRange(PParams."Document No.", Rec."No.");
                        PParams.SetRange(PParams."Line No.", CurrPage.SF.PAGE.getLineNo());
                        PAGE.Run(70134866, PParams);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Assign Vendor(s)")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assign Vendor(s)';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Assign Vendor(s) action.';
                trigger OnAction()
                var
                    Vends: Record "Quotation Request Vendors";
                begin
                    Vends.Reset();
                    Vends.SetRange(Vends."Document Type", Rec."Document Type");
                    Vends.SetRange(Vends."Requisition Document No.", Rec."No.");

                    PAGE.Run(70135391, Vends);
                end;
            }
            separator(Separator1102756039)
            {
            }
            group(Status)
            {
                Caption = 'Status';
                action(Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    ToolTip = 'Executes the Cancel action.';
                    trigger OnAction()
                    begin
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Cancel Document?', false) = false then
                            exit;
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                    end;
                }
                action(Stop)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stop';
                    ToolTip = 'Executes the Stop action.';

                    trigger OnAction()
                    begin
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?', false) = false then
                            exit;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Close';
                    ToolTip = 'Executes the Close action.';

                    trigger OnAction()
                    begin
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?', false) = false then
                            exit;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Release action.';
                    trigger OnAction()
                    begin
                        if Confirm('Release document?', false) = false then
                            exit;
                        //check if the document has any lines
                        Lines.Reset();
                        Lines.SetRange(Lines."Document Type", Rec."Document Type");
                        Lines.SetRange(Lines."Document No.", Rec."No.");
                        if Lines.FindFirst() then
                            repeat
                                Lines.TestField(Lines.Quantity);
                                //Lines.TESTFIELD(Lines."Direct Unit Cost");
                                Lines.TestField("No.");
                            until Lines.Next() = 0
                        else
                            Error('Document has no lines');

                        Purchaselines.Reset();
                        Purchaselines.SetRange(Purchaselines."RFQ No.", Rec."No.");

                        if Purchaselines.Find('-') then
                            repeat
                                Purchaselines."RFQ Created" := true;
                                Purchaselines.Modify();
                            until Purchaselines.Next() = 0;

                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Reopen action.';
                    trigger OnAction()
                    begin
                        //check if the quotation for request number has already been used
                        PurchHeader.Reset();
                        PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                        PurchHeader.SetRange(PurchHeader."Procurement Request No.", Rec."No.");
                        if PurchHeader.FindFirst() then
                            Error('The Quotation for request is already tied to a Quotation. Cannot be Reopened');

                        if Confirm('Reopen Document?', false) = false then
                            exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }
                action("&Print/Preview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print/Preview';
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the &Print/Preview action.';
                    trigger OnAction()
                    begin
                        PQH.SetRecFilter();
                        PQH.SetFilter(PQH."Document Type", '%1', Rec."Document Type");
                        PQH.SetFilter("No.", Rec."No.");
                        repVend.SetTableView(PQH);
                        repVend.Run();
                    end;
                }
                action("Get Purchase Requisition Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Get Purchase Requisition Lines';
                    Promoted = true;
                    PromotedCategory = Report;
                    RunObject = Page "PRF Lines";
                    ToolTip = 'Executes the Get Purchase Requisition Lines action.';

                    trigger OnAction()
                    begin
                        Clear(GETLINES);
                        RFQ := Rec."No.";
                        GETLINES.GetRFQ(RFQ);
                        GETLINES.RunModal();
                    end;
                }
                separator(Separator1)
                {
                }
                action("Bid Analysis")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Worksheet2;
                    Promoted = true;
                    PromotedCategory = Report;
                    RunObject = Page "Bid Analysis";
                    RunPageLink = "RFQ No." = FIELD("No.");
                    ToolTip = 'Executes the Bid Analysis action.';
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Status = Rec.Status::Released then
            Error('The RFQ has already been released you cannot delete records');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
    end;

    var
        PurchHeader: Record "Purchase Header";
        Purchaselines: Record "Purchase Line";
        PQH: Record "Purchase Quote Header";
        Lines: Record "Purchase Quote Line";
        PParams: Record "Purchase Quote Params";
        repVend: Report "Purchase Quote Request Report2";
        GETLINES: Page "PRF Lines";
        RFQ: Code[10];
}
