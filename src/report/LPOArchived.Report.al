report 85317 "LPO Archived"
{
    ApplicationArea = All;
    Caption = 'LPO Archived';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Place_of_Delivery; "Purchase Header Archive"."Pay-to Address")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; Vend."No.")
            {
            }
            column(PaytoName_PurchaseHeader; Vend.Name)
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header Archive"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; Vend.Address)
            {
            }
            column(PaytoAddress2_PurchaseHeader; Vend."Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; Vend.City)
            {
            }
            column(ShiptoCode_PurchaseHeader; "Purchase Header Archive"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header Archive"."Ship-to Name")
            {
                IncludeCaption = true;
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header Archive"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header Archive"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header Archive"."Ship-to Address 2")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(website; CompanyInfo."Home Page")
            {
            }
            column(email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(VATREG; CompanyInfo."VAT Registration No.")
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header Archive"."Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header Archive"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header Archive"."No.")
            {
            }
            column(LpoDuedate; "Purchase Header Archive"."Due Date")
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header Archive"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header Archive"."Currency Code")
            {
            }
            column(Amount_PurchaseHeader; "Purchase Header Archive".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Purchase Header Archive"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; PurchLines."Line Discount Amount")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(PrebBy; PrebBy)
            {
            }
            column(PrebDate; PrebDate)
            {
            }
            column(ApproversName1; ApproversName[1])
            {
            }
            column(ApproversName2; ApproversName[2])
            {
            }
            column(ApproversName3; ApproversName[3])
            {
            }
            column(ApproversName4; ApproversName[4])
            {
            }
            column(ApproversName5; ApproversName[5])
            {
            }
            column(ApproversName6; ApproversName[6])
            {
            }
            column(ApproversName7; ApproversName[7])
            {
            }
            column(ApprovalDate1; ApprovalDate[1])
            {
            }
            column(ApprovalDate2; ApprovalDate[2])
            {
            }
            column(ApprovalDate3; ApprovalDate[3])
            {
            }
            column(ApprovalDate4; ApprovalDate[4])
            {
            }
            column(ApprovalDate5; ApprovalDate[5])
            {
            }
            column(ApprovalDate6; ApprovalDate[6])
            {
            }
            column(ApprovalDate7; ApprovalDate[7])
            {
            }
            column(Sign1; UserRec1[1].Signature)
            {
            }
            column(Sign2; UserRec1[2].Signature)
            {
            }
            column(Sign3; UserRec1[3].Signature)
            {
            }
            column(Sign6; UserRec1[6].Signature)
            {
            }
            column(Sign5; UserRec1[5].Signature)
            {
            }
            column(Sign7; UserRec1[7].Signature)
            {
            }
            column(QuoteNo_PurchaseHeader; "Purchase Header Archive"."Purchase Quote No.")
            {
            }
            column(Sign4; UserRec1[4].Signature)
            {
            }
            column(Sign0; UserRec0.Signature)
            {
            }
            column(VAT2; ("Purchase Header Archive"."Amount Including VAT") - ("Purchase Header Archive".Amount))
            {
            }
            column(NoPrinted; "Purchase Header Archive"."No. Printed")
            {
            }
            column(LPOText; LPOText)
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header Archive"."Document Date")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; "Purchase Header Archive"."Shortcut Dimension 2 Code")
            {
            }
            column(UserId; "Purchase Header Archive"."Assigned User ID")
            {
            }
            dataitem("Purchase Line Archive"; "Purchase Line Archive")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence");
                DataItemTableView = where("Version No." = filter(1));
                column(ReportForNavId_2; 2)
                {
                }
                column(Version_No_; "Version No.")
                {
                }
                column(LineNo_PurchaseLine; "Purchase Line Archive"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line Archive"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line Archive"."Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line Archive".Quantity)
                {
                }
                column(No_PurchaseLine; "Purchase Line Archive"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line Archive".Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line Archive"."Unit of Measure")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line Archive"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line Archive"."Line Discount Amount")
                {
                }
                column(Unit_of_Measure_code; "Purchase Line Archive"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //  "Purchase Line Archive".VALIDATE(Quantity);
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                DataItemTableView = where(Status = const(Approved));
                column(ReportForNavId_35; 35)
                {
                }
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(i; i)
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    i := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //if PurchH.Get("No.") then
                PurchLines.Reset();
                PurchLines.SetRange("Document Type", "Document Type");
                PurchLines.SetRange("Document No.", "No.");
                PurchLines.CalcSums("Line Discount Amount");
                CalcFields("Amount Including VAT");
                //Amount into words
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');

                /*
                IF "No. Printed" = 0 THEN LPOText:= 'Suppliers copy'
                ELSE IF "No. Printed" = 1 THEN LPOText:= 'Accounts copy'
                ELSE IF "No. Printed" = 2 THEN LPOText:= 'Store copy'
                ELSE IF "No. Printed" = 3 THEN LPOText:= 'Files copy';
                  */
                GenLedgerSetup.Get();
                //IF "Currency Code"='' THEN "Currency Code":=GenLedgerSetup."LCY Code";

                //Get Approvers
                GRNHeader.Reset();
                GRNHeader.SetRange(GRNHeader."Order No.", "Purchase Header Archive"."No.");
                if GRNHeader.Find('-') then
                    ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", GRNHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                //ApprovalEntry.SETFILTER(ApprovalEntry."Approval Code",'LPO');
                if ApprovalEntry.Find('-') then begin
                    UserRec0.Get(ApprovalEntry."Sender ID");
                    PrebBy := UserRec0.UserName;
                    UserRec0.CalcFields(UserRec0.Signature);
                    PrebDate := ApprovalEntry."Last Date-Time Modified";
                    repeat
                        UserRec.Get(ApprovalEntry."Approver ID");
                        ApproversName[ApprovalEntry."Sequence No."] := UserRec.UserName;
                        ApprovalDate[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Date-Time Modified";
                        UserRec1[ApprovalEntry."Sequence No."].Get(ApprovalEntry."Approver ID");
                        UserRec1[ApprovalEntry."Sequence No."].CalcFields(UserRec1[ApprovalEntry."Sequence No."].Signature);
                    until ApprovalEntry.Next() = 0;
                end;

                Vend.Reset();
                Vend.SetRange(Vend."No.", "Purchase Header Archive"."Buy-from Vendor No.");
                if Vend.Find('-') then;
                ;
            end;

            trigger OnPostDataItem()
            begin
                if CurrReport.Preview = false then begin
                    "No. Printed" := "No. Printed" + 1;
                    Modify();
                end
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        GenLedgerSetup: Record "General Ledger Setup";
        ApprovalEntry: Record "Posted Approval Entry";
        GRNHeader: Record "Purch. Rcpt. Header";
        PurchLines: Record "Purchase Line Archive";
        UserRec: Record "User Setup";
        UserRec0: Record "User Setup";
        UserRec1: array[10] of Record "User Setup";
        Vend: Record Vendor;
        CheckReport: Report Check;
        ApprovalDate: array[10] of DateTime;
        PrebDate: DateTime;
        i: Integer;
        CopyText: Text;
        LPOText: Text;
        ApproversName: array[10] of Text[100];
        PrebBy: Text[100];
        NumberText: array[2] of Text[120];
}
