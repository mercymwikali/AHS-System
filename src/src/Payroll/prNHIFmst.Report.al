Report 52202585 "prNHIF mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prNHIFmst.rdl';

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
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Address; Address)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(PeriodName_Control1102756007; PeriodName)
            {
            }
            column(NhifAmount; NhifAmount)
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(NhifNo; NhifNo)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(lastName; lastName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(Dob; Dob)
            {
            }
            column(TotNhifAmount; TotNhifAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
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
            column(Page_Nov_Caption; Page_No_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755032; PERIOD_Caption_Control1102755032Lbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(EMPLOYER_Caption; EMPLOYER_CaptionLbl)
            {
            }
            column(EMPOLOYER_NO_Caption; EMPOLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NO_Caption; EMPLOYER_PIN_NO_CaptionLbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Date_Of_BirthCaption; Date_Of_BirthCaptionLbl)
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
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(NhifAmount);
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then;
                EmployeeName := objEmp."Middle Name" + ' ' + objEmp."Last Name";
                lastName := objEmp."First Name";
                NhifNo := objEmp."NHIF No.";
                IDNumber := objEmp."ID Number";
                Dob := objEmp."Date Of Birth";

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Order", 7);
                PeriodTrans.SetRange(PeriodTrans."Sub Group Order", 2);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NhifAmount := 0;

                if PeriodTrans.Find('-') then begin
                    if PeriodTrans.Amount = 0 then
                        CurrReport.Skip();
                    NhifAmount := PeriodTrans.Amount;
                    TotNhifAmount := TotNhifAmount + PeriodTrans.Amount;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if CompInfoSetup.Get() then
                    EmployerNHIFNo := CompInfoSetup."N.H.I.F No";
                CompPINNo := CompInfoSetup."Company P.I.N";
                Address := CompInfoSetup.Address;
                Tel := CompInfoSetup."Phone No.";
                Clear(TotNhifAmount);

                //"prSalary Card".SETFILTER("prSalary Card"."Payroll Period",'%1',SelectedPeriod);
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

        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
        Clear(NhifAmount);
        //CLEAR(TotNhifAmount);
    end;

    var
        Companyinfo: Record "Control-Information";
        CompInfoSetup: Record "Control-Information";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        CompPINNo: Code[20];
        EmployerNHIFNo: Code[20];
        Dob: Date;
        PeriodFilter: Date;
        SelectedPeriod: Date;
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        ADDRESS_CaptionLbl: label 'ADDRESS:';
        AmountCaptionLbl: label 'Amount';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Date_Of_BirthCaptionLbl: label 'Date Of Birth';
        Employee_NameCaptionLbl: label 'Employee Name';
        EMPLOYER_CaptionLbl: label 'EMPLOYER:';
        EMPLOYER_PIN_NO_CaptionLbl: label 'EMPLOYER PIN NO:';
        EMPOLOYER_NO_CaptionLbl: label 'EMPOLOYER NO:';
        ID_Number_CaptionLbl: label 'ID Number:';
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: label 'NATIONAL HOSPITAL INSURANCE FUND';
        NHIF_No_CaptionLbl: label 'NHIF No:';
        No_CaptionLbl: label 'No:';
        Page_No_CaptionLbl: label 'Page No:';
        PERIOD_Caption_Control1102755032Lbl: label 'PERIOD:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Print_Date_CaptionLbl: label 'Print Date:';
        TEL_NO_CaptionLbl: label 'TEL NO:';
        Total_NHIF_CaptionLbl: label 'Total NHIF:';
        User_Name_CaptionLbl: label 'User Name:';
        lastName: Text;
        IDNumber: Text[30];
        NhifNo: Text[30];
        PeriodName: Text[30];
        Tel: Text[30];
        Address: Text[90];
        EmployeeName: Text[150];
}
