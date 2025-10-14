Page 52203128 "Employment History Lines"
{
    PageType = ListPart;
    SourceTable = "HR Employment History";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(CompanyName; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(JobTitle; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field(KeyExperience; Rec."Key Experience")
                {
                    ToolTip = 'Specifies the value of the Key Experience field.';
                }
                field(SalaryOnLeaving; Rec."Salary On Leaving")
                {
                    ToolTip = 'Specifies the value of the Salary On Leaving field.';
                }
                field(PostalAddress; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the value of the Postal Address field.';
                }
                field(Address2; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(ReasonForLeaving; Rec."Reason For Leaving")
                {
                    ToolTip = 'Specifies the value of the Reason For Leaving field.';
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
}
