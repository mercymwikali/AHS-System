namespace PTL.Hospital;

report 85193 "Sync Discount Charges"
{
    ApplicationArea = All;
    Caption = 'Sync Discount Charges';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where(Code = filter('DISCOUNT'), "Visit No" = filter('APP_03020'));
            column(PatientNo; "Patient No.")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Code; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Date; "Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                HMSPatientCharges."Transaction Type" := 'ZDISCOUNT';
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
}
