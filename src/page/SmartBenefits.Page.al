page 85817 "Smart Benefits"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Smart Benefits";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(Benefit; Rec.Benefit)
                {
                    ToolTip = 'Specifies the value of the Benefit field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(PreAuthNeeded; Rec.PreAuthNeeded)
                {
                    ToolTip = 'Specifies the value of the PreAuthNeeded field.';
                }
                field(Claimable; Rec.Claimable)
                {
                    ToolTip = 'Specifies the value of the Claimable field.';
                }
                field("DateTime Retrieved"; Rec."DateTime Retrieved")
                {
                    ToolTip = 'Specifies the value of the DateTime Retrieved field.';
                }
                field("Policy ID"; Rec."Policy ID")
                {
                    ToolTip = 'Specifies the value of the Policy ID field.';
                }
                field("Global ID"; Rec."Global ID")
                {
                    ToolTip = 'Specifies the value of the Global ID field.';
                }
                field("Pool No"; Rec."Pool No")
                {
                    ToolTip = 'Specifies the value of the Pool No field.';
                }
            }
        }
    }

    actions
    {
    }
}
