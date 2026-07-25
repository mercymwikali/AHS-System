Report 85220 "Casual Payment Schedule"
{
    DefaultLayout = RDLC;
    ProcessingOnly = false;
    RDLCLayout = './Layouts/Layouts/CasualPaymentSchedule.rdl';

    dataset
    {
        dataitem("Casual Payment Header"; "Casual Payment Header")
        {
            column(ReportForNavId_1; 1)
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
            column(No_CasualPaymentHeader; "Casual Payment Header"."No.")
            {
            }
            column(PostingDate_CasualPaymentHeader; "Casual Payment Header"."Posting Date")
            {
            }
            column(PayrollPeriod_CasualPaymentHeader; "Casual Payment Header"."Payroll Period")
            {
            }
            column(UserID_CasualPaymentHeader; "Casual Payment Header"."User ID")
            {
            }
            dataitem("Casual Payment Lines"; "Casual Payment Lines")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_4; 4)
                {
                }
                column(DocumentNo_CasualPaymentLines; "Casual Payment Lines"."Document No.")
                {
                }
                column(BasicAmount_CasualPaymentLines; "Casual Payment Lines"."Basic Amount")
                {
                }
                column(PAYEAmount_CasualPaymentLines; "Casual Payment Lines"."PAYE Amount")
                {
                }
                column(NSSFAmount_CasualPaymentLines; "Casual Payment Lines"."NSSF Amount")
                {
                }
                column(NHIFAmount_CasualPaymentLines; "Casual Payment Lines"."NHIF Amount")
                {
                }
                column(EmployeeNo_CasualPaymentLines; "Casual Payment Lines"."Employee No")
                {
                }
                column(EmployeeName_CasualPaymentLines; "Casual Payment Lines"."Employee Name")
                {
                }
                column(BankCode_CasualPaymentLines; "Casual Payment Lines"."Bank Code")
                {
                }
                column(BankName_CasualPaymentLines; "Casual Payment Lines"."Bank Name")
                {
                }
                column(BankAccountNo_CasualPaymentLines; "Casual Payment Lines"."Bank Account No")
                {
                }
                column(DimensionSetID_CasualPaymentLines; "Casual Payment Lines"."Dimension Set ID")
                {
                }
                column(RateperMonth_CasualPaymentLines; "Casual Payment Lines"."Rate per Month")
                {
                }
                column(NoofDays_CasualPaymentLines; "Casual Payment Lines"."No of Days")
                {
                }
                column(TotalAmount_CasualPaymentLines; "Casual Payment Lines"."Total Amount")
                {
                }
                column(PayStutatories_CasualPaymentLines; "Casual Payment Lines"."Pay Stutatories")
                {
                }
                column(Occupation_CasualPaymentLines; "Casual Payment Lines".Occupation)
                {
                }
                column(RateperDate_CasualPaymentLines; "Casual Payment Lines"."Rate per Date")
                {
                }
                column(PayRate_CasualPaymentLines; "Casual Payment Lines"."Pay Rate")
                {
                }
                column(PeriodMonth_CasualPaymentLines; "Casual Payment Lines"."Period (Month)")
                {
                }
                column(NetPay_CasualPaymentLines; "Casual Payment Lines"."Net Pay")
                {
                }
                column(PayrollPeriod_CasualPaymentLines; "Casual Payment Lines"."Payroll Period")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Counts := Counts + 1;
                end;

                trigger OnPreDataItem()
                begin
                    Counts := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
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
        CompInfo: Record "Company Information";
        Counts: Integer;
}
