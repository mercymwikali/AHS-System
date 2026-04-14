page 85548 "HMS Insurance Package"
{
    ApplicationArea = All;
    Caption = 'HMS Insurance Package';
    PageType = List;
    SourceTable = "HMS Insuarance Packages";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Charge Item"; Rec."Charge Item")
                {
                    ToolTip = 'Specifies the value of the Charge Item field.';
                }
                field("Charge Name"; Rec."Charge Name")
                {
                    ToolTip = 'Specifies the value of the Charge Name field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Procedure Total"; Rec."Procedure Total")
                {
                    ToolTip = 'Specifies the value of the Procedure Total Amount field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post Open Charges")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ToolTip = 'Executes the Post Open Charges action.';

                trigger OnAction()
                begin
                    HMSSetup.Reset();
                    HMSSetup.Get();

                    ItemJnlLine.Reset();
                    ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
                    ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
                    if ItemJnlLine.Find('-') then
                        ItemJnlLine.DeleteAll();
                    InsurancePackage.Reset();
                    InsurancePackage.SetRange(InsurancePackage."Insurance No", Rec."Insurance No");
                    InsurancePackage.SetRange(InsurancePackage.Type, InsurancePackage.Type::Item);
                    if InsurancePackage.Find('-') then
                        repeat
                            PatCharges.Reset();
                            PatCharges.SetRange(PatCharges."Insurance No", InsurancePackage."Insurance No");
                            PatCharges.SetRange(PatCharges.Posted, true);
                            PatCharges.SetRange(PatCharges.Code, InsurancePackage."Charge Item");
                            PatCharges.SetRange(PatCharges."Package Item", false);
                            PatCharges.SetFilter(PatCharges."Invoice Number", '<>%1', '');
                            if PatCharges.Find('-') then begin
                                repeat
                                    PatRec.get(PatCharges."Patient No.");
                                    if ObjItm.Get(PatCharges.Code) then begin
                                        LineNo := LineNo + 1;
                                        ItemJnlLine.Init();
                                        ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                                        ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                                        ItemJnlLine."Line No." := LineNo;
                                        ItemJnlLine."Posting Date" := PatCharges.Date;
                                        ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::Sale;
                                        ItemJnlLine."Document No." := PatCharges."Visit No" + ':' + PatCharges.Code;
                                        ItemJnlLine."Item No." := PatCharges.Code;
                                        ItemJnlLine.Validate(ItemJnlLine."Item No.");
                                        ItemJnlLine."Gen. Prod. Posting Group" := ObjItm."Gen. Prod. Posting Group";
                                        ItemJnlLine."Location Code" := PatCharges."Shortcut Dimension 1 Code";
                                        ItemJnlLine.Validate(ItemJnlLine."Location Code");
                                        ItemJnlLine.Quantity := PatCharges.Quantity;
                                        ItemJnlLine.Validate(ItemJnlLine.Quantity);
                                        ItemJnlLine."Unit of Measure Code" := ObjItm."Base Unit of Measure";
                                        ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                                        ItemJnlLine."Unit Amount" := PatCharges.Amount;
                                        ItemJnlLine."Shortcut Dimension 1 Code" := PatCharges."Shortcut Dimension 1 Code";
                                        ItemJnlLine."Shortcut Dimension 2 Code" := PatCharges."Shortcut Dimension 2 Code";
                                        // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                                        ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                                        ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                                        ItemJnlLine.Insert();
                                    end;
                                until PatCharges.Next() = 0;
                                ItemJnlLine.Reset();
                                ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
                                ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
                                if ItemJnlLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
                            end;
                        until InsurancePackage.Next() = 0;
                    Message('Posted successfully');
                end;
            }
        }
    }
    var
        InsurancePackage: Record "HMS Insuarance Packages";
        PatRec: Record "HMS Patient";
        PatCharges: Record "HMS Patient Charges";
        // DrugPrescribe: Record "HMS Admission Drug Prescribe";
        // AdmissionLine: Record "HMS Admission Drug Prescribe";
        HMSSetup: Record "HMS Setup";
        ObjItm: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
}
