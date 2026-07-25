Report 85255 "prBank Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prBankPayments.rdl';

    dataset
    {
        dataitem("prBank Structure"; "Pr Bank Branches")
        {
            RequestFilterFields = "Bank Code", "Branch Code";
            column(ReportForNavId_4233; 4233)
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
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(BANK_PAYMENT_REPORTCaption; BANK_PAYMENT_REPORTCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Net_Amount_Caption; Net_Amount_CaptionLbl)
            {
            }
            column(Account_Number_Caption; Account_Number_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_BankCaption; Employee_BankCaptionLbl)
            {
            }
            column(Bank_Branch_Caption; Bank_Branch_CaptionLbl)
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
            column(Total_Caption; Total_CaptionLbl)
            {
            }
            column(prBank_Structure_Bank_Code; "Bank Code")
            {
            }
            column(prBank_Structure_Branch_Code; "Branch Code")
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Main Bank" = field("Bank Code"), "Branch Bank" = field("Branch Code");
                DataItemTableView = sorting("No.") order(ascending);
                column(ReportForNavId_8631; 8631)
                {
                }
                column(HR_Employee__Main_Bank_; "Main Bank")
                {
                }
                column(HR_Employee__Branch_Bank_; "Branch Bank")
                {
                }
                column(HR_Employee__Main_Bank_Caption; FieldCaption("Main Bank"))
                {
                }
                column(HR_Employee__Branch_Bank_Caption; FieldCaption("Branch Bank"))
                {
                }
                column(HR_Employee_No_; "No.")
                {
                }
                dataitem("prSalary Card"; "prSalary Card")
                {
                    DataItemLink = "Employee Code" = field("No.");
                    RequestFilterFields = "Period Filter", "Employee Code";
                    column(ReportForNavId_6207; 6207)
                    {
                    }
                    column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
                    {
                    }
                    column(EmployeeName; EmployeeName)
                    {
                    }
                    column(TaxablePay; TaxablePay)
                    {
                    }
                    column(bankAcc; bankAcc)
                    {
                    }
                    column(mainBankNM; mainBankNM)
                    {
                    }
                    column(BranchBankNM; BranchBankNM)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //  bankAcc:='';
                        //  mainBankNM:='';
                        //  BranchBankNM:='';

                        objEmp.Reset();
                        objEmp.SetRange(objEmp."No.", "Employee Code");
                        if objEmp.Find('-') then
                            EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                        //Bank Details
                        bankAcc := objEmp."Bank Account Number";

                        bankStruct.Reset();
                        bankStruct.SetRange(bankStruct."Bank Code", objEmp."Main Bank");
                        bankStruct.SetRange(bankStruct."Branch Code", objEmp."Branch Bank");
                        if bankStruct.Find('-') then begin
                            mainBankNM := bankStruct."Bank Name";
                            BranchBankNM := bankStruct."Branch Name";
                        end;

                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);

                        TaxablePay := 0;
                        if PeriodTrans.Find('-') then
                            repeat
                                //TXBP Taxable Pay -  BY DENNIS
                                if (PeriodTrans."Transaction Code" = 'NPAY') then
                                    TaxablePay := PeriodTrans.Amount;
                            until PeriodTrans.Next() = 0;

                        TotTaxablePay := TotTaxablePay + TaxablePay;
                        TotPayeAmount := TotPayeAmount + PayeAmount;
                    end;
                }
            }
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then
            Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        companyinfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        bankStruct: Record "Pr Bank Branches";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        PayeAmount: Decimal;
        TaxablePay: Decimal;
        TotPayeAmount: Decimal;
        TotTaxablePay: Decimal;
        Account_Number_CaptionLbl: label 'Account Number:';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Bank_Branch_CaptionLbl: label 'Bank Branch:';
        BANK_PAYMENT_REPORTCaptionLbl: label 'BANK PAYMENT REPORT';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Employee_BankCaptionLbl: label 'Employee Bank';
        Employee_NameCaptionLbl: label 'Employee Name';
        Net_Amount_CaptionLbl: label 'Net Amount:';
        No_CaptionLbl: label 'No:';
        Page_No_CaptionLbl: label 'Page No:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Total_CaptionLbl: label 'Total:';
        User_Name_CaptionLbl: label 'User Name:';
        EmployeeName: Text[30];
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
}
