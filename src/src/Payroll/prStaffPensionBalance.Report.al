Report 52202571 "prStaff Pension Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prStaffPensionBalance.rdl';

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
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(SelfContrib; SelfContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TotSelfContrib; TotSelfContrib)
            {
            }
            column(Pension_BalancesCaption; Pension_BalancesCaptionLbl)
            {
            }
            column(Self_Contribution_Caption; Self_Contribution_CaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                SelfContrib := 0;
                CompanyContrib := 0;
                SelfContribARREARS := 0;
                CompanyContribARREARS := 0;

                //Get the Basic pay
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Order", 1);
                PeriodTrans.SetRange(PeriodTrans."Sub Group Order", 1);
                if PeriodTrans.Find('-') then
                    BasicPay := PeriodTrans.Amount;

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETRANGE(PeriodTrans."Transaction Name",'PENSION');
                PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);  //dennis
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", SelfContribCode);

                if PeriodTrans.Find('-') then
                    SelfContrib := PeriodTrans.Balance;

                SelfContrib := SelfContrib + SelfContribARREARS;

                prEmployerContrib.Reset();
                prEmployerContrib.SetRange(prEmployerContrib."Employee Code", "Employee Code");
                prEmployerContrib.SetRange(prEmployerContrib."Payroll Period", SelectedPeriod);
                prEmployerContrib.SetRange(prEmployerContrib."Transaction Code", SelfContribCode);

                if prEmployerContrib.Find('-') then
                    CompanyContrib := prEmployerContrib.Amount;

                CompanyContrib := CompanyContrib + CompanyContribARREARS;

                CummContrib := SelfContrib + CompanyContrib;

                if (SelfContrib <= 0) and (CompanyContrib <= 0) then
                    CurrReport.Skip();
                TotBasicPay := TotBasicPay + BasicPay;
                TotSelfContrib := TotSelfContrib + SelfContrib;
                TotCompanyContrib := TotCompanyContrib + CompanyContrib;
                TotCummContrib := TotCummContrib + CummContrib;
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

        //self contribution...Defined contribution is a Special Transaction 1
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", '0007'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then
            SelfContribCode := objTransCode."Transaction Code";

        //self contribution...Defined contribution is a Special Transaction 1 PENSION ARREARS
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", '114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then
            SelfContribCodeArrears := objTransCode."Transaction Code";

        //Company contribution
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-455'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then;
        // CompanyContribCode:=objTransCode."Transaction Code";
        CompanyContribCode := 'Emp-455';

        //Company contribution ARREARS
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then;
        // CompanyContribCode:=objTransCode."Transaction Code";
        CompanyContribCodeArrears := 'Emp-114';

        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        Companyinfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        prEmployerContrib: Record "prEmployer Deductions";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        objTransCode: Record "PR Transaction Codes";
        SelectedPeriod: Date;
        BasicPay: Decimal;
        CompanyContrib: Decimal;
        CompanyContribARREARS: Decimal;
        CummContrib: Decimal;
        SelfContrib: Decimal;
        SelfContribARREARS: Decimal;
        TotBasicPay: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        TotSelfContrib: Decimal;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Page_No_CaptionLbl: label 'Page No:';
        Pension_BalancesCaptionLbl: label 'Pension Balances';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Self_Contribution_CaptionLbl: label 'Self Contribution:';
        Totals_CaptionLbl: label 'Totals:';
        User_Name_CaptionLbl: label 'User Name:';
        CompanyContribCode: Text[30];
        CompanyContribCodeArrears: Text[30];
        EmployeeName: Text[30];
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        SelfContribCode: Text[30];
        SelfContribCodeArrears: Text[30];
}
