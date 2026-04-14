namespace PTL.Hospital;

report 85101 hmspatientchargevalidate
{
    ApplicationArea = All;
    Caption = 'hmspatientchargevalidate';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            RequestFilterFields = "Visit No", "Patient No.";
            column(PatientNo; "Patient No.")
            {
            }
            column(Code; "Code")
            {
            }
            column(Date; "Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                // HMSPatientCharges.Validate(Quantity);
                // HMSPatientCharges.Modify();
                HMSPatientCharges."Total Amount" := Round(HMSPatientCharges.Amount, 1, '=') * HMSPatientCharges.Quantity;
                HMSPatientCharges.Modify();
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
    trigger OnPostReport()
    begin
        Message('done');
    end;
}
