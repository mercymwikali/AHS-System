pageextension 85000 "Apply Customer Entries" extends "Apply Customer Entries"
{
    actions
    {
        addafter("Set Applies-to ID")
        {
            action("Insurance XML File")
            {
                ApplicationArea = Basic, Suite;
                Image = XMLFile;
                Promoted = true;
                ToolTip = 'Executes the Insurance XML File action.';
                //RunObject = Xmlport."Import Insurance Receipts.";
                trigger OnAction()
                begin
                    XMLPORT.Run(Xmlport::"Insurance Payments", true, false);
                end;
            }
            action("Import Insurance Payments")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                ToolTip = 'Executes the Import Insurance Payments action.';
                trigger OnAction()
                var
                    InsurancePayment: Record "Insurance Receipts Payments";
                begin
                    Rec.TestField("Customer No.");

                    InsurancePayment.Init();
                    InsurancePayment."Customer No" := Rec."Customer No.";

                    InsurancePayment.Insert();

                    InsurancePayment.Reset();
                    InsurancePayment.SetFilter(InsurancePayment."Customer No", Rec."Customer No.");

                    if InsurancePayment.Find('-') then
                        XMLPORT.Run(Xmlport::"Insurance Payments", false, true, InsurancePayment);
                end;
            }
            action("Config Package")
            {
                ApplicationArea = all;
                Image = UpdateXML;
                Promoted = true;
                RunObject = Page "Config. Package Card";
                RunPageLink = Code = filter('INSURANCE INVOICE');
                ToolTip = 'Executes the Config Package action.';
            }
            action("Update Mass Insurance Application")
            {
                ApplicationArea = Basic, Suite;
                Image = PostBatch;
                Promoted = true;
                ToolTip = 'Executes the Update Mass Insurance Application action.';

                trigger OnAction()
                var
                    ApplyingCustLedgEntry: Record "Cust. Ledger Entry";
                    InsurancePayment: Record "Insurance Receipts Payments";
                    CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
                    i: Integer;
                begin
                    i := 0;
                    InsurancePayment.Reset();
                    InsurancePayment.SetRange(InsurancePayment."Customer No", Rec."Customer No.");
                    InsurancePayment.SetRange(Applied, false);
                    if InsurancePayment.Find('-') then
                        repeat
                            ApplyingCustLedgEntry.Reset();
                            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry."Customer No.", Rec."Customer No.");
                            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry."Document No.", InsurancePayment."Invoice No");
                            ApplyingCustLedgEntry.SetRange(ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document Type"::Invoice);
                            if ApplyingCustLedgEntry.Find('-') then begin
                                // ApplyingCustLedgEntry."Applies-to ID" := InsurancePayment."Receipt No";
                                // ApplyingCustLedgEntry.Validate("Applies-to ID");
                                // ApplyingCustLedgEntry.Modify();
                                CustEntrySetApplID.SetApplId(ApplyingCustLedgEntry, Rec, Rec."Document No.");
                                CalcApplnAmount();

                                // if (CalcType = CalcType::"Gen. Jnl. Line") and (ApplnType = ApplnType::"Applies-to Doc. No.") then
                                //     Error(CannotSetAppliesToIDErr);
                                // "Applies-to ID" := InsurancePayment."Invoice No";
                                // SetCustApplId(true);
                                /*                             SetApplyingCustLedgEntry();
                                                            SetApplyToFilters(InsurancePayment."Customer No", 2, InsurancePayment."Invoice No", InsurancePayment."Amount Payed");
                                                            SetAppliesToID(InsurancePayment."Invoice No");
                                                            SetAmountToApply(InsurancePayment."Invoice No", InsurancePayment."Customer No");
                                                            */

                                InsurancePayment.Applied := true;
                                InsurancePayment."Receipt No" := Rec."Document No.";
                                InsurancePayment."Posted By" := Rec."User ID";
                                InsurancePayment."Date Posted" := Today;
                                InsurancePayment."Time Posted" := Time;
                                InsurancePayment.Modify();
                                i := i + 1;
                            end;
                        until InsurancePayment.Next() = 0;
                    Message(Format(i) + ' Invoices applied successfully;')
                end;
            }
        }
    }
}
