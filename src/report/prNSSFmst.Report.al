Report 85278 "prNSSF mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prNSSFmst.rdl';

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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(companyinfo_NSSFNO; CompanyInfo."N.S.S.F No.")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodName_Control1102756011; PeriodName)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Volume_Amount_; "Volume Amount")
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(NssfAmount_2; NssfAmount / 2)
            {
            }
            column(NssfNo; NssfNo)
            {
            }
            column(NssfAmount_2_Control1102756008; NssfAmount / 2)
            {
            }
            column(TotNssfAmount_2; TotNssfAmount / 2)
            {
            }
            column(totTotalAmount; totTotalAmount)
            {
            }
            column(TotVolume_Amount_; "TotVolume Amount")
            {
            }
            column(TotNssfAmount_2_Control1102756015; TotNssfAmount / 2)
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
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
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_NAME_Caption; EMPLOYER_NAME_CaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(Vol_AmountCaption; Vol_AmountCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Total_Amounts_Caption; Total_Amounts_CaptionLbl)
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
            column(KRAPin; KRAPin)
            {
            }
            column(GrossAmt; GrossAmt)
            {
            }
            column(OtherNames; OtherNames)
            {
            }

            trigger OnAfterGetRecord()
            begin
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name";
                    OtherNames := objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    NssfNo := objEmp."NSSF No.";
                    IDNumber := objEmp."ID Number";
                    KRAPin := objEmp."PIN Number";
                end;

                //GROSS
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'GPAY');  ///Nssf Code
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                GrossAmt := 0;
                if PeriodTrans.Find('-') then
                    GrossAmt := PeriodTrans.Amount;

                //Volume Amount****************************************************************************
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", Format('D0079'));  ///Nssf Code
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                "Volume Amount" := 0;
                if PeriodTrans.Find('-') then
                    "Volume Amount" := PeriodTrans.Amount;

                "TotVolume Amount" := "TotVolume Amount" + "Volume Amount";

                //Standard Amount**************************************************************************
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=7');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '=1');
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NssfAmount := 0;
                if PeriodTrans.Find('-') then
                    NssfAmount := PeriodTrans.Amount + PeriodTrans.Amount;

                //Total Amount=NssfAmount+Volume Amount**************************************************
                TotalAmount := NssfAmount + "Volume Amount";

                //Summation Total Amount=****************************************************************
                totTotalAmount := totTotalAmount + TotalAmount;

                if NssfAmount <= 0 then
                    CurrReport.Skip();
                TotNssfAmount := TotNssfAmount + NssfAmount;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period Filter';
                    TableRelation = "prPayroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Period Filter field.';
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

    trigger OnInitReport()
    begin
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        if PeriodFilter = 0D then
            Error('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Control-Information";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        KRAPin: Code[20];
        PeriodFilter: Date;
        SelectedPeriod: Date;
        GrossAmt: Decimal;
        NssfAmount: Decimal;
        TotalAmount: Decimal;
        TotNssfAmount: Decimal;
        totTotalAmount: Decimal;
        "TotVolume Amount": Decimal;
        "Volume Amount": Decimal;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Employee_AmountCaptionLbl: label 'Employee Amount';
        Employee_NameCaptionLbl: label 'Employee Name';
        Employer_AmountCaptionLbl: label 'Employer Amount';
        EMPLOYER_NAME_CaptionLbl: label 'EMPLOYER NAME:';
        EMPLOYER_NO_CaptionLbl: label 'EMPLOYER NO:';
        ID_Number_CaptionLbl: label 'ID Number:';
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: label 'NATIONAL SOCIAL SECURITY FUND';
        NSSF_No_CaptionLbl: label 'NSSF No:';
        Page_No_CaptionLbl: label 'Page No:';
        Payroll_No_CaptionLbl: label 'Payroll No:';
        PERIOD_Caption_Control1102755031Lbl: label 'PERIOD:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Total_AmountCaptionLbl: label 'Total Amount';
        Total_Amounts_CaptionLbl: label 'Total Amounts:';
        User_Name_CaptionLbl: label 'User Name:';
        Vol_AmountCaptionLbl: label 'Vol Amount';
        IDNumber: Text[30];
        NssfNo: Text[30];
        PeriodName: Text[30];
        OtherNames: Text[100];
        EmployeeName: Text[150];
}
