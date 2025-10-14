Report 52202604 "prEmployer Gratuity"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prEmployerGratuity.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            DataItemTableView = where("Gratuity Perc." = filter(> 0));
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
            column(CompanyContrib; CompanyContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(CummContrib; CummContrib)
            {
            }
            column(TotCompanyContrib; TotCompanyContrib)
            {
            }
            column(TotSelfContrib; TotSelfContrib)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(TotCummContrib; TotCummContrib)
            {
            }
            column(Employee_Employer_Pension_ContributionCaption; Employee_Employer_Pension_ContributionCaptionLbl)
            {
            }
            column(Self_Contribution_Caption; Self_Contribution_CaptionLbl)
            {
            }
            column(Company_Contrib_Caption; Company_Contrib_CaptionLbl)
            {
            }
            column(Cumm_Contribution_Caption; Cumm_Contribution_CaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
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
            column(Reviewed_by_______________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Dept; Dept)
            {
            }

            trigger OnAfterGetRecord()
            begin
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                Dept := objEmp."Shortcut Dimension 2 Code";

                CompanyContrib := 0;
                CompanyContribARREARS := 0;

                prEmployerContrib.Reset();
                prEmployerContrib.SetRange(prEmployerContrib."Employee Code", "prSalary Card"."Employee Code");
                prEmployerContrib.SetRange(prEmployerContrib."Transaction Code", 'GRAT');
                prEmployerContrib.SetRange(prEmployerContrib."Payroll Period", SelectedPeriod);
                if prEmployerContrib.Find('-') then
                    CompanyContrib := prEmployerContrib.Amount;
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
        if SelectedPeriod = 0D then
            Error('You must specify the period filter');

        //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        //self contribution...Defined contribution is a Special Transaction 1
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'D0047'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then
            SelfContribCode := objTransCode."Transaction Code";

        //self contribution...Defined contribution is a Special Transaction 1 PENSION ARREARS
        objTransCode.Reset();
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'D0047-A'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
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
        objTransCode: Record "PR Transaction Codes";
        SelectedPeriod: Date;
        BasicPay: Decimal;
        CompanyContrib: Decimal;
        CompanyContribARREARS: Decimal;
        CummContrib: Decimal;
        SelfContrib: Decimal;
        TotBasicPay: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        TotSelfContrib: Decimal;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Reviewed by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Basic_Pay_CaptionLbl: label 'Basic Pay:';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                      Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Company_Contrib_CaptionLbl: label 'Company Contrib:';
        Cumm_Contribution_CaptionLbl: label 'Cumm Contribution:';
        Employee_Employer_Pension_ContributionCaptionLbl: label 'Employee/Employer Pension Contribution';
        Page_No_CaptionLbl: label 'Page No:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                  Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Self_Contribution_CaptionLbl: label 'Self Contribution:';
        Totals_CaptionLbl: label 'Totals:';
        User_Name_CaptionLbl: label 'User Name:';
        Dept: Text;
        CompanyContribCode: Text[30];
        CompanyContribCodeArrears: Text[30];
        PeriodName: Text[30];
        SelfContribCode: Text[30];
        SelfContribCodeArrears: Text[30];
        EmployeeName: Text[50];
}
