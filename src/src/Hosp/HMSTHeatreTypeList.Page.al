Page 52202704 "HMS THeatre Type List"
{
    Caption = 'Procedure List';
    PageType = List;
    SourceTable = "HMS Theatre Types";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}
