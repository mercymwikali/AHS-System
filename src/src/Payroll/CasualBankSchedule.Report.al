Report 52202445 "Casual  Bank Schedule"
{
    DefaultLayout = RDLC;
    ProcessingOnly = false;
    RDLCLayout = './Layouts/CasualBankSchedule.rdl';

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
                column(NetPay_CasualPaymentLines; "Casual Payment Lines"."Net Pay")
                {
                }
                column(BankCode_CasualPaymentLines; "Casual Payment Lines"."Bank Code")
                {
                }
                column(BankName_CasualPaymentLines; BankName)
                {
                }
                column(BankAccountNo_CasualPaymentLines; "Casual Payment Lines"."Bank Account No")
                {
                }
                column(EmployeeNo_CasualPaymentLines; "Casual Payment Lines"."Employee No")
                {
                }
                column(EmployeeName_CasualPaymentLines; "Casual Payment Lines"."Employee Name")
                {
                }
                column(BranchCode; BranchCode)
                {
                }
                column(BranchName; "Branch Name")
                {
                }
                column(KBACode; KBA)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    prBankStructure.Reset();
                    prBankStructure.SetRange(prBankStructure."Bank Code", "Casual Payment Lines"."Bank Code");
                    if prBankStructure.Find('-') then begin
                        KBA := prBankStructure."KBA Branch Code";
                        "Branch Name" := prBankStructure."Branch Name";
                        BranchCode := prBankStructure."Branch Code";
                        BankName := Lowercase(prBankStructure."Bank Name");
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
        CompInfo: Record "Company Information";
        prBankStructure: Record "Pr Bank Branches";
        KBA: Code[20];
        BranchCode: Code[30];
        BankName: Text;
        "Branch Name": Text;
}
