// namespace PTL.Hospital;

report 52202694 "Sync Doctor Charges"
{
    ApplicationArea = All;
    Caption = 'Sync Doctor Charges';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where(Posted = filter(true), "Transaction Type" = filter('PROCEDURES'));

            trigger OnAfterGetRecord()
            begin
                if HMSPatientCharges."Doctors Amount" > 15000 then begin
                    HMSPatientCharges."Doctors Amount" := 0;
                    HMSPatientCharges.Modify();
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
