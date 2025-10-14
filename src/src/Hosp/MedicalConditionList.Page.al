Page 52202425 "Medical Condition List"
{
    PageType = List;
    SourceTable = "Medical Condition";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
                field(Family; Rec.Family)
                {
                    ToolTip = 'Specifies the value of the Family field.';
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
