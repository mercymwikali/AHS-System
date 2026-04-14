Report 85219 "Casual payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Casualpayments.rdl';

    dataset
    {
        dataitem("Casual Payment Header"; "Casual Payment Header")
        {
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_8; 8)
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
                DataItemLink = "Document No." = field("No."), "Payroll Period" = field("Payroll Period");
                DataItemLinkReference = "Casual Payment Header";
                RequestFilterFields = "Payroll Period";
                column(ReportForNavId_1; 1)
                {
                }
                column(EmployeeName_CasualPaymentLines; "Casual Payment Lines"."Employee Name")
                {
                }
                column(PayrollPeriod_CasualPaymentLines; "Casual Payment Lines"."Payroll Period")
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
                column(ID; IDNUMBER)
                {
                }
                column(NSSF_N; NSSFNumber)
                {
                }
                column(NHIF_N; NHIFNUMBER)
                {
                }
                column(KRA_N; KRAPIN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if CasualEmployees.Get("Casual Payment Lines"."Employee No") then begin
                        IDNUMBER := CasualEmployees."ID Number";
                        NHIFNUMBER := CasualEmployees."NHIF NO";
                        NSSFNumber := CasualEmployees."NSSF NO";
                        KRAPIN := CasualEmployees."PIN No";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CompInfo.Get();
                    CompInfo.CalcFields(Picture);
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

    var
        CasualEmployees: Record "Casual Employees";
        CompInfo: Record "Company Information";
        KRAPIN: Code[20];
        NHIFNUMBER: Code[20];
        NSSFNumber: Code[20];
        IDNUMBER: Code[50];
}
