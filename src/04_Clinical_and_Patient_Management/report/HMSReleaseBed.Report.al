namespace PTL.Hospital;

report 85061 "HMS Release Bed"
{
    ApplicationArea = All;
    Caption = 'HMS Sync/Release Bed';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSBeds; "HMS Beds")
        {
            column(WardNo; "Ward No")
            {
            }
            column(BedNo; "Bed No")
            {
            }
            column(BedName; "Bed Name")
            {
            }
            column(Occupied; Occupied)
            {
            }
            column(RoomNo; "Room No")
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
            begin
                HMSBeds.Occupied := false;

                HMSAdmissionFormHeader.Reset();
                HMSAdmissionFormHeader.SetRange(Ward, HMSBeds."Ward No");
                HMSAdmissionFormHeader.SetRange("Ward Room", HMSBeds."Room No");
                HMSAdmissionFormHeader.SetRange(Bed, HMSBeds."Bed No");
                HMSAdmissionFormHeader.SetRange(Status, HMSAdmissionFormHeader.Status::Admitted);
                if HMSAdmissionFormHeader.FindFirst() then begin
                    HMSBeds.Occupied := true;
                end;

                HMSBeds.Modify();
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
