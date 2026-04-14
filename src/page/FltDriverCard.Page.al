Page 85014 "Flt Driver Card"
{
    PageType = Card;
    SourceTable = "Flt Driver";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Driver; Rec.Driver)
                {
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field(DriverName; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(DriverLicenseNumber; Rec."Driver License Number")
                {
                    ToolTip = 'Specifies the value of the Driver License Number field.';
                }
                field(LicenseClass; Rec."License Class")
                {
                    ToolTip = 'Specifies the value of the License Class field.';
                }
                field(LastLicenseRenewal; Rec."Last License Renewal")
                {
                    ToolTip = 'Specifies the value of the Last License Renewal field.';
                }
                field(RenewalInterval; Rec."Renewal Interval")
                {
                    ToolTip = 'Specifies the value of the Renewal Interval field.';
                }
                field(RenewalIntervalValue; Rec."Renewal Interval Value")
                {
                    ToolTip = 'Specifies the value of the Renewal Interval Value field.';
                }
                field(NextLicenseRenewal; Rec."Next License Renewal")
                {
                    ToolTip = 'Specifies the value of the Next License Renewal field.';
                }
                field(YearOfExperience; Rec."Year Of Experience")
                {
                    ToolTip = 'Specifies the value of the Year Of Experience field.';
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
