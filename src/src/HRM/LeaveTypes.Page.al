Page 52203090 "Leave Types"
{
    PageType = List;
    SourceTable = "Leave Types";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the value of the Days field.';
                }
                field(UnlimitedDays; Rec."Unlimited Days")
                {
                    ToolTip = 'Specifies the value of the Unlimited Days field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field(MaxCarryForwardDays; Rec."Max Carry Forward Days")
                {
                    ToolTip = 'Specifies the value of the Max Carry Forward Days field.';
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Non Working Days field.', Comment = '%';
                }
                field(InclusiveofHolidays; Rec."Inclusive of Holidays")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Holidays field.';
                }
                field(InclusiveofSaturday; Rec."Inclusive of Saturday")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Saturday field.';
                }
                field(InclusiveofSunday; Rec."Inclusive of Sunday")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Sunday field.';
                }
                field(OffHolidaysDaysLeave; Rec."Off/Holidays Days Leave")
                {
                    ToolTip = 'Specifies the value of the Off/Holidays Days Leave field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
