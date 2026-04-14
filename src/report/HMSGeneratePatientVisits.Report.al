Report 85084 "HMS Generate Patient Visits"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSGeneratePatientVisits.rdl';

    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Patient No.", "Date Registered";
            column(ReportForNavId_6; 6)
            {
            }
            dataitem("HMS Patient Visit Nos"; "HMS Patient Visit Nos")
            {
                DataItemLink = "Patient No" = field("Patient No.");
                DataItemTableView = where("Doctor Amount" = filter(> 0), "Doctor ID" = filter(<> ''), Posted = const(false));
                RequestFilterFields = "Doctor ID";
                column(ReportForNavId_1; 1)
                {
                }
                column(PatientNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Patient No")
                {
                }
                column(VisitNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Visit No")
                {
                }
                column(Balance_HMSPatientVisitNos; "HMS Patient Visit Nos".Balance)
                {
                }
                column(DoctorAmount_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor Amount")
                {
                }
                column(Names; "HMS Patient".Names)
                {
                }
                column(SearchName_HMSPatientSearchName; "HMS Patient"."Search Name")
                {
                }
                column(nDate; dtVDate)
                {
                }
                column(InsuranceNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Insurance No")
                {
                }
                column(InsuranceNM; InsuranceNM)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    IF PostInv=TRUE THEN BEGIN

                     IF ("HMS Patient Visit Nos".Balance<1) OR (CheckifPaid("HMS Patient Visit Nos"."Visit No","HMS Patient Visit Nos"."Patient No")=TRUE) THEN BEGIN
                     UpdateDoctorInvoiceNew("HMS Patient Visit Nos"."Patient No","HMS Patient Visit Nos"."Visit No","HMS Patient Visit Nos"."Doctor ID");
                    "HMS Patient Visit Nos".Posted:=TRUE;
                    "HMS Patient Visit Nos"."User ID":="User ID";
                    "HMS Patient Visit Nos".Date:=TODAY;
                    "HMS Patient Visit Nos".MODIFY;
                    END;
                    END;
                    */
                    InsuranceNM := '';

                    dtVDate := "HMS Patient Visit Nos".Date;

                    if dtVDate = 0D then begin
                        objPatCharges.Reset();
                        objPatCharges.SetRange(objPatCharges."Visit No", "HMS Patient Visit Nos"."Visit No");
                        if objPatCharges.Find('-') then
                            dtVDate := objPatCharges.Date;
                    end;

                    "HMS Patient Visit Nos".CalcFields("Insurance No");

                    if Insurance.Get("Insurance No") then
                        InsuranceNM := Insurance.Name;
                end;
            }
            trigger OnPreDataItem()
            var
                PatVisits: Record "HMS Patient Visit Nos";
            begin

                PatVisits.reset();
                PatVisits.setrange(Completed, false);
                PatVisits.setfilter("Patient No", "HMS Patient Visit Nos".getfilter("Patient No"));
                PatVisits.setfilter("Visit No", "HMS Patient Visit Nos".getfilter("Visit No"));
                PatVisits.setfilter("Doctor ID", "HMS Patient Visit Nos".getfilter("Doctor ID"));
                if PatVisits.find('-') then
                    PatVisits.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            begin
                UpdatePatientVisits("HMS Patient"."Patient No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PostInv; PostInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Invoice';
                    ToolTip = 'Specifies the value of the Post Invoice field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustL2: Record "Cust. Ledger Entry";
        Insurance: Record Customer;
        objPatCharges: Record "HMS Patient Charges";
        PostInv: Boolean;
        dtVDate: Date;
        InsuranceNM: Text;

    local procedure UpdatePatientVisits(PatNo: Code[20])
    var
        HmsPatCharges: Record "HMS Patient Charges";
        PatVisits: Record "HMS Patient Visit Nos";
        PatVisits2: Record "HMS Patient Visit Nos";
        HMSSetup: Record "HMS Setup";
        Noseries: Codeunit NoSeriesManagement;
        NewNo: code[20];
    begin
        HMSSetup.get();
        HMSSetup.TestField("Doctors Posting Nos");
        HmsPatCharges.Reset();
        HmsPatCharges.SetRange(HmsPatCharges."Patient No.", PatNo);
        HmsPatCharges.SetRange(HmsPatCharges.Medicentre, false);
        // HmsPatCharges.SetRange(HmsPatCharges.Claimed, false);
        HmsPatCharges.SetFilter(HmsPatCharges."Visit No", '<>%1', '');
        HmsPatCharges.SetFilter(HmsPatCharges."Doctor Comm%", '>%1', 0);
        HmsPatCharges.SetFilter(HmsPatCharges."Visit Exists in VendL", '%1', false);
        HmsPatCharges.SetFilter(HmsPatCharges."Posting No Exists in VendL", '%1', false);
        if "HMS Patient Visit Nos".GetFilter("Doctor ID") <> '' then
            HmsPatCharges.SetFilter(HmsPatCharges."Doctor ID", "HMS Patient Visit Nos".GetFilter("Doctor ID"));

        if HmsPatCharges.Find('-') then
            repeat
                PatVisits.reset();
                PatVisits.setrange("Patient No", HmsPatCharges."Patient No.");
                PatVisits.setrange("Visit No", HmsPatCharges."Visit No");
                PatVisits.setrange("Doctor ID", HmsPatCharges."Doctor ID");
                PatVisits.setrange(Completed, false);
                if PatVisits.find('-') then begin
                    PatVisits.CalcFields("Doctor Amount");
                    if PatVisits."Doctor Amount" > 0 then begin
                        NewNo := Noseries.GetNextNo(HMSSetup."Doctors Posting Nos", 0D, TRUE);

                        PatVisits2.Init();
                        PatVisits2."Patient No" := HmsPatCharges."Patient No.";
                        PatVisits2."Visit No" := HmsPatCharges."Visit No";
                        PatVisits2."Doctor ID" := HmsPatCharges."Doctor ID";
                        PatVisits2."Posting No" := NewNo;
                        PatVisits2."Charge Posting No" := HmsPatCharges."Posting Document No";
                        PatVisits2.Insert();
                    end;
                end else begin
                    // if not PatVisits.Get(HmsPatCharges."Patient No.", HmsPatCharges."Visit No", HmsPatCharges."Doctor ID") then begin
                    NewNo := Noseries.GetNextNo(HMSSetup."Doctors Posting Nos", 0D, TRUE);
                    PatVisits2.Init();
                    PatVisits2."Patient No" := HmsPatCharges."Patient No.";
                    PatVisits2."Visit No" := HmsPatCharges."Visit No";
                    PatVisits2."Doctor ID" := HmsPatCharges."Doctor ID";
                    PatVisits2."Posting No" := NewNo;
                    PatVisits2."Charge Posting No" := HmsPatCharges."Posting Document No";
                    PatVisits2.Insert();
                end;
            until HmsPatCharges.Next() = 0;
    end;

    local procedure UpdateDoctorInvoiceNew(PatNo: Code[20]; VisitNo: Code[20]; DoctorID: Code[20])
    var
        USetup: Record "Cash Office User Template";
        DefaultBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        PatientCharges: Record "HMS Patient Charges";
        HmsPatVisits: Record "HMS Patient Visit Nos";
        JBatch: Code[10];
        JTemplate: Code[10];
        pDate: Date;
        LineNo: Integer;
    begin

        USetup.Reset();
        USetup.SetRange(USetup.UserID, UserId);
        if USetup.FindFirst() then begin
            if USetup."Receipt Journal Template" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Receipt Journal Batch" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Default Receipts Bank" = '' then;
            JTemplate := 'GENERAL';//USetup."Receipt Journal Template";
            JBatch := 'DOCTOR';//USetup."Receipt Journal Batch";
        end
        else
            Error('Please ensure that the Administrator sets you up as a cashier');

        if DefaultBatch.Get(JTemplate, JBatch) then
            DefaultBatch.Delete();

        DefaultBatch.Reset();
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.Insert();

        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('-') then
            GenJnlLine.DeleteAll();
        /*
              // Delete existing transactions
              VendL.RESET;
              VendL.SETRANGE(VendL."Document No.",VisitNo);
              VendL.SETRANGE(VendL."External Document No.",PatNo);
              IF VendL.FIND('-') THEN BEGIN
                pDate:=VendL."Posting Date";
                VendL.DELETEALL;
              END;

              VendD.RESET;
              VendD.SETRANGE(VendD."Document No.",VisitNo);
              VendD.SETRANGE(VendD."Posting Date",pDate);
              IF VendD.FIND('-') THEN BEGIN
                 VendD.DELETEALL;
              END;

              GlEntry.RESET;
              GlEntry.SETRANGE(GlEntry."Document No.",VisitNo);
              GlEntry.SETRANGE(GlEntry."Posting Date",pDate);
              IF GlEntry.FIND('-') THEN BEGIN
                 GlEntry.DELETEALL;
              END;
          */
        if pDate = 0D then
            pDate := Today;

        HmsPatVisits.Reset();
        HmsPatVisits.SetRange(HmsPatVisits."Patient No", PatNo);
        HmsPatVisits.SetRange(HmsPatVisits."Visit No", VisitNo);
        HmsPatVisits.SetRange(HmsPatVisits."Doctor ID", DoctorID);
        HmsPatVisits.SetRange(HmsPatVisits.Posted, false);
        if HmsPatVisits.Find('-') then begin
            repeat
                HmsPatVisits.CalcFields("Doctor Amount");
                LineNo := LineNo + 100;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := pDate;
                GenJnlLine."Document No." := VisitNo;
                // GenJnlLine."Document Date":="Document Date";
                GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                GenJnlLine."Account No." := HmsPatVisits."Doctor ID";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := HmsPatVisits."Patient No";
                // GenJnlLine."Currency Code":="Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine.Amount := HmsPatVisits."Doctor Amount" * -1;
                GenJnlLine.Validate(GenJnlLine.Amount);
                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := "HMS Patient".Surname + ' ' + "HMS Patient"."Last Name";
                // GenJnlLine."Shortcut Dimension 1 Code":=HmsPatCharges."Shortcut Dimension 1 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // GenJnlLine."Shortcut Dimension 2 Code":=HmsPatCharges."Shortcut Dimension 2 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
                //Balance Account
                LineNo := LineNo + 100;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := pDate;
                GenJnlLine."Document No." := HmsPatVisits."Visit No";
                // GenJnlLine."Document Date":="Document Date";
                GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                GenJnlLine."Account No." := '203001';
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := HmsPatVisits."Patient No";
                //  GenJnlLine."Currency Code":="Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine.Amount := HmsPatVisits."Doctor Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := "HMS Patient".Surname + ' ' + "HMS Patient"."Last Name";
                //  GenJnlLine."Shortcut Dimension 1 Code":=HmsPatCharges."Shortcut Dimension 1 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                //  GenJnlLine."Shortcut Dimension 2 Code":=HmsPatCharges."Shortcut Dimension 2 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                // GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();

                PatientCharges.Reset();
                PatientCharges.SetRange(PatientCharges."Patient No.", PatNo);
                PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
                if PatientCharges.Find('-') then
                    repeat
                        PatientCharges.Claimed := true;
                        PatientCharges."Claim Receipt No" := UserId;
                        PatientCharges.Modify();
                    until PatientCharges.Next() = 0;
                HmsPatVisits.Posted := true;
                HmsPatVisits.Modify();
            until HmsPatVisits.Next() = 0;

            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            if GenJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Bill", GenJnlLine);
        end;
    end;

    local procedure CheckifPaid(VisitNo: Code[20]; PatNo: Code[20]) IsPaid: Boolean
    var
        PatCharges: Record "HMS Patient Charges";
    begin
        IsPaid := false;
        PatCharges.Reset();
        PatCharges.SetRange(PatCharges."Visit No", VisitNo);
        PatCharges.SetRange(PatCharges."Patient No.", PatNo);
        if PatCharges.Find('-') then begin
            PatCharges.CalcFields(PatCharges."Invoice Entry No");
            PatCharges.CalcFields(PatCharges."Insurance Paid Amount");
            PatCharges.CalcFields(PatCharges."Visit Balance");
            if PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance" < 1 then
                IsPaid := true
            else begin // Check if Invoice is fully applied (NHIF)
                CustL2.Reset();
                CustL2.SetRange(CustL2."Document No.", PatCharges."Invoice Number");
                if CustL2.Find('-') then begin
                    CustL2.CalcFields(CustL2."Remaining Amount");
                    if CustL2."Remaining Amount" < 1 then
                        IsPaid := true;
                end;
            end;
        end;

        if IsPaid = false then begin
            "HMS Patient Visit Nos"."Corp Balance" := PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance";
            "HMS Patient Visit Nos".Modify();
        end;
    end;
}
