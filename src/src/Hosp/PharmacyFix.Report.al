namespace PTL.HMISBC;

report 52202717 "Pharmacy Fix"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Fix';
    UsageCategory = Tasks;
    Processingonly = true;
    dataset
    {
        dataitem(HMSPharmacyHeader; "HMS Pharmacy Header")
        {
            DataItemTableView = where(Status = filter(New));
            column(PharmacyNo; "Pharmacy No.")
            {
            }
            column(PharmacyDate; "Pharmacy Date")
            {
            }
            column(LinkNo; "Link No.")
            {
            }
            column(Surname; Surname)
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
                HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
                HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
                HMSPharmacyLine: Record "HMS Pharmacy Line";
                Juzi: date;
            begin
                // juzi := CalcDate('<-1D>', Today);
                if "Pharmacy Date" < Today then begin
                    HMSPharmacyLine.Reset();
                    HMSPharmacyLine.SetRange("Pharmacy No.", HMSPharmacyHeader."Pharmacy No.");
                    if HMSPharmacyLine.FindSet() then
                        repeat
                            HMSPharmacyLine.Delete()
                        until HMSPharmacyLine.Next() = 0;
                    HMSPharmacyHeader.Delete();
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
