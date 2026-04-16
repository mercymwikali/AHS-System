page 85337 "HMS Doctors Payment Batch"
{
    Editable = false;
    PageType = Card;
    SourceTable = "HMS Doctors Payment Batch";

    layout
    {
        area(content)
        {
            field(No; Rec.No)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the No field.';
            }
            field(Date; Rec.Date)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Date field.';
            }
            field(Time; Rec.Time)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Time field.';
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Posted By field.';
            }
            part(Control7; "HMS Patients Visit List")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Batch No" = FIELD(No);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Payment Batch")
            {
                Image = Print;
                ToolTip = 'Executes the Print Payment Batch action.';

                trigger OnAction()
                begin
                    PatVist.Reset();
                    PatVist.SetFilter(PatVist."Batch No", Rec.No);
                    if PatVist.Find('-') then
                        REPORT.Run(70135150, true, true, PatVist);
                end;
            }

            action("Generate PV")
            {
                Image = Payment;
                ToolTip = 'Executes the Generate PV action.';

                trigger OnAction()
                begin
                    IF CONFIRM('Do you really want to Generate a Payment Vourcher?', FALSE) THEN
                        CreatePV();
                end;
            }
        }
    }

    var
        PatVist: Record "HMS Patient Visit Nos";
        VendL: Record "Vendor Ledger Entry";

    local procedure CreatePV()
    var
        CashOfficesetup: Record "Cash Office Setup";
        TaxEntry: Record "Doctors Tax Entry";
        PatVisits: Record "HMS Patient Visit Nos";
        Doc: Record "HMS Setup Doctor";
        PVLine: Record "Payment Line";
        PVHeader: Record "Payments Header";
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        Ln: Integer;
    begin
        IF Rec."Payment Vourcher No" <> '' THEN
            IF PVHeader.GET(Rec."Payment Vourcher No") THEN
                IF PVHeader.Status <> PVHeader.Status::Pending THEN
                    ERROR('The payment for this batch is already processed with PV No. ' + Rec."Payment Vourcher No")
                ELSE
                    PVHeader.DELETE();

        CashOfficesetup.GET();
        CashOfficesetup.TESTFIELD("Normal Payments No");
        NewNo := NoSeriesMgt.GetNextNo(CashOfficesetup."Normal Payments No", 0D, TRUE);
        PVHeader.INIT();
        PVHeader."No." := NewNo;
        PVHeader.Date := TODAY;
        PVHeader."Global Dimension 1 Code" := 'ACCOUNTS';
        PVHeader."Shortcut Dimension 2 Code" := 'ACCOUNTS';
        PVHeader."Responsibility Center" := 'FINANCE';
        //PVHeader.Payee:=
        PVHeader."Doctors Batch Code" := Rec.No;
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        PVHeader."Payment Release Date" := Rec.Date;
        PVHeader.INSERT();

        PatVisits.RESET();
        PatVisits.SETRANGE(PatVisits."Batch No", Rec.No);
        PatVisits.SETRANGE(Posted, TRUE);
        IF PatVisits.FIND('-') THEN
            REPEAT
                PatVisits.CALCFIELDS("Doctor Amount");
                Doc.GET(PatVisits."Doctor ID");
                Ln := Ln + 1;
                PVLine.INIT();
                PVLine.No := NewNo;
                PVLine."Line No." := Ln;
                PVLine."Transaction Name" := Doc."Doctors Name";
                PVLine."Account No." := PatVisits."Doctor ID";
                PVLine.Type := 'DOCTORS';
                PVLine."Account Type" := PVLine."Account Type"::Vendor;
                PVLine.Amount := PatVisits."Doctor Amount";
                PVLine."PO/INV No" := PatVisits."Visit No";
                PVLine."Patient No" := PatVisits."Patient No";
                PVLine."Retention  Amount" := GetHDF(PatVisits."Doctor ID", PatVisits."Visit No", PatVisits."Patient No");
                IF PVLine."Retention  Amount" > 0 THEN
                    PVLine."Retention Code" := 'HDF';
                PVLine."Net Amount" := PatVisits."Doctor Amount" - PVLine."Retention  Amount";
                IF PVLine.Amount > 0 THEN BEGIN
                    VendL.RESET();
                    VendL.SETRANGE("Vendor No.", PatVisits."Doctor ID");
                    VendL.SETRANGE("Document No.", PatVisits."Visit No");
                    VendL.SETRANGE(Open, TRUE);
                    IF VendL.FIND('-') THEN BEGIN
                        PVLine."Applies-to Doc. Type" := PVLine."Applies-to Doc. Type"::Invoice;
                        PVLine."Applies-to ID" := PatVisits."Visit No";
                        PVLine."Apply to ID" := PatVisits."Visit No";
                        PVLine."Applies-to Doc. No." := PatVisits."Visit No";
                    END;
                END;
                //PVLine.VALIDATE("Retention  Amount");
                PVLine.INSERT();
            UNTIL PatVisits.NEXT() = 0;
        TaxEntry.RESET();
        TaxEntry.SETRANGE("Batch No", Rec.No);
        IF TaxEntry.FIND('-') THEN
            REPEAT
                Ln := Ln + 1;
                PVLine.INIT();
                PVLine."Line No." := Ln;
                PVLine.No := NewNo;
                PVLine."Transaction Name" := Doc."Doctors Name";
                PVLine."Account No." := TaxEntry."Doctor ID";
                PVLine.Type := 'DOCTORS';
                PVLine."Account Type" := PVLine."Account Type"::Vendor;
                PVLine.Amount := TaxEntry.Amount * -1;
                PVLine."Withholding Tax Amount" := TaxEntry.Amount;
                PVLine."Withholding Tax Code" := 'WHT';
                PVLine."Net Amount" := TaxEntry.Amount * -1;
                IF PVLine.Amount > 0 THEN BEGIN
                    VendL.RESET();
                    VendL.SETRANGE("Vendor No.", PatVisits."Doctor ID");
                    VendL.SETRANGE("Document No.", PatVisits."Visit No");
                    VendL.SETRANGE(Open, TRUE);
                    IF VendL.FIND('-') THEN BEGIN
                        PVLine."Applies-to Doc. Type" := PVLine."Applies-to Doc. Type"::Invoice;
                        PVLine."Applies-to ID" := PatVisits."Visit No";
                        PVLine."Apply to ID" := PatVisits."Visit No";
                        PVLine."Applies-to Doc. No." := PatVisits."Visit No";
                    END;
                END;
                PVLine.INSERT();
            UNTIL TaxEntry.NEXT() = 0;
        Rec."Payment Vourcher No" := NewNo;
        Rec.MODIFY();
        PVHeader.GET(NewNo);
        IF CONFIRM('Payment Vourcher No. ' + NewNo + ' has been created successfully, Do you want to Open the Payment ?', TRUE) THEN
            PAGE.RUN(70135384, PVHeader);
    end;

    local procedure GetHDF(DocNo: Code[20]; VisitNo: Code[20]; PatNo: Code[20]): Decimal
    var
        Doc: Record "HMS Setup Doctor";
    begin
        PatVist.RESET();
        PatVist.SETRANGE("Batch No", Rec.No);
        PatVist.SETRANGE("Patient No", PatNo);
        PatVist.SETRANGE("Visit No", VisitNo);
        PatVist.SETRANGE("Doctor ID", DocNo);
        IF PatVist.FIND('-') THEN
            Doc.GET(DocNo);
            // PatVist.CALCFIELDS("Other Amount");
            //PatVist.CALCFIELDS("Consultation Amount");
            /// IF (PatVist."Other Amount" > 0) AND (Doc."HDF%" > 0) THEN HDF := PatVist."Other Amount" * (Doc."HDF%" * 0.01);
            // IF PatVist."Consultation Amount" > 0 THEN HDF := HDF + 500;
    end;
}
