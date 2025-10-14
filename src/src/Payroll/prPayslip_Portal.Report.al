Report 52202609 prPayslip_Portal
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPayslipPortal.rdl';

    dataset
    {
        dataitem(SalCard; "prSalary Card")
        {
            RequestFilterFields = "Employee Code";
            column(ReportForNavId_17; 17)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102755015; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756027; COMPANYNAME)
            {
            }
            column(PeriodFilter; strDate)
            {
            }
            column(COMPANYNAME_Control1102756028; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(strJob; strJob)
            {
            }
            column(strGradeLevel; strGradeLevel)
            {
            }
            column(strCampus; strCampus)
            {
            }
            column(strSection; strSection)
            {
            }
            column(EmployeeCode_SalCard; SalCard."Employee Code")
            {
            }
            column(names; names)
            {
            }
            column(PaysNSSF_SalCard; nssf)
            {
            }
            column(PaysNHIF_SalCard; nhif)
            {
            }
            column(PaysPAYE_SalCard; pinno)
            {
            }
            column(BankAccountNumber_SalCard; SalCard."Bank Account Number")
            {
            }
            column(BankBranch_SalCard; SalCard."Bank Branch")
            {
            }
            column(EmployeesBank_SalCard; SalCard."Employee's Bank")
            {
            }
            column(PayslipMessage_SalCard; SalCard."Payslip Message")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Evaluate("Selected Period", SalCard.GetFilter(SalCard."Period Filter"));

                Evaluate(EmployeeNo, SalCard."Employee Code");

                names := '';
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", SalCard."Employee Code");
                if objEmp.Find('-') then begin
                    names := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    pinno := objEmp."PIN Number";
                    nssf := objEmp."NSSF No.";
                    nhif := objEmp."NHIF No.";

                    dtDOE := objEmp."Date Of Join";
                    STATUS := Format(objEmp.Status);
                    "Served Notice Period" := objEmp."Served Notice Period";
                    if objEmp."Date Of Leaving" = 0D then
                        dtOfLeaving := Dmy2date(31, 12, 9999)
                    else
                        dtOfLeaving := objEmp."Date Of Leaving";
                end;
            end;
        }
        dataitem(Income; "PR Transaction Codes")
        {
            DataItemTableView = sorting("Transaction Code") where("Transaction Type" = filter(Income));
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionCode_Income; Income."Transaction Code")
            {
            }
            column(TransactionName_Income; Income."Transaction Name")
            {
            }
            column(IncomeAmount; IncomeAmount)
            {
            }
            column(BPAYAmount; BPAYAmount)
            {
            }
            column(GPAYAmount; GPAYAmount)
            {
            }
            column(PAYEAmount; PAYEAmount)
            {
            }
            column(NHIFAmount; NHIFAmount)
            {
            }
            column(NSSFAmount; NSSFAmount)
            {
            }
            column(PNSRAmount; PNSRAmount)
            {
            }
            column(INSRAmount; INSRAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IncomeAmount := 0;

                Income.SetFilter("Payroll Filter", '%1', "Selected Period");
                Income.SetFilter("Employee Filter", '%1', EmployeeNo);
                Income.CalcFields("Employee Amount");
                IncomeAmount := Income."Employee Amount";

                if IncomeAmount = 0 then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                BPAYAmount := 0;
                GPAYAmount := 0;
                NHIFAmount := 0;
                NSSFAmount := 0;
                PAYEAmount := 0;
                NPAYAmount := 0;
                INSRAmount := 0;
                PNSRAmount := 0;

                BPAYAmount := GetProcessedAmount('BPAY', "Selected Period", EmployeeNo);
                GPAYAmount := GetProcessedAmount('GPAY', "Selected Period", EmployeeNo);
                NHIFAmount := GetProcessedAmount('NHIF', "Selected Period", EmployeeNo);
                NSSFAmount := GetProcessedAmount('NSSF', "Selected Period", EmployeeNo);
                PAYEAmount := GetProcessedAmount('PAYE', "Selected Period", EmployeeNo);
                INSRAmount := GetProcessedAmount('INSR', "Selected Period", EmployeeNo);
                PNSRAmount := GetProcessedAmount('PNSR', "Selected Period", EmployeeNo);
            end;
        }
        dataitem(Deductions; "PR Transaction Codes")
        {
            DataItemTableView = sorting("Transaction Code") where("Transaction Type" = filter(Deduction));
            column(ReportForNavId_8; 8)
            {
            }
            column(TransactionCode_Deductions; Deductions."Transaction Code")
            {
            }
            column(TransactionName_Deductions; Deductions."Transaction Name")
            {
            }
            column(DeductAmount; DeductAmount)
            {
            }
            column(NPAYAmount; NPAYAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DeductAmount := 0;

                Deductions.SetFilter("Payroll Filter", '%1', "Selected Period");
                Deductions.SetFilter("Employee Filter", '%1', EmployeeNo);

                Deductions.CalcFields("Employee Amount");
                DeductAmount := Deductions."Employee Amount";

                if DeductAmount = 0 then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                NPAYAmount := GetProcessedAmount('NPAY', "Selected Period", EmployeeNo);
            end;
        }
        dataitem(Deductions_Balances; "PR Transaction Codes")
        {
            DataItemTableView = sorting("Transaction Code") where("Transaction Type" = filter(Deduction));
            column(ReportForNavId_21; 21)
            {
            }
            column(TransactionCode_DeductionsBalances; Deductions_Balances."Transaction Code")
            {
            }
            column(TransactionName_DeductionsBalances; Deductions_Balances."Transaction Name")
            {
            }
            column(DeductBalancesAmount; DeductBalances)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DeductBalances := 0;
                blnSKIP := false;

                Deductions_Balances.SetFilter("Payroll Filter", '%1', "Selected Period");
                Deductions_Balances.SetFilter("Employee Filter", '%1', EmployeeNo);

                Deductions_Balances.CalcFields("Employee Balance");
                DeductBalances := Deductions_Balances."Employee Balance";

                if Deductions_Balances."Balance Type" <> Deductions_Balances."balance type"::Reducing then
                    blnSKIP := true;

                if Deductions_Balances."Special Transactions" = Deductions_Balances."special transactions"::"Defined Contribution" then begin
                    blnSKIP := false;
                    EmployerTrans.Reset();
                    EmployerTrans.SetRange(EmployerTrans."Employee Code", EmployeeNo);
                    EmployerTrans.SetRange(EmployerTrans."Payroll Period", "Selected Period");
                    EmployerTrans.SetRange(EmployerTrans."Transaction Code", Deductions_Balances."Transaction Code");
                    if EmployerTrans.Find('-') then
                        DeductBalances := EmployerTrans.Amount;
                end;

                if DeductBalances = 0 then
                    blnSKIP := true;

                if blnSKIP = true then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                //NPAYAmount := GetProcessedAmount('NPAY',"Selected Period",EmployeeNo);
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

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        Evaluate("Selected Period", SalCard.GetFilter(SalCard."Period Filter"));

        strDate := '';

        PayrollPEriod.Reset();
        PayrollPEriod.SetRange(PayrollPEriod."Date Opened", "Selected Period");
        if PayrollPEriod.Find('-') then
            strDate := PayrollPEriod."Period Name";
    end;

    var
        CompanyInfo: Record "Control-Information";
        objEmp: Record "HR-Employee";
        EmployerTrans: Record "prEmployer Deductions";
        PayrollPEriod: Record "prPayroll Periods";
        blnSKIP: Boolean;
        "Served Notice Period": Boolean;
        EmployeeNo: Code[20];
        nhif: Code[30];
        nssf: Code[30];
        pinno: Code[30];
        strGradeLevel: Code[50];
        strJob: Code[50];
        dtDOE: Date;
        dtOfLeaving: Date;
        "Selected Period": Date;
        BPAYAmount: Decimal;
        DeductAmount: Decimal;
        DeductBalances: Decimal;
        GPAYAmount: Decimal;
        IncomeAmount: Decimal;
        INSRAmount: Decimal;
        NHIFAmount: Decimal;
        NPAYAmount: Decimal;
        NSSFAmount: Decimal;
        PAYEAmount: Decimal;
        PNSRAmount: Decimal;
        names: Text;
        strCampus: Text;
        strDate: Text;
        strSection: Text;
        STATUS: Text[30];

    local procedure GetProcessedAmount(TransCode: Code[20]; PayPeriod: Date; EmpCode: Code[20]) decAmount: Decimal
    var
        perioddTrans: Record "prPeriod Transactions";
    begin
        decAmount := 0;

        perioddTrans.Reset();
        perioddTrans.SetRange(perioddTrans."Transaction Code", TransCode);
        perioddTrans.SetRange(perioddTrans."Payroll Period", PayPeriod);
        perioddTrans.SetRange(perioddTrans."Employee Code", EmpCode);
        if perioddTrans.Find('-') then
            repeat

                decAmount := decAmount + perioddTrans.Amount;
            until perioddTrans.Next() = 0;
    end;
}
