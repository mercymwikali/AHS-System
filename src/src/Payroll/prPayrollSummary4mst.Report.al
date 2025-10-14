Report 52202591 "prPayrollSummary4 mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayrollSummary4mst.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = sorting("Dimension Code", Code) where("Dimension Code" = const('UNITS'));
            PrintOnlyIfDetail = true;
            column(ReportForNavId_6363; 6363)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Dimension_Value_Name; Name)
            {
            }
            column(subTotBasicPay; subTotBasicPay)
            {
            }
            column(SubTotOtherAllow; SubTotOtherAllow)
            {
            }
            column(SubTotGrosspay; SubTotGrosspay)
            {
            }
            column(subTotnonTaxAmount; subTotnonTaxAmount)
            {
            }
            column(subTotstatutoryDed; subTotstatutoryDed)
            {
            }
            column(subTotPension; subTotPension)
            {
            }
            column(subTotNetPay; subTotNetPay)
            {
            }
            column(subtotTotalDeductions; subtotTotalDeductions)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(TotOtherAllow; TotOtherAllow)
            {
            }
            column(TotGrosspay; TotGrosspay)
            {
            }
            column(TotnonTaxAmount; TotnonTaxAmount)
            {
            }
            column(TotstatutoryDed; TotstatutoryDed)
            {
            }
            column(totTotalDeductions; totTotalDeductions)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(TotnonstatutoryDed; TotnonstatutoryDed)
            {
            }
            column(TotPension; TotPension)
            {
            }
            column(TotnegNet; TotnegNet)
            {
            }
            column(NAME_________________________________________________________________________________________; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION_____________________________________________________; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE____________________________________________________; 'SIGNATURE...................................................')
            {
            }
            column(DATE____________________________________________________________; 'DATE...........................................................')
            {
            }
            column(NAME__________________________________________________________________________________________Control1102756043; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION______________________________________________________Control1102756044; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE_____________________________________________________Control1102756046; 'SIGNATURE...................................................')
            {
            }
            column(DATE_____________________________________________________________Control1102756047; 'DATE...........................................................')
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            column(Gross_Taxable_PayCaption; Gross_Taxable_PayCaptionLbl)
            {
            }
            column(Non_Taxable_AmountCaption; Non_Taxable_AmountCaptionLbl)
            {
            }
            column(Statutory_DeductionsCaption; Statutory_DeductionsCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(Payroll_Summary_Per_DepartmentCaption; Payroll_Summary_Per_DepartmentCaptionLbl)
            {
            }
            column(Non_Statutory_DeductionsCaption; Non_Statutory_DeductionsCaptionLbl)
            {
            }
            column(Pension_Staff_Cont_Caption; Pension_Staff_Cont_CaptionLbl)
            {
            }
            column(Negative_Net_PayCaption; Negative_Net_PayCaptionLbl)
            {
            }
            column(Employee_Code_Caption; Employee_Code_CaptionLbl)
            {
            }
            column(Sub_Totals_Caption; Sub_Totals_CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Checked_byCaption; Checked_byCaptionLbl)
            {
            }
            column(Dimension_Value_Dimension_Code; "Dimension Code")
            {
            }
            column(Dimension_Value_Code; Code)
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Shortcut Dimension 2 Code" = field(Code);
                DataItemTableView = sorting("No.");
                column(ReportForNavId_8631; 8631)
                {
                }
                column(strEmpName; strEmpName)
                {
                }
                column(BasicPay; BasicPay)
                {
                }
                column(Grosspay; Grosspay)
                {
                }
                column(nonTaxAmount; nonTaxAmount)
                {
                }
                column(statutoryDed; statutoryDed)
                {
                }
                column(NetPay; NetPay)
                {
                }
                column(OtherAllow; OtherAllow)
                {
                }
                column(TotalDeductions; TotalDeductions)
                {
                }
                column(nonstatutoryDed; nonstatutoryDed)
                {
                }
                column(Pension; Pension)
                {
                }
                column(negNet; negNet)
                {
                }
                column(strCodes; strCodes)
                {
                }
                column(HR_Employee_No_; "No.")
                {
                }
                column(HR_Employee_Department_Code; "Shortcut Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                    strCodes := "No.";

                    BasicPay := 0;
                    Allow := 0;
                    Grosspay := 0;
                    PenGrat := 0;
                    Nssf := 0;
                    HseAllow := 0;
                    statutoryDed := 0;
                    nonstatutoryDed := 0;
                    TaxablePay := 0;
                    Reliefs := 0;
                    OtherAllow := 0;
                    TotalDeductions := 0;
                    NetPay := 0;
                    negNet := 0;
                    nonTaxAmount := 0;
                    Pension := 0;

                    //Loop through the Income/Earnings and deductions************************************************************************
                    PeriodTrans.Reset();
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                    PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                    if PeriodTrans.Find('-') then
                        repeat
                            //Basic Pay************************START
                            if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) then begin
                                BasicPay := PeriodTrans.Amount;
                                TotBasicPay := TotBasicPay + BasicPay;
                            end;

                            //Other Allowances************************START
                            if (PeriodTrans."Group Order" = 3) and (PeriodTrans."Sub Group Order" = 0) then begin
                                OtherAllow := OtherAllow + PeriodTrans.Amount;
                                TotOtherAllow := TotOtherAllow + PeriodTrans.Amount;
                            end;

                            //Gross Pay************************START
                            if (PeriodTrans."Group Order" = 4) and (PeriodTrans."Sub Group Order" = 0) then begin
                                Grosspay := Grosspay + PeriodTrans.Amount;
                                TotGrosspay := TotGrosspay + PeriodTrans.Amount;
                            end;

                            //other non taxable*************START
                            TransCodes.Reset();
                            TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                            TransCodes.SetRange(TransCodes.Taxable, false);
                            if TransCodes.FindFirst() then begin
                                nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                                TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                            end;

                            //Statutory Deductions*************START
                            if (PeriodTrans."Group Order" = 7) then begin
                                statutoryDed := statutoryDed + PeriodTrans.Amount;
                                TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                            end;
                            /*
                            //Non Statutory Deductions*************START
                              IF (PeriodTrans."Group Order"<>7) and (PeriodTrans."Group Order"<>9) AND (PeriodTrans."Group Text"<>'BASIC SALARY') AND
                                (PeriodTrans."Group Text"<>'GROSS PAY') and (PeriodTrans."Group Text"<>'EMPLOYER DEDUCTIONS') THEN
                              BEGIN
                                 nonstatutoryDed:=nonstatutoryDed+PeriodTrans.Amount;
                                 TotnonstatutoryDed:=TotnonstatutoryDed+PeriodTrans.Amount;
                              END;
                             */
                            //Pension *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'PENS') then begin
                                Pension := Pension + PeriodTrans.Amount;
                                TotPension := TotPension + PeriodTrans.Amount;
                            end;

                            //Total Deductions***********************
                            if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) /* AND (PeriodTrans."Group Order"=7)*/  then begin
                                TotalDeductions := TotalDeductions + PeriodTrans.Amount;
                                totTotalDeductions := totTotalDeductions + PeriodTrans.Amount;
                            end;

                            //Net Pay************************START
                            if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then
                                if PeriodTrans.Amount < 0 then begin
                                    NetPay := NetPay + 0;
                                    TotNetPay := TotNetPay + 0;
                                    negNet := PeriodTrans.Amount;
                                    TotnegNet := TotnegNet + PeriodTrans.Amount;
                                end
                                else begin
                                    NetPay := NetPay + PeriodTrans.Amount;
                                    TotNetPay := TotNetPay + PeriodTrans.Amount
                                end;
                        until PeriodTrans.Next() = 0
                    else
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin

                    if PayrollMode <> Payrollmode::" " then
                        "HR-Employee".SetRange("HR-Employee"."Payment Mode", PayrollMode);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //Loop through the Income/Earnings************************************************************************
                PeriodTrans.Reset();
                //PeriodTrans.SETRANGE(PeriodTrans."Location/Division","Dimension Value".Code);
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                subTotBasicPay := 0;
                subTotHseAllow := 0;
                SubTotOtherAllow := 0;
                SubTotGrosspay := 0;
                subTotnonTaxAmount := 0;
                subTotstatutoryDed := 0;
                subTotnonstatutoryDed := 0;
                subTotPension := 0;
                subTotNetPay := 0;

                if PeriodTrans.Find('-') then
                    repeat
                        //Basic Pay*******************************************************************START
                        if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) then
                            subTotBasicPay := subTotBasicPay + PeriodTrans.Amount;

                        //Other Allowances*************************************************************START
                        if (PeriodTrans."Group Order" = 3) and (PeriodTrans."Sub Group Order" = 0) then
                            SubTotOtherAllow := SubTotOtherAllow + PeriodTrans.Amount;

                        //Gross Pay********************************************************************START
                        if (PeriodTrans."Group Order" = 4) and (PeriodTrans."Sub Group Order" = 0) then
                            SubTotGrosspay := SubTotGrosspay + PeriodTrans.Amount;

                        //other non taxable************************************************************START
                        TransCodes.Reset();
                        TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SetRange(TransCodes.Taxable, false);
                        if TransCodes.Find('-') then
                            // MESSAGE('PASSED');
                            // MESSAGE('PASSED');

                            subTotnonTaxAmount := subTotnonTaxAmount + PeriodTrans.Amount;

                        //Statutory Deductions**********************************************************START
                        if (PeriodTrans."Group Order" = 7) then
                            subTotstatutoryDed := subTotstatutoryDed + PeriodTrans.Amount;

                        //Non Statutory Deductions*************START
                        if (PeriodTrans."Group Order" = 7) then
                            subTotnonstatutoryDed := subTotnonstatutoryDed + PeriodTrans.Amount;

                        //Pension *************************** please redo this ;-) dennis tihihihi
                        if (PeriodTrans."Transaction Code" = '0007') then
                            subTotPension := subTotPension + PeriodTrans.Amount;

                        //Total Deductions***********************
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) then
                            subtotTotalDeductions := subtotTotalDeductions + PeriodTrans.Amount;

                        //Net Pay************************START
                        if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then
                            if PeriodTrans.Amount < 0 then
                                subTotNetPay := subTotNetPay + 0
                            else
                                subTotNetPay := subTotNetPay + PeriodTrans.Amount;
                    //MESSAGE('%1',PeriodTrans.Amount);
                    until PeriodTrans.Next() = 0
                else
                    CurrReport.Skip();
            end;
        }
        dataitem("prPayroll Periods"; "prPayroll Periods")
        {
            RequestFilterFields = "Date Opened";
            column(ReportForNavId_4946; 4946)
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
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

        SelectedPeriod := DateFilter;//"prPayroll Periods".GETRANGEMIN("Date Opened");;
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then
            PeriodName := objPeriod."Period Name";
        // MESSAGE('%1,',PeriodName);

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        TransCodes: Record "PR Transaction Codes";
        strCodes: Code[10];
        DateFilter: Date;
        SelectedPeriod: Date;
        Allow: Decimal;
        Grosspay: Decimal;
        HseAllow: Decimal;
        negNet: Decimal;
        NetPay: Decimal;
        nonstatutoryDed: Decimal;
        nonTaxAmount: Decimal;
        Nssf: Decimal;
        OtherAllow: Decimal;
        PenGrat: Decimal;
        Pension: Decimal;
        Reliefs: Decimal;
        statutoryDed: Decimal;
        subTotBasicPay: Decimal;
        SubTotGrosspay: Decimal;
        subTotHseAllow: Decimal;
        subTotNetPay: Decimal;
        subTotnonstatutoryDed: Decimal;
        subTotnonTaxAmount: Decimal;
        SubTotOtherAllow: Decimal;
        subTotPension: Decimal;
        subTotstatutoryDed: Decimal;
        subtotTotalDeductions: Decimal;
        TaxablePay: Decimal;
        TotalDeductions: Decimal;
        TotBasicPay: Decimal;
        TotGrosspay: Decimal;
        TotnegNet: Decimal;
        TotNetPay: Decimal;
        TotnonstatutoryDed: Decimal;
        TotnonTaxAmount: Decimal;
        TotOtherAllow: Decimal;
        TotPension: Decimal;
        TotstatutoryDed: Decimal;
        totTotalDeductions: Decimal;
        Basic_PayCaptionLbl: label 'Basic Pay';
        Checked_byCaptionLbl: label 'Checked by';
        Employee_Code_CaptionLbl: label 'Employee Code:';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Gross_Taxable_PayCaptionLbl: label 'Gross Taxable Pay';
        Negative_Net_PayCaptionLbl: label 'Negative Net Pay';
        Net_PayCaptionLbl: label 'Net Pay';
        Non_Statutory_DeductionsCaptionLbl: label 'Non Statutory Deductions';
        Non_Taxable_AmountCaptionLbl: label 'Non-Taxable Amount';
        Other_AllowancesCaptionLbl: label 'Other Allowances';
        Payroll_Summary_Per_DepartmentCaptionLbl: label 'Payroll Summary-Per Department';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Sub_Totals_CaptionLbl: label 'Sub Totals:';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Totals_CaptionLbl: label 'Totals:';
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        PeriodName: Text[50];
        strEmpName: Text[100];
}
