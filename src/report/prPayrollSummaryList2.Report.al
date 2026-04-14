Report 85285 "prPayrollSummary-List 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayrollSummaryList2.rdl';

    dataset
    {
        dataitem("prPayroll Periods"; "prPayroll Periods")
        {
            column(ReportForNavId_4946; 4946)
            {
            }
        }
        dataitem("HR-Employee"; "HR-Employee")
        {
            column(ReportForNavId_8631; 8631)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(PayrollMode; PayrollMode)
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
            column(Employee_Pension; EmpPension)
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
            column(TotnegNet; TotnegNet)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(totTotalDeductions; totTotalDeductions)
            {
            }
            column(TotPension; TotPension)
            {
            }
            column(TotnonstatutoryDed; TotnonstatutoryDed)
            {
            }
            column(TotstatutoryDed; TotstatutoryDed)
            {
            }
            column(TotnonTaxAmount; TotnonTaxAmount)
            {
            }
            column(TotGrosspay; TotGrosspay)
            {
            }
            column(TotOtherAllow; TotOtherAllow)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(DATE____________________________________________________________; 'DATE...........................................................')
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
            column(SIGNATURE_____________________________________________________Control1102756035; 'SIGNATURE...................................................')
            {
            }
            column(DATE_____________________________________________________________Control1102756042; 'DATE...........................................................')
            {
            }
            column(NAME__________________________________________________________________________________________Control1102756031; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION______________________________________________________Control1102756034; 'DESIGNATION....................................................')
            {
            }
            column(Payroll_Summary_ListCaption; Payroll_Summary_ListCaptionLbl)
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
            column(Pension_Staff_Cont_Caption; Pension_Staff_Cont_CaptionLbl)
            {
            }
            column(Negative_Net_PayCaption; Negative_Net_PayCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
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
            column(Non_Statutory_DeductionsCaption; Non_Statutory_DeductionsCaptionLbl)
            {
            }
            column(Employee_Code_Caption; Employee_Code_CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Checked_byCaption; Checked_byCaptionLbl)
            {
            }
            column(HR_Employee_No_; "No.")
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
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriodT);
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

                        //Pension *************************** please redo this ;-) dennis tihihihi
                        if (PeriodTrans."Transaction Code" = '0007') then begin
                            Pension := Pension + PeriodTrans.Amount;
                            TotPension := TotPension + PeriodTrans.Amount;
                        end;

                        //Total Deductions***********************
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) then begin
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
                EmpPension := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", HREmployee."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriodT);
                PeriodTrans.SetRange(PeriodTrans."Transaction Name", 'MUST PENSION');
                if PeriodTrans.Find('-') then
                    EmpPension := PeriodTrans.Amount;
            end;

            trigger OnPreDataItem()
            begin
                if PayrollMode <> Payrollmode::" " then
                    "HR-Employee".SetRange("HR-Employee"."Payment Mode", PayrollMode);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PayrollPeriodT; PayrollPeriodT)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period';
                    TableRelation = "prPayroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Period field.';
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

        //SelectedPeriod:="prPayroll Periods".GETRANGEMIN("Date Opened");
        //"prPeriod Transactions".GETRANGEMIN("Payroll Period");

        objPeriod.Reset();
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);

        if objPeriod.Find('-') then
            PeriodName := objPeriod."Period Name";

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        HREmployee: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        TransCodes: Record "PR Transaction Codes";
        strCodes: Code[10];
        PayrollPeriodT: Date;
        SelectedPeriod: Date;
        Allow: Decimal;
        EmpPension: Decimal;
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
        Payroll_Summary_ListCaptionLbl: label 'Payroll Summary-List';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Totals_CaptionLbl: label 'Totals:';
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        PeriodName: Text[50];
        strEmpName: Text[100];
}
