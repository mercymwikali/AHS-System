namespace PTL.Hospital;

report 52202727 "Validate Doctors Amount"
{
    ApplicationArea = All;
    Caption = 'Validate Doctors Amount';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(HMSTransactionscode; "HMS Transactions code")
        {
            column(TransactionType; "Transaction Type")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(CalculateDoctorFee; "Calculate Doctor Fee")
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSPatientCharges: Record "HMS Patient Charges";
            begin
                HMSPatientCharges.Reset();
                HMSPatientCharges.SetRange("Transaction Type", HMSTransactionscode."Transaction Type");
                if HMSPatientCharges.FindSet() then 
                repeat
                    HMSPatientCharges.Validate("Doctor ID");
                    HMSPatientCharges.Modify();
                until HMSPatientCharges.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
