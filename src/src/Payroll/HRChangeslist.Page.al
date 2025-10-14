Page 52202806 "HR Changes list"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "HR Change Entries";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Integer"; Rec.Integer)
                {
                    ToolTip = 'Specifies the value of the Integer field.';
                }
                field(employeeNo; Rec."employee No")
                {
                    ToolTip = 'Specifies the value of the employee No field.';
                }
                field(ChangeDate; Rec."Change Date")
                {
                    ToolTip = 'Specifies the value of the Change Date field.';
                }
                field(ChangeDescription; Rec."Change Description")
                {
                    ToolTip = 'Specifies the value of the Change Description field.';
                }
                field(OldValue; Rec."Old Value")
                {
                    ToolTip = 'Specifies the value of the Old Value field.';
                }
                field(NewValue; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field.';
                }
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                }
            }
        }
    }

    actions
    {
    }
}
