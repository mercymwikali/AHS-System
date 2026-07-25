page 85161 "HMS Charge Weiver Card"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "HMS Patient Charges Weiver";
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field("Patient Names"; Rec."Patient Names")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field("Visit No"; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Initial Amount"; Rec."Initial Amount")
                {
                    ToolTip = 'Specifies the value of the Initial Amount field.';
                }
                field("Approval Remarks"; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}