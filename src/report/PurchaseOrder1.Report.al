Report 85035 "Purchase Order1."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PurchaseOrder1.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Place_of_Delivery; "Place of Delivery")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Purchase Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
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
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Payments_Terms; terms)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Requested Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header"."Currency Code")
            {
            }
            column(ExpiryDate_PurchaseHeader; "Purchase Header"."Expiry Date")
            {
                IncludeCaption = true;
            }
            column(Amount_PurchaseHeader; "Purchase Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Purchase Header"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; PurchLines."Line Discount Amount")
            {
            }
            column(SpecialRemark_PurchaseHeader; "Purchase Header"."Special Remark")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "Purchase Header"."No. Printed")
            {
            }
            column(LPOText; LPOText)
            {
            }
            column(PrebBy; PrebBy)
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
            column(Signature1_; Signature1)
            {
            }
            column(Signature2_; Signature2)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line"."Line Discount Amount")
                {
                }
                column(VAT; "Purchase Line"."VAT %")
                {
                }
                column(Pay_To_Name; Vends.Name)
                {
                }
                column(Vendor_Address; Vends.Address)
                {
                }
                column(Vendor_Address2; Vends."Address 2")
                {
                }
                column(Vendor_City; Vends.City)
                {
                }
                column(Vendor_Phone; Vends."Phone No.")
                {
                }
                column(Vendor_Email; Vends."E-Mail")
                {
                }
                column(SN; sn)
                {
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    sn := sn + 1;
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
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                PurchLines.Reset();
                PurchLines.SetRange("Document Type", "Document Type");
                PurchLines.SetRange("Document No.", "No.");
                PurchLines.CalcSums("Line Discount Amount");
                CalcFields("Amount Including VAT");
                //Amount into words
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');

                if "No. Printed" = 0 then
                    LPOText := 'Suppliers copy'
                else
                    if "No. Printed" = 1 then
                        LPOText := 'Accounts copy'
                    else
                        if "No. Printed" = 2 then
                            LPOText := 'Store copy'
                        else
                            if "No. Printed" = 3 then
                                LPOText := 'Files copy';

                GenLedgerSetup.Get();
                if "Currency Code" = '' then
                    "Currency Code" := GenLedgerSetup."LCY Code";
                //get approver signature
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                // ApprovalEntry.SetRange(ApprovalEntry."Approval Code", 'MS-INCDOCAPW-03');
                ApprovalEntry.SetRange(ApprovalEntry."Sequence No.", 1);
                if ApprovalEntry.Find('-') then
                    Signature1 := GetSignature(ApprovalEntry."Last Modified By User ID");

                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                // ApprovalEntry.SetRange(ApprovalEntry."Approval Code", 'MS-INCDOCAPW-03');
                ApprovalEntry.SetRange(ApprovalEntry."Sequence No.", 2);
                if ApprovalEntry.Find('-') then
                    Signature2 := GetSignature(ApprovalEntry."Last Modified By User ID");

                //Get Approvers
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                // ApprovalEntry.SetRange(ApprovalEntry."Approval Code", 'MS-INCDOCAPW-03');
                // ApprovalEntry.SetRange(ApprovalEntry."Sequence No.", 3);
                if ApprovalEntry.Find('-') then begin
                    UserRec.Get(ApprovalEntry."Sender ID");
                    repeat
                        UserRec.Get(ApprovalEntry."Last Modified By User ID");
                        ApproversName[ApprovalEntry."Sequence No."] := UserRec.UserName;
                        ApprovalDate[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Date-Time Modified";
                    until ApprovalEntry.Next() = 0;
                end;

                Vends.Reset();
                Vends.SetRange(Vends."No.", "Purchase Header"."Buy-from Vendor No.");
                if Vends.Find('-') then
                    terms := Vends."Payment Terms Code";
            end;

            trigger OnPostDataItem()
            begin
                if CurrReport.Preview = false then begin
                    "No. Printed" := "No. Printed" + 1;
                    Modify();
                end
                ///******************
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
        ApprovalEntry: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        GenLedgerSetup: Record "General Ledger Setup";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PurchLines: Record "Purchase Line";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        UserRec: Record "User Setup";
        Vends: Record Vendor;
        CheckReport: Report Check;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        ShowInternalInfo: Boolean;
        terms: Code[30];
        ApprovalDate: array[10] of DateTime;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        IStream: InStream;
        NoOfCopies: Integer;
        sn: Integer;
        CopyText: Text;
        LPOText: Text;
        Signature1: Text;
        Signature2: Text;
        PurchaserText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VendAddr: array[8] of Text[50];
        ReferenceText: Text[80];
        VATNoText: Text[80];
        ApproversName: array[10] of Text[100];
        PrebBy: Text[100];
        NumberText: array[2] of Text[120];

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FieldCaption("VAT Registration No."));
    end;

    local procedure GetSignature(userid: Code[50]) BaseImage: Text
    var
        userset: Record "User Setup";
    begin

        userset.Reset();
        userset.SetRange("User ID", userid);
        if userset.Find('-') then
            userset.CalcFields(userset.Signature);
        userset.Signature.CreateInstream(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        CopyStream(MemoryStream, IStream);
        Bytes := MemoryStream.GetBuffer();
        BaseImage := Convert.ToBase64String(Bytes);
    end;
}
