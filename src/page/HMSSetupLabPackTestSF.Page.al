Page 85528 "HMS Setup Lab Pack Test SF"
{
    PageType = List;
    SourceTable = "HMS Setup Lab Package Test";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Lab Package"; Rec."Lab Package")
                {
                    ToolTip = 'Specifies the value of the Lab Package field.', Comment = '%';
                }
                field("Package Name"; Rec."Package Name")
                {
                    ToolTip = 'Specifies the value of the Package Name field.', Comment = '%';
                }

                field(Test; Rec.Test)
                {
                    ToolTip = 'Specifies the value of the Test field.';
                }
                field(TestName; Rec."Test Name")
                {
                    ToolTip = 'Specifies the value of the Test Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
