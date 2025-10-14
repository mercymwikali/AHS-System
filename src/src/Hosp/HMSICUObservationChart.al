page 52202707 "HMS ICU Observation Chart"
{
    PageType = List;
    SourceTable = "HMS General Observation";
    SourceTableView = WHERE(ICU = FILTER(true),
                            "ICU Category" = CONST(0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Category Value"; Rec."Category Value")
                {
                    ToolTip = 'Specifies the value of the Category Value field.';
                }
                field("ICU Timings"; Rec."ICU Timings")
                {
                    ToolTip = 'Specifies the value of the ICU Timings field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ICU := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.ICU := true;
    end;
}
