Report 85261 "prDeductions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prDeductionsReport.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = sorting("Employee Code", "Department Code") order(ascending);
            RequestFilterFields = "Transaction Code";
            column(ReportForNavId_7769; 7769)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions___Transaction_Name_; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions___Loan_Number_; "prPeriod Transactions"."Loan Number")
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755038; Amount)
            {
            }
            column(prPeriod_Transactions_Balance_Control1102755039; Balance)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(GrandBalance; GrandBalance)
            {
            }
            column(Deductions_ReportCaption; Deductions_ReportCaptionLbl)
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
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Description_Caption; Description_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
            {
            }
            column(Balance_Caption; Balance_CaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(SubtotalsCaption; SubtotalsCaptionLbl)
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
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
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
            column(IDNumber; EmpIDNumber)
            {
            }
            column(i; i)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    EmpIDNumber := objEmp."ID Number";
                end;

                "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                "prPeriod Transactions".SetRange("Payroll Period", Periods);
                //"prPeriod Transactions".SETRANGE("prPeriod Transactions"."Transaction Code");
                //"prPeriod Transactions".SETRANGE("prPeriod Transactions"."Period Month");
                //"prPeriod Transactions".SETRANGE("prPeriod Transactions"."Period Year");

                "prPeriod Transactions".SetFilter("Group Order", '=7|=8');

                /*IF (Amount<=0) OR ("prPeriod Transactions"."Transaction Code"='TOT-DED') OR ("prPeriod Transactions"."Group Order"=1) THEN
                BEGIN
                 GrandTotal:=GrandTotal+0;
                 CurrReport.SKIP;
                END;

                GrandTotal:=GrandTotal+Amount;
                GrandBalance:=GrandBalance+Balance;
                  */
                i := i + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Period Year");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Periods; Periods)
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
        //SelectedPeriod:="prPeriod Transactions".GETRANGEMIN("Payroll Period");
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
        EmpIDNumber: Code[20];
        Periods: Date;
        SelectedPeriod: Date;
        GrandBalance: Decimal;
        GrandTotal: Decimal;
        i: Integer;
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..              DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Balance_CaptionLbl: label 'Balance:';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Deductions_ReportCaptionLbl: label 'Deductions Report';
        Description_CaptionLbl: label 'Description:';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Employee_No_CaptionLbl: label 'Employee No.';
        Grand_Total_CaptionLbl: label 'Grand Total:';
        Page_No_CaptionLbl: label 'Page No:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..                 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Print_Date_CaptionLbl: label 'Print Date:';
        SubtotalsCaptionLbl: label 'Subtotals';
        User_Name_CaptionLbl: label 'User Name:';
        PeriodName: Text[30];
        strEmpName: Text[100];
}
