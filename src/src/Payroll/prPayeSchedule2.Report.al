Report 52202478 "prPaye Schedule mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayeSchedulemst.rdl';

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
            column(BPay; BPay)
            {
            }
            column(HouseAll; HouseAll)
            {
            }
            column(Transport; transport)
            {
            }
            column(LeavePay; LeavePay)
            {
            }
            column(Overtime; Overtime)
            {
            }
            column(Directors; Directors)
            {
            }
            column(LumpSum; LumpSum)
            {
            }
            column(Other; Other)
            {
            }
            column(Director; Director)
            {
            }
            column(TotalCash; TotalCash)
            {
            }
            column(ValueofCar; ValueofCar)
            {
            }
            column(TotalNonCash; TotalNonCash)
            {
            }
            column(Other2; Other2)
            {
            }
            column(GlobalIncome; GlobalIncome)
            {
            }
            column(TypeofHousing; TypeofHousing)
            {
            }
            column(RentofHouseMarketValue; RentofHouseMarketValue)
            {
            }
            column(ComputedRentofHouse; ComputedRentofHouse)
            {
            }
            column(Rentrecovered; Rentrecovered)
            {
            }
            column(NetValueofHouse; NetValueofHouse)
            {
            }
            column(TotalGrossPay; TotalGrossPay)
            {
            }
            column(thirtypercCashPay; thirtypercCashPay)
            {
            }
            column(Paye; Paye)
            {
            }
            column(PermissibleLimit; PermissibleLimit)
            {
            }
            column(MortgageInterest; MortgageInterest)
            {
            }
            column(DepositHOSP; DepositHOSP)
            {
            }
            column(AmountofBenefit; AmountofBenefit)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(PersonalRelief; PersonalRelief)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(selfAssessedPaye; selfAssessedPaye)
            {
            }
            column(taxcharged; taxcharged)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(Totalpension; Totalpension)
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
                PayeAmount := 0;
                TotPayeAmount := 0;
                TaxablePay := 0;
                TotTaxablePay := 0;
                BPay := 0;
                HouseAll := 0;
                Transport := 0;
                LeavePay := 0;
                Overtime := 0;
                Director := 0;
                LumpSum := 0;
                Other := 0;
                TotalCash := 0;
                ValueofCar := 0;
                Other2 := 0;
                TotalNonCash := 0;
                GlobalIncome := 0;
                RentofHouseMarketValue := 0;
                ComputedRentofHouse := 0;
                Rentrecovered := 0;
                NetValueofHouse := 0;
                TotalGrossPay := 0;
                thirtypercCashPay := 0;
                ActualContribution := 0;
                PermissibleLimit := 0;
                MortgageInterest := 0;
                DepositHOSP := 0;
                AmountofBenefit := 0;
                PersonalRelief := 0;
                InsuranceRelief := 0;
                selfAssessedPaye := 0;
                Totalpension := 0;

                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                    PinNumber := objEmp."PIN Number";
                end;

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '%1|%2', 6, 7); //Taxable Pay
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '%1|%2', 3, 6); //Paye Amount

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
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                // PeriodTrans.SetFilter(PeriodTrans."Group Order",'%1|%2',6,7); //Taxable Pay
                //PeriodTrans.SetFilter(PeriodTrans."Sub Group Order",'%1|%2',3,6); //Paye Amount
                // PeriodTrans.SetRange(PeriodTrans."Transaction Code",'BPAY');

                BPAY := 0;
                //PayeAmount:=0;
                if PeriodTrans.Find('-') then
                    repeat
                        TransCode.reset();
                        TransCode.SetRange(TransCode."Transaction Code", PeriodTrans."Transaction Code");
                        TransCode.SetRange(TransCode."Transaction Type", TransCode."Transaction Type"::Income);
                        if TransCode.Find('-') then
                            repeat
                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::"Housing Allowance" THEN
                                    HouseAll := HouseAll + PeriodTrans.Amount;

                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::"Leave Allowance" THEN
                                    LeavePay := LeavePay + PeriodTrans.Amount;

                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::OT THEN
                                    Overtime := Overtime + PeriodTrans.Amount;

                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::"Transport Allowance" THEN
                                    Transport := Transport + PeriodTrans.Amount;

                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::"Directors Fees" THEN
                                    Director := Director + PeriodTrans.Amount;

                                IF TransCode."itax Grouping" = TransCode."itax Grouping"::" " THEN
                                    Other := Other + PeriodTrans.Amount;
                            until TransCode.Next() = 0;

                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'BPAY') then
                            BPay := PeriodTrans.Amount;

                        IF PeriodTrans."Transaction Code" = 'D751' THEN
                            Totalpension := Totalpension + PeriodTrans.Amount;

                        IF PeriodTrans."Transaction Code" = 'D625' THEN
                            Totalpension := Totalpension + PeriodTrans.Amount;

                        //GrpOrder 7, SubGrpOrder 3 = Taxable Pay
                        if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 3) then
                            PayeAmount := PeriodTrans.Amount;
                        if (PeriodTrans."Group Order" = 6) and (PeriodTrans."Sub Group Order" = 7) then
                            taxcharged := PeriodTrans.Amount;

                        if (PeriodTrans."Transaction Code" = 'PSNR') then
                            PersonalRelief := PeriodTrans.Amount;
                        if (PeriodTrans."Transaction Code" = 'INSR') then
                            InsuranceRelief := PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                empdeduction.Reset();
                empdeduction.setrange("Employee Code", "Employee Code");
                empdeduction.setrange("Payroll Period", SelectedPeriod);
                if empdeduction.find('-') then
                    Totalpension := Totalpension + EMpDeduction.Amount;

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

        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        EMpDeduction: record "prEmployer Deductions";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        TransCode: record "PR Transaction Codes";
        PeriodFilter: Date;
        SelectedPeriod: Date;
        ActualContribution: Decimal;
        AmountofBenefit: Decimal;
        BPay: decimal;
        ComputedRentofHouse: Decimal;
        DepositHOSP: Decimal;
        director: decimal;
        Directors: Decimal;
        GlobalIncome: Decimal;
        HouseAll: Decimal;
        InsuranceRelief: Decimal;
        LeavePay: Decimal;
        LumpSum: Decimal;
        MortgageInterest: decimal;
        NetValueofHouse: Decimal;
        Other: Decimal;
        Other2: Decimal;
        Overtime: Decimal;
        paye: Decimal;
        PayeAmount: Decimal;
        PermissibleLimit: Decimal;
        PersonalRelief: Decimal;
        RentofHouseMarketValue: Decimal;
        Rentrecovered: Decimal;
        selfAssessedPaye: Decimal;
        TaxablePay: Decimal;
        taxcharged: decimal;
        thirtypercCashPay: decimal;
        TotalCash: Decimal;
        TotalGrossPay: Decimal;
        TotalNonCash: Decimal;
        Totalpension: Decimal;
        TotPayeAmount: Decimal;
        TotTaxablePay: Decimal;
        Transport: Decimal;
        ValueofCar: Decimal;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Employee_NameCaptionLbl: label 'Employee Name';
        No_CaptionLbl: label 'No:';
        P_A_Y_E_ScheduleCaptionLbl: label 'P.A.Y.E Schedule';
        Page_No_CaptionLbl: label 'Page No:';
        Paye_Amount_CaptionLbl: label 'Paye Amount:';
        Period_CaptionLbl: label 'Period:';
        PIN_Number_CaptionLbl: label 'PIN Number:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Print_Date_CaptionLbl: label 'Print Date:';
        Taxable_Pay_CaptionLbl: label 'Taxable Pay:';
        Totals_CaptionLbl: label 'Totals:';
        User_Name_CaptionLbl: label 'User Name:';
        TypeofHousing: Text;
        PeriodName: Text[30];
        PinNumber: Text[30];
        EmployeeName: Text[150];
}
