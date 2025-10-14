pageextension 52202450 "Cust. Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Source Code")
        {
            field("ExternalDocument No."; Rec."External Document No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Patient No';
                ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
            }
            field("Patient Name"; Rec."Patient Name")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
            field(NewCust; NewCust)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'New Customer No';
                TableRelation = Customer."No.";
                ToolTip = 'Specifies the value of the New Customer No field.';
            }
            field("Old Customer No."; Rec."Old Customer No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Prev. Customer No';
                ToolTip = 'Specifies the value of the Prev. Customer No field.';
            }
        }
    }

    actions
    {
        addafter(AppliedEntries)
        {
            action(UpdateCust)
            {
                ApplicationArea = Basic, Suite;
                caption = 'Update New Customer';
                ToolTip = 'Executes the Update New Customer action.';
                trigger OnAction()
                var
                    DCust: record "Detailed Cust. Ledg. Entry";
                begin
                    if NewCust = '' then
                        error('Please enter the New Customer No');
                    DCust.reset();
                    dcust.setrange("Customer No.", Rec."Customer No.");
                    Dcust.setrange("Document No.", Rec."Document No.");
                    Dcust.setrange("Cust. Ledger Entry No.", Rec."Entry No.");
                    if DCust.find('-') then
                        repeat
                            Dcust."Customer No." := NewCust;
                            Dcust.modify();
                        until Dcust.next() = 0;

                    Rec."Old Customer No." := Rec."Customer No.";
                    Rec."Customer No." := NewCust;
                    NewCust := '';
                    Rec.Modify();
                    message('Updated Successfully');
                end;
            }
        }
        addafter(UnapplyEntries)
        {
            action(ForceUnapply)
            {
                ApplicationArea = Basic, Suite;
                caption = 'Force Unapply';
                ToolTip = 'Executes the Force Unapply action.';
                trigger OnAction()
                var
                    DCust: record "Detailed Cust. Ledg. Entry";

                begin
                    if confirm('Do you really want to force Unappy the selected entry?', false) then begin
                        DCust.reset();
                        dcust.setrange(DCust."Customer No.", Rec."Customer No.");
                        Dcust.setrange(DCust."Document No.", Rec."Document No.");
                        Dcust.setrange(DCust."Entry Type", DCust."Entry Type"::Application);
                        if DCust.find('-') then
                            repeat
                                DCust.Delete();
                            until Dcust.next() = 0;
                        Rec.Open := true;
                        Rec.modify();
                    end;
                end;
            }
        }
    }

    var
        NewCust: code[20];
}