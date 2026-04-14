Page 85376 "HMS Patient ClosedCharges List"
{
    Editable = false;
    PageType = List;
    SourceTable = "HMS Patient Charges";
    SourceTableView = where(Posted = filter(true));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(VisitNo; Rec."Visit No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field(AppointmentNo; Rec."Appointment No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(BillSection; Rec."Bill Section")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bill Section field.';
                }
                field(BillingType; Rec."Billing Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Billing Type field.';
                }
                field(ReccuringType; Rec."Reccuring Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reccuring Type field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(InsuranceNo; Rec."Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(DoctorsAmount; Rec."Doctors Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctors Amount field.';
                }
                field(InsuranceAmount; Rec."Insurance Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Amount field.';
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the G/L Account No field.';
                }
                field("Posting Document No"; Rec."Posting Document No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posting Document No field.';
                }
                field("Posted Invoice No."; Rec."Posted Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Invoice No. field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(BillingStartDate; Rec."Billing Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Billing Start Date field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(BillingEndDate; Rec."Billing End Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Billing End Date field.';
                }
                field(WeiverAmount; Rec."Weiver Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Weiver Amount field.';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt posted field.', Comment = '%';
                }
                field("Receipt posted"; Rec."Receipt posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt posted field.', Comment = '%';
                }
                field("Receipt Reversed"; Rec."Receipt Reversed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Reversed field.', Comment = '%';
                }
                field("Claim Receipt No"; Rec."Claim Receipt No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Receipt No field.', Comment = '%';
                }
                field("Total Receipts"; Rec."Total Receipts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Receipts field.', Comment = '%';
                }

                field(WeiverReason; Rec."Weiver Reason")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Weiver Reason field.';
                }
                field(InvoiceID; Rec."Invoice ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoice ID field.';
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(LinkNo; Rec."Link No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Link No field.';
                }
                field(DoctorRate; Rec."Doctor Rate")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Rate field.';
                }
                field(InvoiceNumber; Rec."Invoice Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(PostedInvoiceNo; Rec."Posted Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Invoice No. field.';
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field("Visit Amount"; Rec."Visit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit Amount field.';
                }
                field("Visit Balance"; Rec."Visit Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit Balance field.';
                }
                field("Invoice Entry No"; Rec."Invoice Entry No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice Entry No field.';
                }
                field("Insurance Paid Amount"; Rec."Insurance Paid Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Paid Amount field.';
                }
                field("Invoice ID"; Rec."Invoice ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice ID field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Raise Weiver Request")
            {
                ApplicationArea = Basic, Suite;
                Image = SendApprovalRequest;
                ToolTip = 'Executes the Raise Weiver Request action.';

                trigger OnAction()
                begin
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
                    HMSChargeWeiver."Patient No" := Rec."Patient No.";
                    HMSChargeWeiver.Code := Rec.Code;
                    HMSChargeWeiver.Description := Rec.Description;
                    HMSChargeWeiver.Amount := Rec."Weiver Amount";
                    HMSChargeWeiver."Initial Amount" := Rec.Amount;
                    HMSChargeWeiver.Remarks := Rec."Weiver Reason";
                    HMSChargeWeiver.Insert();
                    Rec."Weiver Code" := NewNo;
                    Message('Done');
                end;
            }
            separator(Action22)
            {
            }
            action("View Raised Weiver Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Patient Charges Weiver";
                ToolTip = 'Executes the View Raised Weiver Request action.';
            }
            separator(Action3)
            {
            }
            action("Refresh Insurance Amount")
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                ToolTip = 'Executes the Refresh Insurance Amount action.';

                trigger OnAction()
                begin
                    HMSCharges.Reset();
                    HMSCharges.SetRange(HMSCharges."Patient No.", Rec."Patient No.");
                    HMSCharges.SetRange(HMSCharges.Posted, false);
                    if HMSCharges.Find('-') then
                        repeat
                            HMSCharges.Validate(Amount);
                            HMSCharges.Modify();
                        until HMSCharges.Next() = 0;
                end;
            }
            action("Reopen Posted Charges")
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                ToolTip = 'Executes the Reopen Posted Charges action.';

                trigger OnAction()
                begin
                    HMSCharges.Reset();
                    HMSCharges.SetRange(HMSCharges."Patient No.", Rec."Patient No.");
                    HMSCharges.SetRange(HMSCharges."Visit No", Rec."Visit No");
                    HMSCharges.SetRange(HMSCharges.Posted, true);
                    if HMSCharges.Find('-') then
                        repeat
                            // TODO: Implement Correct reopening of charges to check for exists in GL charges.
                            HMSCharges.Posted := false;
                            HMSCharges.Closed := false;
                            HMSCharges.Modify();
                        until HMSCharges.Next() = 0;
                end;
            }
            separator(Action37)
            {
            }
            action("Post Drugs Returns")
            {
                ApplicationArea = Basic, Suite;
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
            action("Re-Open Doctor Invoice")
            {
                ApplicationArea = Basic, Suite;
                Image = Return;
                ToolTip = 'Executes the Re-Open Doctor Invoice action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to Re-Open Doctor Invoice?', false) then begin
                        Rec."Doctors Posting No" := '';
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        HMSCharges: Record "HMS Patient Charges";
        HMSChargeWeiver: Record "HMS Patient Charges Weiver";
        HMSSetup: Record "HMS Setup";
        Itm: Record Item;
        NoSeriesMgt: Codeunit NoSeriesManagement;
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
        ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Positive Adjmt.";
        ItemJnlLine."Document No." := Rec."Patient No." + ':' + Rec."Link No";
        ItemJnlLine."Item No." := Rec.Code;
        ItemJnlLine.Validate(ItemJnlLine."Item No.");
        // ItemJnlLine."Location Code":=AdmissionLine."Location Code";
        ItemJnlLine.Validate(ItemJnlLine."Location Code");
        ItemJnlLine.Quantity := Rec.Quantity;
        ItemJnlLine.Validate(ItemJnlLine.Quantity);
        //  ItemJnlLine."Unit of Measure Code":=AdmissionLine."Unit Of Measure";
        ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
        ItemJnlLine."Unit Amount" := Rec.Amount;
        ItemJnlLine."Shortcut Dimension 1 Code" := 'PHARMACY';
        ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
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
}
