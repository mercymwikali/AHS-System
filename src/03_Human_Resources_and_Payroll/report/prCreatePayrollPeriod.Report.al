Report 85260 "prCreate Payroll Period"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CreatePeriod; "prPayroll Periods")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPreDataItem()
            begin
                if prPeriods.find('-') then
                    error('Payroll period already exists');
                prPeriods.Init();
                prPeriods."Period Month" := Date2dmy(StartPeriod, 2);
                prPeriods."Date Opened" := StartPeriod;
                prPeriods."Period Year" := Date2dmy(StartPeriod, 3);
                prPeriods."Period Name" := Format(StartPeriod, 0, '<Month Text>  <Year4>');
                prPeriods.Insert();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartPeriod; StartPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        prPeriods: Record "prPayroll Periods";
        StartPeriod: Date;
}
