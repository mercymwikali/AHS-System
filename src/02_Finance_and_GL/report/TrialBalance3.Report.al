Report 85053 "Trial Balance3"
{
    Caption = 'Trial Balance';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Trial Balance1.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Global Dimension 4 Filter";
            column(ReportForNavId_6710; 6710)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(AccountType; "G/L Account"."Account Type")
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Totaldebit; Totaldebit)
            {
            }
            column(Totalcredit; -Totalcredit)
            {
            }
            column(Totaldebitbal; Totaldebitbal)
            {
            }
            column(Totalcreditbal; -Totalcreditbal)
            {
            }
            column(AdditionalCurrencyNetChange_GLAccount; "G/L Account"."Additional-Currency Net Change")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    column(ReportForNavId_7; 7)
                    {
                    }
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break();

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date");
                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";

                CalcFields("Net Change", "Balance at Date");
                //CurrReport.CREATETOTALS("Net Change","Balance at Date");
                if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                    if "Net Change" > 0 then
                        Totaldebit := Totaldebit + "Net Change";
                    if "Net Change" < 0 then
                        Totalcredit := Totalcredit + "Net Change";
                end;

                if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                    if "Balance at Date" > 0 then
                        Totaldebitbal := Totaldebitbal + "Balance at Date";
                    if "Balance at Date" < 0 then
                        Totalcreditbal := Totalcreditbal + "Balance at Date";
                end;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE(FORMAT(Totaldebit));
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print to Excel';
                        ToolTip = 'Specifies the value of the Print to Excel field.';
                    }
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

    trigger OnPostReport()
    begin
    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
    end;

    var
        ChangeGroupNo: Boolean;
        PrintToExcel: Boolean;
        Totalcredit: Decimal;
        Totalcreditbal: Decimal;
        Totaldebit: Decimal;
        Totaldebitbal: Decimal;
        BlankLineNo: Integer;
        PageGroupNo: Integer;
        BalanceCaptionLbl: label 'Balance';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: label 'Credit';
        G_L_Account___Net_Change_CaptionLbl: label 'Debit';
        Net_ChangeCaptionLbl: label 'Net Change';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
        Text000: label 'Period: %1';
        Trial_BalanceCaptionLbl: label 'Trial Balance';
        GLFilter: Text;
        PeriodText: Text[30];
}
