namespace PTL.HMIS;
using Microsoft.Foundation.NoSeries;

report 85146 "Sync Lab with Patient Charges"
{
    ApplicationArea = All;
    Caption = 'Sync Lab with Patient Charges';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Laboratory Test Line"; "HMS Laboratory Test Line")
        {
            DataItemTableView = where(Completed = filter(true));

            trigger OnAfterGetRecord()
            var
                HMSTreatmentFormLaboratory: Record "HMS Treatment Form Laboratory";
            begin
                if "HMS Laboratory Test Line"."Completion Date" = Today then begin
                    HMSTreatmentFormLaboratory.Reset();
                    HMSTreatmentFormLaboratory.SetRange("Lab No", "HMS Laboratory Test Line"."Laboratory No.");
                    HMSTreatmentFormLaboratory.SetRange("Laboratory Test Package Code", "HMS Laboratory Test Line"."Laboratory Test Code");
                    if HMSTreatmentFormLaboratory.FindFirst() then begin
                        HMSTreatmentFormLaboratory.Status := HMSTreatmentFormLaboratory.Status::Completed;
                        HMSTreatmentFormLaboratory.Modify();
                    end;
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
    var
        HMSLaboratoryTestLine: Record "HMS Laboratory Test Line";
        HMSLaboratoryTestLine2: Record "HMS Laboratory Test Line";
        HMSLaboratoryFormHeader: Record "HMS Laboratory Form Header";
        HMSLaboratoryFormHeader2: Record "HMS Laboratory Form Header";
}
