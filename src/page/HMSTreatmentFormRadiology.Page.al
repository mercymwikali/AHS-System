Page 85475 "HMS Treatment Form Radiology"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Radiology";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(RadiologyTypeCode; Rec."Radiology Type Code")
                {
                    ToolTip = 'Specifies the value of the Radiology Type Code field.';
                }
                field(RadiologyTypeName; Rec."Radiology Type Name")
                {
                    ToolTip = 'Specifies the value of the Radiology Type Name field.';
                }
                field(DateDue; Rec."Date Due")
                {
                    ToolTip = 'Specifies the value of the Date Due field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
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
                    CuHMSProcess.FnRequestRadiologyTests(Rec);
                end;
            }
        }
    }

    var
        RadiologyHeader: Record "HMS Radiology Form Header";
        RadiologyLine: Record "HMS Radiology Form Line";
        HMSSetup: Record "HMS Setup";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Radiology";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
}
