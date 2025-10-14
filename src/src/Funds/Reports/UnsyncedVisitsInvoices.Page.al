namespace PTL.Hospital;
using Microsoft.Sales.History;
using PTL.HMISBC;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Document;

page 52203218 "Unsynced Visits Invoices"
{
    ApplicationArea = All;
    Caption = 'Unsynced Visits Invoices';
    PageType = List;
    SourceTable = "Visits with Unsynced Charges";
    PromotedActionCategories = 'New,Process,Report,Charges,Sync,Posting';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Visit No"; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.', Comment = '%';
                }
                field("Patient Number"; Rec."Patient Number")
                {
                    ToolTip = 'Specifies the value of the Patient Number field.', Comment = '%';
                    Editable = false;
                }
                field("Posted Invoice Number"; Rec."Posted Invoice Number")
                {
                    ToolTip = 'Specifies the value of the Posted Invoice Number field.', Comment = '%';
                }
                field("Synched with sales Invoice"; Rec."Synched with sales Invoice")
                {
                    ToolTip = 'Specifies the value of the Synched with sales Invoice field.', Comment = '%';
                }
                field("First Invoice number"; Rec."First Invoice number")
                {
                    ToolTip = 'Hope this works';
                    Editable = false;
                }
                field("Missing Charges Amount"; Rec."Missing Charges Amount")
                {
                    ToolTip = 'Specifies the value of the Missing Charges Amount field.', Comment = '%';
                    Editable = false;
                }
                field("No of Charges Missing"; Rec."No of Charges Missing")
                {
                    ToolTip = 'Specifies the value of the No of Charges Missing field.', Comment = '%';
                    Editable = false;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ToolTip = 'Specifies the value of the Settlement Type field.', Comment = '%';
                }

                field("Insurance No"; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.', Comment = '%';
                }
                field("Missing Insurance No"; Rec."Missing Insurance No")
                {
                    ToolTip = 'Specifies the value of the Missing Insurance No field.', Comment = '%';
                }
                field("Amount in Invoice"; Rec."Amount in Invoice")
                {
                    ToolTip = 'Specifies the value of the Amount in Invoice field.', Comment = '%';
                }
                field("Visit Amount"; Rec."Visit Amount")
                {
                    ToolTip = 'Specifies the value of the Visit Amount field.', Comment = '%';
                }
                field("For Review"; Rec."For Review")
                {
                    ToolTip = 'These Items have to be reviewd. Get the submitted invoice number and update accordingly';
                }
                field("Confirmed to Sync"; Rec."Confirmed to Sync")
                {
                    ToolTip = 'These Items can be synched with sales invoice';
                }
                field("Review Comments"; Rec."Review Comments")
                {
                    ToolTip = 'What to review about the encounter';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UpdateList)
            {
                Caption = 'Update List';
                ApplicationArea = All;
                RunObject = report "Update Unsynched Visit tbl";
                Image = Report;
                Promoted = true;
                Visible = false;
                ToolTip = 'Executes the Update List action.';
            }
            action("Patient Charges")
            {
                Image = "report";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = field("Patient Number"), "Visit No" = field("Visit No");
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Patient Charges action.';
            }
            action("Posted Patient Charges")
            {
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = field("Patient Number"), "Visit No" = field("Visit No");
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Posted Patient Charges action.';
            }
            action(SyncINvoice)
            {
                ApplicationArea = All;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category5;
                Caption = 'Sync All Confirmed';
                ToolTip = 'Executes the Sync All Confirmed action.';
                trigger OnAction()
                var
                    UnsynchedRecords: Record "Visits with Unsynced Charges";
                    HMSPatientCharges: Record "HMS Patient Charges";
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    lineNo: Integer;
                    counter: Integer;
                begin
                    counter := 0;

                    // UnsynchedRecords.SetAutoCalcFields("First Invoice number", "Insurance No");
                    UnsynchedRecords.Reset();
                    UnsynchedRecords.SetRange("Confirmed to Sync", true);
                    UnsynchedRecords.SetRange("Synched with sales Invoice", false);
                    if UnsynchedRecords.FindSet() then
                        repeat
                            SalesInvoiceLine.Reset();
                            if SalesInvoiceLine.FindLast() then
                                lineNo := SalesInvoiceLine."Line No.";

                            HMSPatientCharges.Reset();
                            HMSPatientCharges.SetRange("Visit No", Rec."Visit No");
                            HMSPatientCharges.SetRange(Posted, true);
                            HMSPatientCharges.SetFilter(Code, '<>%1', 'REBATES');
                            if HMSPatientCharges.FindSet() then
                                repeat
                                    if HMSPatientCharges."Invoice Number" = '' then begin
                                        HMSPatientCharges."Insurance No" := Rec."Insurance No";
                                        HMSPatientCharges."Invoice Number" := Rec."First Invoice number";

                                        lineNo += 1;
                                        SalesInvoiceLine.Init();
                                        SalesInvoiceLine."Line No." := lineNo;
                                        SalesInvoiceLine."Document No." := Rec."First Invoice number";
                                        SalesInvoiceLine."Sell-to Customer No." := HMSPatientCharges."Insurance No";
                                        SalesInvoiceLine.Type := SalesInvoiceLine.Type::"G/L Account";
                                        SalesInvoiceLine."No." := HMSPatientCharges."G/L Account No";
                                        SalesInvoiceLine."Shipment Date" := HMSPatientCharges.Date;
                                        SalesInvoiceLine.Description := HMSPatientCharges.Description;
                                        SalesInvoiceLine.Quantity := HMSPatientCharges.Quantity;
                                        SalesInvoiceLine."Unit Price" := HMSPatientCharges.Amount;
                                        SalesInvoiceLine.Amount := HMSPatientCharges."Total Amount";
                                        SalesInvoiceLine."Bill-to Customer No." := HMSPatientCharges."Insurance No";
                                        SalesInvoiceLine."Line Amount" := SalesInvoiceLine.Amount;
                                        SalesInvoiceLine."Amount Including VAT" := SalesInvoiceLine.Amount;
                                        SalesInvoiceLine."Tax Liable" := false;
                                        SalesInvoiceLine."Gen. Prod. Posting Group" := 'SERVICES';
                                        SalesInvoiceLine."Gen. Bus. Posting Group" := 'LOCAL';
                                        if SalesInvoiceLine.Insert() then
                                            counter := counter + 1;

                                        HMSPatientCharges.Modify();
                                    end;
                                until HMSPatientCharges.Next() = 0;

                            UnsynchedRecords."Synched with sales Invoice" := true;
                            UnsynchedRecords.Modify();
                        until UnsynchedRecords.Next() = 0;

                    Message('done %1', counter);
                end;
            }
            action(SyncINvoiceSingle)
            {
                ApplicationArea = All;
                Caption = 'Sync Single Invoice';
                Image = Archive;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Sync Single Invoice action.';
                trigger OnAction()
                var
                    UnsynchedRecords: Record "Visits with Unsynced Charges";
                    HMSPatientCharges: Record "HMS Patient Charges";
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    lineNo: Integer;
                    counter: Integer;
                begin
                    // Rec.TestField("Confirmed to Sync", true);
                    // Rec.TestField("Synched with sales Invoice", false);

                    // Rec.CalcFields("First Invoice number", "Insurance No");
                    counter := 0;

                    SalesInvoiceLine.Reset();
                    if SalesInvoiceLine.FindLast() then
                        lineNo := SalesInvoiceLine."Line No.";

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange("Visit No", Rec."Visit No");
                    HMSPatientCharges.SetRange(Posted, true);
                    HMSPatientCharges.SetFilter(Code, '<>%1', 'REBATES');
                    if HMSPatientCharges.FindSet() then
                        repeat
                            if HMSPatientCharges."Invoice Number" = '' then begin
                                HMSPatientCharges."Insurance No" := Rec."Insurance No";
                                HMSPatientCharges."Invoice Number" := Rec."First Invoice number";

                                lineNo += 1;
                                SalesInvoiceLine.Init();
                                SalesInvoiceLine."Line No." := lineNo;
                                SalesInvoiceLine."Document No." := Rec."First Invoice number";
                                SalesInvoiceLine."Sell-to Customer No." := HMSPatientCharges."Insurance No";
                                SalesInvoiceLine.Type := SalesInvoiceLine.Type::"G/L Account";
                                SalesInvoiceLine."No." := HMSPatientCharges."G/L Account No";
                                SalesInvoiceLine."Shipment Date" := HMSPatientCharges.Date;
                                SalesInvoiceLine.Description := HMSPatientCharges.Description;
                                SalesInvoiceLine.Quantity := HMSPatientCharges.Quantity;
                                SalesInvoiceLine."Unit Price" := HMSPatientCharges.Amount;
                                SalesInvoiceLine.Amount := HMSPatientCharges."Total Amount";
                                SalesInvoiceLine."Bill-to Customer No." := HMSPatientCharges."Insurance No";
                                SalesInvoiceLine."Line Amount" := SalesInvoiceLine.Amount;
                                SalesInvoiceLine."Amount Including VAT" := SalesInvoiceLine.Amount;
                                SalesInvoiceLine."Tax Liable" := false;
                                SalesInvoiceLine."Gen. Prod. Posting Group" := 'SERVICES';
                                SalesInvoiceLine."Gen. Bus. Posting Group" := 'LOCAL';
                                if SalesInvoiceLine.Insert() then
                                    counter := counter + 1;

                                HMSPatientCharges.Modify();
                            end;
                        until HMSPatientCharges.Next() = 0;

                    Rec."Synched with sales Invoice" := true;
                    rec.Modify();

                    Message('done %1', counter);
                end;
            }
            action(FIXVAT)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = true;
                ToolTip = 'Executes the Fix VAT action.';
                trigger OnAction()
                var
                    UnsynchedRecords: Record "Visits with Unsynced Charges";
                    HMSPatientCharges: Record "HMS Patient Charges";
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    lineNo: Integer;
                    counter: Integer;
                begin
                    counter := 0;
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Amount Including VAT", 0);
                    // SalesInvoiceLine.SetRange("Document No.", Rec."First Invoice number");
                    if SalesInvoiceLine.FindSet() then
                        repeat
                            counter += 1;
                            SalesInvoiceLine."Amount Including VAT" := SalesInvoiceLine.Amount;
                            SalesInvoiceLine."Tax Liable" := false;
                            SalesInvoiceLine."Gen. Prod. Posting Group" := 'SERVICES';
                            SalesInvoiceLine."Gen. Bus. Posting Group" := 'LOCAL';
                            SalesInvoiceLine.Modify();
                        until SalesInvoiceLine.Next() = 0;
                end;
            }

            action(POSTSalesnvoice)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                Caption = 'Post Sales Invoice';
                ToolTip = 'Executes the Post Sales Invoice action.';
                trigger OnAction()
                var
                    VisitswithUnsyncedCharges: Record "Visits with Unsynced Charges";
                    SalesHeader: Record "Sales Header";
                begin
                    VisitswithUnsyncedCharges.Reset();
                    VisitswithUnsyncedCharges.SetRange("Confirmed to Sync", true);
                    if VisitswithUnsyncedCharges.FindSet() then
                        repeat
                            if VisitswithUnsyncedCharges."Amount in Invoice" = 0 then begin
                                SalesHeader.Reset();
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                                SalesHeader.SetRange("No.", VisitswithUnsyncedCharges."First Invoice number");
                                if SalesHeader.FindFirst() then
                                    SalesHeader.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                            end;
                        until VisitswithUnsyncedCharges.Next() = 0;

                    Message('posted sales invoice %1', SalesHeader."No.");
                end;
            }
            action(GetVisits)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = report "Get Encounters";
                Image = Report;
                ToolTip = 'Executes the GetVisits action.';
            }
            action(DeleteVisits)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = report "Delete Unsynced invoice";
                Image = Report;
                ToolTip = 'Executes the Delete Visits action.';
            }
            action(RefreshVisits)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = Report;
                ToolTip = 'Executes the Refresh Visits action.';
                trigger OnAction()
                var
                    VisitswithUnsyncedCharges: Record "Visits with Unsynced Charges";
                    SalesHeader: Record "Sales Header";
                begin
                    VisitswithUnsyncedCharges.Reset();
                    VisitswithUnsyncedCharges.SetRange("Confirmed to Sync", true);
                    if VisitswithUnsyncedCharges.FindSet() then
                        repeat
                            if VisitswithUnsyncedCharges."Amount in Invoice" = 0 then begin
                                VisitswithUnsyncedCharges.Validate("Visit No");
                                VisitswithUnsyncedCharges.Modify();
                            end;
                        until VisitswithUnsyncedCharges.Next() = 0;

                    Message('posted sales invoice %1', SalesHeader."No.");
                    CurrPage.Update();

                end;
            }
        }
    }
}
