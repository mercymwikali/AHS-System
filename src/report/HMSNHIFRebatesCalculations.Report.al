Report 85094 "HMS NHIF Rebates Calculations"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            RequestFilterFields = "Patient No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(PatientNo_HMSPatient; "HMS Patient"."Patient No.")
            {
            }
            column(Names_HMSPatient; "HMS Patient".Names)
            {
            }

            trigger OnAfterGetRecord()
            var
                HMSProcesses: Codeunit "HMS Processes";
            begin
                if "charge Date" = 0D then
                    Error('Kindly specify the date to continue');
                if InsuranceCode = '' then
                    Error('Please Enter the prefered NHIF scheme to proceed');

                HMSProcesses.FnSHIFRebatesCalculation("HMS Patient", RebateAmount, "charge Date", InsuranceCode);

            end;

            trigger OnPreDataItem()
            begin
                if RebateAmount = 0 then
                    Error('Please enter the Rebate Amount');
                if PatientNo = '' then
                    Error('Enter the patient to proceed');

                "HMS Patient".SetFilter("HMS Patient"."Patient No.", PatientNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(RebateAmount; RebateAmount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allocation';
                    ToolTip = 'Specifies the value of the Allocation field.';
                }
                field(InsuranceCode; InsuranceCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Insurance Code';
                    TableRelation = Customer."No.";
                    ToolTip = 'Specifies the value of the Insurance Code field.';
                }
                field(PatientNo; PatientNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Patient No';
                    TableRelation = "HMS Patient"."Patient No.";
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(ChargeDate; "charge Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Charge Date';
                    ToolTip = 'Specifies the value of the Charge Date field.';
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
        HMSPatIns: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
        InsuranceCode: Code[20];
        PatientNo: Code[20];
        "charge Date": Date;
        RebateAmount: Decimal;
}
