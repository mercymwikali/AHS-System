report 85176 "HMS Patient Invoice Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HMS Patient Invoice Summary.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = SORTING("Patient No.", "Transaction Type", Date)
                                ORDER(Ascending)
                                WHERE(Amount = FILTER(<> 0),
                                      Closed = CONST(false),
                                      "Receipt Reversed" = CONST(false));
            RequestFilterFields = "Patient No.", "Visit No", "Invoice Number";
            column(PatientNo_HMSPatientCharges; "HMS Patient Charges"."Patient No.")
            {
            }
            column(ShortcutDimension1Code_HMSPatientCharges; "HMS Patient Charges"."Shortcut Dimension 1 Code")
            {
            }
            column(TransactionType_HMSPatientCharges; TranType)
            {
            }
            column(Code_HMSPatientCharges; "HMS Patient Charges".Code)
            {
            }
            column(Description_HMSPatientCharges; "HMS Patient Charges".Description)
            {
            }
            column(TranDate; "HMS Patient Charges".Date)
            {
            }
            column(Amount_HMSPatientCharges; "HMS Patient Charges".Amount)
            {
            }
            column(Remarks_HMSPatientCharges; "HMS Patient Charges".Remarks)
            {
            }
            column(Qty; Qty)
            {
            }
            column(AmountPaid_HMSPatientCharges; "HMS Patient Charges"."Amount Paid")
            {
            }
            column(ShortcutDimension2Code_HMSPatientCharges; "HMS Patient Charges"."Shortcut Dimension 2 Code")
            {
            }
            column(AppliedAmount_HMSPatientCharges; "HMS Patient Charges"."Applied Amount")
            {
            }
            column(Applyto_HMSPatientCharges; "HMS Patient Charges"."Apply to")
            {
            }
            column(Recognized_HMSPatientCharges; "HMS Patient Charges".Recognized)
            {
            }
            column(Posted_HMSPatientCharges; "HMS Patient Charges".Posted)
            {
            }
            column(PharmacyNo_HMSPatientCharges; "HMS Patient Charges"."Pharmacy No")
            {
            }
            column(Location_HMSPatientCharges; "HMS Patient Charges".Location)
            {
            }
            column(Unit_HMSPatientCharges; "HMS Patient Charges"."Doctors Amount")
            {
            }
            column(RecoveredFirst_HMSPatientCharges; "HMS Patient Charges"."Recovered First")
            {
            }
            column(Transfer_HMSPatientCharges; "HMS Patient Charges".Transfer)
            {
            }
            column(TransferAmount_HMSPatientCharges; "HMS Patient Charges"."Transfer Amount")
            {
            }
            column(Transfered_HMSPatientCharges; "HMS Patient Charges".Transfered)
            {
            }
            column(TransactonID_HMSPatientCharges; "HMS Patient Charges"."Invoice ID")
            {
            }
            column(NoSeries_HMSPatientCharges; "HMS Patient Charges"."No. Series")
            {
            }
            column(FullyPaid_HMSPatientCharges; "HMS Patient Charges"."Fully Paid")
            {
            }
            column(RoomAllocation_HMSPatientCharges; "HMS Patient Charges"."Room Allocation")
            {
            }
            column(Charge_HMSPatientCharges; "HMS Patient Charges".Charge)
            {
            }
            column(Reversed_HMSPatientCharges; "HMS Patient Charges".Reversed)
            {
            }
            column(Distribution_HMSPatientCharges; "HMS Patient Charges".Distribution)
            {
            }
            column(Quantity_HMSPatientCharges; decQuantity)
            {
            }
            column(Course_HMSPatientCharges; "HMS Patient Charges"."Invoice Number")
            {
            }
            column(AppliedPayment_HMSPatientCharges; "HMS Patient Charges"."Applied Payment")
            {
            }
            column(RecoveryPriority_HMSPatientCharges; "HMS Patient Charges"."Recovery Priority")
            {
            }
            column(FullTuitionFee_HMSPatientCharges; "HMS Patient Charges"."Full Tuition Fee")
            {
            }
            column(DistributionAccount_HMSPatientCharges; "HMS Patient Charges"."Distribution Account")
            {
            }
            column(Currency_HMSPatientCharges; "HMS Patient Charges".Currency)
            {
            }
            column(OverCharged_HMSPatientCharges; "HMS Patient Charges"."Over Charged")
            {
            }
            column(OverChargedAmount_HMSPatientCharges; "HMS Patient Charges"."Over Charged Amount")
            {
            }
            column(SystemCreated_HMSPatientCharges; "HMS Patient Charges"."System Created")
            {
            }
            column(ChargeGender_HMSPatientCharges; "HMS Patient Charges"."Charge Gender")
            {
            }
            column(CustomerNo_HMSPatientCharges; "HMS Patient Charges"."Customer No.")
            {
            }
            column(BillSection_HMSPatientCharges; "HMS Patient Charges"."Bill Section")
            {
            }
            column(LineNo_HMSPatientCharges; "HMS Patient Charges"."Line No")
            {
            }
            column(GLAccount_HMSPatientCharges; "HMS Patient Charges"."G/L Account")
            {
            }
            column(TreatmentNo_HMSPatientCharges; "HMS Patient Charges"."Treatment No.")
            {
            }
            column(InvoiceCounter_HMSPatientCharges; "HMS Patient Charges"."Invoice Counter")
            {
            }
            column(ApplicableSection_HMSPatientCharges; "HMS Patient Charges"."Applicable Section")
            {
            }
            column(LinkNo_HMSPatientCharges; "HMS Patient Charges"."Link No")
            {
            }
            column(LinkNoLk_HMSPatientCharges; "HMS Patient Charges"."Link No Lk")
            {
            }
            column(AppointmentNo_HMSPatientCharges; "HMS Patient Charges"."Appointment No.")
            {
            }
            column(PatientTypeLk_HMSPatientCharges; "HMS Patient Charges"."Patient Type Lk")
            {
            }
            column(AppointmentNoLk_HMSPatientCharges; "HMS Patient Charges"."Appointment No Lk")
            {
            }
            column(BillingType_HMSPatientCharges; "HMS Patient Charges"."Billing Type")
            {
            }
            column(BillingStartDate_HMSPatientCharges; "HMS Patient Charges"."Billing Start Date")
            {
            }
            column(BillingEndDate_HMSPatientCharges; "HMS Patient Charges"."Billing End Date")
            {
            }
            column(AdmissionNo_HMSPatientCharges; "HMS Patient Charges"."Admission No")
            {
            }
            column(DoctorID_HMSPatientCharges; "HMS Patient Charges"."Doctor ID")
            {
            }
            column(DimensionSetID_HMSPatientCharges; "HMS Patient Charges"."Dimension Set ID")
            {
            }
            column(NewDimensionSetID_HMSPatientCharges; "HMS Patient Charges"."New Dimension Set ID")
            {
            }
            column(GLAccountNo_HMSPatientCharges; "HMS Patient Charges"."G/L Account No")
            {
            }
            column(DoctorsAmount_HMSPatientCharges; "HMS Patient Charges"."Doctors Amount")
            {
            }
            column(InsuranceAmount_HMSPatientCharges; "HMS Patient Charges"."Insurance Amount")
            {
            }
            column(RunBal; RunBal)
            {
            }
            column(InsNo; HMSPatRec."Insurance No.")
            {
            }
            column(InsName; HMSPatRec."Insurance Name")
            {
            }
            column(MemberNo; HMSPatRec."Membership No")
            {
            }
            column(PMemberName; HMSPatRec."Mother Full Name")
            {
            }
            column(AdmDate; AdmissionDates)
            {
            }
            column(dischargeDate; DischargeDates)
            {
            }
            column(Ward; Ward_)
            {
            }
            column(Bed; Beds_)
            {
            }
            column(InvoiceNo; "HMS Patient Charges"."Posted Invoice No.")
            {
            }
            column(PatName; HMSPatRec.Surname + ' ' + HMSPatRec."Last Name")
            {
            }
            column(Balance; HMSPatRec."Bill Balance")
            {
            }
            column(InvAmt; Round(InvAmt, 1, '='))
            {
            }
            column(RecAmt; Receipts)
            {
            }
            column(LogoName; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompInfAddress; CompInf.Address)
            {
            }
            column(CompInfAddress2; CompInf."Address 2")
            {
            }
            column(CompInfPhone; CompInf."Phone No.")
            {
            }
            column(UserN; USERID)
            {
            }
            column(Amt; Round(Amt, 1, '='))
            {
            }
            column(DocName; DocNM)
            {
            }
            column(UAmt; Round(UAmt, 1, '='))
            {
            }
            column(AdminNo; HMSPatRec."Current Ward")
            {
            }
            column(Names; HMSPatRec."Search Name")
            {
            }
            column(InsurancePaidAmount; "HMS Patient Charges"."Insurance Paid Amount")
            {
            }
            column(ClaimedTxt; ClaimedTxt)
            {
            }
            column(ClaimedAmount; ClaimedAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //Get bills
                /*PatientCharges.RESET;
                PatientCharges.SETRANGE(PatientCharges."Patient No.","Patient No.");
                PatientCharges.SETRANGE(PatientCharges.Closed,FALSE);
                PatientCharges.SETRANGE(PatientCharges.Posted,FALSE);
                PatientCharges.SETFILTER(PatientCharges.Amount,'>0');
                IF "HMS Patient Charges"."Visit No"<>'' THEN
                 PatientCharges.SETRANGE(PatientCharges."Visit No","HMS Patient Charges"."Visit No");
                IF PatientCharges.FIND('-') THEN REPEAT
                 Bills:=Bills+PatientCharges.Amount;
                UNTIL PatientCharges.NEXT=0;
                */

                //Get Receipts
                /*PatientCharges.RESET;
                PatientCharges.SETRANGE(PatientCharges."Patient No.","Patient No.");
                PatientCharges.SETFILTER(PatientCharges.Amount,'<0');
                IF "HMS Patient Charges"."Visit No"<>'' THEN
                 PatientCharges.SETRANGE(PatientCharges."Visit No","HMS Patient Charges"."Visit No");
                IF PatientCharges.FIND('-') THEN REPEAT
                 Receipts:=Receipts+PatientCharges.Amount;
                UNTIL PatientCharges.NEXT=0;
                */
                //************************************************************

                IF HMSPatRec.GET("HMS Patient Charges"."Patient No.") THEN BEGIN
                    HMSPatRec.SETFILTER(HMSPatRec."Appointment No Filter", "HMS Patient Charges"."Appointment No.");
                    HMSPatRec.CALCFIELDS(HMSPatRec."Current Ward");
                    IF HMSPatRec.Inpatient = FALSE THEN
                        "HMS Patient Charges".SETFILTER("HMS Patient Charges"."Visit No", GETFILTER("Visit No"));
                    //HMSPatRec.CALCFIELDS("Bill Balance");
                    //HMSPatRec.CALCFIELDS("Invoice Amount");
                    //HMSPatRec.CALCFIELDS("Receipt Amount");
                    IF Cust.GET(HMSPatRec."Insurance No.") THEN;
                        // IF Cust."Claimed Amount">0 THEN BEGIN
                        // ClaimedAmount := Cust."Claimed Amount";
                        // ClaimedTxt := 'Claimed Amount';
                        // END;
                END;
                IF "HMS Patient Charges".Quantity = 0 THEN
                    Qty := 1
                ELSE
                    Qty := "HMS Patient Charges".Quantity;
                Amt := 0;
                UAmt := 0;

                Amt := Round("HMS Patient Charges".Amount, 1, '=') * Qty;
                UAmt := Round("HMS Patient Charges".Amount, 1, '=');

                IF "HMS Patient Charges".Amount < 0 THEN
                    ReceiptAmt := ReceiptAmt + "HMS Patient Charges".Amount;

                IF "HMS Patient Charges".Amount > 0 THEN
                    IF "HMS Patient Charges"."Insurance Amount" > 0 THEN BEGIN
                        if Qty > 1 then begin
                            Amt := Round("HMS Patient Charges"."Insurance Amount", 1, '=');
                            UAmt := Round("HMS Patient Charges"."Insurance Amount", 1, '=') / Qty;
                            // RunBal:=RunBal+("HMS Patient Charges"."Insurance Amount"*Qty);
                        end else begin
                            Amt := Round("HMS Patient Charges"."Insurance Amount", 1, '=');
                            UAmt := Round("HMS Patient Charges"."Insurance Amount", 1, '=');
                        end;
                    END ELSE BEGIN
                        Amt := Round("HMS Patient Charges".Amount, 1, '=') * Qty;
                        UAmt := Round("HMS Patient Charges".Amount, 1, '=');
                    END;
                IF "HMS Patient Charges".Amount > 0 THEN
                    InvAmt := InvAmt + Amt;

                //Get Receipts
                PatientCharges.RESET();
                PatientCharges.SETRANGE(PatientCharges."Patient No.", "Patient No.");
                PatientCharges.SETFILTER(PatientCharges.Amount, '<0');
                PatientCharges.SETFILTER(PatientCharges."Visit No", GETFILTER("Visit No"));
                /*
                IF "HMS Patient Charges"."Visit No"<>'' THEN
                 PatientCharges.SETRANGE(PatientCharges."Visit No","HMS Patient Charges"."Visit No");
                 */
                IF PatientCharges.FIND('-') THEN
                    REPEAT
                        Receipts := Receipts + PatientCharges.Amount;
                    UNTIL PatientCharges.NEXT() = 0;

                RunBal := RunBal + Amt;
                Bal := RunBal;

                DocNM := '';

                IF DocRec.GET("HMS Patient Charges"."Doctor ID") THEN
                    DocNM := DocRec."Doctors Name" + ' (' + DocRec.Specialization + ')';
                AdmissionDates := '';
                DischargeDates := '';
                IF HMSPatRec."Admissions Date" <> 0D THEN
                    AdmissionDates := 'Admission Date: ' + FORMAT(HMSPatRec."Admissions Date");
                IF HMSPatRec."Discharge Date" <> 0D THEN
                    DischargeDates := 'Discharge Date: ' + FORMAT(HMSPatRec."Discharge Date");

                Ward_ := '';

                AdmRec.RESET();
                AdmRec.SETRANGE(AdmRec."Patient No.", "HMS Patient Charges"."Patient No.");
                AdmRec.SETRANGE(AdmRec.Status, AdmRec.Status::Admitted);
                IF AdmRec.FIND('-') THEN BEGIN
                    Ward_ := 'Ward: ' + AdmRec.Ward;
                    Beds_ := 'Bed: ' + AdmRec.Bed;
                END;

                IF "HMS Patient Charges"."Transaction Type" = 'ZRECEIPT' THEN BEGIN
                    TranType := 'RECEIPTS';
                    IF "HMS Patient Charges".Code = 'REBATES' THEN
                        TransDec := 'NHIF Rebates'
                    ELSE
                        TransDec := 'Payment Receipt';
                END ELSE BEGIN
                    TranType := "HMS Patient Charges"."Transaction Type";
                    TransDec := "HMS Patient Charges".Description;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.GET();
                CompInf.CALCFIELDS(Picture);
                /*
                HMSCharges.RESET;
                HMSCharges.SETFILTER(HMSCharges."Patient No.",GETFILTER("Patient No."));
                HMSCharges.SETFILTER(HMSCharges."Visit No",GETFILTER("Visit No"));
                IF HMSCharges.FIND('-') THEN BEGIN
                //  HMSPat.CalculateTotalCharges(HMSCharges."Patient No.");
                 // HMSPat.PostCharges(HMSCharges."Patient No.",HMSCharges."Visit No");
                END;
                */
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
    }

    var
        CompInf: Record "Company Information";
        Cust: Record Customer;
        AdmRec: Record "HMS Admission Form Header";
        HMSPatRec: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        DocRec: Record "HMS Setup Doctor";
        TranType: Code[20];
        Amt: Decimal;
        Bal: Decimal;
        ClaimedAmount: Decimal;
        decQuantity: Decimal;
        InvAmt: Decimal;
        Qty: Decimal;
        ReceiptAmt: Decimal;
        Receipts: Decimal;
        RunBal: Decimal;
        UAmt: Decimal;
        AdmissionDates: Text;
        Beds_: Text;
        ClaimedTxt: Text;
        DischargeDates: Text;
        DocNM: Text;
        Ward_: Text;
        TransDec: Text[100];
}
