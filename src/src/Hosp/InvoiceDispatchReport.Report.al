Report 52202687 "Invoice Dispatch Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Funds/InvoiceDispatchReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Invoice Dispatch Lines"; "Invoice Dispatch Linesd")
        {
            RequestFilterFields = No, "Customer No";
            column(ReportForNavId_1; 1)
            {
            }
            column(InvoiceNo_InvoiceDispatchLines; "Invoice Dispatch Lines"."Invoice No")
            {
            }
            column(InvoiceDate_InvoiceDispatchLines; "Invoice Dispatch Lines"."Invoice Date")
            {
            }
            column(PatientNo_InvoiceDispatchLines; "Invoice Dispatch Lines"."Patient No")
            {
            }
            column(PatientName_InvoiceDispatchLines; "Invoice Dispatch Lines"."Patient Name")
            {
            }
            column(MemberNo_InvoiceDispatchLines; "Invoice Dispatch Lines"."Member No")
            {
            }
            column(CurrAmount_InvoiceDispatchLines; "Invoice Dispatch Lines"."Curr Amount")
            {
            }
            column(OriginalAmount_InvoiceDispatchLines; "Invoice Dispatch Lines"."Original Amount")
            {
            }
            column(No_InvoiceDispatchLines; "Invoice Dispatch Lines".No)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CustNo; Cust."No.")
            {
            }
            column(CustName; Cust.Name)
            {
            }
            column(CustAddr; Cust.Address)
            {
            }
            column(CustPhone; Cust."Phone No.")
            {
            }
            column(MCCNo_InvoiceDispatchLines; "Invoice Dispatch Lines"."MCC No.")
            {
            }
            column(MCC; MCC)
            {
            }
            column(AppointmentDate_InvoiceDispatchLines; "Invoice Dispatch Lines"."Appointment Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //"Invoice Dispatch Lines".CALCFIELDS("Customer No");
                if Cust.Get("Invoice Dispatch Lines"."Customer No") then
                    if Cust.Minet = true then
                        MCC := 'MCC NO.'
                    else
                        MCC := '';
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
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
        CompInf: Record "Company Information";
        Cust: Record Customer;
        MCC: Text;
}
