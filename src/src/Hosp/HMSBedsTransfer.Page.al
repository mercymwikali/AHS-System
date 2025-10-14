Page 52202696 "HMS Beds Transfer"
{
    PageType = List;
    SourceTable = "HMS Beds Transfer";
    SourceTableView = where(Posted = filter(false));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(CurrentWard; Rec."Current Ward")
                {
                    ToolTip = 'Specifies the value of the Current Ward field.';
                }
                field(CurrentBedNo; Rec."Current Bed No")
                {
                    ToolTip = 'Specifies the value of the Current Bed No field.';
                }
                field(NewWard; Rec."New Ward")
                {
                    ToolTip = 'Specifies the value of the New Ward field.';
                }
                field(NewBedNo; Rec."New Bed No")
                {
                    ToolTip = 'Specifies the value of the New Bed No field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                Image = Post;
                ToolTip = 'Executes the Post Transfer action.';

                trigger OnAction()
                var
                    AdmH: Record "HMS Admission Form Header";
                    Charges: Record "HMS Charges";
                    Patient: Record "HMS Patient";
                    HMSPatientCharges: Record "HMS Patient Charges";
                    HMSSetup: Record "HMS Setup";
                    WardRec: Record "HMS Ward Setup";
                    CuHMSProcess: Codeunit "HMS Processes";
                begin
                    if (CuHMSProcess.FnPostBedTransferRequest(Rec)) then
                        Message('Posted successfully');
                end;
            }
        }
    }

    var
        "HMS Adm": Record "HMS Admission Form Header";
}
