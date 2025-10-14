Page 52203121 Referees
{
    PageType = ListPart;
    SourceTable = Referees;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(TelephoneNo; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
            }
        }
    }

    actions
    {
    }
}
