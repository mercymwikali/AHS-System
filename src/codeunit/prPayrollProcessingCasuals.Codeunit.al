Codeunit 85041 "prPayrollProcessing-Casuals"
{
    trigger OnRun()
    begin
    end;

    var
        Customer: Record Customer;
        HrEmployee: Record "HR-Employee";
        PostingGroup: Record "prEmployee Posting Group";
        empsalCard: Record "prSalary Card";
        prsalCard: Record "prSalary Card";
        VitalSetup: Record "prVital Setup Info";
        NHIFEMPyee: Code[20];
        NSSFEMPyee: Code[20];
        NSSFEMPyer: Code[20];
        PayablesAcc: Code[20];
        PayrollType: Code[20];
        PensionEMPyer: Code[20];
        salariesAcc: Code[20];
        TaxAccount: Code[20];
        curgManInsuranceReliefyAmnt: Decimal;
        curgratuityAmnt: Decimal;
        curLoanCorpRate: Decimal;
        curLoanMarketRate: Decimal;
        curMaximumRelief: Decimal;
        curMaxPensionContrib: Decimal;
        curNssf_Employer_Factor: Decimal;
        curNssfEmployee: Decimal;
        curOOIDecemberDedc: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curRateTaxExPension: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curReliefPersonal: Decimal;
        RoundDownDiff: Decimal;
        RoundUpDif: Decimal;
        SpecialTranAmount: Decimal;
        intOldMonth: Integer;
        intOldYear: Integer;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
        selectedPp: Text;

    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst();
        curReliefPersonal := VitalSetup."Tax Relief";
        curReliefInsurance := VitalSetup."Insurance Relief";
        curReliefMorgage := VitalSetup."Mortgage Relief"; //Same as HOSP
        curMaximumRelief := VitalSetup."Max Relief";
        curNssfEmployee := VitalSetup."NSSF Employee";
        curNssf_Employer_Factor := VitalSetup."NSSF Employer Factor";
        intNHIF_BasedOn := VitalSetup."SHIF Based on";
        curMaxPensionContrib := VitalSetup."Max Pension Contribution";
        curRateTaxExPension := VitalSetup."Tax On Excess Pension";
        curOOIMaxMonthlyContrb := VitalSetup."OOI Deduction";
        curOOIDecemberDedc := VitalSetup."OOI December";
        curLoanMarketRate := VitalSetup."Loan Market Rate";
        curLoanCorpRate := VitalSetup."Loan Corporate Rate";
    end;

    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20])
    var
        Customer: Record Customer;
        prEmployeeTransactions: Record "prEmployee Transactions";
        prEmployerDeductions: Record "prEmployer Deductions";
        prPeriodTransactions: Record "prPeriod Transactions";
        prSalaryArrears: Record "prSalary Arrears";
        prTransactionCodes: Record "PR Transaction Codes";
        prUnusedRelief: Record "prUnused Relief";
        JournalAcc: Code[20];
        curBenefits: Decimal;
        curDefinedContrib: Decimal;
        curExcessPension: Decimal;
        curGrossPay: Decimal;
        curGrossTaxable: Decimal;
        curHOSP: Decimal;
        curInsuranceReliefAmount: Decimal;
        curLoanInt: Decimal;
        curNetPay: Decimal;
        curNetRnd_Effect: Decimal;
        curNHIF: Decimal;
        curNhif_Base_Amount: Decimal;
        curNonTaxable: Decimal;
        curNSSF: Decimal;
        curOOI: Decimal;
        curPAYE: Decimal;
        curPayeArrears: Decimal;
        curPensionCompany: Decimal;
        curPensionStaff: Decimal;
        currManualTaxRelief: Decimal;
        curSalaryArrears: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curTaxOnExcessPension: Decimal;
        curTotalDeductions: Decimal;
        curTotAllowances: Decimal;
        curTotCompanyDed: Decimal;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        curUnusedRelief: Decimal;
        curValueOfQuarters: Decimal;
        fnCalcFringeBenefit: Decimal;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        intMonth: Integer;
        intYear: Integer;
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        JournalPostAs: Option " ",Debit,Credit;
        JournalPostingType: Option " ","G/L Account",Customer,Vendor;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Tax Relief ( voluntary nssf)";
        TGroup: Text[30];
        strTransDescription: Text[50];
        strExtractedFrml: Text[250];
        strTransCode: Text[250];
    begin
        //prPeriodTransactions.RESET;
        //prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code",strEmpCode);
        //prPeriodTransactions.SETRANGE(prPeriodTransactions."Payroll Period",dtOpenPeriod);
        //IF prPeriodTransactions.FIND('-') THEN
        //  prPeriodTransactions.DELETEALL;

        //Initialize
        fnInitialize();
        fnGetJournalDet(strEmpCode);
        selectedPp := Format(SelectedPeriod);

        PostingGroup.Reset();
        PostingGroup.SetRange(PostingGroup.Code, 'PAYROLL');
        if PostingGroup.Find('-') then begin

            //check if the period selected=current period. If not, do NOT run this function
            if SelectedPeriod <> dtOpenPeriod then
                exit;
            intMonth := Date2dmy(SelectedPeriod, 2);
            intYear := Date2dmy(SelectedPeriod, 3);
            //Delete all Records from the prPeriod Transactions for Reprocessing
            prPeriodTransactions.Reset();
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", dtOpenPeriod);
            if prPeriodTransactions.Find('-') then
                prPeriodTransactions.DeleteAll();

            //Delete all Records from prEmployer Deductions
            prEmployerDeductions.Reset();
            prEmployerDeductions.SetRange(prEmployerDeductions."Employee Code", strEmpCode);
            prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", dtOpenPeriod);
            if prEmployerDeductions.Find('-') then
                prEmployerDeductions.DeleteAll();

            if ((curBasicPay > 0) or (curBasicPay = 0)) then begin
                //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                    DaysWorked := fnDaysWorked(dtDOE, false);
                    curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                end;

                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                if dtTermination <> 0D then
                    if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                        DaysWorked := fnDaysWorked(dtTermination, true);
                        curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                    end;

                curTransAmount := curBasicPay;
                strTransDescription := 'Basic Pay';
                TGroup := 'BASIC SALARY';
                TGroupOrder := 1;
                TSubGroupOrder := 1;
                salariesAcc := PostingGroup."Salary Account";
                fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
                TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                //Salary Arrears
                prSalaryArrears.Reset();
                prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
                prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
                prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
                if prSalaryArrears.Find('-') then
                    repeat
                        curSalaryArrears := prSalaryArrears."Salary Arrears";
                        curPayeArrears := prSalaryArrears."PAYE Arrears";

                        //Insert [Salary Arrears] into period trans [ARREARS]
                        curTransAmount := curSalaryArrears;
                        strTransDescription := 'Salary Arrears';
                        TGroup := 'ARREARS';
                        TGroupOrder := 1;
                        TSubGroupOrder := 2;
                        salariesAcc := PostingGroup."Salary Account";
                        fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                          strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
                          Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                        //Insert [PAYE Arrears] into period trans [PYAR]
                        curTransAmount := curPayeArrears;
                        strTransDescription := 'P.A.Y.E Arrears';
                        TGroup := 'STATUTORIES';
                        TGroupOrder := 7;
                        TSubGroupOrder := 4;
                        TaxAccount := PostingGroup."Income Tax Account";
                        fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                           strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                           TaxAccount, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none)
                    until prSalaryArrears.Next() = 0;

                //Get Earnings
                prEmployeeTransactions.Reset();
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                if prEmployeeTransactions.Find('-') then begin
                    curTotAllowances := 0;
                    repeat
                        prTransactionCodes.Reset();
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);

                        if prTransactionCodes.Find('-') then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                            strTransDescription := '';
                            strExtractedFrml := '';
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                            end else
                                curTransAmount := prEmployeeTransactions.Amount;

                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
                                curTransBalance := 0;
                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                                curTransBalance := prEmployeeTransactions.Balance - curTransAmount;

                            //Prorate Allowances Here
                            //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                            if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtDOE);
                                DaysWorked := fnDaysWorked(dtDOE, false);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;

                            //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                            if dtTermination <> 0D then
                                if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtTermination);
                                    DaysWorked := fnDaysWorked(dtTermination, true);
                                    curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                                end;
                            // Prorate Allowances Here

                            //Add Non Taxable Here
                            if (not prTransactionCodes.Taxable) and ((
                            prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Gratuity) or
                            (prTransactionCodes."Special Transactions" =
                            prTransactionCodes."special transactions"::Ignore)) then
                                curNonTaxable := curNonTaxable + curTransAmount;

                            //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                            if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                            prTransactionCodes."special transactions"::Ignore) and
                            (prTransactionCodes."Special Transactions" <> prTransactionCodes."special transactions"::Gratuity) then
                                curTransAmount := 0;

                            curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                            curTransAmount := curTransAmount;
                            curTransBalance := curTransBalance;
                            strTransDescription := prTransactionCodes."Transaction Name";
                            TGroup := 'ALLOWANCE';
                            TGroupOrder := 3;
                            TSubGroupOrder := 0;

                            //Get the posting Details
                            JournalPostingType := Journalpostingtype::" ";
                            JournalAcc := '';
                            if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                    HrEmployee.Get(strEmpCode);
                                    Customer.Reset();
                                    Customer.SetRange(Customer."No.", strEmpCode);
                                    if Customer.Find('-') then begin
                                        JournalAcc := Customer."No.";
                                        JournalPostingType := Journalpostingtype::Customer;
                                    end;
                                end;
                            end else begin
                                JournalAcc := prTransactionCodes."GL Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;

                            //End posting Details

                            //For those transactions with Start and End Date Specified
                            if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then
                                if prEmployeeTransactions."End Date" < SelectedPeriod then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            //End Transactions with Start and End Date

                            fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                            strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                            prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType
                            , '', Coopparameters::none);
                        end;
                    until prEmployeeTransactions.Next() = 0;
                end;

                //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
                curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
                curTransAmount := curGrossPay;
                strTransDescription := 'Gross Pay';
                TGroup := 'GROSS PAY';
                TGroupOrder := 4;
                TSubGroupOrder := 0;
                fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
                 intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);

                //Get the NSSF amount
                if blnPaysNssf then
                    curNSSF := curNssfEmployee;
                curTransAmount := curNSSF;
                strTransDescription := 'N.S.S.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 1;
                NSSFEMPyee := PostingGroup."NSSF Employee Account";
                fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
                Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
                curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
                curTransAmount := curDefinedContrib;
                strTransDescription := 'Defined Contributions';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 1;
                fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
                 strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ",
                 Journalpostingtype::" ", '', Coopparameters::none);

                //Get the Gross taxable amount
                //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
                curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

                //>If GrossTaxable = 0 Then TheDefinedToPost = 0
                if curGrossTaxable = 0 then
                    curDefinedContrib := 0;

                //Personal Relief
                // if get relief is ticked  - DENNO ADDED
                blnGetsPAYERelief := blnPaysPaye;
                if blnGetsPAYERelief then begin
                    curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                    curTransAmount := curReliefPersonal;
                    strTransDescription := 'Personal Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 9;
                    fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                     , '', Coopparameters::none);
                end
                else
                    curReliefPersonal := 0;

                //////////////////////////////////////////////////////////////////////////////////////////////////////
                // Disability tax Exemption

                //////////////////////////////////////////////////////////////////////////////////////////////////////

                //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                //>Pension Contribution [self] relief
                curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
                if curPensionStaff > 0 then begin
                    if curPensionStaff > curMaxPensionContrib then
                        curTransAmount := curMaxPensionContrib
                    else
                        curTransAmount := curPensionStaff;
                    strTransDescription := 'Pension Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                    , '', Coopparameters::none)
                end;
                // Has Gratuity
                Clear(curgratuityAmnt);
                curgratuityAmnt := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::Gratuity, false);
                if curgratuityAmnt > 0 then begin
                    curTransAmount := curgratuityAmnt;
                    strTransDescription := 'Tax-Gratuity(30%)';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 11;
                    fnUpdatePeriodTrans(strEmpCode, 'GRAD', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                    , '', Coopparameters::none);
                end;

                /// Capture Manually Entered Insurance Relief
                Clear(curgManInsuranceReliefyAmnt);
                curgManInsuranceReliefyAmnt := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Insurance Relief", false);
                if curgManInsuranceReliefyAmnt > 0 then begin
                    curTransAmount := curgManInsuranceReliefyAmnt;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 12;
                    fnUpdatePeriodTrans(strEmpCode, 'INSR_M', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                    , '', Coopparameters::none);
                end;
                // Capture Manual Tax Relief
                Clear(currManualTaxRelief);
                currManualTaxRelief := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Tax Relief ( voluntary nssf)", false);
                if currManualTaxRelief > 0 then begin
                    curTransAmount := currManualTaxRelief;
                    strTransDescription := 'Tax Relief ( voluntary nssf)';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 12;
                    fnUpdatePeriodTrans(strEmpCode, 'TXR_M', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                    , '', Coopparameters::none);
                end;

                // Tax Relief ( voluntary nssf)

                //if he PAYS paye only*******************
                if blnPaysPaye then begin
                    //Get Insurance Relief
                    curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]
                    if curInsuranceReliefAmount > 0 then begin
                        curTransAmount := curInsuranceReliefAmount;
                        strTransDescription := 'Insurance Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 8;
                        fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                        , '', Coopparameters::none);
                    end;

                    //>OOI
                    curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                    if curOOI > 0 then begin
                        if curOOI <= curOOIMaxMonthlyContrb then
                            curTransAmount := curOOI
                        else
                            curTransAmount := curOOIMaxMonthlyContrb;

                        strTransDescription := 'Owner Occupier Interest';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 3;
                        fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                        , '', Coopparameters::none);
                    end;

                    //HOSP
                    curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                    if curHOSP > 0 then begin
                        if curHOSP <= curReliefMorgage then
                            curTransAmount := curHOSP
                        else
                            curTransAmount := curReliefMorgage;

                        strTransDescription := 'Home Ownership Savings Plan';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 4;
                        fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                        , '', Coopparameters::none);
                    end;

                    //Enter NonTaxable Amount
                    // Commented By Wanjala
                    /*IF curNonTaxable>0 THEN BEGIN
                          strTransDescription := 'Other Non-Taxable Benefits';
                          TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                          fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                          curNonTaxable, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" "
                          ,'',CoopParameters::none);
                    END; */
                end;

                //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                //>Company pension, Excess pension, Tax on excess pension
                curPensionCompany := fnGetPensionAmount(strEmpCode, intMonth, intYear, Specialtranstype::"Defined Contribution",
                true); //Self contrib Pension is 1 on [Special Transaction]
                if curPensionCompany > 0 then begin
                    curTransAmount := curPensionCompany;
                    strTransDescription := 'Pension (Company)';
                    //Update the Employer deductions table

                    curExcessPension := ((curPensionCompany * 3) - curMaxPensionContrib);
                    if curExcessPension > 0 then begin
                        if ((curPensionCompany - curMaxPensionContrib) > 0) then begin
                            curTransAmount := (curPensionCompany - curMaxPensionContrib);
                            strTransDescription := 'Excess Pension';
                            TGroup := 'STATUTORIES';
                            TGroupOrder := 7;
                            TSubGroupOrder := 5;
                            fnUpdatePeriodTrans(strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                             intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                             , '', Coopparameters::none);
                        end;
                        if (((curPensionCompany * 3) - curMaxPensionContrib) > 0) then begin
                            if not ((curPensionCompany - curMaxPensionContrib) > 0) then
                                curTaxOnExcessPension := (curRateTaxExPension / 100) * ((curPensionCompany * 3) - curMaxPensionContrib)
                            else
                                curTaxOnExcessPension := (curRateTaxExPension / 100) * ((curPensionCompany * 2));
                            curTransAmount := curTaxOnExcessPension;
                            strTransDescription := 'Tax on ExPension';
                            TGroup := 'STATUTORIES';
                            TGroupOrder := 7;
                            TSubGroupOrder := 6;
                            fnUpdatePeriodTrans(strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                             intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                             , '', Coopparameters::none);
                        end;
                    end;
                    // clear()
                end;

                //////////////////////////////////////////////////////////////////////////////////////////////////////
                // Disability tax Exemption

                //////////////////////////////////////////////////////////////////////////////////////////////////////

                //Get the Taxable amount for calculation of PAYE
                //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)

                //Add HOSP and MORTGAGE KIM{}
                if curPensionStaff > curMaxPensionContrib then begin
                    if (disabled_emp(strEmpCode, curGrossTaxable) = true) then
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable + 150000 - 200)
                    else
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable - 200);
                end else
                    if (disabled_emp(strEmpCode, curGrossTaxable) = true) then
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable + 150000)
                    else
                        curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable);
                curTransAmount := curTaxablePay;
                strTransDescription := 'Taxable Pay';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 6;
                fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                 , '', Coopparameters::none);

                //Get the Tax charged for the month
                curTaxCharged := fnGetEmployeePaye(curTaxablePay);
                curTransAmount := curTaxCharged;
                strTransDescription := 'Tax Charged';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 7;
                fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" "
                , '', Coopparameters::none);

                //Get the Net PAYE amount to post for the month
                if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                    curPAYE := curTaxCharged - (curMaximumRelief + currManualTaxRelief)
                else
                    curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curgManInsuranceReliefyAmnt + currManualTaxRelief);
                // IF NOT ((curPensionCompany - curMaxPensionContrib)>0) THEN
                curPAYE := curPAYE + curgratuityAmnt + curTaxOnExcessPension;
                // ELSE
                //  curPAYE :=curPAYE+curgratuityAmnt;
                if not blnPaysPaye then
                    curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
                curTransAmount := ROUND((curPAYE));    //,0,'>'
                if curPAYE < 0 then
                    curTransAmount := 0;
                strTransDescription := 'P.A.Y.E';
                TaxAccount := PostingGroup."Income Tax Account";
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 3;
                fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, Journalpostas::Credit,
                 Journalpostingtype::"G/L Account", '', Coopparameters::none);

                //Store the unused relief for the current month
                //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
                if curPAYE < 0 then begin
                    prUnusedRelief.Reset();
                    prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
                    prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                    prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                    if prUnusedRelief.Find('-') then
                        prUnusedRelief.Delete();

                    prUnusedRelief.Reset();
                end;

                //Deductions: get all deductions for the month
                //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
                //>Balance = (Openning Bal + Deduction)...//Increasing balance
                //>Balance = (Openning Bal - Deduction)...//Reducing balance
                //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance

                //Get the N.H.I.F amount for the month GBT
                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                if blnPaysNhif then begin
                    curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                    curTransAmount := curNHIF;
                    NHIFEMPyee := PostingGroup."SHIF Employee Account";
                    strTransDescription := 'N.H.I.F';
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                     NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
                end;

                prEmployeeTransactions.Reset();
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                if prEmployeeTransactions.Find('-') then begin
                    curTotalDeductions := 0;
                    repeat
                        prTransactionCodes.Reset();
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                        if prTransactionCodes.Find('-') then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                            strTransDescription := '';
                            strExtractedFrml := '';

                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                            end else
                                curTransAmount := prEmployeeTransactions.Amount;

                            //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Life Insurance")
                              and (prTransactionCodes."Deduct Premium" = false) then
                                curTransAmount := 0;

                            //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Morgage)
                             and (prTransactionCodes."Deduct Mortgage" = false) then
                                curTransAmount := 0;

                            // Added By Wanjala
                            //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Gratuity)
                             and (prTransactionCodes."Deduct Mortgage" = false) then
                                curTransAmount := prEmployeeTransactions.Amount * 0.3;

                            //Get the posting Details
                            JournalPostingType := Journalpostingtype::" ";
                            JournalAcc := '';
                            if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                    Customer.Reset();
                                    // Customer.SETRANGE(Customer."Payroll/Staff No",strEmpCode);
                                    if Customer.Find('-') then begin
                                        JournalAcc := Customer."No.";
                                        JournalPostingType := Journalpostingtype::Customer;
                                    end;
                                end;
                            end else begin
                                JournalAcc := prTransactionCodes."GL Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;

                            //End posting Details

                            //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Staff Loan") and
                               (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                                curTransAmount := 0;
                                curLoanInt := 0;
                                curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                                prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
                                   prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                                //Post the Interest
                                if (curLoanInt <> 0) then begin
                                    curTransAmount := curLoanInt;
                                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                    curTransBalance := 0;
                                    strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                    strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                    TGroup := 'DEDUCTIONS';
                                    TGroupOrder := 8;
                                    TSubGroupOrder := 1;
                                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                      JournalAcc, Journalpostas::Credit, JournalPostingType, '', Coopparameters::none)
                                end;
                                //Get the Principal Amt
                                curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
                                //Modify PREmployeeTransaction Table
                                prEmployeeTransactions.Amount := curTransAmount;
                                // prEmployeeTransactions.MODIFY;
                            end;
                            //Loan Calculation Amortized

                            case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                                prTransactionCodes."balance type"::None:
                                    curTransBalance := 0;
                                prTransactionCodes."balance type"::Increasing:
                                    curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                prTransactionCodes."balance type"::Reducing:
                                    begin
                                        //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                            curTransAmount := prEmployeeTransactions.Balance;
                                            curTransBalance := 0;
                                        end else
                                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        if curTransBalance < 0 then begin
                                            curTransAmount := 0;
                                            curTransBalance := 0;
                                        end;
                                    end
                            end;

                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransAmount := curTransAmount;
                            curTransBalance := curTransBalance;
                            strTransDescription := prTransactionCodes."Transaction Name";
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 0;
                            fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                             strTransDescription, curTransAmount, curTransBalance, intMonth,
                             intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                             JournalAcc, Journalpostas::Credit, JournalPostingType, '', Coopparameters::none);

                            //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Staff Loan") and
                               (prTransactionCodes."Repayment Method" <> prTransactionCodes."repayment method"::Amortized) then begin

                                curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                               prTransactionCodes."Interest Rate",
                                prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                                prEmployeeTransactions.Balance, SelectedPeriod, false);
                                if curLoanInt > 0 then begin
                                    // if strempcode='0201' then error('Test'+format(curLoanInt));
                                    curTransAmount := curLoanInt;
                                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                    curTransBalance := 0;
                                    strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                    strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                    TGroup := 'DEDUCTIONS';
                                    TGroupOrder := 8;
                                    TSubGroupOrder := 1;
                                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                      JournalAcc, Journalpostas::Credit, JournalPostingType, '', Coopparameters::none)
                                end;
                            end;
                            //End Loan transaction calculation
                            //Fringe Benefits and Low interest Benefits
                            if prTransactionCodes."Fringe Benefit" = true then begin
                                if prTransactionCodes."Interest Rate" < curLoanMarketRate then
                                    fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                                     * prEmployeeTransactions.Balance;
                            end else
                                fnCalcFringeBenefit := 0;
                            if fnCalcFringeBenefit > 0 then
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                                 'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
                            //End Fringe Benefits

                            //Create Employer Deduction
                            if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                                if prTransactionCodes."Is Formula for employer" <> '' then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                    curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                                end else
                                    curTransAmount := prEmployeeTransactions."Employer Amount";
                                if curTransAmount > 0 then
                                    fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                                     'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)
                            end;
                            //Employer deductions
                        end;
                    until prEmployeeTransactions.Next() = 0;
                    //GET TOTAL DEDUCTIONS
                    curTransBalance := 0;
                    strTransCode := 'TOT-DED';
                    strTransDescription := 'TOTAL DEDUCTION';

                    TGroup := 'DEDUCTIONS';
                    TGroupOrder := 8;
                    TSubGroupOrder := 9;
                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                      // (curTotalDeductions+curPAYE+curNHIF+curNssfEmployee)
                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                      '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none)

                    //END GET TOTAL DEDUCTIONS
                end;

                //Net Pay: calculate the Net pay for the month in the following manner:
                //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
                //...Tot Deductions also include (SumLoan + SumInterest)
                curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions);

                //>Nett = Nett - curExcessPension
                //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
                curNetPay := ROUND((curNetPay)); //- curExcessPension

                //>Nett = Nett - cSumEmployerDeductions
                //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
                curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

                curNetRnd_Effect := curNetPay - ROUND(curNetPay, 1, '=');
                RoundDownDiff := 0;
                RoundUpDif := 0;
                if curNetRnd_Effect > 0 then
                    RoundDownDiff := ROUND(curNetRnd_Effect, 0.01, '=')
                else
                    if curNetRnd_Effect <> 0 then
                        RoundUpDif := ((ROUND(curNetRnd_Effect, 0.01, '=')) * (-1));
                if ((RoundDownDiff <> 0) or (RoundUpDif <> 0)) then begin
                    // Insert the Rounding Effect Into the Salary Card Table For that Specific Month and Year
                    empsalCard.Reset();
                    empsalCard.SetRange(empsalCard."Employee Code", strEmpCode);
                    if empsalCard.Find('-') then
                        if RoundDownDiff <> 0 then begin
                            empsalCard."Current Round Down" := RoundDownDiff;
                            empsalCard."Current Round Up" := 0;
                            empsalCard."Current Month" := intMonth;
                            empsalCard."Current Year" := intYear;
                            empsalCard.Modify();
                        end else
                            if RoundUpDif <> 0 then begin
                                empsalCard."Current Round Down" := 0;
                                empsalCard."Current Round Up" := RoundUpDif;
                                empsalCard."Current Month" := intMonth;
                                empsalCard."Current Year" := intYear;
                                empsalCard.Modify();
                            end;
                end else begin
                    empsalCard.Reset();
                    empsalCard.SetRange(empsalCard."Employee Code", strEmpCode);
                    if empsalCard.Find('-') then begin
                        empsalCard."Current Round Down" := 0;
                        empsalCard."Current Round Up" := 0;
                        empsalCard."Current Month" := intMonth;
                        empsalCard."Current Year" := intYear;
                        empsalCard.Modify();
                    end;
                end;
                // curNetPay :=
                curTransAmount := ROUND(curNetPay, 1, '=');
                strTransDescription := 'Net Pay';
                PayablesAcc := PostingGroup."Net Salary Payable";
                TGroup := 'NET PAY';
                TGroupOrder := 9;
                TSubGroupOrder := 0;
                fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                PayablesAcc, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                //Rounding Effect: if the Net pay is rounded, take the rounding effect &
                //save it as an earning for the staff for the next month
                //>Insert the Netpay rounding effect into the tblRoundingEffect table

                //Negative pay: if the NetPay<0 then log the entry
                //>Display an on screen report
                //>Through a pop-up to the user
                //>Send an email to the user or manager
            end;
        end
    end;

    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary);
    end;

    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        SysDate: Record Date;
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
        Day: Integer;
        Expr1: Text[30];
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset();
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysInMonth := SysDate.Count;
    end;

    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
    var
        prSalCard: Record "HR-Employee";
        prPeriodTransactions: Record "prPeriod Transactions";
    begin

        if curAmount = 0 then
            exit;
        prPeriodTransactions.Init();
        prPeriodTransactions."Employee Code" := EmpCode;
        prPeriodTransactions."Transaction Code" := TCode;
        prPeriodTransactions."Group Text" := TGroup;
        prPeriodTransactions."Transaction Name" := Description;
        //  Amount := ROUND(curAmount,0.05,'=');
        prPeriodTransactions.Amount := ROUND(curAmount);
        prPeriodTransactions.Balance := curBalance;
        prPeriodTransactions."Original Amount" := prPeriodTransactions.Balance;
        prPeriodTransactions."Group Order" := GroupOrder;
        prPeriodTransactions."Sub Group Order" := SubGroupOrder;
        prPeriodTransactions.Membership := mMembership;
        prPeriodTransactions."Reference No" := ReferenceNo;
        prPeriodTransactions."Period Month" := Month;
        prPeriodTransactions."Period Year" := Year;
        prPeriodTransactions."Payroll Period" := dtOpenPeriod;
        prPeriodTransactions."Department Code" := Department;
        prPeriodTransactions."Journal Account Type" := JournalACType;
        prPeriodTransactions."Post As" := PostAs;
        prPeriodTransactions."Journal Account Code" := JournalAC;
        prPeriodTransactions."Loan Number" := LoanNo;
        prPeriodTransactions."coop parameters" := CoopParam;
        prPeriodTransactions."Payroll Code" := PayrollType;
        //Paymode
        if prSalCard.Get(EmpCode) then
            prPeriodTransactions."Payment Mode" := prSalCard."Payment Mode";
        if ROUND(curAmount) <> 0 then
            prPeriodTransactions.Insert();
        //Update the prEmployee Transactions  with the Amount
        fnUpdateEmployeeTrans(prPeriodTransactions."Employee Code", prPeriodTransactions."Transaction Code", prPeriodTransactions.Amount, prPeriodTransactions."Period Month", prPeriodTransactions."Period Year", prPeriodTransactions."Payroll Period");
    end;

    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Tax Relief ( voluntary nssf)"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.Reset();
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        if prTransactionCodes.Find('-') then
            repeat
                prEmployeeTransactions.Reset();
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Gratuity:
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount * 0.3;

                        Intspectransid::"Insurance Relief":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;
                        // BKK
                        Intspectransid::"Tax Relief ( voluntary nssf)":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                if SpecialTransAmount > curReliefMorgage then
                                    SpecialTransAmount := curReliefMorgage;
                            end;
                    end;
            until prTransactionCodes.Next() = 0;
        SpecialTranAmount := SpecialTransAmount;
    end;

    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.Reset();
        if prPAYE.FindFirst() then begin
            if curTaxablePay < prPAYE."PAYE Tier" then
                exit;
            repeat
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                if curTaxablePay = 0 then
                    exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxablePay := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;
            until prPAYE.Next() = 0;
        end;
    end;

    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record prNHIF;
    begin
        prNHIF.Reset();
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst() then
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                    NHIF := prNHIF.Amount;
            until prNHIF.Next() = 0;
    end;

    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        StartCopy: Boolean;
        TransCode: Code[20];
        TransCodeAmount: Decimal;
        i: Integer;
        Char: Text[1];
        Where: Text[30];
        Which: Text[30];
        FinalFormula: Text[250];
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then
                StartCopy := true;

            if StartCopy then
                TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
    begin
        prEmployeeTransactions.Reset();
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
        if prEmployeeTransactions.FindFirst() then begin

            TransAmount := prEmployeeTransactions.Amount;
            if prEmployeeTransactions."No of Units" <> 0 then
                TransAmount := prEmployeeTransactions."No of Units";
        end;
        if TransAmount = 0 then begin
            prPeriodTransactions.Reset();
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
            if prPeriodTransactions.FindFirst() then
                TransAmount := prPeriodTransactions.Amount;
        end;
    end;

    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    begin
        //  Results:=AccSchedMgt.EvaluateExpression(true,strFormula,AccSchedLine,ColumnLayout,CalcAddCurr);
    end;

    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
    var
        ControlInfo: Record "Control-Information";
        prEmployeeTrans: Record "prEmployee Transactions";
        prEmployeeTransactions: Record "prEmployee Transactions";
        prNewPayrollPeriods: Record "prPayroll Periods";
        prPayrollPeriods: Record "prPayroll Periods";
        prTransactionCodes: Record "PR Transaction Codes";
        dtNewPeriod: Date;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        intMonth: Integer;
        intNewMonth: Integer;
        intNewYear: Integer;
        intYear: Integer;
    begin
        ControlInfo.Get();

        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);
        intOldMonth := Date2dmy(dtOpenPeriod, 2);
        intOldYear := Date2dmy(dtOpenPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset();
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);

        //Multiple Payroll
        if ControlInfo."Multiple Payroll" then
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);

        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",'0001');

        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset();
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                if prTransactionCodes.Find('-') then
                    with prTransactionCodes do
                        case prTransactionCodes."Balance Type" of
                            prTransactionCodes."balance type"::None:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := 0;
                                end;
                            prTransactionCodes."balance type"::Increasing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                end;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else
                                        curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;

                //For those transactions with Start and End Date Specified
                if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then
                    if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                    end;
                //End Transactions with Start and End Date

                if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                   (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED


                    // IF (curTransAmount <> 0) THEN  //Update the employee transaction table
                    begin
                    if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
                     (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
                        prEmployeeTransactions.Balance := curTransBalance;
                    prEmployeeTransactions.Modify();

                    //Insert record for the next period
                    with prEmployeeTrans do
                        if (prEmployeeTransactions."Transaction Code" <> 'D066') then
                            if (prEmployeeTransactions."Transaction Code" <> 'P021') then begin
                                prEmployeeTrans.Init();
                                prEmployeeTrans."Employee Code" := prEmployeeTransactions."Employee Code";
                                prEmployeeTrans."Transaction Code" := prEmployeeTransactions."Transaction Code";
                                prEmployeeTrans."Transaction Name" := prEmployeeTransactions."Transaction Name";
                                prEmployeeTrans.Amount := curTransAmount;
                                prEmployeeTrans.Balance := curTransBalance;
                                prEmployeeTrans."Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
                                prEmployeeTrans."Original Amount" := prEmployeeTransactions."Original Amount";
                                prEmployeeTrans.Membership := prEmployeeTransactions.Membership;
                                prEmployeeTrans."Reference No" := prEmployeeTransactions."Reference No";
                                prEmployeeTrans."Loan Number" := prEmployeeTransactions."Loan Number";
                                prEmployeeTrans."Period Month" := intNewMonth;
                                prEmployeeTrans."Period Year" := intNewYear;
                                prEmployeeTrans."Payroll Period" := dtNewPeriod;
                                prEmployeeTrans."Payroll Code" := PayrollCode;
                                prEmployeeTrans.Insert();
                            end;
                end;
            until prEmployeeTransactions.Next() = 0;
            prsalCard.Reset();
            if prsalCard.Find('-') then
                repeat
                begin
                    if prsalCard."Current Round Up" > 0 then
                        with prEmployeeTrans do begin
                            prEmployeeTrans.Init();
                            prEmployeeTrans."Employee Code" := prsalCard."Employee Code";
                            prEmployeeTrans."Transaction Code" := 'D066';
                            prEmployeeTrans."Transaction Name" := 'Rounding Up Effect';
                            prEmployeeTrans.Amount := prsalCard."Current Round Up";
                            prEmployeeTrans."Period Month" := intNewMonth;
                            prEmployeeTrans."Period Year" := intNewYear;
                            prEmployeeTrans."Payroll Period" := dtNewPeriod;
                            prEmployeeTrans."Payroll Code" := PayrollCode;
                            prEmployeeTrans.Insert();
                        end
                    else
                        if prsalCard."Current Round Down" > 0 then
                            with prEmployeeTrans do begin
                                prEmployeeTrans.Init();
                                prEmployeeTrans."Employee Code" := prsalCard."Employee Code";
                                prEmployeeTrans."Transaction Code" := 'P021';
                                prEmployeeTrans."Transaction Name" := 'Rounding Down Effect';
                                prEmployeeTrans.Amount := prsalCard."Current Round Down";
                                prEmployeeTrans."Period Month" := intNewMonth;
                                prEmployeeTrans."Period Year" := intNewYear;
                                prEmployeeTrans."Payroll Period" := dtNewPeriod;
                                prEmployeeTrans."Payroll Code" := PayrollCode;
                                prEmployeeTrans.Insert();
                            end;

                    prsalCard."Preveous Round Down" := prsalCard."Current Round Down";
                    prsalCard."Preveous Round Up" := prsalCard."Current Round Up";
                    prsalCard."Period Month" := intNewMonth;
                    prsalCard."Period Year" := intNewYear;
                    prsalCard."Current Round Down" := 0;
                    prsalCard."Current Round Up" := 0;
                    prsalCard."Current Month" := intOldMonth;
                    prsalCard."Current Year" := intOldYear;
                    prsalCard.Modify();
                end;
                until prsalCard.Next() = 0;
        end;

        //Update the Period as Closed
        prPayrollPeriods.Reset();
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if ControlInfo."Multiple Payroll" then
            prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods.Modify();
        end;

        //Enter a New Period
        prNewPayrollPeriods.Init();
        prNewPayrollPeriods."Period Month" := intNewMonth;
        prNewPayrollPeriods."Period Year" := intNewYear;
        prNewPayrollPeriods."Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + ' - ' + Format(intNewYear);
        prNewPayrollPeriods."Date Opened" := dtNewPeriod;
        prNewPayrollPeriods.Closed := false;
        prNewPayrollPeriods."Payroll Code" := PayrollCode;
        prNewPayrollPeriods.Insert();

        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);

        //sEND nOTIFICATION  FRANK  ON EM-PLOYEE
        ///CODEUNIT.RUN(70134723);
    end;

    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        prPeriodTransactions.Reset();
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then
            repeat
                prEmployeeTransactions.Init();
                prEmployeeTransactions."Employee Code" := prPeriodTransactions."Employee Code";
                prEmployeeTransactions."Transaction Code" := 'NEGP';
                prEmployeeTransactions."Transaction Name" := 'Negative Pay';
                prEmployeeTransactions.Amount := prPeriodTransactions.Amount;
                prEmployeeTransactions.Balance := 0;
                prEmployeeTransactions."Original Amount" := 0;
                prEmployeeTransactions."Period Month" := intNewMonth;
                prEmployeeTransactions."Period Year" := intNewYear;
                prEmployeeTransactions."Payroll Period" := dtNewPeriod;
                prEmployeeTransactions.Insert();
            until prPeriodTransactions.Next() = 0;
    end;

    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        prEmployee: Record "HR-Employee";
        prPeriodTransactions: Record "prPeriod Transactions";
        P9Allowances: Decimal;
        P9BasicPay: Decimal;
        P9Benefits: Decimal;
        P9Deductions: Decimal;
        P9DefinedContribution: Decimal;
        P9GrossPay: Decimal;
        P9InsuranceRelief: Decimal;
        P9NetPay: Decimal;
        P9NHIF: Decimal;
        P9NSSF: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9Paye: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9TaxRelief: Decimal;
        P9ValueOfQuarters: Decimal;
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset();
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Normal);
        if prEmployee.Find('-') then
            repeat

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then
                    repeat
                        case prPeriodTransactions."Group Order" of
                            1: //Basic pay & Arrears
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then
                                        P9BasicPay := prPeriodTransactions.Amount; //Basic Pay
                                    if prPeriodTransactions."Sub Group Order" = 2 then
                                        P9BasicPay := P9BasicPay + prPeriodTransactions.Amount; //Basic Pay Arrears
                                end;
                            3:  //Allowances


                                P9Allowances := P9Allowances + prPeriodTransactions.Amount;
                            4: //Gross Pay


                                P9GrossPay := prPeriodTransactions.Amount;
                            6: //Taxation
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then
                                        P9DefinedContribution := prPeriodTransactions.Amount; //Defined Contribution
                                    if prPeriodTransactions."Sub Group Order" = 9 then
                                        P9TaxRelief := prPeriodTransactions.Amount; //Tax Relief
                                    if prPeriodTransactions."Sub Group Order" = 8 then
                                        P9InsuranceRelief := prPeriodTransactions.Amount; //Insurance Relief
                                    if prPeriodTransactions."Sub Group Order" = 6 then
                                        P9TaxablePay := prPeriodTransactions.Amount; //Taxable Pay
                                    if prPeriodTransactions."Sub Group Order" = 7 then
                                        P9TaxCharged := prPeriodTransactions.Amount; //Tax Charged
                                end;
                            7: //Statutories
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then
                                        P9NSSF := prPeriodTransactions.Amount; //Nssf
                                    if prPeriodTransactions."Sub Group Order" = 2 then
                                        P9NHIF := prPeriodTransactions.Amount; //Nhif
                                    if prPeriodTransactions."Sub Group Order" = 3 then
                                        P9Paye := prPeriodTransactions.Amount; //paye
                                    if prPeriodTransactions."Sub Group Order" = 4 then
                                        P9Paye := P9Paye + prPeriodTransactions.Amount; //Paye Arrears
                                end;
                            8://Deductions


                                P9Deductions := P9Deductions + prPeriodTransactions.Amount;
                            9: //NetPay


                                P9NetPay := prPeriodTransactions.Amount;
                        end;
                    until prPeriodTransactions.Next() = 0;
                //Update the P9 Details

                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);
            until prEmployee.Next() = 0;
    end;

    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "prEmployee P9 Info";
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset();
        prEmployeeP9Info.Init();
        prEmployeeP9Info."Employee Code" := P9EmployeeCode;
        prEmployeeP9Info."Basic Pay" := P9BasicPay;
        prEmployeeP9Info.Allowances := P9Allowances;
        prEmployeeP9Info.Benefits := P9Benefits;
        prEmployeeP9Info."Value Of Quarters" := P9ValueOfQuarters;
        prEmployeeP9Info."Defined Contribution" := P9DefinedContribution;
        prEmployeeP9Info."Owner Occupier Interest" := P9OwnerOccupierInterest;
        prEmployeeP9Info."Gross Pay" := P9GrossPay;
        prEmployeeP9Info."Taxable Pay" := P9TaxablePay;
        prEmployeeP9Info."Tax Charged" := P9TaxCharged;
        prEmployeeP9Info."Insurance Relief" := P9InsuranceRelief;
        prEmployeeP9Info."Tax Relief" := P9TaxRelief;
        prEmployeeP9Info.PAYE := P9Paye;
        prEmployeeP9Info.NSSF := P9NSSF;
        prEmployeeP9Info.NHIF := P9NHIF;
        prEmployeeP9Info.Deductions := P9Deductions;
        prEmployeeP9Info."Net Pay" := P9NetPay;
        prEmployeeP9Info."Period Month" := intMonth;
        prEmployeeP9Info."Period Year" := intYear;
        prEmployeeP9Info."Payroll Period" := dtCurrPeriod;
        prEmployeeP9Info."Payroll Code" := prPayrollCode;
        prEmployeeP9Info.Insert();
    end;

    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        SysDate: Record Date;
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
        Day: Integer;
        Expr1: Text[30];
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset();
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;

    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        "prEmployee P9 Info": Record "prEmployee P9 Info";
        FirstMonth: Boolean;
        P9BasicPay: Decimal;
        P9PAYE: Decimal;
        P9taxablePay: Decimal;
        PAYEArrears: Decimal;
        PAYEVariance: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedPAYE: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        startmonth: Integer;
        startYear: Integer;
    begin
        fnInitialize();

        FirstMonth := true;
        if EndDate > StartDate then begin
            while StartDate < EndDate do begin
                //fnGetEmpP9Info
                startmonth := Date2dmy(StartDate, 2);
                startYear := Date2dmy(StartDate, 3);

                "prEmployee P9 Info".Reset();
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
                if "prEmployee P9 Info".Find('-') then begin
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    if P9BasicPay > 0 then   //Staff payment history is available
                     begin
                        if FirstMonth then                  //This is the first month in the arrears loop
                            if Date2dmy(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
                             begin
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                if (Date2dmy(dtDOE, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(StartDate, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, false);
                                    ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                if dtTermination <> 0D then
                                    if (Date2dmy(dtTermination, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(StartDate, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                                        DaysWorked := fnDaysWorked(dtTermination, true);
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                    end;

                                SalaryArrears := (CBasic - ProratedBasic)
                            end
                            else
                                SalaryArrears := (CBasic - P9BasicPay);
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        if SupposedTaxablePay > P9taxablePay then begin
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        end;
                        FirstMonth := false;               //reset the FirstMonth Boolean to False
                    end;
                end;
                StartDate := CalcDate('+1M', StartDate);
            end;
            if SalaryArrears <> 0 then begin
                PeriodYear := Date2dmy(dtOpenPeriod, 3);
                PeriodMonth := Date2dmy(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            end
        end
        else
            Error('The start date must be earlier than the end date');
    end;

    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        "prSalary Arrears": Record "prSalary Arrears";
    begin
        "prSalary Arrears".Reset();
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears".Init();
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Insert();
        end
    end;

    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);

        curLoanInt := 0;

        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 100) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 100) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 100) * Balance;
        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := ROUND(curLoanInt);
    end;

    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "prEmployer Deductions";
    begin

        if curAmount = 0 then
            exit;
        prEmployerDeductions.Init();
        prEmployerDeductions."Employee Code" := EmpCode;
        prEmployerDeductions."Transaction Code" := TCode;
        prEmployerDeductions.Amount := curAmount;
        prEmployerDeductions."Period Month" := Month;
        prEmployerDeductions."Period Year" := Year;
        prEmployerDeductions."Payroll Period" := dtOpenPeriod;
        prEmployerDeductions.Insert();
    end;

    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;

    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
    begin
        /* prEmployeeTrans.RESET;
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Employee Code",EmpCode);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Month",Month);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Year",Year);
         IF prEmployeeTrans.FIND('-') THEN BEGIN
           prEmployeeTrans.Amount:=Amount;
           prEmployeeTrans.MODIFY;
         END; */
    end;

    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "prSalary Card";
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being

                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                PostingGroup.TestField("Net Salary Payable");
                PostingGroup.TestField("NSSF Employer Account");
                PostingGroup.TestField("Pension Employer Acc");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."NSSF Employer Account";
                NSSFEMPyee := PostingGroup."NSSF Employee Account";
                NHIFEMPyee := PostingGroup."SHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
            end else
                Error('Please specify Posting Group in Employee No.  ' + strEmpCode);
        //End Get Payroll Posting Accounts
    end;

    procedure fnGetSpecialTransAmount2(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean)
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
    begin
        SpecialTranAmount := 0;
        prTransactionCodes.Reset();
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        if prTransactionCodes.Find('-') then
            repeat
                prEmployeeTransactions.Reset();
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                SpecialTranAmount := SpecialTranAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTranAmount := SpecialTranAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTranAmount := SpecialTranAmount + curReliefMorgage;

                                if SpecialTranAmount > curReliefMorgage then
                                    SpecialTranAmount := curReliefMorgage;
                            end;
                    end;
            until prTransactionCodes.Next() = 0;
    end;

    procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date) PaysPens: Boolean
    var
        pnEmpTrans: Record "prEmployee Transactions";
        pnTranCode: Record "PR Transaction Codes";
    begin
        PaysPens := false;
        pnEmpTrans.Reset();
        pnEmpTrans.SetRange(pnEmpTrans."Employee Code", pnEmpCode);
        pnEmpTrans.SetRange(pnEmpTrans."Payroll Period", pnPayperiod);
        if pnEmpTrans.Find('-') then
            repeat
                if pnTranCode.Get(pnEmpTrans."Transaction Code") then
                    if pnTranCode."coop parameters" = pnTranCode."coop parameters"::Pension then
                        PaysPens := true;
            until pnEmpTrans.Next() = 0;
    end;

    procedure fnGetPensionAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "PR Transaction Codes";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.Reset();
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        prTransactionCodes.SetRange(prTransactionCodes.Pension, true);
        if prTransactionCodes.Find('-') then
            repeat
                prEmployeeTransactions.Reset();
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if (prTransactionCodes.Pension) then
                                if prTransactionCodes."Is Formula" then begin
                                    strExtractedFrml := '';
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                    SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                                end else
                                    SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;
                    end;
            until prTransactionCodes.Next() = 0;
        SpecialTranAmount := SpecialTransAmount;
    end;

    procedure disabled_emp(var empNo: Code[20]; var Gross: Decimal) Dis_A: Boolean
    var
        hrEmp: Record "HR-Employee";
    begin
        if hrEmp.Get(empNo) then
            Dis_A := hrEmp."Physical Disability";
        if Dis_A = true then
            if (Gross <= 150000) then
                Dis_A := false;
    end;

    procedure "**************************Webportal_"()
    begin
    end;

    /* procedure GenerateStudentAdmissionLetter("Student No": Text; filenameFromApp: Text)
    var
        filename: Text[100];
    begin
        filename := FILESPATH_S + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        objAdmissionFormHeader.Reset;
        objAdmissionFormHeader.SetRange(objAdmissionFormHeader."Index Number", "Student No");
        if objAdmissionFormHeader.Find('-') then begin
            Report.SaveAsPdf(70134697, filename, objAdmissionFormHeader);
            Message('SAVED');
        end;
    end; */

    procedure GetProfilePictureStudent(StudentNo: Text) BaseImage: Text
    var
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        IStream: InStream;
    begin
        Customer.Reset();
        Customer.SetRange(Customer."No.", StudentNo);

        if Customer.Find('-') then
            if Customer.Image.Hasvalue then begin
                Customer.CalcFields(Image);
                //Customer.Picture.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
    end;
}
