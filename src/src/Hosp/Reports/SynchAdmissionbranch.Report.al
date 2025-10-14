// namespace PTL.HMISBC;

report 52202741 "Synch Admission - branch"
{
    ApplicationArea = All;
    Caption = 'Synch Admission - branch';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatient; "HMS Patient")
        {
            DataItemTableView = where(Inpatient = filter(true), Activated = filter(true));

            trigger OnAfterGetRecord()
            begin
                HMSAdmissionFormHeader.Reset();
                HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatient."Active Visit No");
                if HMSAdmissionFormHeader.FindFirst() then begin
                    if HMSAdmissionFormHeader.Branch <> HMSPatient."Global Dimension 1 Code" then begin
                        HMSAdmissionFormHeader.Branch := HMSPatient."Global Dimension 1 Code";
                        HMSAdmissionFormHeader.Modify();
                    end;
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
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSPharmacyHeader: Record "HMS Pharmacy Header";
}
