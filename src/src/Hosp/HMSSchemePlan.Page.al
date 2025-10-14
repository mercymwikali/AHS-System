Page 52202760 "HMS Scheme Plan"
{
    PageType = Card;
    SourceTable = "HMS Scheme Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(TelexNo; Rec."Telex No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(CreditLimitLCY; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Credit Limit (LCY) field.';
                }
                field(CustomerPostingGroup; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer Posting Group field.';
                }
                field(CustomerPriceGroup; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
            }
            group(Control16)
            {
            }
            part(Control17; "HMS Scheme Services")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Insurance = field("No.");
            }
            part(Control18; "HMS Scheme Plan Items")
            {
                SubPageLink = Insurance = field("No.");
            }
        }
    }

    actions
    {
    }
}
