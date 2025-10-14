namespace PTL.HMIS;
using HMISBC.HMISBC;

page 52203193 "HMS Procedure Request List"
{
    ApplicationArea = All;
    Caption = 'HMS Procedure Request List';
    PageType = ListPart;
    SourceTable = "HMS Procedure Requests";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Link No"; Rec."Link No")
                {
                    Caption = 'Observation No';
                    ToolTip = 'Specifies the value of the Link No field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field("Procedure Type"; Rec."Procedure Type")
                {
                    ToolTip = 'Specifies the value of the Procedure Type field.', Comment = '%';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Doctors Name"; Rec."Doctors Name")
                {
                    ToolTip = 'Specifies the value of the Doctors Name field.', Comment = '%';
                }
                field("Procedure Date"; Rec."Procedure Date")
                {
                    ToolTip = 'Specifies the value of the Procedure Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RequestProcedure)
            {
                ApplicationArea = All;
                Caption = 'Request Procedure';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Register;
                ToolTip = 'Executes the Request Procedure action.';
                trigger OnAction()
                var
                    HMSProcess: Codeunit "HMS Processes";
                begin
                    HMSProcess.FnRequestProcedureTest(Rec);
                end;
            }
        }
    }
}
