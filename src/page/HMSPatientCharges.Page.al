page 85374 "HMS Patient Charges"
{
    PageType = List;
    SourceTable = "HMS Patient Charges";
    SourceTableView = sorting("Patient No.", "Transaction Type", Date)
                      order(ascending);
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(VisitNo; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.';

                    trigger OnValidate()
                    begin
                        HmAPP.SetRange(HmAPP."Appointment No.", Rec."Visit No");
                        if HmAPP.Find('-') then
                            Rec."Insurance No" := HmAPP."Insurance No";
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    DrillDownPageId = "HMS Transaction List";
                    LookupPageId = "HMS Transaction List";
                    TableRelation = "HMS Transactions code" where("Disable Manual Billing" = const(false));
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';

                    trigger OnValidate()
                    begin
                        if duplcateExists() = true then
                            if Confirm('You have already charged this item today do you want to proceed') = false then begin
                                Rec.Code := '';
                                Error('Cancelled by User');
                            end;
                        if Rec.Code = 'CONSULTATION FEES' then
                            CurrPage.Editable(true);
                    end;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(BillSection; Rec."Bill Section")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bill Section field.';
                }
                field(BillingType; Rec."Billing Type")
                {
                    ToolTip = 'Specifies the value of the Billing Type field.';
                }
                field(ReccuringType; Rec."Reccuring Type")
                {
                    ToolTip = 'Specifies the value of the Reccuring Type field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(InsuranceNo; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ToolTip = 'Specifies the value of the G/L Account No field.';
                }
                field(DoctorsAmount; Rec."Doctors Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctors Amount field.';
                }
                field(InsuranceAmount; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.';
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Insurance Paid Amount"; Rec."Insurance Paid Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Paid Amount field.';
                }
                field("Invoice Entry No"; Rec."Invoice Entry No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoice Entry No field.';
                }
                field(InvoiceID; Rec."Invoice ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoice ID field.';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field(LinkNo; Rec."Link No")
                {
                    ToolTip = 'Specifies the value of the Link No field.';
                }
                field(Branch; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(Department; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field("Corporate Excluded"; Rec."Corporate Excluded")
                {
                    ToolTip = 'Specifies the value of the Corporate Excluded field.';
                }
                field(DoctorRate; Rec."Doctor Rate")
                {
                    ToolTip = 'Specifies the value of the Doctor Rate field.';
                }
                field(InvoiceNumber; Rec."Invoice Number")
                {
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field(PostedInvoiceNo; Rec."Posted Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Posted Invoice No. field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(OwnDebtor; Rec."Own Debtor")
                {
                    ToolTip = 'Specifies the value of the Own Debtor field.';
                }
                field(Claimed; Rec.Claimed)
                {
                    ToolTip = 'Specifies the value of the Claimed field.';
                }
                field(UserId; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(InsurancePaidAmount; Rec."Insurance Paid Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Paid Amount field.';
                }
                field("System Created"; Rec."System Created")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the System Created field.';
                }
                field(SystemId; SystemId)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            Action("Post Open Charges")
            {
                Image = Post;
                ToolTip = 'Executes the Post Open Charges action.';

                trigger OnAction()
                begin
                    HMSPatCU.CalculateTotalCharges(Rec."Patient No.");
                    HMSCharges.Reset();
                    HMSCharges.SetRange(HMSCharges."Patient No.", Rec."Patient No.");
                    // HMSCharges.SetFilter(HMSCharges."Visit No", "Visit No");
                    HMSCharges.SetRange(HMSCharges.Posted, false);
                    if HMSCharges.Find('-') then
                        repeat
                            HMSPatCU.PostCharges(HMSCharges."Patient No.", HMSCharges."Visit No", HMSCharges."Own Debtor");
                            if HMSCharges."Transaction Type" = 'ZDISCOUNT' then
                                HMSPatCU.PostChargesDiscount(HMSCharges."Patient No.", HMSCharges."Visit No", HMSCharges.Amount);
                        until HMSCharges.Next() = 0;
                    Message('Charges Posted succesfuly');
                end;
            }
            separator(Action47)
            {
            }
            Action("Raise Weiver Request")
            {
                Image = SendApprovalRequest;
                ToolTip = 'Executes the Raise Weiver Request action.';

                trigger OnAction()
                begin

                    if (Rec.Posted = true) and (Rec.Reversed = false) then
                        Error('Please note that posted charges must be reversed before posting weiver');

                    if Rec."Weiver Code" <> '' then begin
                        HMSChargeWeiver.Reset();
                        HMSChargeWeiver.SetRange(HMSChargeWeiver.No, Rec."Weiver Code");
                        if HMSChargeWeiver.Find('-') then
                            HMSChargeWeiver.DeleteAll();
                    end;

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Charges Weiver Nos", 0D, true);
                    HMSChargeWeiver.Init();
                    HMSChargeWeiver.No := NewNo;
                    HMSChargeWeiver.Date := today;
                    HMSChargeWeiver."Patient No" := Rec."Patient No.";
                    HMSChargeWeiver.Code := Rec.Code;
                    HMSChargeWeiver.Description := Rec.Description;
                    HMSChargeWeiver.Amount := Rec."Total Amount";
                    HMSChargeWeiver."Initial Amount" := Rec."Total Amount";
                    HMSChargeWeiver.Remarks := Rec."Weiver Reason";
                    HMSChargeWeiver."Visit No" := Rec."Visit No";
                    HMSChargeWeiver.Type := HMSChargeWeiver.Type::Weiver;
                    HMSChargeWeiver."User ID" := Database.UserId();
                    HMSChargeWeiver.Insert();
                    Rec."Weiver Code" := NewNo;
                    Message('Weiver Raised Successfully');
                end;
            }
            Action("Raise Discount Request")
            {
                Image = SendApprovalRequest;
                ToolTip = 'Executes the Raise Discount Request action.';

                trigger OnAction()
                begin

                    if (Rec.Posted = true) and (Rec.Reversed = false) then
                        Error('Please note that posted charges must be reversed before posting weiver');
                    if Rec."Weiver Code" <> '' then begin
                        HMSChargeWeiver.Reset();
                        HMSChargeWeiver.SetRange(HMSChargeWeiver.No, Rec."Weiver Code");
                        if HMSChargeWeiver.Find('-') then
                            HMSChargeWeiver.DeleteAll();
                    end;

                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Charges Weiver Nos", 0D, true);
                    HMSChargeWeiver.Init();
                    HMSChargeWeiver.Type := HMSChargeWeiver.Type::Discount;
                    HMSChargeWeiver.No := NewNo;
                    HMSChargeWeiver.Date := today;
                    HMSChargeWeiver."Patient No" := Rec."Patient No.";
                    HMSChargeWeiver.Code := Rec.Code;
                    HMSChargeWeiver.Description := Rec.Description;
                    HMSChargeWeiver.Amount := Rec."Total Amount";
                    HMSChargeWeiver."Initial Amount" := Rec."Total Amount";
                    HMSChargeWeiver.Remarks := Rec."Weiver Reason";
                    HMSChargeWeiver."Visit No" := Rec."Visit No";
                    HMSChargeWeiver."Line No" := Rec."Line No";
                    HMSChargeWeiver."User ID" := Database.UserId();
                    HMSChargeWeiver.Insert();

                    Rec."Weiver Code" := NewNo;
                    Message('Discount Raised Successfully');
                end;
            }
            separator(Action22)
            {
            }
            Action("View Raised Weiver Request")
            {
                RunObject = Page "HMS Patient Charges Weiver";
                RunPageLink = "Patient No" = field("Patient No."), "Visit No" = field("Visit No");
                ToolTip = 'Executes the View Raised Weiver Request action.';
            }
            Action("View Raised Discount Request")
            {
                RunObject = Page "HMS Patient Charges Discount";
                ToolTip = 'Executes the View Raised Discount Request action.';
            }
            separator(Action3)
            {
            }
            Action("Refresh Insurance Amount")
            {
                Image = Refresh;
                ToolTip = 'Executes the Refresh Insurance Amount action.';

                trigger OnAction()
                begin
                    HmsPAT.Get(Rec."Patient No.");
                    HMSCharges.Reset();
                    HMSCharges.SetRange(HMSCharges."Patient No.", Rec."Patient No.");
                    HMSCharges.SetRange(HMSCharges."Visit No", HmsPAT."Active Visit No");
                    if HMSCharges.Find('-') then
                        repeat
                            HMSCharges."Insurance No" := HmsPAT."Insurance No.";
                            HMSCharges.Validate(Amount);
                            HMSCharges.Modify();
                        until HMSCharges.Next() = 0;
                end;
            }

            separator(Action37)
            {
            }
            Action("Post Drugs Returns")
            {
                Image = Return;
                ToolTip = 'Executes the Post Drugs Returns action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to post Item return?', false) then
                        if Itm.Get(Rec.Code) then begin
                            PostDrugsReturn();
                            Rec.Closed := true;
                            Rec.Modify();
                        end;
                end;
            }
            separator(Action18)
            {
            }
            Action("Post Reversal")
            {
                Promoted = true;
                ToolTip = 'Executes the Post Reversal action.';

                trigger OnAction()
                begin

                    HMSCharges.Reset();
                    HMSCharges.SetRange(HMSCharges."Patient No.", Rec."Patient No.");
                    HMSCharges.SetRange(HMSCharges."Visit No", Rec."Visit No");
                    HMSCharges.SetRange(HMSCharges.Posted, true);
                    if HMSCharges.Find('-') then begin
                        PostCu.Post_Reverse_Charge(HMSCharges."Posting Document No", Rec."Patient No.");
                        HMSCharges."Posting Document No" := '';
                        HMSCharges.Posted := false;
                        HMSCharges.Closed := false;
                        HMSCharges.Modify();
                    end;
                    Message('Charge Reversed successfully');
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User ID" := UserId();
        Rec."Creation Time" := Time;
        Rec."Creation Date" := Today;
    end;

    var
        HmAPP: Record "HMS Appointment Form Header";
        HmsPAT: Record "HMS Patient";
        HMSCharges: Record "HMS Patient Charges";
        prevCharge: Record "HMS Patient Charges";
        HMSChargeWeiver: Record "HMS Patient Charges Weiver";
        HMSSetup: Record "HMS Setup";
        Itm: Record Item;
        HMSPatCU: Codeunit "HMS Patient-integration";
        PostCu: Codeunit "HMS Patient-integration";
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];

    procedure PostDrugsReturn()
    var
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
    begin

        HMSSetup.Reset();
        HMSSetup.Get();
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then
            ItemJnlLine.DeleteAll();

        LineNo := LineNo + 1;
        ItemJnlLine.Init();
        ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
        ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine."Posting Date" := Today;
        ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Negative Adjmt.";
        ItemJnlLine."Document No." := Rec."Patient No." + ':' + Rec."Link No";
        ItemJnlLine."Item No." := Rec.Code;
        ItemJnlLine.Validate(ItemJnlLine."Item No.");
        ItemJnlLine."Location Code" := Rec."Location Code";
        ItemJnlLine.Validate(ItemJnlLine."Location Code");
        ItemJnlLine.Quantity := Rec.Quantity;
        ItemJnlLine.Validate(ItemJnlLine.Quantity);
        //  ItemJnlLine."Unit of Measure Code":=AdmissionLine."Unit Of Measure";
        ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
        ItemJnlLine."Unit Amount" := Rec.Amount;
        ItemJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
        ItemJnlLine.Validate("Shortcut Dimension 1 Code");
        ItemJnlLine.Validate("Shortcut Dimension 2 Code");
        ItemJnlLine.Insert();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then
            Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
    end;

    local procedure duplcateExists() Exissts: Boolean
    begin
        Exissts := false;

        prevCharge.Reset();
        prevCharge.SetRange(prevCharge.Code, Rec.Code);
        prevCharge.SetRange(prevCharge.Date, Rec.Date);
        prevCharge.SetRange(prevCharge."Patient No.", Rec."Patient No.");
        if prevCharge.Find('-') then
            Exissts := true;
        //IF CONFIRM('You had already charges this patient,'+Code+' Are you sure you want to proceed') = FALSE THEN ERROR('Cancelled by user')
    end;
}
