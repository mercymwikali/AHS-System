Report 85269 prGrossNetPay
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prGrossNetPay.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code", "Posting Group";

            column(ReportForNavId_6207; 6207)
            {
            }
            column(MainBank_HREmployee; "bank Name")
            {
            }
            column(BranchBank_HREmployee; objEmp."Branch Bank")
            {
            }
            column(BankAccountNumber_HREmployee; objEmp."Bank Account Number")
            {
            }
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(xx; xx)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(TotGrossPay; TotGrossPay)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(Gross_and_Net_pay_scheduleCaption; Gross_and_Net_pay_scheduleCaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
            {
            }
            column(Net_Pay_Caption; Net_Pay_CaptionLbl)
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
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(TotalDed; TotalDeductions)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                BasicPay := 0;
                GrossPay := 0;
                NetPay := 0;
                TotalDeductions := 0;

                "bank Name" := '';

                BankStruct.Reset();
                BankStruct.SetRange(BankStruct."Bank Code", objEmp."Main Bank");
                if BankStruct.Find('-') then
                    "bank Name" := BankStruct."Bank Name";

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=1|=4|=9');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '<=1');
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                if PeriodTrans.Find('-') then
                    repeat
                        if PeriodTrans."Group Order" = 1 then
                            BasicPay := PeriodTrans.Amount;

                        if PeriodTrans."Group Order" = 4 then
                            GrossPay := PeriodTrans.Amount; //Gross pay

                        if PeriodTrans."Group Order" = 9 then
                            NetPay := PeriodTrans.Amount; //Net pay
                    until PeriodTrans.Next() = 0;
                TotalDeductions := GrossPay - NetPay;
                //IF NetPay<=0 THEN
                //CurrReport.SKIP;
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;

                xx := xx + 1;
            end;

            trigger OnPreDataItem()
            begin
                //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
                //IF PeriodFilter='' THEN ERROR('You must specify the period filter');

                //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
                objPeriod.Reset();
                if objPeriod.Get(SelectedPeriod) then
                    PeriodName := objPeriod."Period Name";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    TableRelation = "prPayroll Periods";
                    ToolTip = 'Specifies the value of the SelectedPeriod field.';
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

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        //IF PeriodFilter='' THEN ERROR('You must specify the period filter');

        //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        BankStruct: Record "Pr Bank Branches";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        BasicPay: Decimal;
        GrossPay: Decimal;
        NetPay: Decimal;
        TotalDeductions: Decimal;
        TotBasicPay: Decimal;
        TotGrossPay: Decimal;
        TotNetPay: Decimal;
        xx: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Basic_Pay_CaptionLbl: label 'Basic Pay:';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Gross_and_Net_pay_scheduleCaptionLbl: label 'Gross and Net pay schedule';
        Gross_Pay_CaptionLbl: label 'Gross Pay:';
        Net_Pay_CaptionLbl: label 'Net Pay:';
        Page_No_CaptionLbl: label 'Page No:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Print_Date_CaptionLbl: label 'Print Date:';
        Totals_CaptionLbl: label 'Totals:';
        User_Name_CaptionLbl: label 'User Name:';
        "bank Name": Text;
        PeriodName: Text[30];
        EmployeeName: Text[100];
}
