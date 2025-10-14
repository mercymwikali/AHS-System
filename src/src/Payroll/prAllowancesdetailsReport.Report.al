Report 52202537 "prAllowances details Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prAllowancesdetailsReport.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year") order(ascending);
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
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
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions__Membership; "prPeriod Transactions".Membership)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755038; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name__Control1102755016; "Transaction Name")
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(Allowances_ReportCaption; Allowances_ReportCaptionLbl)
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
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption22; Period_Amount_22)
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
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }
            column(prPeriod_Transactions_Payroll_Period; "Payroll Period")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";

                "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                "prPeriod Transactions".SetRange("Payroll Period", Periods);
                "prPeriod Transactions".SetFilter("Group Order", '=3');

                if (Amount <= 0) or ("prPeriod Transactions"."Group Order" = 1) then begin
                    GrandTotal := GrandTotal + 0;
                    CurrReport.Skip();
                end;

                GrandTotal := GrandTotal + Amount;
                GrandBalance := GrandBalance + Balance;
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
        Periods: Date;
        SelectedPeriod: Date;
        GrandBalance: Decimal;
        GrandTotal: Decimal;
        LastFieldNo: Integer;
        Allowances_ReportCaptionLbl: label 'Allowances Report';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Employee_No_CaptionLbl: label 'Employee No.';
        Grand_Total_CaptionLbl: label 'Grand Total:';
        Page_No_CaptionLbl: label 'Page No:';
        Period_Amount_22: label 'Period Amount:';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        SubtotalsCaptionLbl: label 'Subtotals';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        User_Name_CaptionLbl: label 'User Name:';
        PeriodName: Text[30];
        strEmpName: Text[100];
}
