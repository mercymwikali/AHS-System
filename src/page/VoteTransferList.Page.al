Page 85274 "Vote Transfer List"
{
    CardPageID = "Votebook Transfer";
    Editable = false;
    PageType = List;
    SourceTable = "Vote Transfer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(SourceVote; Rec."Source Vote")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Source Vote field.';
                }
                field(DestinationVote; Rec."Destination Vote")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Destination Vote field.';
                }
                field(BudgetName; Rec."Budget Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Budget Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(SourceDimmension1; Rec."Source Dimmension 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Source Dimmension 1 field.';
                }
                field(DestinationDimmension1; Rec."Destination Dimmension 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Destination Dimmension 1 field.';
                }
                field(SourceDimmension2; Rec."Source Dimmension 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Source Dimmension 2 field.';
                }
                field(DestinationDimmension2; Rec."Destination Dimmension 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Destination Dimmension 2 field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(PostedDate; Rec."Posted Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Date field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control16; "Budget Matrix")
            {
            }
            systempart(Control17; Notes)
            {
            }
            systempart(Control18; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup19)
            {
                action(sendApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    var
                        VarVariant: Variant;
                    begin

                        Rec.TestField(Posted, false);

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(cancellsApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Re&quest action.';

                    trigger OnAction()

                    begin

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
        }
    }

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}
