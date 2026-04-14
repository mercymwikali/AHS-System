Page 85791 prPostedPCAMassList
{
    CardPageID = "prMassPCA Card VW";
    PageType = List;
    SourceTable = prMassPCAHD;
    SourceTableView = where(Status = filter(Posted));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChangeAdviceSerialNo; Rec."Change Advice Serial No.")
                {
                    ToolTip = 'Specifies the value of the Change Advice Serial No. field.';
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
