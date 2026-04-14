Page 85189 "Legal Setups"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Security Setups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(LegalNos; Rec."Legal Nos")
                {
                    ToolTip = 'Specifies the value of the Legal Nos field.';
                }
                field(CorporateNo; Rec."Corporate No.")
                {
                    ToolTip = 'Specifies the value of the Corporate No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
