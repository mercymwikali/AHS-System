Report 52202669 "Casual Statutory deduction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Layouts/CasualStatutorydeduction.rdl';

    dataset
    {
        dataitem("prPeriod Transactions-Casuals"; "prPeriod Transactions-Casuals")
        {
            RequestFilterFields = "Period Month", "Period Year";
            column(ReportForNavId_1; 1)
            {
            }
            column(TEXT1; TEXT1)
            {
            }
            column(cname; CompInfo.Name)
            {
            }
            column(csddress; CompInfo.Address)
            {
            }
            column(ccity; CompInfo.City)
            {
            }
            column(cphone; CompInfo."Phone No.")
            {
            }
            column(cemail; CompInfo."E-Mail")
            {
            }
            column(cwebsite; CompInfo."Home Page")
            {
            }
            column(cpic; CompInfo.Picture)
            {
            }
            column(EmployeeCode_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Employee Code")
            {
            }
            column(TransactionCode_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Transaction Code")
            {
            }
            column(GroupText_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Group Text")
            {
            }
            column(TransactionName_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals".Amount)
            {
            }
            column(PeriodMonth_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Period Month")
            {
            }
            column(PeriodYear_prPeriodTransactionsCasuals; "prPeriod Transactions-Casuals"."Period Year")
            {
            }
            column(B_Amount; BasicAmount)
            {
            }
            column(NHIF_Amount; NHIFAmount)
            {
            }
            column(NSSF_Amount; NSSFAmount)
            {
            }
            column(PAYE_Amount; PAYEAmount)
            {
            }
            column(Net_Amount; NetAmount)
            {
            }
            column(Name; employeeName)
            {
            }
            column(TBasicAmount; TBasicAmount)
            {
            }
            column(TNHIFAmount; TNHIFAmount)
            {
            }
            column(TNSSFAmount; TNSSFAmount)
            {
            }
            column(TPAYEAmount; TPAYEAmount)
            {
            }
            column(TNetAmoun; TNetAmount)
            {
            }
            dataitem("Casual Employees"; "Casual Employees")
            {
                DataItemLink = "Casual No" = field("Employee Code");
                column(ReportForNavId_21; 21)
                {
                }
                column(CasualNo_CasualEmployees; "Casual Employees"."Casual No")
                {
                }
                column(IDNumber_CasualEmployees; "Casual Employees"."ID Number")
                {
                }
                column(PINNo_CasualEmployees; "Casual Employees"."PIN No")
                {
                }
                column(NSSFNO_CasualEmployees; "Casual Employees"."NSSF NO")
                {
                }
                column(NHIFNO_CasualEmployees; "Casual Employees"."NHIF NO")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "prPeriod Transactions-Casuals"."Transaction Code" = 'BPAY' then begin
                    BasicAmount := "prPeriod Transactions-Casuals".Amount;
                    TBasicAmount := TBasicAmount + "prPeriod Transactions-Casuals".Amount;
                end else
                    if "prPeriod Transactions-Casuals"."Transaction Code" = 'NHIF' then begin
                        NHIFAmount := "prPeriod Transactions-Casuals".Amount;
                        TNHIFAmount := TNHIFAmount + "prPeriod Transactions-Casuals".Amount;
                    end else
                        if "prPeriod Transactions-Casuals"."Transaction Code" = 'NSSF' then begin
                            NSSFAmount := "prPeriod Transactions-Casuals".Amount;
                            TNSSFAmount := TNSSFAmount + "prPeriod Transactions-Casuals".Amount;
                        end else
                            if "prPeriod Transactions-Casuals"."Transaction Code" = 'PAYE' then begin
                                PAYEAmount := "prPeriod Transactions-Casuals".Amount;
                                TPAYEAmount := TPAYEAmount + "prPeriod Transactions-Casuals".Amount;
                            end else
                                if "prPeriod Transactions-Casuals"."Transaction Code" = 'NPAY' then begin
                                    NetAmount := "prPeriod Transactions-Casuals".Amount;
                                    TNetAmount := TNetAmount + "prPeriod Transactions-Casuals".Amount;
                                end;
                CasualEmployees.Reset();
                CasualEmployees.SetRange(CasualEmployees."Casual No", "prPeriod Transactions-Casuals"."Employee Code");
                if CasualEmployees.Find('-') then
                    employeeName := CasualEmployees."Full  Name";
            end;

            trigger OnPreDataItem()
            begin
                BasicAmount := 0;
                NHIFAmount := 0;
                NSSFAmount := 0;
                PAYEAmount := 0;
                NetAmount := 0;
                TBasicAmount := 0;
                TNHIFAmount := 0;
                TNSSFAmount := 0;
                TPAYEAmount := 0;
                TNetAmount := 0;
                CompInfo.Get();
                CompInfo.CalcFields(Picture);
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

    var
        CasualEmployees: Record "Casual Employees";
        CompInfo: Record "Company Information";
        BasicAmount: Decimal;
        NetAmount: Decimal;
        NHIFAmount: Decimal;
        NSSFAmount: Decimal;
        PAYEAmount: Decimal;
        TBasicAmount: Decimal;
        TNetAmount: Decimal;
        TNHIFAmount: Decimal;
        TNSSFAmount: Decimal;
        TPAYEAmount: Decimal;
        TEXT1: label 'CASUAL STATUTORY STATEMENT';
        employeeName: Text;
}
