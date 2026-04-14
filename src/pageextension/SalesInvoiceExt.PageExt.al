pageextension 85026 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Patient No."; Rec."Patient No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient No. field.';
            }
            field("Appointment No"; Rec."Appointment No")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Appointment No field.';
            }
            field("NHIF No"; Rec."NHIF No")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Claim No.';
                ToolTip = 'Specifies the value of the Claim No. field.';
            }
            field("Shipping No. Series"; Rec."Shipping No. Series")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Shipping No. Series field.';
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            var
                HMSPat: Record "HMS Patient";
                PatientCharges: Record "HMS Patient Charges";
                SalesInv: Record "Sales Invoice Header";
                SalesLine: Record "Sales Line";
            begin
                SalesLine.reset();
                SalesLine.setrange("Document No.", Rec."No.");
                if SalesLine.find('-') then begin
                    PatientCharges.reset();
                    PatientCharges.setrange("Patient No.", Rec."Patient No.");
                    PatientCharges.setrange("Visit No", Rec."Appointment No");
                    PatientCharges.setrange(Code, SalesLine."Charge Code");
                    // PatientCharges.setrange("Line No", SalesLine."Line No.");
                    if PatientCharges.find('-') then
                        repeat
                            PatientCharges."Invoice Number" := Rec."No.";
                            PatientCharges.Posted := true;
                            PatientCharges.Modify();
                        until PatientCharges.next() = 0;
                    //send data to smartlink

                    // InsertSmartInvoices("Patient No.", "No.");
                end;
                //if (PostSmartInvoice("Patient No.", "No.")) then
                if HMSPat.get(Rec."Patient No.") then begin
                    HMSPat.Activated := false;
                    HMSPat.modify();
                end;
                if SalesInv.Get(Rec."No.") then
                    Page.Run(132, SalesInv);
            end;
        }
        addafter(Preview)
        {
            action("PrintHMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print Invoice action.';
                trigger OnAction()
                var
                    PostedInv: Record "Sales Header";
                begin
                    PostedInv.reset();
                    PostedInv.setfilter("No.", Rec."No.");
                    if PostedInv.find('-') then
                        report.run(52202628, true, true, PostedInv);
                end;
            }
        }
    }
}