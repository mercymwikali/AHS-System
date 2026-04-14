namespace PTL.HMISBC;
using Microsoft.Foundation.Company;
using System.Security.User;

report 85007 "P10 Ver 26"
{
    Caption = 'P10 Ver 26';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Payroll/P10V26.rdl';
    ApplicationArea = All;
    
    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            DataItemTableView = sorting("Employee Code");
            column(PayrollNo_PayrollEmployee; "prSalary Card"."Employee Code")
            {
            }
            column(Names_PayrollEmployee; EmployeeName)
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
            column(PIN; PIN)
            {
            }
            column(PersonalRelief; PersonalRelief)
            {
            }
            column(primarysecondary; primarysecondary)
            {
            }
            column(TaxableAmount; TaxableAmount)
            {
            }
            column(PAYEAmount; PAYEAmount)
            {
            }
            column(TaxCharged1; TaxCharged1)
            {
            }
            column(InsRelief; InsRelief)
            {
            }
            column(ahlrelief; ahlrelief)
            {
            }
            column(AllBenefits; AllBenefits)
            {
            }
            column(sadvance; sadvance)
            {
            }
            column(ArrearsSal; ArrearsSal)
            {
            }
            column(VariablePay; VariablePay)
            {
            }
            column(TransAllow; TransAllow)
            {
            }
            column(HseAllow; HseAllow)
            {
            }
            column(incentives; incentives)
            {
            }
            column(Responsibility; Responsibility)
            {
            }
            column(Risk; Risk)
            {
            }
            column(Bonus; Bonus)
            {
            }
            column(Travel; Travel)
            {
            }
            column(leave; leave)
            {
            }
            column(afyasacco; afyasacco)
            {
            }
            column(provident; provident)
            {
            }
            column(voluntary; voluntary)
            {
            }
            column(sacco; sacco)
            {
            }
            column(helb; helb)
            {
            }
            column(moneycloud; moneycloud)
            {
            }
            column(kcbloan; kcbloan)
            {
            }
            column(amref; amref)
            {
            }
            column(staffwelfare; staffwelfare)
            {
            }
            column(stima; stima)
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
            column(Period; SelectedPeriod)
            {
            }
            column(USERID; UserId)
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
            column(OtherAllow; otherallowances)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(nonstatutoryDed; nonstatutoryDed)
            {
            }
            column(Defincont; Defincont)
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
            column(TotOtherAllow; otherallowances)
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
            column(HR_Employee_No_; "Employee Code")
            {
            }
            column(Paye_Ded; PAYEDed)
            {
            }
            column(Nssf_Ded; NSSFDed)
            {
            }
            column(Nhif_Ded; NHIFDed)
            {
            }
            column(shif; shif)
            {
            }
            column(hleavy; hleavy)
            {
            }
            column(mortgageM; mortgageM)
            {
            }
            column(NSSF2; NSSF2)
            {
            }
            column(Relief2; Relief2)
            {
            }
            column(TotPAYE; TotPAYEDed)
            {
            }
            column(TotNSSF; TotNSSFDed)
            {
            }
            column(TotNHIF; TotNHIFDed)
            {
            }
            column(HseTotAllow; HseTotAllow)
            {
            }
            column(TotalTransAllow; TotalTransAllow)
            {
            }
            column(overtime; overtime)
            {
            }
            column(OverTimeTotal; OverTimeTotal)
            {
            }
            column(Aggregate; Aggregate)
            {
            }
            column(TotalAgg; TotalAgg)
            {
            }
            column(StaffBonus; StaffBonus)
            {
            }
            column(TotalSArrears; TotalStaff)
            {
            }
            column(ShareCont; ShareCont)
            {
            }
            column(TotalShareCont; TotalShareCont)
            {
            }
            column(LoanRepay; LoanRepay)
            {
            }
            column(TotalLoanRepay; TotalLoanRepay)
            {
            }
            column(ADV12; ADV12)
            {
            }
            column(TotalADV12; TotalADV12)
            {
            }
            column(IntRepay; IntRepay)
            {
            }
            column(TotInt; TotInt)
            {
            }
            column(HseLoan; HseLoan)
            {
            }
            column(TotalHseLoan; TotalHseLoan)
            {
            }
            column(allowances; allowances)
            {
            }
            column(Pension; Pension)
            {
            }
            column(swelfare; swelfare)
            {
            }
            column(counter; counter)
            {
            }
            column(saladvance; saladvance)
            {
            }
            column(PhysicalDisability; PhysicalDisability) { }
            column(TaxExemptionCertificate; TaxExemptionCertificate) { }
            trigger OnPreDataItem();
            begin
                if PayrollMode <> Payrollmode::" " then begin
                    "prSalary Card".SetRange("prSalary Card"."Payment Mode", PayrollMode);
                end;
            end;

            trigger OnAfterGetRecord();
            begin

                mortgageM := '';
                InsRelief := 0;
                NSSF2 := '';
                Relief2 := '';
                TaxableAmount := 0;
                TaxCharged1 := 0;
                PAYEAmount := 0;
                AllBenefits := 0;
                BasicPay := 0;
                Allow := 0;
                ahlrelief := 0;
                Responsibility := 0;
                PhysicalDisability := '';
                Risk := 0;
                Bonus := 0;
                Travel := 0;
                leave := 0;
                provident := 0;
                afyasacco := 0;
                kcbloan := 0;
                voluntary := 0;
                helb := 0;
                moneycloud := 0;
                amref := 0;
                sacco := 0;
                stima := 0;
                staffwelfare := 0;
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
                PersonalRelief := 0;
                Pension := 0;
                NSSFDed := 0;
                PAYEDed := 0;
                NHIFDed := 0;
                shif := 0;
                hleavy := 0;
                TransAllow := 0;//fuel
                ArrearsSal := 0;//sal arrears
                ShareCont := 0;
                HseLoan := 0;//staff loans
                LoanRepay := 0;//advance
                IntRepay := 0;
                ADV12 := 0;
                overtime := 0;//reimbursements
                Aggregate := 0;
                PAYETaxDeduction := 0;
                SArrears := 0;
                StaffBonus := 0;//phone
                Defincont := 0;
                VariablePay := 0;
                SchoolFeeAmount := 0;
                EmployeeName := '';
                TaxExemptionCertificate := '';
                //counter:=counter+1;
                if HREmployee.Get("prSalary Card"."Employee Code") then begin
                    EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    PIN := HREmployee."PIN Number";

                    if HREmployee."Physical Disability" then
                        PhysicalDisability := 'Yes'
                    else
                        PhysicalDisability := 'No';

                end;

                if ("prSalary Card"."Pays 30% PAYE" = true) or ("prSalary Card"."Pays PAYE" = false) then begin
                    primarysecondary := 'Secondary Employee';
                    PersonalRelief := 0;
                    Relief2 := Relief2;
                end else
                    if "prSalary Card"."Pays 30% PAYE" = false then begin
                        primarysecondary := 'Primary Employee';
                        PersonalRelief := 2400;
                        Relief2 := '2400';
                        mortgageM := '0';
                    end;
                saladvance := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "prSalary Card"."Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                if PeriodTrans.Find('-') then
                    counter := counter + 1;
                //Loop through the Income/Earnings and deductions************************************************************************
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "prSalary Card"."Employee Code");
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
                        //	 IF BasicPay=0 THEN BEGIN//E0008// locum from basic
                        //	   IF (PeriodTrans."Transaction Code"='E0008') THEN
                        //	BEGIN
                        //	   BasicPay:=PeriodTrans.Amount;
                        //	   //HseTotAllow:=HseTotAllow+PeriodTrans.Amount;
                        //	END;
                        //END;
                        // HOUSE ALLOWANCE///staff loans, felix richard
                        if (PeriodTrans."Transaction Code" = 'E0001') then begin
                            HseAllow := HseAllow + PeriodTrans.Amount;
                            HseTotAllow := HseTotAllow + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0003') then//responsibility clmc
                           begin
                            Responsibility := Responsibility + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0002') then//Risk Allowance
                            begin
                            Risk := Risk + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0006') then//bonus clmc
                            begin
                            Bonus := Bonus + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0005') then//locum clmc
                            begin
                            leave := leave + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0009') then//travel clmc
                            begin
                            Travel := Travel + PeriodTrans.Amount;
                        end;
                        // HOUSE ALLOWANCE
                        //Incentives clmc
                        if (PeriodTrans."Transaction Code" = 'E0006') then begin
                            incentives := incentives + PeriodTrans.Amount;
                            TotalIncentives := TotalIncentives + PeriodTrans.Amount;
                        end;
                        //Incentives
                        //fuel all felix richard///overtime clmc
                        if (PeriodTrans."Transaction Code" = 'E0004') then begin
                            TransAllow := TransAllow + PeriodTrans.Amount;
                            //TotalIncentives:=TotalIncentives+PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0011') then//arrears
                            begin
                            ArrearsSal := ArrearsSal + PeriodTrans.Amount;
                            //TotalIncentives:=TotalIncentives+PeriodTrans.Amount;
                        end;
                        //
                        if (PeriodTrans."Transaction Code" = 'E0012') then//arrears
                            begin
                            VariablePay := VariablePay + PeriodTrans.Amount;
                            //TotalIncentives:=TotalIncentives+PeriodTrans.Amount;
                        end;
                        //clmc Deductions
                        if (PeriodTrans."Transaction Code" = 'D0011') then//afya
                           begin
                            afyasacco := afyasacco + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0001') then//provident
                           begin
                            provident := provident + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0002') then//voluntary
                           begin
                            voluntary := voluntary + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0003') then//sacco loans-staff
                            begin
                            sacco := sacco + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0007') then//HELB deductions
                            begin
                            helb := helb + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0015') then//money cloud
                            begin
                            moneycloud := moneycloud + PeriodTrans.Amount;
                        end;
                        //D0016
                        if (PeriodTrans."Transaction Code" = 'D0016') or (PeriodTrans."Transaction Code" = 'D0017') then//kcb Loan
                            begin
                            kcbloan := kcbloan + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0018') then//AMREF
                            begin
                            amref := amref + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0004') or (PeriodTrans."Transaction Code" = 'D0003') then//Stima
                            begin
                            stima := stima + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'D0006') or (PeriodTrans."Transaction Code" = 'D0005') then//Staff Welfare
                            begin
                            staffwelfare := staffwelfare + PeriodTrans.Amount;
                        end;
                        ///
                        //Defined Contribution ......start
                        Defincont := NSSFDed;
                        TotDefincont := NSSFDed;
                        //Defined Contribution.....End
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
                        TransCodes.Reset;
                        TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SetRange(TransCodes.Taxable, false);
                        if TransCodes.FindFirst then begin
                            nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                            TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                        end;
                        //Statutory Deductions*************START
                        if (PeriodTrans."Group Order" = 7) then begin
                            statutoryDed := statutoryDed + PeriodTrans.Amount;
                            TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                        end;
                        //NSSF tier 1
                        if (PeriodTrans."Transaction Code" = 'NSSF Tier 1') then begin
                            NSSFDed := NSSFDed + PeriodTrans.Amount;
                            TotNSSFDed := TotNSSFDed + PeriodTrans.Amount;
                        end;
                        // NSSF Tier 2
                        if (PeriodTrans."Transaction Code" = 'NSSF Tier 2') then begin
                            NSSFDed := NSSFDed + PeriodTrans.Amount;
                            TotNSSFDed := TotNSSFDed + PeriodTrans.Amount;
                        end;

                        if PersonalRelief <> 0 then begin
                            NSSF2 := Format(NSSFDed);
                        end;
                        //SHIF
                        //NHIF
                        if (PeriodTrans."Transaction Code" = 'NHIF') then begin
                            NHIFDed := NHIFDed + PeriodTrans.Amount;
                            TotNHIFDed := TotNHIFDed + PeriodTrans.Amount;
                        end;
                        //SHIF
                        if (PeriodTrans."Transaction Code" = 'SHIF') then begin
                            shif := shif + PeriodTrans.Amount;
                            shif := ROUND(shif, 1, '=');
                            //TotNHIFDed:=TotNHIFDed+PeriodTrans.Amount;
                            //paye:=ROUND(PayeAmount,1,'=');
                        end;
                        //Housing Leavy
                        if (PeriodTrans."Transaction Code" = 'HLEVY') then begin
                            hleavy := hleavy + PeriodTrans.Amount;
                            //TotNHIFDed:=TotNHIFDed+PeriodTrans.Amount;
                        end;
                        //PAYEE
                        if (PeriodTrans."Transaction Code" = 'PAYE') then begin
                            PAYEDed := PAYEDed + PeriodTrans.Amount;
                            PAYEAmount := PAYEAmount + PeriodTrans.Amount;
                            //TotPAYEDed:=TotPAYEDed+PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'NHIFR') then begin
                            InsRelief := InsRelief + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'TXBP') then begin
                            TaxableAmount := TaxableAmount + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'TXCHRG') then begin
                            TaxCharged1 := TaxCharged1 + PeriodTrans.Amount;
                        end;
                        //Misl dedu *************************** please redo this ;-) dennis tihihihi
                        if (PeriodTrans."Transaction Code" = 'D004') then begin
                            Pension := Pension + PeriodTrans.Amount;
                            TotPension := TotPension + PeriodTrans.Amount;
                        end;
                        // Phone
                        if (PeriodTrans."Transaction Code" = 'E008') then begin
                            overtime := overtime + PeriodTrans.Amount;
                            OverTimeTotal := OverTimeTotal + PeriodTrans.Amount;
                        end;
                        // OVERTIME
                        // Fuel
                        if (PeriodTrans."Transaction Code" = 'E009') then begin
                            Aggregate := Aggregate + PeriodTrans.Amount;
                            TotalAgg := TotalAgg + PeriodTrans.Amount;
                        end;
                        if (PeriodTrans."Transaction Code" = 'E0010') then
                            SchoolFeeAmount := PeriodTrans.Amount;

                        AllBenefits := BasicPay + HseAllow + TransAllow + leave + Responsibility + Bonus + Risk + Travel + ArrearsSal + VariablePay + SchoolFeeAmount;
                        // AGGREGATION
                        // Staff Loan//afya SACCO
                        if (PeriodTrans."Transaction Code" = 'D0011') then begin
                            StaffBonus := StaffBonus + PeriodTrans.Amount;
                            TotalStaff := TotalStaff + PeriodTrans.Amount;
                        end;
                        // Staff Loan
                        // Staff advance
                        if (PeriodTrans."Transaction Code" = 'D0007') then begin
                            sadvance := sadvance + PeriodTrans.Amount;
                            Totalsadvance := Totalsadvance + PeriodTrans.Amount;
                        end;
                        // Staff advance
                        // reimbursement//voluntary
                        if (PeriodTrans."Transaction Code" = 'D0002') then begin
                            swelfare := swelfare + PeriodTrans.Amount;
                            //Totalswelfare:=Totalswelfare+PeriodTrans.Amount;
                        end;
                        // Staff welfare
                        //other allowances//provident
                        if (PeriodTrans."Transaction Code" = 'D0001') then begin
                            allowances := PeriodTrans.Amount;
                            //Totalswelfare:=Totalswelfare+PeriodTrans.Amount;
                        end;
                        // BOSA LOAN REPAYMENT DEDUCTION
                        if (PeriodTrans."Transaction Code" = 'D016') or (PeriodTrans."Transaction Code" = 'D010')
                            or (PeriodTrans."Transaction Code" = 'D005') or (PeriodTrans."Transaction Code" = 'D007')
                        //OR (PeriodTrans."Transaction Code"='D008') OR (PeriodTrans."Transaction Code"='D009')
                        //OR (PeriodTrans."Transaction Code"='D013') OR (PeriodTrans."Transaction Code"='D014')
                        //OR (PeriodTrans."Transaction Code"='D019')
                        then begin
                            LoanRepay := LoanRepay + PeriodTrans.Amount;
                            TotalLoanRepay := TotalLoanRepay + PeriodTrans.Amount;
                        end;
                        // BOSA LOAN REPAYMENT DEDUCTION
                        // FOSA ADVANCES REPAYMENT DEDUCTION//AMREF
                        if (PeriodTrans."Transaction Code" = 'D0018') then begin
                            ADV12 := ADV12 + PeriodTrans.Amount;
                            TotalADV12 := TotalADV12 + PeriodTrans.Amount;
                        end;
                        // FOSA ADVANCES REPAYMENT DEDUCTION
                        // STAFF HOUSE LOAN
                        if (PeriodTrans."Transaction Code" = 'B012') or (PeriodTrans."Transaction Code" = 'B002') then begin
                            HseLoan := HseLoan + PeriodTrans.Amount;
                            TotalHseLoan := TotalHseLoan + PeriodTrans.Amount;
                        end;
                        // STAFF HOUSE LOAN
                        //Interest Deduction************************START
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 1) then begin
                            IntRepay := IntRepay + PeriodTrans.Amount;
                            TotInt := TotInt + PeriodTrans.Amount;
                        end;
                        //Helb
                        if PeriodTrans."Transaction Code" = 'D0007' then begin
                            saladvance := PeriodTrans.Amount;
                        end;
                        // SHARES  CONTRIBUTION//money cloud
                        if (PeriodTrans."Transaction Code" = 'D0015') then begin
                            ShareCont := ShareCont + PeriodTrans.Amount;
                            TotalShareCont := TotalShareCont + PeriodTrans.Amount;
                        end;
                        // SHARES CONTRIBUTION
                        //Total Deductions***********************
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) then begin
                            TotalDeductions := TotalDeductions + PeriodTrans.Amount;  //+NHIFDed+NSSFDed+PAYEDed;;
                            totTotalDeductions := totTotalDeductions + PeriodTrans.Amount;
                            //otherallowances:=TotalDeductions;
                        end;
                        //Net Pay************************START
                        if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then begin
                            if PeriodTrans.Amount < 0 then begin
                                NetPay := NetPay + 0;
                                TotNetPay := TotNetPay + 0;
                                negNet := PeriodTrans.Amount;
                                TotnegNet := TotnegNet + PeriodTrans.Amount;
                            end
                            else begin
                                //other non taxable*************START
                                TransCodes.Reset;
                                TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                                TransCodes.SetRange(TransCodes.Taxable, false);
                                if TransCodes.FindFirst then begin
                                    nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                                    //TotnonTaxAmount:=TotnonTaxAmount+PeriodTrans.Amount;
                                    TotnonTaxAmount := TotnonTaxAmount + nonTaxAmount;
                                end;
                                //Statutory Deductions*************START
                                if (PeriodTrans."Group Order" = 7) then begin
                                    statutoryDed := statutoryDed + PeriodTrans.Amount;
                                    TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                                end;
                                //objEmp.RESET;
                                //objEmp.SETRANGE(objEmp."prSalary Card"."Employee Code","prSalary Card"."Employee Code");
                                //IF objEmp.FIND('-') THEN BEGIN
                                //IF objEmp."Full / Part Time"=objEmp."Full / Part Time"::"Full Time" THEN BEGIN
                                NetPay := NetPay + PeriodTrans.Amount;
                                TotNetPay := TotNetPay + PeriodTrans.Amount;
                                //END
                                //ELSE
                                //IF objEmp."Full / Part Time"=objEmp."Full / Part Time"::Contract THEN BEGIN
                                //  NetPay:=NetPay+(PeriodTrans.Amount-(PeriodTrans.Amount*0.3));
                                //TotNetPay:=TotNetPay+PeriodTrans.Amount;
                                //END;
                                //END;
                                //TotNetPay:=TotNetPay+PeriodTrans.Amount;
                            end;
                        end;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;
            end;

        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(Content)
            {
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll Period';
                    TableRelation = "prPayroll Periods"."Date Opened";
                }
            }
        }

    }


    trigger OnPreReport()
    begin
        counter := 0;
        SelectedPeriod := DateFilter;//"prPayroll Periods".GETRANGEMIN("Date Opened");
                                     //"prPeriod Transactions".GETRANGEMIN("Payroll Period");
                                     //MESSAGE('%1',SelectedPeriod);
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;
        if CompanyInfo.Get then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        strEmpName: Text[100];
        PIN: Text;
        mortgageM: Text;
        ahlrelief: Decimal;
        VariablePay: Decimal;
        ArrearsSal: Decimal;
        TotalProvident: Decimal;
        PersonalRelief1: Decimal;
        primarysecondary: Text;
        TaxExemptionCertificate: Text;
        AllBenefits: Decimal;
        TaxableAmount: Decimal;
        SchoolFeeAmount: Decimal;
        PAYEAmount: Decimal;
        TaxCharged1: Decimal;
        InsRelief: Decimal;
        BasicPay: Decimal;
        Allow: Decimal;
        Grosspay: Decimal;
        PenGrat: Decimal;
        Nssf: Decimal;
        NSSF2: Text;
        Relief2: Text;
        subTotNssf: Decimal;
        TotBasicPay: Decimal;
        Responsibility: Decimal;
        Risk: Decimal;
        TotAllow: Decimal;
        Bonus: Decimal;
        Travel: Decimal;
        leave: Decimal;
        provident: Decimal;
        voluntary: Decimal;
        sacco: Decimal;
        afyasacco: Decimal;
        helb: Decimal;
        moneycloud: Decimal;
        kcbloan: Decimal;
        amref: Decimal;
        stima: Decimal;
        staffwelfare: Decimal;
        TotGrosspay: Decimal;
        TotPenGrat: Decimal;
        TotNssf: Decimal;
        PeriodTrans: Record "prPeriod Transactions";
        TransCodes: Record "PR Transaction Codes";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PhysicalDisability: Text;
        PeriodName: Text[50];
        periods: Date;
        HseAllow: Decimal;
        HseTotAllow: Decimal;
        HREmployee: Record "HR-Employee";
        subTotNHIF: Decimal;
        TotNHIF: Decimal;
        NHIF: Decimal;
        statutoryDed: Decimal;
        TotstatutoryDed: Decimal;
        subTotstatutoryDed: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        SubTotTaxablePay: Decimal;
        Reliefs: Decimal;
        TotReliefs: Decimal;
        TaxCharged: Decimal;
        TotTaxCharged: Decimal;
        UnusedRelief: Decimal;
        SubTotUnusedRelief: Decimal;
        TotUnusedRelief: Decimal;
        PersonalRelief: Decimal;
        SubTotPersonalRelief: Decimal;
        TotPersonalRelief: Decimal;
        PAYETaxDeduction: Decimal;
        TotPAYETaxDeduction: Decimal;
        OtherDeduction: Decimal;
        TotOtherDeduction: Decimal;
        NetPay: Decimal;
        subTotNetPay: Decimal;
        TotNetPay: Decimal;
        subTotBasicPay: Decimal;
        subTotHseAllow: Decimal;
        SubTotGrosspay: Decimal;
        OtherAllow: Decimal;
        TotOtherAllow: Decimal;
        SubTotOtherAllow: Decimal;
        subtotTotalDeductions: Decimal;
        totTotalDeductions: Decimal;
        TotalDeductions: Decimal;
        companyHousing: Decimal;
        TotcompanyHousing: Decimal;
        SubTotcompanyHousing: Decimal;
        subTotReliefs: Decimal;
        SubTotTaxCharged: Decimal;
        subtotPAYETaxDeduction: Decimal;
        subTotOtherDeductions: Decimal;
        nonTaxAmount: Decimal;
        TotnonTaxAmount: Decimal;
        subTotnonTaxAmount: Decimal;
        nonstatutoryDed: Decimal;
        TotnonstatutoryDed: Decimal;
        subTotnonstatutoryDed: Decimal;
        Pension: Decimal;
        TotPension: Decimal;
        subTotPension: Decimal;
        negNet: Decimal;
        TotnegNet: Decimal;
        subTotnegNet: Decimal;
        strCodes: Code[10];
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        Payroll_Summary_ListCaptionLbl: label 'Payroll Summary-List';
        Gross_Taxable_PayCaptionLbl: label 'Gross Taxable Pay';
        Non_Taxable_AmountCaptionLbl: label 'Non-Taxable Amount';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Negative_Net_PayCaptionLbl: label 'Negative Net Pay';
        Other_AllowancesCaptionLbl: label 'Other Allowances';
        Net_PayCaptionLbl: label 'Net Pay';
        Basic_PayCaptionLbl: label 'Basic Pay';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Non_Statutory_DeductionsCaptionLbl: label 'Non Statutory Deductions';
        Employee_Code_CaptionLbl: label 'Employee Code:';
        Totals_CaptionLbl: label 'Totals:';
        Checked_byCaptionLbl: label 'Checked by';
        DateFilter: Date;
        PAYEDed: Decimal;
        NSSFDed: Decimal;
        NHIFDed: Decimal;
        TotPAYEDed: Decimal;
        TotNSSFDed: Decimal;
        TotNHIFDed: Decimal;
        objEmp: Record "HR-Employee";
        // net: Record UnknownRecord51109;
        overtime: Decimal;
        OverTimeTotal: Decimal;
        Aggregate: Decimal;
        TotalAgg: Decimal;
        IntRepay: Decimal;
        TotInt: Decimal;
        HseLoan: Decimal;
        TotalHseLoan: Decimal;
        ADV12: Decimal;
        TotalADV12: Decimal;
        LoanRepay: Decimal;
        TotalLoanRepay: Decimal;
        TransAllow: Decimal;
        TotalTransAllow: Decimal;
        TotalSArrears: Decimal;
        SArrears: Decimal;
        ShareCont: Decimal;
        TotalShareCont: Decimal;
        StaffBonus: Decimal;
        TotalStaff: Decimal;
        UserSetup: Record "User Setup";
        Defincont: Decimal;
        TotDefincont: Decimal;
        otherallowances: Decimal;
        sadvance: Decimal;
        swelfare: Decimal;
        Totalsadvance: Decimal;
        Totalswelfare: Decimal;
        incentives: Decimal;
        TotalIncentives: Decimal;
        allowances: Decimal;
        counter: Integer;
        saladvance: Decimal;
        shif: Decimal;
        hleavy: Decimal;

        EmployeeName: Text[200];
}
