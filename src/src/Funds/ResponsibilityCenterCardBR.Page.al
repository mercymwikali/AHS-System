Page 52203039 "Responsibility Center Card BR"
{
    Caption = 'Responsibility Center Card';
    PageType = Card;
    SourceTable = "Responsibility Center BR";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Address2; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(PostCodeCity; Rec."Post Code")
                {
                    Caption = 'Post Code/City';
                    ToolTip = 'Specifies the value of the Post Code/City field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(HODUserID; Rec."HOD User ID")
                {
                    ToolTip = 'Specifies the value of the HOD User ID field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(PhoneNo; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(FaxNo; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field(HomePage; Rec."Home Page")
                {
                    ToolTip = 'Specifies the value of the Home Page field.';
                }
                field(NotifyPaymentUsers; Rec."Notify Payment User(s)")
                {
                    ToolTip = 'Specifies the value of the Notify Payment User(s) field.';
                }
                field(PaymentUsersEMail; Rec."Payment User(s) - E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(RespCtr)
            {
                Caption = '&Resp. Ctr.';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(39006016),
                                  "No." = field(Code);
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                    ToolTip = 'Executes the Dimensions action.';
                }
            }
        }
    }
}
