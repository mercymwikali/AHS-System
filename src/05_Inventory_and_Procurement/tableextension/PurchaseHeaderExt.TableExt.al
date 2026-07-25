TableExtension 85004 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        //Unsupported feature: Property Modification (Data type) on ""Pay-to Name"(Field 5)".

        modify("Pay-to Name 2")
        {
            TableRelation = Vendor;
        }
        field(50100; Copied; Boolean)
        {
        }
        field(50101; "Debit Note"; Boolean)
        {
        }
        field(50102; "Procurement Request No."; Code[20])
        {
        }
        field(50103; "Invoice Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50104; "Request No"; Code[10])
        {
        }
        field(50105; Commited; Boolean)
        {
        }
        field(50106; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }

        field(50107; "Delivery No"; Code[15])
        {
        }
        field(50108; "Ledger Card No"; Code[15])
        {
        }
        field(50109; "PRN No"; Code[15])
        {
        }
        field(50110; "Approval Status"; Option)
        {
            OptionCaption = 'New,Purchasing,Finance,Admin,Completed';
            OptionMembers = New,Purchasing,Finance,Admin,Completed;
        }
        field(50111; "PO Status"; Option)
        {
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50112; "Finance Status"; Option)
        {
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50113; "Admin Status"; Option)
        {
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50114; "P.O Name"; Code[15])
        {
        }
        field(50115; "P.O Approval Date"; Date)
        {
        }
        field(50116; "Finance Approved By"; Code[15])
        {
        }
        field(50117; "Finance Approval Date"; Date)
        {
        }
        field(50118; "Admin Approved By"; Code[15])
        {
        }
        field(50119; "Admin Approved Date"; Date)
        {
        }
        field(50120; "Contract No."; Code[15])
        {
        }
        field(50121; "Quotation No."; Code[15])
        {
        }
        field(50122; "Request for Quote No."; Code[15])
        {
            TableRelation = "Purchase Quote Header"."No." where(Status = const(Released));

            trigger OnValidate()
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                if not Confirm('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?', false)
                then
                    Error('You have selected to abort the process');

                PurchLine.Reset();
                PurchLine.SetRange(PurchLine."Document No.", "No.");
                PurchLine.DeleteAll();

                RFQ.Reset();
                RFQ.SetRange(RFQ."Document No.", "Procurement Request No.");
                if RFQ.Find('-') then
                    repeat
                        PurchLine.Init();
                        PurchLine."Document Type" := "Document Type";
                        PurchLine."Document No." := "No.";
                        PurchLine."Line No." := RFQ."Line No." + 5;
                        PurchLine.Type := RFQ.Type;
                        //  PurchLine."Document Type 2":="Document Type 2";
                        PurchLine."No." := RFQ."No.";
                        PurchLine.Validate("No.");
                        PurchLine."Location Code" := RFQ."Location Code";
                        PurchLine.Validate("Location Code");
                        PurchLine.Quantity := RFQ.Quantity;
                        PurchLine."Description 2" := RFQ."Description 2";
                        PurchLine.Validate(Quantity);
                        PurchLine."Direct Unit Cost" := RFQ."Direct Unit Cost";
                        PurchLine.Validate("Direct Unit Cost");
                        PurchLine.Amount := RFQ.Amount;
                        PurchLine.validate(Amount);
                        PurchLine."Shortcut Dimension 1 Code" := RFQ."Shortcut Dimension 1 Code";
                        PurchLine.validate("Shortcut Dimension 1 Code");
                        PurchLine."Shortcut Dimension 2 Code" := RFQ."Shortcut Dimension 2 Code";
                        PurchLine.Insert();
                    until RFQ.Next() = 0;
            end;
        }
        field(50123; "Document Type 2"; Option)
        {
            OptionMembers = Requisition,Quote,"Order";
        }
        field(50124; "Tendor Number"; Code[15])
        {
        }
        field(50125; Allocation; Decimal)
        {
        }
        field(50126; Expenditure; Decimal)
        {
        }
        field(50127; "Purchase Type"; Option)
        {
            OptionCaption = ' ,Departmental,Global';
            OptionMembers = " ",Departmental,Global;
        }
        field(50128; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50129; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50130; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50131; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
        field(50132; "Reference No"; Code[30])
        {
            TableRelation = if ("Refrence Type" = const(Employee)) "HR-Employee"."No."
            else
            if ("Refrence Type" = const(Student)) Customer."No." where("Customer Posting Group" = const('STUDENT'));
        }
        field(50133; "Refrence Type"; Option)
        {
            OptionCaption = 'Employee,Student';
            OptionMembers = Employee,Student;
        }
        field(50134; "Quote Comments"; Text[100])
        {
            Description = 'Store Comments of Purchase Quote in the DB (Added)';
        }
        field(50135; "Responsibility Center Name"; Text[100])
        {
            Description = 'Stores Responsibilty Center Name in the database (Added)';
        }
        field(50136; "Donor Name"; Text[50])
        {
            Description = 'Stores Donor Name in the database (Added)';
        }
        field(50137; "Pillar Name"; Text[50])
        {
            Description = 'Stores Pillar Name in the database (Added)';
        }
        field(50138; "Quote Comments 2"; Text[100])
        {
        }
        field(50139; "Quote Comments 3"; Text[100])
        {
            Enabled = false;
        }
        field(50140; "Recommendation 1"; Text[100])
        {
        }
        field(50141; "Recommendation 2"; Text[100])
        {
        }
        field(50142; "Project Code"; Code[10])
        {
        }
        field(50143; "Archive Unused Doc"; Boolean)
        {
        }
        field(50144; "VAT Method"; Option)
        {
            OptionCaption = 'Expensed,Recovered';
            OptionMembers = Expensed,Recovered;
        }
        field(50145; "Department Name"; Text[100])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50146; "Sub-Department Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('SUB DEPARTMENT'));
            trigger OnValidate()
            var
                dimensionvalue: Record "Dimension Value";
            begin
                dimensionvalue.Reset();
                dimensionvalue.SetRange("Dimension Code", 'SUB DEPARTMENT');
                dimensionvalue.SetRange(Code, "Sub-Department Code");
                if dimensionvalue.FindFirst() then
                    "Sub-Department Name" := dimensionvalue.Name;
            end;
        }
        field(50147; "Sub-Department Name"; Text[250])
        {
            Editable = false;
        }
        field(50148; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50149; text; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; Cancelled; Boolean)
        {
            Editable = false;
        }
        field(50151; "Cancelled By"; Code[20])
        {
        }
        field(50152; "Cancelled Date"; Date)
        {
        }
        field(50153; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(50154; "Procurement Type Code"; Code[20])
        {
            // TableRelation = "Procurement Limit Code"."Procurement Code";
        }
        field(50155; "Invoice Basis"; Option)
        {
            OptionMembers = "PO Based","Direct Invoice";
        }
        field(50156; "RFQ No."; Code[20])
        {
            TableRelation = "Purchase Quote Header" where(Status = const(Released));

            trigger OnLookup()
            begin
                TestField("Responsibility Center");
                //  TestField("Shortcut Dimension 1 Code");
                //  TestField("Shortcut Dimension 2 Code");

                RFQHdr.Reset();
                RFQHdr.SetRange(RFQHdr.Status, RFQHdr.Status::Released);
                // RFQHdr.SetRange(RFQHdr."No.", "RFQ No.");
                if Page.RunModal(70135317, RFQHdr) = Action::LookupOK then
                    InsertRFQ(RFQHdr);
            end;
        }
        field(50157; "Expiry Date"; Date)
        {
        }
        field(50158; "Special Remark"; Text[20])
        {
        }
        field(50159; "Responsible Officer"; Code[20])
        {
            TableRelation = "User Setup" where("Procurement Officer" = filter(true));
        }
        field(50160; Type; Option)
        {
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
        }
        field(50161; "Imprest Purchase Doc No"; Code[20])
        {
        }
        field(50162; "Manual LPO No."; Code[20])
        {
        }
        field(50163; "Requisition No1."; Code[20])
        {
            CalcFormula = lookup("Purchase Line"."Requisition No" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50164; "LPO No."; Code[20])
        {
        }
        field(50165; Contract; Boolean)
        {
            trigger OnValidate()
            begin
                CalcFields("Invoice Amount");
                if "Invoice Amount" < 1000000 then
                    Error('Please note that contract LPO is only applicable for LPOs with a value of 1million and above');
                Status := Status::Released;
            end;
        }
        field(50166; "Employee No1."; Code[20])
        {
            TableRelation = "HR-Employee";
        }
        field(50167; "LPO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash LPO,Normal LPO';
            OptionMembers = "Cash LPO","Normal LPO";
        }
        field(50168; "Place of Delivery"; Text[100])
        {
        }
    }
    keys
    {
        //Unsupported feature: Deletion (KeyCollection) on ""Status,""Expected Receipt Date"",""Location Code"",""Responsibility Center"""(Key)".

        //Unsupported feature: Deletion (KeyCollection) on ""Assigned User ID"(Key)".
    }
    trigger OnAfterInsert()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(database.UserId) then
            "Shortcut Dimension 1 Code" := UserRec."Global Dimension 1 Code";
    end;

    procedure InsertRFQ(RFQHeader: Record "Purchase Quote Header")
    var
        ReqLines: Record "Purchase Line";
        RFQLines: Record "Purchase Quote Line";
        Ln: Integer;
    begin
        //RFQHeader.GET(RFQHeader."Document Type"::"Quotation Request","RFQ No.");

        ReqLines.Reset();
        ReqLines.SetRange(ReqLines."Document Type", "Document Type");
        ReqLines.SetRange(ReqLines."Document No.", "No.");
        ReqLines.DeleteAll();

        RFQLines.reset();
        RFQLines.SETRANGE(RFQLines."Document No.", RFQHeader."No.");
        if RFQLines.find('-') then begin
            repeat
                ln := ln + 1;
                ReqLines.Init();
                //ReqLines.TransferFields(RFQLines);
                ReqLines."Line No." := ReqLines."Line No." + ln;
                ReqLines."Document Type" := "Document Type";
                ReqLines."Document No." := "No.";
                ReqLines.Type := RFQLines.Type;
                ReqLines."No." := RFQLines."No.";
                ReqLines.Validate("No.");
                ReqLines.Description := RFQLines.Description;
                ReqLines.Quantity := RFQLines.Quantity;
                ReqLines.Validate(Quantity);
                ReqLines."Buy-from Vendor No." := "Buy-from Vendor No.";
                ReqLines."Pay-to Vendor No." := "Pay-to Vendor No.";
                ReqLines."Requisition No" := RFQLines."Requisition No";
                ReqLines."Shortcut Dimension 1 Code" := ReqLines."Shortcut Dimension 1 Code";
                ReqLines."Shortcut Dimension 2 Code" := ReqLines."Shortcut Dimension 2 Code";
                ReqLines.Insert();
                "Shortcut Dimension 1 Code" := ReqLines."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := ReqLines."Shortcut Dimension 2 Code";
            until RFQLines.Next() = 0;
            "RFQ No." := RFQHeader."No.";

            modify();
        end;
    end;

    var
        PurchLine: Record "Purchase Line";
        RFQHdr: Record "Purchase Quote Header";
        RFQ: Record "Purchase Quote Line";
}
