Page 52202884 "HMS Laboratory Request Line"
{
    PageType = ListPart;
    SourceTable = "HMS Laboratory Test Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(LaboratoryTestCode; Rec."Laboratory Test Code")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Code field.';
                }
                field(LaboratoryTestName; Rec."Laboratory Test Name")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Name field.';
                }
                field(SpecimenCode; Rec."Specimen Code")
                {
                    ToolTip = 'Specifies the value of the Specimen Code field.';
                }
                field(SpecimenName; Rec."Specimen Name")
                {
                    ToolTip = 'Specifies the value of the Specimen Name field.';
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                }
                field("Charges Insurance No"; Rec."Charges Insurance No")
                {
                    ToolTip = 'Specifies the value of the Charges Insurance No field.';
                }
                field("Payment Exist"; Rec."Payment Exist")
                {
                    ToolTip = 'Specifies the value of the Payment Exist field.';
                }
                field("Lab Date"; Rec."Lab Date")
                {
                    ToolTip = 'Specifies the value of the Lab Date field.';
                }
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the Laboratory No. field.';
                }
                field("Unique No"; Rec."Unique No")
                {
                    ToolTip = 'Specifies the value of the Unique No field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
                field("Completion Time"; Rec."Completion Time")
                {
                    ToolTip = 'Specifies the value of the Completion Time field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Receipt No"; Rec."Receipt No")
                {
                    ToolTip = 'Specifies the value of the Receipt No field.';
                }
                field(Paid; Rec.Paid)
                {
                    ToolTip = 'Specifies the value of the Paid field.';
                }
                field("Receipt Line No"; Rec."Receipt Line No")
                {
                    ToolTip = 'Specifies the value of the Receipt Line No field.';
                }
                field("Collection Time"; Rec."Collection Time")
                {
                    ToolTip = 'Specifies the value of the Collection Time field.';
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ToolTip = 'Specifies the value of the Collection Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
