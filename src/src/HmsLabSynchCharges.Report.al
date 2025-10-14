namespace PTL.Hospital;

report 52202738 "Hms Lab Synch Charges"
{
    ApplicationArea = All;
    Caption = 'Hms Lab Synch Charges';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSSetupLabTest; "HMS Setup Lab Test")
        {
            column(Code; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(GLAccount; "G/L Account")
            {
            }
            column(Amount; Amount)
            {
            }
            column(InsuranceAmount; "Insurance Amount")
            {
            }
            column(Department; Department)
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSCharges: Record "HMS Charges";
            begin
                HMSCharges.Reset();
                HMSCharges.SetRange(Code, HMSSetupLabTest.Code);
                if HMSCharges.FindFirst() then begin
                    HMSCharges.Amount := HMSSetupLabTest.Amount;
                    HMSCharges.Modify();
                end;
            end;
            trigger OnPostDataItem()
            begin
                Message('done');
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
