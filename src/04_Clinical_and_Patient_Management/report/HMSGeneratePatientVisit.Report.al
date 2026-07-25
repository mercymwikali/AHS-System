report 85175 "HMS Generate Patient Visit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HMS Generate Patient Visit.rdl';

    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            PrintOnlyIfDetail = true;
            dataitem("HMS Patient Visit Nos"; "HMS Patient Visit Nos")
            {
                DataItemLink = "Patient No" = FIELD("Patient No.");
                DataItemTableView = ORDER(Ascending)
                                    WHERE("Doctor Amount All" = FILTER(> 0),
                                          "Doctor ID" = FILTER(<> ''));
                RequestFilterFields = "Doctor ID", Date, "Visit No", "Insurance No";
                column(Patient_No_HMSPatientVisitNos; "HMS Patient Visit Nos"."Patient No")
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
                column(Names; Names)
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
                column(Names_HMSPatientVisitNos; Names)
                {
                }
                column(DoctorID_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor ID")
                {
                }
                column(DoctorName_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor Name")
                {
                }
                column(Date_HMSPatientVisitNos; "HMS Patient Visit Nos".Date)
                {
                }
                column(Doctor_Amount_Posted; "Doctor Amount Posted")
                {
                }
                column(Doctor_Amount_All; "Doctor Amount All")
                {
                }
                column(Doctor_Amount_Posting; "Doctor Amount Posting")
                {
                }
                column(Posting_No; "Posting No")
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

                    dtVDate := Date;

                    IF dtVDate = 0D THEN BEGIN
                        objPatCharges.RESET();
                        objPatCharges.SETRANGE(objPatCharges."Visit No", "Visit No");
                        IF objPatCharges.FIND('-') THEN
                            dtVDate := objPatCharges.Date;
                    END;

                    CALCFIELDS("Insurance No");

                    IF Insurance.GET("Insurance No") THEN
                        InsuranceNM := Insurance.Name;
                    IF InsuranceNM = '' THEN
                        InsuranceNM := 'Cash';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                UpdatePatientVisits("Patient No.");
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
    begin
        HmsPatCharges.RESET();
        HmsPatCharges.SETRANGE(HmsPatCharges."Patient No.", PatNo);
        HmsPatCharges.SETRANGE(HmsPatCharges.Medicentre, FALSE);
        // HmsPatCharges.SETRANGE(HmsPatCharges.Sunflash,FALSE);
        HmsPatCharges.SETFILTER(HmsPatCharges."Visit No", '<>%1', '');
        // HmsPatCharges.SETFILTER(HmsPatCharges."Doctor Comm%",'>%1',0);
        IF "HMS Patient Visit Nos".GETFILTER("Doctor ID") <> '' THEN
            HmsPatCharges.SETFILTER(HmsPatCharges."Doctor ID", "HMS Patient Visit Nos".GETFILTER("Doctor ID"));

        IF HmsPatCharges.FIND('-') THEN
            REPEAT

                HmsPatCharges.CALCFIELDS("Doctor Comm%");
                /*
               IF (HmsPatCharges."Doctors Amount"=0) AND (HmsPatCharges."Doctor Comm%">0) AND (HmsPatCharges."Doctor ID"<>'') THEN BEGIN
               HmsPatCharges."Doctors Amount":=HmsPatCharges."Total Amount"*(HmsPatCharges."Doctor Comm%"/100);
               HmsPatCharges.MODIFY;
              // ERROR('Test2');
               END;
               */
                IF HmsPatCharges."Doctors Amount" <> 0 THEN
                    IF NOT PatVisits.GET(HmsPatCharges."Patient No.", HmsPatCharges."Visit No", HmsPatCharges."Doctor ID") THEN BEGIN
                        PatVisits.INIT();
                        PatVisits."Patient No" := HmsPatCharges."Patient No.";
                        PatVisits."Visit No" := HmsPatCharges."Visit No";
                        PatVisits."Doctor ID" := HmsPatCharges."Doctor ID";
                        PatVisits.INSERT();
                    END;
            UNTIL HmsPatCharges.NEXT() = 0;
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

        USetup.RESET();
        USetup.SETRANGE(USetup.UserID, USERID);
        IF USetup.FINDFIRST() THEN BEGIN
            IF USetup."Receipt Journal Template" = '' THEN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
            IF USetup."Receipt Journal Batch" = '' THEN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
            IF USetup."Default Receipts Bank" = '' THEN;
            JTemplate := 'GENERAL';//USetup."Receipt Journal Template";
            JBatch := 'DOCTOR';//USetup."Receipt Journal Batch";
        END
        ELSE
            ERROR('Please ensure that the Administrator sets you up as a cashier');

        IF DefaultBatch.GET(JTemplate, JBatch) THEN
            DefaultBatch.DELETE();

        DefaultBatch.RESET();
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.INSERT();

        GenJnlLine.RESET();
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('-') THEN
            GenJnlLine.DELETEALL();
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
        IF pDate = 0D THEN
            pDate := TODAY;

        HmsPatVisits.RESET();
        HmsPatVisits.SETRANGE(HmsPatVisits."Patient No", PatNo);
        HmsPatVisits.SETRANGE(HmsPatVisits."Visit No", VisitNo);
        HmsPatVisits.SETRANGE(HmsPatVisits."Doctor ID", DoctorID);
        HmsPatVisits.SETRANGE(HmsPatVisits.Posted, FALSE);
        IF HmsPatVisits.FIND('-') THEN BEGIN
            REPEAT
                HmsPatVisits.CALCFIELDS("Doctor Amount");
                LineNo := LineNo + 100;
                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := pDate;
                GenJnlLine."Document No." := VisitNo;
                // GenJnlLine."Document Date":="Document Date";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                GenJnlLine."Account No." := HmsPatVisits."Doctor ID";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := HmsPatVisits."Patient No";
                // GenJnlLine."Currency Code":="Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine.Amount := HmsPatVisits."Doctor Amount" * -1;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := "HMS Patient".surname + ' ' + "HMS Patient"."Last Name";
                // GenJnlLine."Shortcut Dimension 1 Code":=HmsPatCharges."Shortcut Dimension 1 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                // GenJnlLine."Shortcut Dimension 2 Code":=HmsPatCharges."Shortcut Dimension 2 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT();
                //Balance Account
                LineNo := LineNo + 100;
                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := pDate;
                GenJnlLine."Document No." := HmsPatVisits."Visit No";
                // GenJnlLine."Document Date":="Document Date";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := '203001';
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := HmsPatVisits."Patient No";
                //  GenJnlLine."Currency Code":="Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine.Amount := HmsPatVisits."Doctor Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := "HMS Patient".Surname + ' ' + "HMS Patient"."Last Name";
                //  GenJnlLine."Shortcut Dimension 1 Code":=HmsPatCharges."Shortcut Dimension 1 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                //  GenJnlLine."Shortcut Dimension 2 Code":=HmsPatCharges."Shortcut Dimension 2 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                // GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT();

                PatientCharges.RESET();
                PatientCharges.SETRANGE(PatientCharges."Patient No.", PatNo);
                PatientCharges.SETRANGE(PatientCharges."Visit No", VisitNo);
                IF PatientCharges.FIND('-') THEN
                    REPEAT
                        PatientCharges.Claimed := TRUE;
                        PatientCharges."Claim Receipt No" := USERID;
                        PatientCharges.MODIFY();
                    UNTIL PatientCharges.NEXT() = 0;
                HmsPatVisits.Posted := TRUE;
                HmsPatVisits.MODIFY();
            UNTIL HmsPatVisits.NEXT() = 0;

            GenJnlLine.RESET();
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            IF GenJnlLine.FIND('-') THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
        END;
    end;

    local procedure CheckifPaid(VisitNo: Code[20]; PatNo: Code[20]) IsPaid: Boolean
    var
        PatCharges: Record "HMS Patient Charges";
    begin
        IsPaid := FALSE;
        PatCharges.RESET();
        PatCharges.SETRANGE(PatCharges."Visit No", VisitNo);
        PatCharges.SETRANGE(PatCharges."Patient No.", PatNo);
        IF PatCharges.FIND('-') THEN BEGIN
            PatCharges.CALCFIELDS(PatCharges."Invoice Entry No");
            PatCharges.CALCFIELDS(PatCharges."Insurance Paid Amount");
            PatCharges.CALCFIELDS(PatCharges."Visit Balance");
            IF PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance" < 1 THEN
                IsPaid := TRUE
            ELSE BEGIN // Check if Invoice is fully applied (NHIF)
                CustL2.RESET();
                CustL2.SETRANGE(CustL2."Document No.", PatCharges."Invoice Number");
                IF CustL2.FIND('-') THEN BEGIN
                    CustL2.CALCFIELDS(CustL2."Remaining Amount");
                    IF CustL2."Remaining Amount" < 1 THEN
                        IsPaid := TRUE;
                END;
            END;
        END;

        IF IsPaid = FALSE THEN BEGIN
            "HMS Patient Visit Nos"."Corp Balance" := PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance";
            "HMS Patient Visit Nos".MODIFY();
        END;
    end;
}
