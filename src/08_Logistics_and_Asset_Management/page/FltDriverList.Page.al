page 85015 "Flt Driver List"
{
    CardPageID = "Flt Driver Card";
    PageType = List;
    SourceTable = "Flt Driver";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Driver; Rec.Driver)
                {
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ToolTip = 'Specifies the value of the Driver License Number field.';
                }
                field("Last License Renewal"; Rec."Last License Renewal")
                {
                    ToolTip = 'Specifies the value of the Last License Renewal field.';
                }
                field("Renewal Interval"; Rec."Renewal Interval")
                {
                    ToolTip = 'Specifies the value of the Renewal Interval field.';
                }
                field("Renewal Interval Value"; Rec."Renewal Interval Value")
                {
                    ToolTip = 'Specifies the value of the Renewal Interval Value field.';
                }
                field("Next License Renewal"; Rec."Next License Renewal")
                {
                    ToolTip = 'Specifies the value of the Next License Renewal field.';
                }
                field("Year Of Experience"; Rec."Year Of Experience")
                {
                    ToolTip = 'Specifies the value of the Year Of Experience field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
            }
        }
    }

    actions
    {
    }
}
