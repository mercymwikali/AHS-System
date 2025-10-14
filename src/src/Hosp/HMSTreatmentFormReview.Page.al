namespace PTL.HMISBC;
using HMISBC.HMISBC;

page 52203190 "HMS Treatment Form Review"
{
    ApplicationArea = All;
    Caption = 'HMS Treatment Form Review';
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Review";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }
                field(Clinic; Rec.Clinic)
                {
                    ToolTip = 'Specifies the value of the Clinic field.', Comment = '%';
                }
                field("Doctor No."; Rec."Doctor No.")
                {
                    ToolTip = 'Specifies the value of the Doctor No. field.', Comment = '%';
                }
                field("Request Reason"; Rec."Request Reason")
                {
                    ToolTip = 'Specifies the value of the Request Reason field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PlaceRequest)
            {
                Caption = '&Place Request';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Place Request action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    if CuHMSProcesses.FnRequestDoctorReview(Rec) then
                        Message('Doctor review request placed successfully.');
                end;
            }
        }
    }
}
