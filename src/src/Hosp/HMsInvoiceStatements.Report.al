Report 52202454 "HMs Invoice Statements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMsInvoiceStatements.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.", "Posting Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(PatNo; HMSPat."Patient No.")
            {
            }
            column(sName; HMSPat.Surname + ' ' + HMSPat."Middle Name" + '  ' + HMSPat."Last Name")
            {
            }
            column(DebitAmount; "Cust. Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(Amount; "Cust. Ledger Entry".Amount)
            {
            }
            column(CustomerNo; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Description; "Cust. Ledger Entry".Description)
            {
            }
            column(insuranceNM; insuranceNM)
            {
            }
            column(logo; compinfo.Picture)
            {
            }
            column(strDate; strDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Insurance.Get("Cust. Ledger Entry"."Customer No.") then
                    insuranceNM := Insurance.Name;

                SalInv.Reset();
                SalInv.SetRange(SalInv."No.", "Cust. Ledger Entry"."Document No.");
                if SalInv.Find('-') then begin

                    HMSPat.Reset();
                    HMSPat.SetRange(HMSPat."Patient No.", SalInv."Patient No.");
                    if HMSPat.Find('-') then;

                end;
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
        compinfo.Get();
        compinfo.CalcFields(Picture);

        strDate := "Cust. Ledger Entry".GetFilter("Cust. Ledger Entry"."Posting Date");
    end;

    var
        compinfo: Record "Company Information";
        Insurance: Record Customer;
        HMSPat: Record "HMS Patient";
        SalInv: Record "Sales Invoice Header";
        insuranceNM: Text;
        strDate: Text;
}
