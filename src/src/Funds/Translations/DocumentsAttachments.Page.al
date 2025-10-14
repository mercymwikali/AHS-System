page 52202641 "Document Attachments"
{
    Caption = 'Documents Attached';
    PageType = CardPart;
    SourceTable = "Document Attachment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;
                field(Documents; Rec.Count)
                {
                    Caption = 'Documents';
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
                    var
                        Customer: Record Customer;
                        Employee: Record Employee;
                        FixedAsset: Record "Fixed Asset";
                        Item: Record Item;
                        Job: Record Job;
                        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                        PurchInvHeader: Record "Purch. Inv. Header";
                        PurchaseHeader: Record "Purchase Header";
                        Resource: Record Resource;
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        SalesHeader: Record "Sales Header";
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        Vendor: Record Vendor;
                        // Conf: Record "Conference Attendance";
                        // Jb: Record jobs;
                        DocumentAttachmentDetails: Page "Document Attachment Det Custom";
                        RecRef: RecordRef;
                    begin

                        case Rec."Table ID" of
                            DATABASE::Customer:
                                begin
                                    RecRef.Open(DATABASE::Customer);
                                    if Customer.Get(Rec."No.") then
                                        RecRef.GetTable(Customer);
                                end;
                            DATABASE::Vendor:
                                begin
                                    RecRef.Open(DATABASE::Vendor);
                                    if Vendor.Get(Rec."No.") then
                                        RecRef.GetTable(Vendor);
                                end;
                            DATABASE::Item:
                                begin
                                    RecRef.Open(DATABASE::Item);
                                    if Item.Get(Rec."No.") then
                                        RecRef.GetTable(Item);
                                end;
                            DATABASE::Employee:
                                begin
                                    RecRef.Open(DATABASE::Employee);
                                    if Employee.Get(Rec."No.") then
                                        RecRef.GetTable(Employee);
                                end;
                            DATABASE::"Fixed Asset":
                                begin
                                    RecRef.Open(DATABASE::"Fixed Asset");
                                    if FixedAsset.Get(Rec."No.") then
                                        RecRef.GetTable(FixedAsset);
                                end;
                            DATABASE::Resource:
                                begin
                                    RecRef.Open(DATABASE::Resource);
                                    if Resource.Get(Rec."No.") then
                                        RecRef.GetTable(Resource);
                                end;
                            DATABASE::Job:
                                begin
                                    RecRef.Open(DATABASE::Job);
                                    if Job.Get(Rec."No.") then
                                        RecRef.GetTable(Job);
                                end;
                            // DATABASE::Jobs:
                            //     begin
                            //         RecRef.Open(DATABASE::Jobs);
                            //         if Jb.Get("No.") then
                            //             RecRef.GetTable(Jb);
                            //     end;
                            // DATABASE::"Conference Attendance":
                            //     begin
                            //         RecRef.Open(DATABASE::"Conference Attendance");
                            //         if Conf.Get("No.") then
                            //             RecRef.GetTable(Conf);
                            //     end;
                            DATABASE::"Sales Header":
                                begin
                                    RecRef.Open(DATABASE::"Sales Header");
                                    if SalesHeader.Get(Rec."Document Type", Rec."No.") then
                                        RecRef.GetTable(SalesHeader);
                                end;
                            DATABASE::"Sales Invoice Header":
                                begin
                                    RecRef.Open(DATABASE::"Sales Invoice Header");
                                    if SalesInvoiceHeader.Get(Rec."No.") then
                                        RecRef.GetTable(SalesInvoiceHeader);
                                end;
                            DATABASE::"Sales Cr.Memo Header":
                                begin
                                    RecRef.Open(DATABASE::"Sales Cr.Memo Header");
                                    if SalesCrMemoHeader.Get(Rec."No.") then
                                        RecRef.GetTable(SalesCrMemoHeader);
                                end;
                            DATABASE::"Purchase Header":
                                begin
                                    RecRef.Open(DATABASE::"Purchase Header");
                                    if PurchaseHeader.Get(Rec."Document Type", Rec."No.") then
                                        RecRef.GetTable(PurchaseHeader);
                                end;
                            DATABASE::"Purch. Inv. Header":
                                begin
                                    RecRef.Open(DATABASE::"Purch. Inv. Header");
                                    if PurchInvHeader.Get(Rec."No.") then
                                        RecRef.GetTable(PurchInvHeader);
                                end;
                            DATABASE::"Purch. Cr. Memo Hdr.":
                                begin
                                    RecRef.Open(DATABASE::"Purch. Cr. Memo Hdr.");
                                    if PurchCrMemoHdr.Get(Rec."No.") then
                                        RecRef.GetTable(PurchCrMemoHdr);
                                end;
                            // DATABASE::"Admission Form Header":
                            //     begin
                            //         RecRef.Open(DATABASE::"Admission Form Header");
                            //         if AdminHeader.Get("No.") then
                            //             RecRef.GetTable(AdminHeader);
                            //     end;
                            // DATABASE::"Application Form Header":
                            //     begin
                            //         RecRef.Open(DATABASE::"Application Form Header");
                            //         if AppHeader.Get("No.") then
                            //             RecRef.GetTable(AppHeader);
                            //     end;
                            else
                                OnBeforeDrillDown(Rec, RecRef);
                        end;

                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
    end;
}
