report 85263 "prDeductions Variance Report2"
{
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING("Transaction Code", "Payroll Period", Membership, "Reference No")
                                ORDER(Ascending);
            RequestFilterFields = "Transaction Code", "Group Order";
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
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
            column(Amount_PrevMonth; Amount - PrevMonth)
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions___Transaction_Name__Control1102756017; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(PrevMonth; PrevMonth)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(PrevMonthTot; PrevMonthTot)
            {
            }
            column(GrandTotal_PrevMonthTot; GrandTotal - PrevMonthTot)
            {
            }
            column(Transactions_Variant_ReportCaption; Transactions_Variant_ReportCaptionLbl)
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
            column(Variant_Caption; Variant_CaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(Prev__Month_Caption; Prev__Month_CaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                //Get the staff details (header)
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                "prPeriod Transactions".SETRANGE("prPeriod Transactions"."Employee Code");
                "prPeriod Transactions".SETRANGE("Payroll Period", SelectedPeriod);
                "prPeriod Transactions".SETfilter("Payroll Period", '%1', Periods);
                //"prPeriod Transactions".SETFILTER("Group Order",'=7|=8');

                PrevMonth := 0;
                PeriodTrans2.RESET();
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year");
                //IF "prPeriod Transactions"."Period Month" = 1 THEN BEGIN
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Month", 12);
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year" - 1);
                //END ELSE BEGIN
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Month", "prPeriod Transactions"."Period Month" - 1);
                //END;
                //PeriodTrans2.SETFILTER(PeriodTrans2."Group Order",'=7|=8');
                PeriodTrans2.SETRANGE(PeriodTrans2."Payroll Period", selectedperiod2);
                PeriodTrans2.SETRANGE(PeriodTrans2."Transaction Code", "prPeriod Transactions"."Transaction Code");
                PeriodTrans2.SETRANGE(PeriodTrans2."Employee Code", "prPeriod Transactions"."Employee Code");
                IF PeriodTrans2.FIND('-') THEN
                    PrevMonth := PeriodTrans2.Amount;

                IF PrevMonth = Amount THEN
                    CurrReport.SKIP();

                //Transactions in prev month not in this month
                "prPeriod Transactions".SETRANGE("prPeriod Transactions"."Employee Code");
                "prPeriod Transactions".SETRANGE("Payroll Period", SelectedPeriod2);
                "prPeriod Transactions".SETfilter("Payroll Period", '%1', Periods);
                //"prPeriod Transactions".SETFILTER("Group Order",'=7|=8');

                PrevMonth := 0;
                PeriodTrans2.RESET();
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year");
                //IF "prPeriod Transactions"."Period Month" = 1 THEN BEGIN
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Month", 12);
                //PeriodTrans2.SETRANGE(PeriodTrans2."Period Year", "prPeriod Transactions"."Period Year" - 1);
                //END ELSE BEGIN
                // PeriodTrans2.SETRANGE(PeriodTrans2."Period Month", "prPeriod Transactions"."Period Month" - 1);
                //END;
                //PeriodTrans2.SETFILTER(PeriodTrans2."Group Order",'=7|=8');
                PeriodTrans2.SETRANGE(PeriodTrans2."Payroll Period", SelectedPeriod);
                PeriodTrans2.SETRANGE(PeriodTrans2."Transaction Code", "prPeriod Transactions"."Transaction Code");
                PeriodTrans2.SETRANGE(PeriodTrans2."Employee Code", "prPeriod Transactions"."Employee Code");
                IF PeriodTrans2.FIND('-') THEN
                    PrevMonth := PeriodTrans2.Amount;

                IF PrevMonth = Amount THEN
                    CurrReport.SKIP();

                GrandTotal := GrandTotal + Amount;
                GrandBalance := GrandBalance + Balance;
                PrevMonthTot := PrevMonthTot + PrevMonth;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Period Year");
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
        objPeriod.RESET();
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN
            PeriodName := objPeriod."Period Name";

        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans2: Record "prPeriod Transactions";
        Periods: Date;
        SelectedPeriod: Date;
        selectedperiod2: date;
        GrandBalance: Decimal;
        GrandTotal: Decimal;
        PrevMonth: Decimal;
        PrevMonthTot: Decimal;
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Description_CaptionLbl: Label 'Description:';
        Employee_Name_CaptionLbl: Label 'Employee Name:';
        Employee_No_CaptionLbl: Label 'Employee No.';
        Grand_Total_CaptionLbl: Label 'Grand Total:';
        Page_No_CaptionLbl: Label 'Page No:';
        Period_Amount_CaptionLbl: Label 'Period Amount:';
        Period_CaptionLbl: Label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Prev__Month_CaptionLbl: Label 'Prev. Month:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Transactions_Variant_ReportCaptionLbl: Label 'Transactions Variant Report';
        User_Name_CaptionLbl: Label 'User Name:';
        Variant_CaptionLbl: Label 'Variant:';
        PeriodName: Text[30];
        strEmpName: Text[100];
}
