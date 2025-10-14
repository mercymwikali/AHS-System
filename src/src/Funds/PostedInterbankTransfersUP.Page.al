page 52202988 "Posted Interbank Transfers UP"
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "InterBank Transfers";
    SourceTableView = WHERE(Posted = CONST(true));
    UsageCategory = History;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Control1102758030; '')
                {
                    CaptionClass = Text19025618;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Receiving Transfer Type"; Rec."Receiving Transfer Type")
                {
                    ToolTip = 'Specifies the value of the Receiving Transfer Type field.';
                }
                field("Reciept Responsibility Center"; Rec."Reciept Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Reciept Responsibility Center field.';
                }
                field(Control1102758029; '')
                {
                    CaptionClass = Text19044997;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Receipt Resp Centre"; Rec."Receipt Resp Centre")
                {
                    ToolTip = 'Specifies the value of the Receipt Resp Centre field.';
                }
                field("Receiving Account"; Rec."Receiving Account")
                {
                    ToolTip = 'Specifies the value of the Receiving Account field.';

                    trigger OnValidate()
                    begin
                        ReceivingAccountOnAfterValidat();
                    end;
                }
                field("Receiving Bank Account Name"; Rec."Receiving Bank Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receiving Bank Account Name field.';
                }
                field("Currency Code Destination"; Rec."Currency Code Destination")
                {
                    ToolTip = 'Specifies the value of the Currency Code Destination field.';
                }
                field("Amount 2"; Rec."Amount 2")
                {
                    ToolTip = 'Specifies the value of the Amount 2 field.';
                }
                field("Request Amt LCY"; Rec."Request Amt LCY")
                {
                    ToolTip = 'Specifies the value of the Request Amt LCY field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Source Transfer Type"; Rec."Source Transfer Type")
                {
                    ToolTip = 'Specifies the value of the Source Transfer Type field.';
                }
                field("Sending Responsibility Center"; Rec."Sending Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Sending Responsibility Center field.';
                }
                field("Sending Resp Centre"; Rec."Sending Resp Centre")
                {
                    ToolTip = 'Specifies the value of the Sending Resp Centre field.';
                }
                field("Paying Account"; Rec."Paying Account")
                {
                    ToolTip = 'Specifies the value of the Paying Account field.';

                    trigger OnValidate()
                    begin
                        PayingAccountOnAfterValidate();
                    end;
                }
                field("Paying  Bank Account Name"; Rec."Paying  Bank Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Paying  Bank Account Name field.';
                }
                field("Currency Code Source"; Rec."Currency Code Source")
                {
                    ToolTip = 'Specifies the value of the Currency Code Source field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Pay Amt LCY"; Rec."Pay Amt LCY")
                {
                    ToolTip = 'Specifies the value of the Pay Amt LCY field.';
                }
                field("Exch. Rate Destination"; Rec."Exch. Rate Destination")
                {
                    Visible = "Exch. Rate DestinationVisible";
                    ToolTip = 'Specifies the value of the Exch. Rate Destination field.';
                }
                field("Exch. Rate Source"; Rec."Exch. Rate Source")
                {
                    Visible = "Exch. Rate SourceVisible";
                    ToolTip = 'Specifies the value of the Exch. Rate Source field.';
                }
                group("Transfer Lines")
                {
                    part(Control9; "Interbank Transfer Lines")
                    {
                        SubPageLink = "No." = FIELD(No);
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Post")
            {
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the &Post action.';

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Approved);

                    //Check whether the two LCY amounts are same
                    if Rec."Request Amt LCY" <> Rec."Pay Amt LCY" then
                        Error('The [Requested Amount in LCY] should be same as the [Paid Amount in LCY]');
                    //get the source account balance from the database table
                    BankAcc.Reset();
                    BankAcc.SetRange(BankAcc."No.", Rec."Paying Account");
                    BankAcc.SetRange(BankAcc."Bank Type", BankAcc."Bank Type"::Cash);

                    if BankAcc.FindFirst() then begin
                        BankAcc.CalcFields(BankAcc."Balance (LCY)");
                        Rec."Current Source A/C Bal." := BankAcc."Balance (LCY)";
                        if (Rec."Current Source A/C Bal." - Rec.Amount) < 0 then
                            Error('The transaction will result in a negative balance in a CASH ACCOUNT.');
                    end;
                    if Rec.Amount = 0 then
                        Error('Please ensure Amount to Transfer is entered');
                    /*Check if the user's batch has any records within it*/
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", Rec."Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec."Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll();

                    LineNo := 1000;
                    /*Insert the new lines to be updated*/
                    GenJnlLine.Init();
                    /*Insert the lines*/
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                    GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                    GenJnlLine."Posting Date" := Rec.Date;
                    GenJnlLine."Document No." := Rec.No;
                    if Rec."Receiving Transfer Type" = Rec."Receiving Transfer Type"::"Intra-Company" then
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
                    else
                        if Rec."Receiving Transfer Type" = Rec."Receiving Transfer Type"::"Inter-Company" then
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"IC Partner";
                    GenJnlLine."Account No." := Rec."Receiving Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec.No);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Receiving Depot Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Receiving Department Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code1");
                    GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code1");

                    GenJnlLine.Description := Rec.Remarks;
                    if Rec.Remarks = '' then
                        GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec.No);
                    GenJnlLine."Currency Code" := Rec."Currency Code Destination";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    if Rec."Currency Code Destination" <> '' then begin
                        GenJnlLine."Currency Factor" := Rec."Reciprical 2";
                        GenJnlLine.Validate(GenJnlLine."Currency Factor");
                    end;
                    GenJnlLine.Amount := Rec."Amount 2";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine.Insert();

                    GenJnlLine.Init();
                    /*Insert the lines*/
                    GenJnlLine."Line No." := LineNo + 1;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                    GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                    GenJnlLine."Posting Date" := Rec.Date;
                    GenJnlLine."Document No." := Rec.No;
                    if Rec."Source Transfer Type" = Rec."Source Transfer Type"::"Intra-Company" then
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
                    else
                        if Rec."Source Transfer Type" = Rec."Source Transfer Type"::"Inter-Company" then
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"IC Partner";

                    GenJnlLine."Account No." := Rec."Paying Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Source Department Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                    GenJnlLine.Description := Rec.Remarks;
                    if Rec.Remarks = '' then
                        GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec.No);
                    GenJnlLine."Currency Code" := Rec."Currency Code Source";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    if Rec."Currency Code Source" <> '' then begin
                        GenJnlLine."Currency Factor" := Rec."Reciprical 1";
                        GenJnlLine.Validate(GenJnlLine."Currency Factor");
                    end;
                    GenJnlLine.Amount := -Rec.Amount;
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine.Insert();
                    Post := false;
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                    Post := JournalPostedSuccessfully.PostedSuccessfully(Rec.No);

                    if Post then begin
                        Rec.Posted := true;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        Message('The Journal Has Been Posted Successfully');
                    end;
                end;
            }

            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Visible = false;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                var
                    DocumentType: Option Interbank;
                begin
                    DocumentType := DocumentType::Interbank;
                    ApprovalEntries.SetRecordFilters(DATABASE::"InterBank Transfers", DocumentType, Rec.No);
                    ApprovalEntries.Run();
                end;
            }
            separator(Separator1102756004)
            {
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(70135460, true, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Date := Today;
        Rec."Inter Bank Template Name" := JTemplate;
        Rec."Inter Bank Journal Batch" := JBatch;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Reciept Responsibility Center" := UserMgt.GetPurchasesFilter();
        //VALIDATE( "Reciept Responsibility Center");
        Rec.Status := Rec.Status::Pending;
        Rec."Created By" := UserId;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Reciept Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;

        TempBatch.Reset();

        TempBatch.SetRange(TempBatch.UserID, UserId);
        if TempBatch.Find('-') then begin
            JTemplate := TempBatch."Inter Bank Template Name";
            JBatch := TempBatch."Inter Bank Batch Name";
        end;

        /*Check if the user has the batches selected*/
        if (JTemplate = '') or (JBatch = '') then
            Error('Please ensure you are setup as an interbank transfer user');

        /*
       IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
         FILTERGROUP(2);
         SETRANGE("Reciept Responsibility Center" ,UserMgt.GetPurchasesFilter());
         FILTERGROUP(0);
       END;
          //Reciept Responsibility Center
          */
    end;

    var
        BankAcc: Record "Bank Account";
        TempBatch: Record "Cash Office User Template";
        GenJnlLine: Record "Gen. Journal Line";
        JournalPostedSuccessfully: Codeunit "Journal Post Successful";
        UserMgt: Codeunit "User Setup Management BR";
        ApprovalEntries: Page "Approval Entries";
        [InDataSet]
        "Exch. Rate DestinationVisible": Boolean;
        [InDataSet]
        "Exch. Rate SourceVisible": Boolean;
        Post: Boolean;
        JBatch: Code[20];
        JTemplate: Code[20];
        LineNo: Integer;
        Text19025618: Label 'Requesting Details';
        Text19044997: Label 'Source Details';

    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset();
        GLSetup.Get();

        DimVal.Reset();
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code")
        else
            if DimNo = 2 then
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
        if DimVal.Find('-') then
            Name := DimVal.Name;
    end;

    procedure UpdateControl()
    begin
    end;

    local procedure ReceivingAccountOnAfterValidat()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate DestinationVisible" := false;
        if Rec."Currency Code Destination" <> '' then
            "Exch. Rate DestinationVisible" := true;
    end;

    local procedure PayingAccountOnAfterValidate()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate SourceVisible" := false;
        if Rec."Currency Code Source" <> '' then
            "Exch. Rate SourceVisible" := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if Rec."Currency Code Source" <> '' then
            "Exch. Rate SourceVisible" := true
        else
            "Exch. Rate SourceVisible" := false;

        if Rec."Currency Code Destination" <> '' then
            "Exch. Rate DestinationVisible" := true
        else
            "Exch. Rate DestinationVisible" := false;

        UpdateControl();
    end;
}
