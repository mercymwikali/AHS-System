Report 85256 "pr Bank Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prBankSchedule.rdl';

    dataset
    {
        dataitem("prBank Structure"; "Pr Bank Branches")
        {
            DataItemTableView = sorting("Bank Code", "Branch Code");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Bank Code", "Branch Code", "Period Filter";
            column(ReportForNavId_4233; 4233)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Name")
            {
            }
            column(prBank_Structure__Branch_Name_; "Branch Name")
            {
            }
            column(prBank_Structure__prBank_Structure___KBA_Branch_Code_; "prBank Structure"."KBA Branch Code")
            {
            }
            column(GrantTotal; GrantTotal)
            {
            }
            column(Bank_ScheduleCaption; Bank_ScheduleCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prBank_Structure__Bank_Name_Caption; FieldCaption("Bank Name"))
            {
            }
            column(prBank_Structure__Branch_Name_Caption; FieldCaption("Branch Name"))
            {
            }
            column(KBA_Branch_CodeCaption; KBA_Branch_CodeCaptionLbl)
            {
            }
            column(Period_TotalCaption; Period_TotalCaptionLbl)
            {
            }
            column(prBank_Structure_Bank_Code; "Bank Code")
            {
            }
            column(prBank_Structure_Branch_Code; "Branch Code")
            {
            }
            column(periodLabel; "prBank Structure".GetFilter("prBank Structure"."Period Filter"))
            {
            }
            column(period; period)
            {
            }
            column(perName; payper."Period Name")
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Branch Bank" = field("Branch Code"), "Main Bank" = field("Bank Code");
                DataItemTableView = where(Status = filter(Normal));
                RequestFilterFields = "Payroll Posting Group";
                column(ReportForNavId_8631; 8631)
                {
                }
                column(HR_Employee__No__; "No.")
                {
                }
                column(HR_Employee___First_Name_______HR_Employee___Middle_Name_______HR_Employee___Last_Name_; "HR-Employee"."First Name" + "HR-Employee"."Middle Name" + "HR-Employee"."Last Name")
                {
                }
                column(HR_Employee__Bank_Account_Number_; "Bank Account Number")
                {
                }
                column(NPay; NPay)
                {
                }
                column(TNpay; TNpay)
                {
                }
                column(HR_Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(Full_NamesCaption; Full_NamesCaptionLbl)
                {
                }
                column(HR_Employee__Bank_Account_Number_Caption; FieldCaption("Bank Account Number"))
                {
                }
                column(Net_PayCaption; Net_PayCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(HR_Employee_Branch_Bank; "Branch Bank")
                {
                }
                column(HR_Employee_Main_Bank; "Main Bank")
                {
                }
                column(KBA_Code; "prBank Structure"."Bank Code" + "prBank Structure"."Branch Code")
                {
                }
                column(Details; Details)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NPay := 0;
                    PeriodTRans.Reset();
                    PeriodTRans.SetRange(PeriodTRans."Employee Code", "HR-Employee"."No.");
                    PeriodTRans.SetRange(PeriodTRans."Transaction Code", 'NPAY');
                    PeriodTRans.SetFilter(PeriodTRans."Payroll Period", '=%1', period);
                    if PeriodTRans.Find('-') then
                        NPay := PeriodTRans.Amount;

                    if NPay <= 0 then
                        CurrReport.Skip();

                    TNpay := TNpay + NPay;
                    GrantTotal := GrantTotal + NPay;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PerFilter; period)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pay Period';
                    TableRelation = "prPayroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Pay Period field.';
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
        if period = 0D then
            Error('Error!\Specify the period.');

        payper.Reset();
        payper.SetRange(payper."Date Opened", period);
        if payper.Find('-') then
            Details := payper."Period Name" + ' Salaries';
    end;

    var
        payper: Record "prPayroll Periods";
        PeriodTRans: Record "prPeriod Transactions";
        period: Date;
        GrantTotal: Decimal;
        NPay: Decimal;
        TNpay: Decimal;
        Bank_ScheduleCaptionLbl: label 'Bank Schedule';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Full_NamesCaptionLbl: label 'Full Names';
        KBA_Branch_CodeCaptionLbl: label 'KBA Branch Code';
        Net_PayCaptionLbl: label 'Net Pay';
        Period_TotalCaptionLbl: label 'Period Total';
        TotalCaptionLbl: label 'Total';
        Details: text[200];
}
