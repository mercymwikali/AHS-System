Page 85567 "SMS Broadcast List1"
{
    CardPageID = "SMS Broadcast Card1";
    Editable = false;
    PageType = List;
    SourceTable = "SMS Broadcast";
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
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(SMSMessage; Rec."SMS Message")
                {
                    ToolTip = 'Specifies the value of the SMS Message field.';
                }
            }
        }
    }

    actions
    {
    }
}
