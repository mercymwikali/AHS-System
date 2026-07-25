page 85395 "HMS Pharmacy Header History"
{
    PageType = Document;
    SourceTable = "HMS Pharmacy Header";
    ApplicationArea = Basic, Suite;
    // SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pharmacy Date field.';
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pharmacy Time field.';
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field("Bill To Customer No."; Rec."Bill To Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bill To Customer No. field.';
                }
                field("Issued By"; Rec."Issued By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued By field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Price"; Rec."Total Price")
                {
                    Caption = 'Pharmacy Cost';
                    ToolTip = 'Specifies the value of the Pharmacy Cost field.';
                }
            }
            part(Control1102760001; "HMS Pharmacy Line History")
            {
                SubPageLink = "Pharmacy No." = FIELD("Pharmacy No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print Drug Prescription")
            {
                Caption = 'Print Drug Prescription';
                Image = Print;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    HMSPharmacyHeader: Record "HMS Pharmacy Header";
                    HMSPatientPresctiption: Report "HMS Patient Prescription";
                begin
                    if Confirm('Do you want to print the prescription') = true then begin
                        HMSPharmacyHeader.Reset();
                        HMSPharmacyHeader.SetRange(HMSPharmacyHeader."Pharmacy No.", Rec."Pharmacy No.");
                        if HMSPharmacyHeader.FindFirst then
                            REPORT.Run(Report::"HMS Patient Prescription", true, false, HMSPharmacyHeader);
                    end;
                end;
            }
        }
    }

    var
        Patient: Record "HMS Patient";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        PatientName: Text[100];

    /* procedure PostItems()
    begin
        if Confirm('Do you wish to post the record?', false) = false then
            exit;
        HMSSetup.Reset();
        HMSSetup.Get();
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then
            ItemJnlLine.DeleteAll();
        LineNo := 1000;
        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", Rec."Pharmacy No.");
        if PharmLine.Find('-') then begin
            repeat
                ItemJnlLine.Init();
                ItemJnlLine."Line No." := LineNo;
                ItemJnlLine."Posting Date" := Today;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Document No." := PharmLine."Pharmacy No." + ':' + PharmLine."No.";
                ItemJnlLine."Item No." := PharmLine."No.";
                ItemJnlLine.Validate(ItemJnlLine."Item No.");
                ItemJnlLine."Location Code" := PharmLine.Pharmacy;
                ItemJnlLine.Validate(ItemJnlLine."Location Code");
                ItemJnlLine.Quantity := PharmLine."Issued Quantity";
                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                ItemJnlLine.Validate(ItemJnlLine."Unit Amount");
                ItemJnlLine.Insert();
                PharmLine.Remaining := PharmLine.Remaining - PharmLine."Issued Units";
                PharmLine.Modify();
                LineNo := LineNo + 1;
            until PharmLine.Next() = 0;
            CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);
        end;
    end;

 */    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;
}
