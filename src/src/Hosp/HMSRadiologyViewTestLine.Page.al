Page 52202889 "HMS Radiology View Test Line"
{
    Editable = false;
    PageType = Document;
    SourceTable = "HMS Radiology Form Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(RadiologyTypeCode; Rec."Radiology Type Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Radiology Type Code field.';
                }
                field(RadiologyTypeName; Rec."Radiology Type Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Radiology Type Name field.';
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                }
                field(PerformedDate; Rec."Performed Date")
                {
                    ToolTip = 'Specifies the value of the Performed Date field.';
                }
                field(PerformedTime; Rec."Performed Time")
                {
                    ToolTip = 'Specifies the value of the Performed Time field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RadiologyImages)
            {
                Caption = 'Radiology Image(s)';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Radiology Image(s) action.';

                trigger OnAction()
                begin
                    RadiologyLine.Reset();
                    RadiologyLine.SetRange(RadiologyLine."Radiology no.", Rec."Radiology no.");
                    RadiologyLine.SetRange(RadiologyLine."Radiology Type Code", Rec."Radiology Type Code");
                    Page.Run(52573, RadiologyLine);
                end;
            }
        }
    }

    var
        RadiologyLine: Record "HMS Radiology Form Line";
}
