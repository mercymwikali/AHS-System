Page 52202667 "HMS Patient Insurance"
{
    PageType = List;
    SourceTable = "HMS Patient Insuarance";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(InsuranceNo; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field(InsuranceName; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(MemberNo; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.', Comment = '%';
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(setAsDefault)
            {
                ApplicationArea = All;
                Caption = 'Set as Default';
                Promoted = true;
                PromotedCategory = Process;
                image = Default;
                ToolTip = 'Executes the Set as Default action.';

                trigger OnAction()
                var
                    HMSProcessesCU: Codeunit "HMS Processes";
                begin
                    HMSProcessesCU.SetDefaultPatientInsurance(Rec);
                end;
            }
        }
    }
}
