Table 85036 "Purchase Quote Header"
{
    Caption = 'Purchase Header';
    LookupPageID = "Purchase Quote List";

    fields
    {
        field(50000; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(50001; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(50002; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(50003; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = Location.Code where("Use As In-Transit" = const(false));
        }
        field(50004; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(50005; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(50006; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(50007; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(50008; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(50009; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(50010; "Expected Opening Date"; Date)
        {
            Caption = 'Expected Opening Date';
            trigger OnValidate()
            begin
                if "Expected Closing Date" <> 0D then
                    if "Expected Opening Date" > "Expected Closing Date" then
                        error('Please note that opening date can not be after closing date');
            end;
        }
        field(50011; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50012; "Expected Closing Date"; Date)
        {
            Caption = 'Expected Closing Date';
            trigger OnValidate()
            begin
                if "Expected Closing Date" < "Expected Opening Date" then
                    error('Please note that closing date can not be ealier than opening date');
            end;
        }
        field(50013; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(50014; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(50015; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(50016; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(50017; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(50018; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(50019; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(50020; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50021; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50022; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(50023; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50024; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50025; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            begin
            end;
        }
        field(50026; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(50027; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(50028; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
            end;
        }
        field(50029; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(50030; Comment; Boolean)
        {
            CalcFormula = exist("Purch. Comment Line" where("Document Type" = field("Document Type"),
                                                             "No." = field("No."),
                                                             "Document Line No." = const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(50032; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(50033; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(50034; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(50035; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(50036; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(50037; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(50038; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line".Amount where("Document Type" = field("Document Type"),
                                                            "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = field("Document Type"),
                                                                            "Document No." = field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(50041; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(50042; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(50043; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(50044; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(50045; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50046; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            // TableRelation = VE;
        }
        field(50047; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(50048; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50049; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50050; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(50051; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50052; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(50053; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';

            trigger OnValidate()
            begin
            end;
        }
        field(50054; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50055; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(50056; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(50057; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(50058; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(50059; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50060; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50061; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(50062; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";
        }
        field(50063; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(50064; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(50065; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50066; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
            end;
        }
        field(50067; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
            end;
        }
        field(50068; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped;
        }
        field(50069; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(50070; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(50071; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
        }
        field(50072; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(50073; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(50074; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(50075; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(50076; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(50077; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("Purchase Header Archive"."Version No." where("Document Type" = field("Document Type"),
                                                                             "No." = field("No."),
                                                                             "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50078; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(50079; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(50080; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
            end;
        }
        field(50081; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
            end;
        }
        field(50082; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";
        }
        field(50083; "Completely Received"; Boolean)
        {
            CalcFormula = min("Purchase Line"."Completely Received" where("Document Type" = field("Document Type"),
                                                                           "Document No." = field("No."),
                                                                           Type = filter(<> ' '),
                                                                           "Location Code" = field("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50084; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(50085; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50086; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(50087; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(50088; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(50089; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(50090; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50091; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(50092; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";
        }
        field(50093; Ship; Boolean)
        {
            Caption = 'Ship';
        }
        field(50094; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(50095; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
        field(50096; Copied; Boolean)
        {
        }
        field(50097; "Debit Note"; Boolean)
        {
        }
        field(50098; Cancelled; Boolean)
        {
        }
        field(50099; "Cancelled By"; Code[20])
        {
        }
        field(50100; "Cancelled Date"; Date)
        {
        }
        field(50101; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(50102; "Procurement Type Code"; Code[20])
        {
            // TableRelation = "Procurement Limit Code";
        }
        field(50103; "Created By"; Code[20])
        {
        }
        field(50104; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
        field(50105; "Time Received"; Time)
        {
            Caption = 'Time Received';
        }
        field(50106; "BizTalk Purchase Quote"; Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
        }
        field(50107; "BizTalk Purch. Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
        }
        field(50108; "BizTalk Purchase Invoice"; Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
        }
        field(50109; "BizTalk Purchase Receipt"; Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
        }
        field(50110; "BizTalk Purchase Credit Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
        }
        field(50111; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(50112; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(50113; "BizTalk Request for Purch. Qte"; Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
        }
        field(50114; "BizTalk Purchase Order"; Boolean)
        {
            Caption = 'BizTalk Purchase Order';
        }
        field(50115; "Vendor Quote No."; Code[20])
        {
            Caption = 'Vendor Quote No.';
        }
        field(50116; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
        field(50117; Description2; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50118; "Country of Origin"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50119; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Check if the number has been inserted by the user
        if "No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField(PurchSetup."Quotation Request No");
            NoSeriesMgt.InitSeries(PurchSetup."Quotation Request No", xRec."No. Series", Today, "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        if xRec."No." <> "No." then begin
            PurchSetup.Get();
            NoSeriesMgt.TestManual(PurchSetup."Quotation Request No");
        end;
    end;

    var
        PurchSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
