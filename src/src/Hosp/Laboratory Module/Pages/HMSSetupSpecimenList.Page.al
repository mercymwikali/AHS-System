Page 52202846 "HMS Setup Specimen List"
{
    PageType = List;
    SourceTable = "HMS Setup Specimen";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Result Type"; Rec."Result Type")
                {
                    ToolTip = 'Specifies the value of the Result Type field.', Comment = '%';
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
