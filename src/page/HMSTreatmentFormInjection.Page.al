Page 85472 "HMS Treatment Form Injection"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Injection";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(InjectionNo; Rec."Injection No.")
                {
                    ToolTip = 'Specifies the value of the Injection No. field.';
                }
                field(ItemNo; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(InjectionName; Rec."Injection Name")
                {
                    ToolTip = 'Specifies the value of the Injection Name field.';
                }
                field(InjectionGiven; Rec."Injection Given")
                {
                    ToolTip = 'Specifies the value of the Injection Given field.';
                }
                field(InjectionUnitofMeasure; Rec."Injection Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Injection Unit of Measure field.';
                }
                field(InjectionQuantity; Rec."Injection Quantity")
                {
                    ToolTip = 'Specifies the value of the Injection Quantity field.';
                }
                field(Duration; Rec.Duration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(InjectionRemarks; Rec."Injection Remarks")
                {
                    ToolTip = 'Specifies the value of the Injection Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PostItemUsage)
            {
                Caption = '&Post Item Usage';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Post Item Usage action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnPostInjectionItemsUsage(Rec);
                end;
            }
        }
    }

    var
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Injection";
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
}
