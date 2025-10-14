namespace PTL.HMIS;

page 52203164 "EDD Protocol Setup Page"
{
    ApplicationArea = All;
    Caption = 'EDD Protocol Setup Page';
    PageType = List;
    SourceTable = "EDD Protocol Setup";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Psychiatry Condition"; Rec."Psychiatry Condition")
                {
                    ToolTip = 'Specifies the value of the Psychiatry Condition field.', Comment = '%';
                }
                field("Expected Discharge Date"; Rec."Expected Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Expected Discharge Date field.', Comment = '%';
                }
            }
        }
    }
}
