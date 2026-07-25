Report 85254 "prAllowances Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prAllowancesReport.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code");
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_7769; 7769)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Group_Text_; "Group Text")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(Allowances_ReportCaption; Allowances_ReportCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }
            column(prPeriod_Transactions_Department_Code; "Department Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                //"prPeriod Transactions".SETFILTER("Group Order",'=1|3');
                //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');
                if Amount <= 0 then
                    CurrReport.Skip();
                TotalsAllowances := TotalsAllowances + "prPeriod Transactions".Amount;

                PrevMonth := 0;
                PeriodTrans2.Reset();
                PeriodTrans2.SetRange(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year");
                if "prPeriod Transactions"."Period Month" = 1 then begin
                    PeriodTrans2.SetRange(PeriodTrans2."Period Month", 12);
                    PeriodTrans2.SetRange(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year" - 1);
                end else
                    PeriodTrans2.SetRange(PeriodTrans2."Period Month", "prPeriod Transactions"."Period Month" - 1);
                //PeriodTrans2.SETFILTER(PeriodTrans2."Group Order",'=7|=8');
                PeriodTrans2.SetRange(PeriodTrans2."Transaction Code", "prPeriod Transactions"."Transaction Code");
                PeriodTrans2.SetRange(PeriodTrans2."Employee Code", "prPeriod Transactions"."Employee Code");
                if PeriodTrans2.Find('-') then
                    PrevMonth := PeriodTrans2.Amount;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Period Year");
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then
            PeriodName := objPeriod."Period Name";

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans2: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        PrevMonth: Decimal;
        TotalsAllowances: Decimal;
        LastFieldNo: Integer;
        Allowances_ReportCaptionLbl: label 'Allowances Report';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Page_No_CaptionLbl: label 'Page No:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Print_Date_CaptionLbl: label 'Print Date:';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        User_Name_CaptionLbl: label 'User Name:';
        PeriodName: Text[30];
}
