namespace PTL.Hospital;

report 52202692 "Close Triage List"
{
    ApplicationArea = All;
    Caption = 'Close Triage List';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(HMSObservationFormHeader; "HMS Observation Form Header")
        {
            column(ObservationNo; "Observation No.")
            {
            }
            column(ObservationType; "Observation Type")
            {
            }
            column(Status; Status)
            {
            }
            trigger OnAfterGetRecord()
            begin
                HMSObservationFormHeader.Status := HMSObservationFormHeader.Status::Closed;
                HMSObservationFormHeader.Modify();
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
