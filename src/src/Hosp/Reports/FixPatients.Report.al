namespace PTL.Hospital;

report 52202740 "Fix Patients"
{
    ApplicationArea = All;
    Caption = 'Fix Patients';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatient; "HMS Patient")
        {
            DataItemTableView = where(Activated = filter(false));
            trigger OnAfterGetRecord()
            begin
                if not HMSPatient.Activated then begin

                    HMSPatient."Active Visit No" := '';
                    HMSPatient.Inpatient:= false;
                    HMSPatient."Current Adm No" := '';
                    HMSPatient.Modify();
                end
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
