Page 52202850 "HMS Setup Radiology Type List"
{
    PageType = List;
    SourceTable = "HMS Setup Radiology Type";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.', Comment = '%';
                }
                field("Radiology Section"; Rec."Radiology Section")
                {
                    ToolTip = 'Specifies the value of the Radiology Section field.', Comment = '%';
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.', Comment = '%';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
