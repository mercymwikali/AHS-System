Report 85249 "Payroll Summary ENTERPRISE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PayrollSummaryENTERPRISE.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(PrintBy; ' SIGNATURE:............................... DATE:.............................')
            {
            }
            column(CheckedBy; 'CHECKED BY:....................................... SIGNATURE:................................... DESIGNATION:...................................... DATE:.............................')
            {
            }
            column(VerifiedBy; 'VERIFIED BY:....................................... SIGNATURE:................................... DESIGNATION:...................................... DATE:.............................')
            {
            }
            column(ApprovedBy; 'APPROVED BY:..................................... SIGNATURE:................................... DESIGNATION:...................................... DATE:.............................')
            {
            }
            column(BasicPayLbl; 'BASIC PAY')
            {
            }
            column(payelbl; 'PAYE.')
            {
            }
            column(nssflbl; 'NSSF')
            {
            }
            column(nhiflbl; 'NHIF')
            {
            }
            column(Netpaylbl; 'Net Pay')
            {
            }
            column(payeamount; payeamount)
            {
            }
            column(nssfam; nssfam)
            {
            }
            column(nhifamt; nhifamt)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(periods; myTitle)
            {
            }
            column(empName; "No." + ': ' + "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(intCount; intCount)
            {
            }
            column(TransName_1_1; TransName[1, 1])
            {
            }
            column(TransName_1_2; TransName[1, 2])
            {
            }
            column(TransName_1_3; TransName[1, 3])
            {
            }
            column(TransName_1_4; TransName[1, 4])
            {
            }
            column(TransName_1_5; TransName[1, 5])
            {
            }
            column(TransName_1_6; TransName[1, 6])
            {
            }
            column(TransName_1_7; TransName[1, 7])
            {
            }
            column(TransName_1_8; TransName[1, 8])
            {
            }
            column(TransName_1_9; TransName[1, 9])
            {
            }
            column(TransName_1_10; TransName[1, 10])
            {
            }
            column(TransName_1_11; TransName[1, 11])
            {
            }
            column(TransName_1_12; TransName[1, 12])
            {
            }
            column(TransName_1_13; TransName[1, 13])
            {
            }
            column(TransName_1_14; TransName[1, 14])
            {
            }
            column(TransName_1_15; TransName[1, 15])
            {
            }
            column(TransName_1_16; TransName[1, 16])
            {
            }
            column(TransName_1_17; TransName[1, 17])
            {
            }
            column(TransName_1_18; TransName[1, 18])
            {
            }
            column(TransName_1_19; TransName[1, 19])
            {
            }
            column(TransName_1_20; TransName[1, 20])
            {
            }
            column(TransName_1_21; TransName[1, 21])
            {
            }
            column(TransName_1_22; TransName[1, 22])
            {
            }
            column(TransName_1_23; TransName[1, 23])
            {
            }
            column(TransName_1_24; TransName[1, 24])
            {
            }
            column(TransName_1_25; TransName[1, 25])
            {
            }
            column(TransName_1_26; TransName[1, 26])
            {
            }
            column(TransName_1_27; TransName[1, 27])
            {
            }
            column(TransName_1_28; TransName[1, 28])
            {
            }
            column(TranscAmount_1_1; TranscAmount[1, 1])
            {
            }
            column(TranscAmount_1_2; TranscAmount[1, 2])
            {
            }
            column(TranscAmount_1_3; TranscAmount[1, 3])
            {
            }
            column(TranscAmount_1_4; TranscAmount[1, 4])
            {
            }
            column(TranscAmount_1_5; TranscAmount[1, 5])
            {
            }
            column(TranscAmount_1_6; TranscAmount[1, 6])
            {
            }
            column(TranscAmount_1_7; TranscAmount[1, 7])
            {
            }
            column(TranscAmount_1_8; TranscAmount[1, 8])
            {
            }
            column(TranscAmount_1_9; TranscAmount[1, 9])
            {
            }
            column(TranscAmount_1_10; TranscAmount[1, 10])
            {
            }
            column(TranscAmount_1_11; TranscAmount[1, 11])
            {
            }
            column(TranscAmount_1_12; TranscAmount[1, 12])
            {
            }
            column(TranscAmount_1_13; TranscAmount[1, 13])
            {
            }
            column(TranscAmount_1_14; TranscAmount[1, 14])
            {
            }
            column(TranscAmount_1_15; TranscAmount[1, 15])
            {
            }
            column(TranscAmount_1_16; TranscAmount[1, 16])
            {
            }
            column(TranscAmount_1_17; TranscAmount[1, 17])
            {
            }
            column(TranscAmount_1_18; TranscAmount[1, 18])
            {
            }
            column(TranscAmount_1_19; TranscAmount[1, 19])
            {
            }
            column(TranscAmount_1_20; TranscAmount[1, 20])
            {
            }
            column(TranscAmount_1_21; TranscAmount[1, 21])
            {
            }
            column(TranscAmount_1_22; TranscAmount[1, 22])
            {
            }
            column(TranscAmount_1_23; TranscAmount[1, 23])
            {
            }
            column(TranscAmount_1_24; TranscAmount[1, 24])
            {
            }
            column(TranscAmount_1_25; TranscAmount[1, 25])
            {
            }
            column(TranscAmount_1_26; TranscAmount[1, 26])
            {
            }
            column(TranscAmount_1_27; TranscAmount[1, 27])
            {
            }
            column(TranscAmount_1_28; TranscAmount[1, 28])
            {
            }

            trigger OnAfterGetRecord()
            begin

                TransCount := 0;
                showdet := true;
                NetPay := 0;
                BasicPay := 0;
                GrossPay := 0;
                Clear(TranscAmount);
                payeamount := 0;
                nssfam := 0;
                nhifamt := 0;
                decAllowances := 0;
                decDeductions := 0;

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Group Text", 'ALLOWANCE');
                if prPeriodTransactions.Find('-') then
                    repeat
                        decAllowances := decAllowances + prPeriodTransactions.Amount;
                        decAllowancesTotal := decAllowancesTotal + prPeriodTransactions.Amount;
                    until prPeriodTransactions.Next() = 0;

                TranscAmount[1, 1] := decAllowances;

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Group Text", 'GROSS PAY');
                if prPeriodTransactions.Find('-') then begin
                    GrossPay := GrossPay + prPeriodTransactions.Amount;
                    GrosspayTotal := GrosspayTotal + prPeriodTransactions.Amount;
                end;

                TranscAmount[1, 2] := GrossPay;

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetFilter(prPeriodTransactions."Group Text", 'DEDUCTIONS|STATUTORIES');
                if prPeriodTransactions.Find('-') then
                    repeat
                        if prPeriodTransactions."Transaction Code" <> 'TOT-DED' then begin
                            decDeductions := decDeductions + prPeriodTransactions.Amount;
                            decDeductionsTotal := decDeductionsTotal + prPeriodTransactions.Amount;
                        end;
                    until prPeriodTransactions.Next() = 0;

                TranscAmount[1, 3] := decDeductions;

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Name", 'Net Pay');
                if prPeriodTransactions.Find('-') then
                    NetPay := prPeriodTransactions.Amount;
                    //NetPayTotal:=(NetPayTotal+(prPeriodTransactions.Amount));

                prPeriodTransactions.Reset();
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR-Employee"."No.");
                //prPeriodTransactions.SETRANGE(prPeriodTransactions."Transaction Name",'Net Pay');
                if prPeriodTransactions.Find('-') then
                    repeat

                        if prPeriodTransactions."Transaction Code" = 'NPAY' then begin
                            NetPay := prPeriodTransactions.Amount;
                            NetPayTotal := (NetPayTotal + (prPeriodTransactions.Amount));
                        end else
                            if prPeriodTransactions."Transaction Code" = 'PAYE' then begin
                                payeamount := prPeriodTransactions.Amount;
                                ;
                                payeamountTotal := (payeamountTotal + (prPeriodTransactions.Amount));
                            end else
                                if prPeriodTransactions."Transaction Code" = 'NSSF' then begin
                                    nssfam := prPeriodTransactions.Amount;
                                    ;
                                    nssfamTotal := (nssfamTotal + (prPeriodTransactions.Amount));
                                end else
                                    if prPeriodTransactions."Transaction Code" = 'NHIF' then begin
                                        nhifamt := prPeriodTransactions.Amount;
                                        ;
                                        nhifamtTotal := (nhifamtTotal + (prPeriodTransactions.Amount));
                                    end else
                                        if prPeriodTransactions."Transaction Code" = 'BPAY' then begin
                                            BasicPay := prPeriodTransactions.Amount;
                                            ;
                                            BasicPayTotal := (BasicPayTotal + (prPeriodTransactions.Amount));
                                            ;
                                        end;
                    until prPeriodTransactions.Next() = 0;

                if "HR-Employee"."No." = '' then
                    showdet := false;

                if ((BasicPay = 0) or ("HR-Employee"."No." = '')) then //showdet:=FALSE;
                    CurrReport.Skip();

                intCount := intCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if periods = 0D then
                    Error('Please Specify the Period first.');
                counts := 0;
                NetPayTotal := 0;
                BasicPayTotal := 0;
                payeamountTotal := 0;
                nssfamTotal := 0;
                nhifamtTotal := 0;

                Clear(TranscAmountTotal);

                info.Reset();
                if info.Find('-') then
                    info.CalcFields(info.Picture);

                myTitle := 'PAYROLL SUMMARY FOR ' + Format(periods, 20, '<Month Text>-<Year4>');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Period; periods)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period:';
                    TableRelation = "prPayroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Period: field.';
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

    var
        info: Record "Company Information";
        prPeriodTransactions: Record "prPeriod Transactions";
        showdet: Boolean;
        myTitle: Code[50];
        periods: Date;
        BasicPayTotal: Decimal;
        decAllowances: Decimal;
        decAllowancesTotal: Decimal;
        decDeductions: Decimal;
        decDeductionsTotal: Decimal;
        GrossPay: Decimal;
        GrosspayTotal: Decimal;
        NetPay: Decimal;
        NetPayTotal: Decimal;
        nhifamt: Decimal;
        nhifamtTotal: Decimal;
        nssfam: Decimal;
        nssfamTotal: Decimal;
        payeamount: Decimal;
        payeamountTotal: Decimal;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;
        counts: Integer;
        intCount: Integer;
        TransCount: Integer;
        TransName: array[1, 200] of Text[200];
}
