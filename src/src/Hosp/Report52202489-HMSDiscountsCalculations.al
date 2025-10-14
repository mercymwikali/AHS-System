report 52202489 "HMS Discounts Calculations"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            RequestFilterFields = "Patient No.", "Visit No Filter";
            column(PatientNo_HMSPatient; "HMS Patient"."Patient No.")
            {
            }
            column(Names_HMSPatient; "HMS Patient".Names)
            {
            }

            trigger OnAfterGetRecord()

            begin
                HMSSetup.get();
                HMSSetup.Testfield("Discount Exp. Account");
                "HMS Patient".CALCFIELDS("Open Insurance Amount");
                IF DiscAmount = 0 THEN
                    DiscAmount := "HMS Patient"."Open Insurance Amount" * (DiscPerc / 100);
                //IF InsuranceCode='' THEN ERROR('Please Enter the prefered Insurance scheme to proceed');

                HMSPatCharges.RESET();
                HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", "HMS Patient"."Patient No.");
                HMSPatCharges.SETFILTER(HMSPatCharges."Visit No", "HMS Patient".GETFILTER("HMS Patient"."Visit No Filter"));
                //HMSPatCharges.SETRANGE(HMSPatCharges.Posted,FALSE);
                IF HMSPatCharges.FIND('-') THEN BEGIN
                    HMSPatCharges2.INIT();
                    HMSPatCharges2."Transaction Type" := 'ZDISCOUNT';
                    HMSPatCharges2."Patient No." := "HMS Patient"."Patient No.";
                    HMSPatCharges2."Link No" := HMSPatCharges."Link No";
                    HMSPatCharges2."Treatment No." := HMSPatCharges."Treatment No.";
                    HMSPatCharges2."Appointment No." := HMSPatCharges."Appointment No.";
                    HMSPatCharges2.Code := 'Discount';
                    HMSPatCharges2.Description := 'Discount Given';
                    HMSPatCharges2.Amount := DiscAmount * -1;
                    HMSPatCharges2."Total Amount" := DiscAmount * -1;
                    HMSPatCharges2.Date := TODAY;
                    HMSPatCharges2.Quantity := 1;
                    HMSPatCharges2."Shortcut Dimension 1 Code" := "HMS Patient"."Global Dimension 1 Code";
                    HMSPatCharges2."Shortcut Dimension 2 Code" := 'Accounts';
                    HMSPatCharges2."G/L Account" := HMSSetup."Discount Exp. Account";
                    HMSPatCharges2."G/L Account No" := HMSSetup."Discount Exp. Account";
                    HMSPatCharges2."Insurance No" := InsuranceCode;
                    HMSPatCharges2."Insurance Amount" := DiscAmount * -1;
                    HMSPatCharges2."Visit No" := HMSPatCharges."Visit No";
                    HMSPatCharges2."Invoice Number" := HMSPatCharges."Invoice Number";
                    HMSPatCharges2.Posted := HMSPatCharges.Posted;
                    HMSPatCharges2.INSERT();
                END;
            end;

            trigger OnPreDataItem()
            begin
                //  IF DiscPerc=0 THEN ERROR('Please enter the discount percentage');
                //IF PatientNo='' THEN ERROR('Enter the patient to proceed');

                IF "HMS Patient".GETFILTER("HMS Patient"."Patient No.") = '' THEN
                    ERROR('Please select the Patient No');
                IF "HMS Patient".GETFILTER("HMS Patient"."Visit No Filter") = '' THEN
                    ERROR('Please select the Visit No');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(DiscPerc; DiscPerc)
                {
                    Caption = 'Discount Percentage';
                    ToolTip = 'Specifies the value of the Discount Percentage field.';
                }
                field(DiscAmount; DiscAmount)
                {
                    Caption = 'Discount Amount';
                    ToolTip = 'Specifies the value of the Discount Amount field.';
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
        HMSPatCharges: Record "HMS Patient Charges";
        HMSPatCharges2: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        InsuranceCode: Code[20];
        DiscAmount: Decimal;
        DiscPerc: Decimal;
}
