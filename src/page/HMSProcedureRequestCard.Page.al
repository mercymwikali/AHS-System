namespace PTL.HMIS;
using HMISBC.HMISBC;

page 85556 "HMS Procedure Request Card"
{
    ApplicationArea = All;
    Caption = 'HMS Procedure Request Card';
    PageType = Card;
    SourceTable = "HMS Procedure Requests";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }
                field("Link No"; Rec."Link No")
                {
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
            }
            group(Notes)
            {
                Caption = 'Notes';

                field("Procedure Notes"; Rec."Procedure Notes")
                {
                    ToolTip = 'Specifies the value of the Procedure Notes field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(MarkAsdone)
            {
                Caption = 'Mark As Done';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Mark As Done action.';
                trigger OnAction()
                var
                    HMSProcessCu: Codeunit "HMS Processes";
                begin
                    HMSProcessCu.FnCompleteRequestProcedureTest(Rec);
                end;
            }
        }
    }

}
