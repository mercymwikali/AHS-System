Report 52202552 "Loans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LoansReport.rdl';

    dataset
    {
        dataitem("prTransaction Codes"; "PR Transaction Codes")
        {
            DataItemTableView = sorting("Transaction Code") order(ascending) where("IsCoop/LnRep" = const(true));
            column(ReportForNavId_6955; 6955)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(Today; Today)
            {
            }
            column(UserId; UserId)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(GrandBalance; GrandBalance)
            {
            }
            column(GrandTotInt; GrandTotInt)
            {
            }
            column(Loans_ReportCaption; Loans_ReportCaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
            {
            }
            column(prTransaction_Codes_Transaction_Code; "Transaction Code")
            {
            }
            dataitem("prPeriod Transactions"; "prPeriod Transactions")
            {
                DataItemLink = "Transaction Code" = field("Transaction Code");
                DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year");
                RequestFilterFields = "Payroll Period", "Transaction Code";
                column(ReportForNavId_7769; 7769)
                {
                }
                column(prPeriod_Transactions__prPeriod_Transactions___Transaction_Name_; "prPeriod Transactions"."Transaction Name")
                {
                }
                column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
                {
                }
                column(prPeriod_Transactions_Amount; Amount)
                {
                }
                column(prPeriod_Transactions_Balance; Balance)
                {
                }
                column(Employee_Code_______strEmpName; "Employee Code" + ': ' + strEmpName)
                {
                }
                column(Interest; Interest)
                {
                }
                column(prPeriod_Transactions_Amount_Control1102755038; Amount)
                {
                }
                column(prPeriod_Transactions_Balance_Control1102755039; Balance)
                {
                }
                column(prPeriod_Transactions__Transaction_Name__Control1102755016; "Transaction Name")
                {
                }
                column(SubTotInt; SubTotInt)
                {
                }
                column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
                {
                }
                column(Period_Amount_Caption; Period_Amount_CaptionLbl)
                {
                }
                column(Balance_Caption; Balance_CaptionLbl)
                {
                }
                column(EmployeeCaption; EmployeeCaptionLbl)
                {
                }
                column(Interest_Caption; Interest_CaptionLbl)
                {
                }
                column(SubtotalsCaption; SubtotalsCaptionLbl)
                {
                }
                column(prPeriod_Transactions_Employee_Code; "Employee Code")
                {
                }
                column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
                {
                }
                column(prPeriod_Transactions_Period_Month; "Period Month")
                {
                }
                column(prPeriod_Transactions_Period_Year; "Period Year")
                {
                }
                column(prPeriod_Transactions_Membership; Membership)
                {
                }
                column(prPeriod_Transactions_Reference_No; "Reference No")
                {
                }
                column(prPeriod_Transactions_Group_Order; "Group Order")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Get the staff details (header)
                    objEmp.SetRange(objEmp."No.", "Employee Code");
                    if objEmp.Find('-') then
                        strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";

                    "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                    "prPeriod Transactions".SetFilter("Group Order", '=7|=8');

                    if (Amount <= 0) or ("prPeriod Transactions"."Transaction Code" = 'TOT-DED') or ("prPeriod Transactions"."Group Order" = 1) then begin
                        GrandTotal := GrandTotal + 0;
                        CurrReport.Skip();
                    end;

                    Interest := 0;
                    prPeriodTrans.Reset();
                    prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "prPeriod Transactions"."Employee Code");
                    prPeriodTrans.SetRange(prPeriodTrans."Transaction Code", "prPeriod Transactions"."Transaction Code" + '-INT');
                    prPeriodTrans.SetRange(prPeriodTrans."Payroll Period", "prPeriod Transactions"."Payroll Period");
                    if prPeriodTrans.Find('-') then begin
                        Interest := prPeriodTrans.Amount;
                        SubTotInt := SubTotInt + prPeriodTrans.Amount;
                        GrandTotInt := GrandTotInt + prPeriodTrans.Amount;
                    end;
                    GrandTotal := GrandTotal + Amount;
                    GrandBalance := GrandBalance + Balance;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Period Year");
                    Interest := 0;
                    SubTotInt := 0;
                end;
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
        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then
            PeriodName := objPeriod."Period Name";

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        prPeriodTrans: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        GrandBalance: Decimal;
        GrandTotal: Decimal;
        GrandTotInt: Decimal;
        Interest: Decimal;
        SubTotInt: Decimal;
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Balance_CaptionLbl: label 'Balance:';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        EmployeeCaptionLbl: label 'Employee';
        Grand_Total_CaptionLbl: label 'Grand Total:';
        Interest_CaptionLbl: label 'Interest:';
        Loans_ReportCaptionLbl: label 'Loans Report';
        Page_No_CaptionLbl: label 'Page No:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        SubtotalsCaptionLbl: label 'Subtotals';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        User_Name_CaptionLbl: label 'User Name:';
        PeriodName: Text[30];
        strEmpName: Text[100];
}
