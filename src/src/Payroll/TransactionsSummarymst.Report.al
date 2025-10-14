Report 52202589 "Transactions Summary mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TransactionsSummarymst.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = sorting("Group Order", "Sub Group Order");
            RequestFilterFields = "Period Filter";
            column(ReportForNavId_6955; 6955)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(GetFilters; GetFilters)
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(prTransaction_Codes__Curr__Amount_; "prPeriod Transactions".Amount)
            {
            }
            column(prTransaction_Codes__Curr__Amount__Control1102755010; "prPeriod Transactions".Amount)
            {
            }
            column(Transactions_SummaryCaption; Transactions_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //IF "prPeriod Transactions"."Non-Transactional" = TRUE THEN BEGIN
                if ("prPeriod Transactions"."Transaction Code" <> 'BPAY') and
                   ("prPeriod Transactions"."Transaction Code" <> 'PAYE') and
                   ("prPeriod Transactions"."Transaction Code" <> 'NHF') then
                    CurrReport.Skip();

                //END;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Period Filter") = '' then
                    Error('You must specify Current Period Filter.');

                Evaluate(SelectedPeriod, GetFilter("Period Filter"));

                //SETFILTER("Previous Month Filter",FORMAT(CALCDATE('-1M',SelectedPeriod)));
                //CurrReport.CREATETOTALS(DebitAmount,CreditAmount);
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        CompanyInfo: Record "Company Information";
        SelectedPeriod: Date;
        AmountCaptionLbl: label 'Amount';
        CodeCaptionLbl: label 'Code';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        DescriptionCaptionLbl: label 'Description';
        Transactions_SummaryCaptionLbl: label 'Transactions Summary';
}
