Report 85288 "prPayrollSummary5 mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayrollSummary5mst.rdl';

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
                column(HOUSE; HOUSE)
                {
                }
                column(TRANS; TRANS)
                {
                }
                column(ERELIEF; ERELIEF)
                {
                }
                column(R; R)
                {
                }
                column(INC; INC)
                {
                }
                column(LEAVE; LEAVE)
                {
                }
                column(EDU; EDUC)
                {
                }
                column(UTIL; UTIL)
                {
                }
                column(DOMES; DOMES)
                {
                }
                column(MEDICAL; MEDICAL)
                {
                }
                column(NYSC; NYSC)
                {
                }
                column(XMASS; XMASS)
                {
                }
                column(FURN; FURN)
                {
                }
                column(BAREAS; BAREAS)
                {
                }
                column(ENTER; ENTER)
                {
                }
                column(TAX; TAX)
                {
                }
                column(PENSIONN; PENSIONN)
                {
                }
                column(AVC; AVC)
                {
                }
                column(SCBANK; SCBANK)
                {
                }
                column(AGLCO; AGLCO)
                {
                }
                column(GUINEA; GUINEA)
                {
                }
                column(LTCOOP; LTCOOP)
                {
                }
                column(SALREC; SALREC)
                {
                }
                column(SALDEDUC; SALDEDUC)
                {
                }
                column(LOAN; LOAN)
                {
                }
                column(NBCCOOP; NBCCOOP)
                {
                }
                column(HITV; HITV)
                {
                }
                column(LEVY; LEVY)
                {
                }
                column(FAMILY; FAMILY)
                {
                }
                column(OTHERALL; OTHERALL)
                {
                }
                column(DRIVE; DRIVE)
                {
                }
                column(OVERTIME; OVERTIME)
                {
                }
                column(SIWES; SIWES)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                    strCodes := "No.";

                    /*
                  TotBasicPay:=0;
                  TotGrosspay:=0;
                  TotNetPay:=0;
                     */

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
                    HOUSE := 0;
                    TRANS := 0;
                    ERELIEF := 0;
                    R := 0;
                    INC := 0;
                    LEAVE := 0;
                    EDUC := 0;
                    UTIL := 0;
                    DOMES := 0;
                    MEDICAL := 0;
                    NYSC := 0;
                    XMASS := 0;
                    FURN := 0;
                    BAREAS := 0;
                    ENTER := 0;
                    TAX := 0;
                    PENSIONN := 0;
                    AVC := 0;
                    SCBANK := 0;
                    AGLCO := 0;
                    GUINEA := 0;
                    LTCOOP := 0;
                    SALREC := 0;
                    SALDEDUC := 0;
                    LOAN := 0;
                    NBCCOOP := 0;
                    HITV := 0;
                    LEVY := 0;
                    FAMILY := 0;
                    OTHERALL := 0;
                    DRIVE := 0;
                    OVERTIME := 0;
                    SIWES := 0;

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
                            /*
                           //Other Allowances************************START
                             IF (PeriodTrans."Group Order"=3) AND (PeriodTrans."Sub Group Order"=0) THEN
                             BEGIN
                               OtherAllow:= OtherAllow+PeriodTrans.Amount;
                               TotOtherAllow:=TotOtherAllow+PeriodTrans.Amount;
                             END;
                              */
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

                            //CYRUS MODIFIED
                            //housing *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'HSEDIR') or (PeriodTrans."Transaction Code" = 'HSEEXP') or (PeriodTrans."Transaction Code" = 'HSEIT') or
                             (PeriodTrans."Transaction Code" = 'HSEJN') or (PeriodTrans."Transaction Code" = 'HSESN') then
                                HOUSE := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //transport *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'TRANSDIR') or (PeriodTrans."Transaction Code" = 'TRANSEXP') or (PeriodTrans."Transaction Code" = 'TRANSIT') or
                             (PeriodTrans."Transaction Code" = 'TRANSJN') or (PeriodTrans."Transaction Code" = 'TRANSSN') then
                                TRANS := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //Erelief *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'E-RELIEFDIR') or (PeriodTrans."Transaction Code" = 'E-RELIEFEXP') or (PeriodTrans."Transaction Code" = 'E-RELIEFIT') or
                             (PeriodTrans."Transaction Code" = 'E-RELIEFJN') or (PeriodTrans."Transaction Code" = 'E-RELIEFSN') then
                                ERELIEF := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //INC *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'INCDIR') or (PeriodTrans."Transaction Code" = 'INCEXP') or (PeriodTrans."Transaction Code" = 'INCIT') or
                             (PeriodTrans."Transaction Code" = 'INCJN') or (PeriodTrans."Transaction Code" = 'INCSN') then
                                INC := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //LEAVE *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'LEAVE') or (PeriodTrans."Transaction Code" = 'LEAVEJN') or (PeriodTrans."Transaction Code" = 'LEAVESN') then
                                LEAVE := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //OVERTIME *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'OT') or (PeriodTrans."Transaction Code" = 'DOT') or (PeriodTrans."Transaction Code" = 'PHOLS') then
                                OVERTIME := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //EDU *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'EDUDIR') or (PeriodTrans."Transaction Code" = 'EDUJN') or (PeriodTrans."Transaction Code" = 'EDUSN') then
                                EDUC := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //UTIL *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'UTILDIR') or (PeriodTrans."Transaction Code" = 'UTILEXP') or (PeriodTrans."Transaction Code" = 'UTILIT') or
                             (PeriodTrans."Transaction Code" = 'UTILJN') or (PeriodTrans."Transaction Code" = 'UTILSN') then
                                UTIL := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //DOMES *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'DOME') or (PeriodTrans."Transaction Code" = 'DOME2') or (PeriodTrans."Transaction Code" = 'DOMEEXP') or
                             (PeriodTrans."Transaction Code" = 'DOMESN') then
                                DOMES := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //OTHER ALLOWANCE *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'OTHERS-A') or (PeriodTrans."Transaction Code" = 'OTHERS-A2') or (PeriodTrans."Transaction Code" = 'OTHERS-ADIR') or
                             (PeriodTrans."Transaction Code" = 'OTHERS-AEXP') or (PeriodTrans."Transaction Code" = 'OTHERS-AIT') or (PeriodTrans."Transaction Code" = 'OTHERS-AJN')
                             or (PeriodTrans."Transaction Code" = 'OTHERS-ASN') then
                                OTHERALL := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //XMAASS *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'XMAS') or (PeriodTrans."Transaction Code" = 'XMAS2') then
                                XMASS := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //FURN *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'FURNDIR') or (PeriodTrans."Transaction Code" = 'FURNEXP') or (PeriodTrans."Transaction Code" = 'FURNIT') or
                             (PeriodTrans."Transaction Code" = 'FURNJN') or (PeriodTrans."Transaction Code" = 'FURNSN') then
                                FURN := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //FURN *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'BAREASDIR') or (PeriodTrans."Transaction Code" = 'BAREASEXP') or (PeriodTrans."Transaction Code" = 'BAREASIT') or
                             (PeriodTrans."Transaction Code" = 'BAREASSN') or (PeriodTrans."Transaction Code" = 'BAREAJJN') then
                                BAREAS := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //ENTER *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'ENTDIR') or (PeriodTrans."Transaction Code" = 'ENTEXP') or (PeriodTrans."Transaction Code" = 'ENTIT') or
                             (PeriodTrans."Transaction Code" = 'ENTJN') or (PeriodTrans."Transaction Code" = 'ENTSN') then
                                ENTER := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //rIMBUSE *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'RIMBUSE') then
                                R := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //NYSC *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'SIWES') then
                                SIWES := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //ENTER *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'ENTDIR') or (PeriodTrans."Transaction Code" = 'ENTEXP') or (PeriodTrans."Transaction Code" = 'ENTIT') or
                             (PeriodTrans."Transaction Code" = 'ENTJN') or (PeriodTrans."Transaction Code" = 'ENTSN') then
                                ENTER := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //DRIVE *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'DRIV') or (PeriodTrans."Transaction Code" = 'DRIVJN') or (PeriodTrans."Transaction Code" = 'DRIVSN') then
                                DRIVE := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //TAX *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'PAYE') or (PeriodTrans."Transaction Code" = 'PAYE50%') or (PeriodTrans."Transaction Code" = 'PAYE-CONT') or
                             (PeriodTrans."Transaction Code" = 'PAYE-EXP') then
                                TAX := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //PENSION *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'PENS') or (PeriodTrans."Transaction Code" = 'PENS2') then
                                PENSIONN := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //AVC *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'AVC') then
                                AVC := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //SCBANK *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'SCBANK') then
                                SCBANK := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'LT-COOP') then
                                LTCOOP := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'RECOV') or (PeriodTrans."Transaction Code" = 'SAL DECT.') then
                                SALREC := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'LOAN') or (PeriodTrans."Transaction Code" = 'LOAN-S') then
                                LOAN := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'NBC COOP') then
                                NBCCOOP := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'LEVY') then
                                LEVY := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            // *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = 'FAMILY') then
                                FAMILY := PeriodTrans.Amount;
                            //TotPension:=TotPension+PeriodTrans.Amount;

                            //CYRUS MODIFIED

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
        AGLCO: Decimal;
        Allow: Decimal;
        AVC: Decimal;
        BAREAS: Decimal;
        DOMES: Decimal;
        DRIVE: Decimal;
        EDUC: Decimal;
        ENTER: Decimal;
        ERELIEF: Decimal;
        FAMILY: Decimal;
        FURN: Decimal;
        Grosspay: Decimal;
        GUINEA: Decimal;
        HITV: Decimal;
        HOUSE: Decimal;
        HseAllow: Decimal;
        INC: Decimal;
        LEAVE: Decimal;
        LEVY: Decimal;
        LOAN: Decimal;
        LTCOOP: Decimal;
        MEDICAL: Decimal;
        NBCCOOP: Decimal;
        negNet: Decimal;
        NetPay: Decimal;
        nonstatutoryDed: Decimal;
        nonTaxAmount: Decimal;
        Nssf: Decimal;
        NYSC: Decimal;
        OTHERALL: Decimal;
        OtherAllow: Decimal;
        OVERTIME: Decimal;
        PenGrat: Decimal;
        Pension: Decimal;
        PENSIONN: Decimal;
        R: Decimal;
        Reliefs: Decimal;
        SALDEDUC: Decimal;
        SALREC: Decimal;
        SCBANK: Decimal;
        SIWES: Decimal;
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
        TAX: Decimal;
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
        TRANS: Decimal;
        UTIL: Decimal;
        XMASS: Decimal;
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
