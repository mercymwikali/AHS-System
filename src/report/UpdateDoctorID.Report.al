namespace PTL.Hospital;

report 85002 "Update Doctor ID"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    Caption = 'Update Doctor ID';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {

            trigger OnAfterGetRecord()
            begin
                TreatHeader.Reset();
                TreatHeader.SetRange(TreatHeader."Treatment No.", "Visit No");
                TreatHeader.SetRange(TreatHeader."Patient No.", "Patient No.");
                IF TreatHeader.Find('-') then begin
                    "Doctor ID" := TreatHeader."Doctor ID";
                    Modify();
                end;

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
    var
        TreatHeader: Record "HMS Treatment Form Header";
}
