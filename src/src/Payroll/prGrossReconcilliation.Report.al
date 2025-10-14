Report 52202565 "prGross Reconcilliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prGrossReconcilliation.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(ReportForNavId_6207; 6207)
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
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(GrossPayPREV; GrossPayPREV)
            {
            }
            column(BasicPayPREV; BasicPayPREV)
            {
            }
            column(Payment_ReconcilliationCaption; Payment_ReconcilliationCaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
            {
            }
            column(Prev_Gross_Pay_Caption; Prev_Gross_Pay_CaptionLbl)
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
            column(Prev_Basic_Pay_Caption; Prev_Basic_Pay_CaptionLbl)
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
            dataitem("Monthly Reconcilliation"; "Monthly Reconcilliation")
            {
                DataItemLink = Employee = field("Employee Code");
                DataItemTableView = sorting(Employee, TransCode) order(ascending);
                column(ReportForNavId_5750; 5750)
                {
                }
                column(Monthly_Reconcilliation_TransCode; TransCode)
                {
                }
                column(Monthly_Reconcilliation_Description; Description)
                {
                }
                column(Monthly_Reconcilliation_CurrAmount; CurrAmount)
                {
                }
                column(Monthly_Reconcilliation_PrevAmount; PrevAmount)
                {
                }
                column(No; No)
                {
                }
                column(Monthly_Reconcilliation_Employee; Employee)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No += 1;
                end;

                trigger OnPreDataItem()
                begin
                    No := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                BasicPay := 0;
                GrossPay := 0;
                BasicPayPREV := 0;
                GrossPayPREV := 0;

                NetPay := 0;

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=1|=4|=9');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '<=1');
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                if PeriodTrans.Find('-') then
                    repeat
                        if PeriodTrans."Group Order" = 1 then
                            BasicPay := PeriodTrans.Amount;

                        if PeriodTrans."Group Order" = 4 then
                            GrossPay := PeriodTrans.Amount; //Gross pay

                        if PeriodTrans."Group Order" = 9 then
                            NetPay := PeriodTrans.Amount; //Net pay
                    until PeriodTrans.Next() = 0;

                PeriodTransPREV.Reset();
                PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", "Employee Code");
                PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                PeriodTransPREV.SetFilter(PeriodTransPREV."Group Order", '=1|=4|=9');
                PeriodTransPREV.SetFilter(PeriodTransPREV."Sub Group Order", '<=1');
                PeriodTransPREV.SetCurrentkey(PeriodTransPREV."Employee Code", PeriodTransPREV."Period Month", PeriodTransPREV."Period Year",
                PeriodTransPREV."Group Order", PeriodTransPREV."Sub Group Order");
                if PeriodTransPREV.Find('-') then
                    repeat
                        if PeriodTransPREV."Group Order" = 1 then
                            BasicPayPREV := PeriodTransPREV.Amount;

                        if PeriodTransPREV."Group Order" = 4 then
                            GrossPayPREV := PeriodTransPREV.Amount; //Gross pay

                        if PeriodTransPREV."Group Order" = 9 then
                            NetPay := PeriodTransPREV.Amount; //Net pay
                    until PeriodTransPREV.Next() = 0;

                //
                if GrossPayPREV = GrossPay then
                    CurrReport.Skip();

                ReconcilliationTable.DeleteAll();

                if BasicPayPREV <> BasicPay then begin
                    ReconcilliationTable.Init();
                    ReconcilliationTable.Employee := "Employee Code";
                    ReconcilliationTable.TransCode := 'BASIC PAY';
                    ReconcilliationTable.CurrAmount := BasicPay;
                    ReconcilliationTable.PrevAmount := BasicPayPREV;
                    if BasicPay > BasicPayPREV then
                        ReconcilliationTable.Description := 'Increase in Basic Pay'
                    else
                        ReconcilliationTable.Description := 'Decrease in Basic Pay';
                    ReconcilliationTable.Insert();
                end;

                if GrossPayPREV <> GrossPay then
                    if GrossPayPREV > GrossPay then begin
                        PeriodTransPREV.Reset();
                        PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", "Employee Code");
                        PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                        PeriodTransPREV.SetFilter(PeriodTransPREV."Group Order", '=3');
                        PeriodTransPREV.SetCurrentkey(PeriodTransPREV."Employee Code", PeriodTransPREV."Period Month", PeriodTransPREV."Period Year",
                        PeriodTransPREV."Group Order", PeriodTransPREV."Sub Group Order");
                        if PeriodTransPREV.Find('-') then
                            repeat
                                PeriodTrans.Reset();
                                PeriodTrans.SetRange(PeriodTrans."Employee Code", PeriodTransPREV."Employee Code");
                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                PeriodTrans.SetRange(PeriodTrans."Transaction Code", PeriodTransPREV."Transaction Code");
                                if PeriodTrans.Find('-') then begin
                                    if PeriodTransPREV.Amount <> PeriodTrans.Amount then begin
                                        ReconcilliationTable.Init();
                                        ReconcilliationTable.Employee := "Employee Code";
                                        ReconcilliationTable.TransCode := PeriodTrans."Transaction Code";
                                        ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                        ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                        ReconcilliationTable.Description := 'Changes in ' + PeriodTrans."Transaction Name";
                                        ReconcilliationTable.Insert();
                                    end;
                                end else begin
                                    ReconcilliationTable.Init();
                                    ReconcilliationTable.Employee := "Employee Code";
                                    ReconcilliationTable.TransCode := PeriodTrans."Transaction Code";
                                    ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                    ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                    ReconcilliationTable.Description := 'Changes in ' + PeriodTrans."Transaction Name";
                                    ReconcilliationTable.Insert();
                                end;
                            until PeriodTransPREV.Next() = 0;

                    end else begin
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        PeriodTrans.SetFilter(PeriodTrans."Group Order", '=3');
                        PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                        PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                        if PeriodTrans.Find('-') then
                            repeat
                                PeriodTransPREV.Reset();
                                PeriodTransPREV.SetRange(PeriodTransPREV."Employee Code", PeriodTrans."Employee Code");
                                PeriodTransPREV.SetRange(PeriodTransPREV."Payroll Period", CalcDate('-1M', SelectedPeriod));
                                PeriodTransPREV.SetRange(PeriodTransPREV."Transaction Code", PeriodTrans."Transaction Code");
                                if PeriodTransPREV.Find('-') then begin
                                    if PeriodTransPREV.Amount <> PeriodTrans.Amount then begin
                                        ReconcilliationTable.Init();
                                        ReconcilliationTable.Employee := "Employee Code";
                                        ReconcilliationTable.TransCode := PeriodTrans."Transaction Code";
                                        ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                        ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                        ReconcilliationTable.Description := 'Changes in ' + PeriodTrans."Transaction Name";
                                        ReconcilliationTable.Insert();
                                    end;
                                end else begin
                                    ReconcilliationTable.Init();
                                    ReconcilliationTable.Employee := "Employee Code";
                                    ReconcilliationTable.TransCode := PeriodTrans."Transaction Code";
                                    ReconcilliationTable.CurrAmount := PeriodTrans.Amount;
                                    ReconcilliationTable.PrevAmount := PeriodTransPREV.Amount;
                                    ReconcilliationTable.Description := 'Changes in ' + PeriodTrans."Transaction Name";
                                    ReconcilliationTable.Insert();
                                end;
                            until PeriodTrans.Next() = 0;
                    end;

                if NetPay <= 0 then
                    CurrReport.Skip();
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;
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
        ReconcilliationTable: Record "Monthly Reconcilliation";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodTransPREV: Record "prPeriod Transactions";
        SelectedPeriod: Date;
        BasicPay: Decimal;
        BasicPayPREV: Decimal;
        GrossPay: Decimal;
        GrossPayPREV: Decimal;
        NetPay: Decimal;
        TotBasicPay: Decimal;
        TotGrossPay: Decimal;
        TotNetPay: Decimal;
        No: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Basic_Pay_CaptionLbl: label 'Basic Pay:';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Gross_Pay_CaptionLbl: label 'Gross Pay:';
        Page_No_CaptionLbl: label 'Page No:';
        Payment_ReconcilliationCaptionLbl: label 'Payment Reconcilliation';
        Period_CaptionLbl: label 'Period:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Prev_Basic_Pay_CaptionLbl: label 'Prev Basic Pay:';
        Prev_Gross_Pay_CaptionLbl: label 'Prev Gross Pay:';
        Print_Date_CaptionLbl: label 'Print Date:';
        User_Name_CaptionLbl: label 'User Name:';
        EmployeeName: Text[30];
        PeriodFilter: Text[30];
        PeriodName: Text[30];
}
