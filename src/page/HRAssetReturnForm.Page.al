Page 85627 "HR Asset Return Form"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Misc. Article Information";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(MiscArticleCode; Rec."Misc. Article Code")
                {
                    ToolTip = 'Specifies the value of the Misc. Article Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(InUse; Rec."In Use")
                {
                    ToolTip = 'Specifies the value of the In Use field.';
                }
                field(SerialNo; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure refresh()
    begin
        CurrPage.Update(false);
    end;
}
