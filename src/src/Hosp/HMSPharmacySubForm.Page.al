Page 52202911 "HMS Pharmacy SubForm"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS Pharmacy Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(PharmacyNo; Rec."Pharmacy No.")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field(PharmacyDate; Rec."Pharmacy Date")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Date field.';
                }
                field(PharmacyTime; Rec."Pharmacy Time")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Time field.';
                }
                field(IssuedBy; Rec."Issued By")
                {
                    ToolTip = 'Specifies the value of the Issued By field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }
}
