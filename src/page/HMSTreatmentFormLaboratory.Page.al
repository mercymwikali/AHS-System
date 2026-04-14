Page 85473 "HMS Treatment Form Laboratory"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Laboratory";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(LaboratoryTestPackageCode; Rec."Laboratory Test Package Code")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Package Code field.';
                }
                field(LaboratoryTestPackageName; Rec."Laboratory Test Package Name")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Package Name field.';
                }
                field(DateDue; Rec."Date Due")
                {
                    ToolTip = 'Specifies the value of the Date Due field.';
                }
                field(Results; Rec.Results)
                {
                    ToolTip = 'Specifies the value of the Results field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RequestTests)
            {
                Caption = '&Request Tests';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Request Tests action.';

                trigger OnAction()
                var
                    CuHMSProcess: Codeunit "HMS Processes";
                begin
                    /*Send the request now?*/
                    CuHMSProcess.RequestLaboratoryTests(Rec);
                end;
            }
        }
    }

    var
        LabHeader: Record "HMS Laboratory Form Header";
        labheader2: Record "HMS Laboratory Form Header";
        LabTestLines: Record "HMS Laboratory Test Line";
        HMSSetup: Record "HMS Setup";
        LabSpecimenSetup: Record "HMS Setup Test Specimen";
        TreatmentHeader: Record "HMS Treatment Form Header";
        DocLabRequestLines: Record "HMS Treatment Form Laboratory";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
}
