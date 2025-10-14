Report 52202539 "prPaye Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayeSchedule.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(ReportForNavId_6207; 6207)
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
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PinNumber; PinNumber)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Taxable_Pay_Caption; Taxable_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                PinNumber := objEmp."PIN Number";

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETFILTER(PeriodTrans."Group Order",'=6|=7'); //Taxable Pay
                //PeriodTrans.SETFILTER(PeriodTrans."Sub Group Order",'=5|=3'); //Paye Amount

                TaxablePay := 0;
                PayeAmount := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'TXBP') then
                            TaxablePay := PeriodTrans.Amount;

                        //GrpOrder 7, SubGrpOrder 3 = Taxable Pay
                        if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 3) then
                            PayeAmount := PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                if PayeAmount <= 0 then
                    CurrReport.Skip();
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then
            Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        PayeAmount: Decimal;
        TaxablePay: Decimal;
        TotPayeAmount: Decimal;
        TotTaxablePay: Decimal;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Employee_NameCaptionLbl: label 'Employee Name';
        No_CaptionLbl: label 'No:';
        P_A_Y_E_ScheduleCaptionLbl: label 'P.A.Y.E Schedule';
        Page_No_CaptionLbl: label 'Page No:';
        Paye_Amount_CaptionLbl: label 'Paye Amount:';
        Period_CaptionLbl: label 'Period:';
        PIN_Number_CaptionLbl: label 'PIN Number:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Taxable_Pay_CaptionLbl: label 'Taxable Pay:';
        Totals_CaptionLbl: label 'Totals:';
        User_Name_CaptionLbl: label 'User Name:';
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        PinNumber: Text[30];
        EmployeeName: Text[150];
}
