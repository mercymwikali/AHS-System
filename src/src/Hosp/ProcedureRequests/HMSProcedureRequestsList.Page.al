page 52203150 "HMS Procedure Requests List"
{
    ApplicationArea = All;
    Caption = 'HMS Procedure Requests List';
    CardPageId = "HMS Procedure Request Card";
    PageType = List;
    SourceTable = "HMS Procedure Requests";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Procedure Date"; Rec."Procedure Date")
                {
                    ToolTip = 'Specifies the value of the Procedure Date field.', Comment = '%';
                }
                field("Procedure Type"; Rec."Procedure Type")
                {
                    ToolTip = 'Specifies the value of the Procedure Type field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Requesting Doctor"; Rec."Requesting Doctor")
                {
                    ToolTip = 'Specifies the value of the Requesting Doctor field.', Comment = '%';
                }
                field("Total count"; Rec."Total count")
                {
                    ToolTip = 'Specifies the value of the Total count field.', Comment = '%';
                }
                field("Total Done"; Rec."Total Done")
                {
                    ToolTip = 'Specifies the value of the Total Done field.', Comment = '%';
                }
                field("Procedure Notes"; Rec."Procedure Notes")
                {
                    ToolTip = 'Specifies the value of the Procedure Notes field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
