Report 85097 "HMS Operational Daily Totals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSOperationalDailyTotals.rdl';

    dataset
    {
        dataitem("HMS Transactions code"; "HMS Transactions code")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionType_HMSTransactionscode; "HMS Transactions code"."Transaction Type")
            {
            }
            column(Description_HMSTransactionscode; "HMS Transactions code".Description)
            {
            }
            column(DateFilter_HMSTransactionscode; "HMS Transactions code"."Date Filter")
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Adress; CompInf.Address)
            {
            }
            column(Adress2; CompInf."Address 2")
            {
            }
            column(Phone; CompInf."Phone No.")
            {
            }
            column(YearText; YearText)
            {
            }
            column(D21; D2[1])
            {
            }
            column(D22; D2[2])
            {
            }
            column(D23; D2[3])
            {
            }
            column(D24; D2[4])
            {
            }
            column(D25; D2[5])
            {
            }
            column(D26; D2[6])
            {
            }
            column(D27; D2[7])
            {
            }
            column(D28; D2[8])
            {
            }
            column(D29; D2[9])
            {
            }
            column(D210; D2[10])
            {
            }
            column(D211; D2[11])
            {
            }
            column(D212; D2[12])
            {
            }
            column(D213; D2[13])
            {
            }
            column(D214; D2[14])
            {
            }
            column(D215; D2[15])
            {
            }
            column(D216; D2[16])
            {
            }
            column(D217; D2[17])
            {
            }
            column(D218; D2[18])
            {
            }
            column(D219; D2[19])
            {
            }
            column(D220; D2[20])
            {
            }
            column(D221; D2[21])
            {
            }
            column(D222; D2[22])
            {
            }
            column(D223; D2[23])
            {
            }
            column(D224; D2[24])
            {
            }
            column(D225; D2[25])
            {
            }
            column(D226; D2[26])
            {
            }
            column(D227; D2[27])
            {
            }
            column(D228; D2[28])
            {
            }
            column(D229; D2[29])
            {
            }
            column(D230; D2[30])
            {
            }
            column(D231; D2[31])
            {
            }
            column(SD1; SD[1])
            {
            }
            column(SD2; SD[2])
            {
            }
            column(SD3; SD[3])
            {
            }
            column(SD4; SD[4])
            {
            }
            column(SD5; SD[5])
            {
            }
            column(SD6; SD[6])
            {
            }
            column(SD7; SD[7])
            {
            }
            column(SD8; SD[8])
            {
            }
            column(SD9; SD[9])
            {
            }
            column(SD10; SD[10])
            {
            }
            column(SD11; SD[11])
            {
            }
            column(SD12; SD[12])
            {
            }
            column(SD13; SD[13])
            {
            }
            column(SD14; SD[14])
            {
            }
            column(SD15; SD[15])
            {
            }
            column(SD16; SD[16])
            {
            }
            column(SD17; SD[17])
            {
            }
            column(SD18; SD[18])
            {
            }
            column(SD19; SD[19])
            {
            }
            column(SD20; SD[20])
            {
            }
            column(SD21; SD[21])
            {
            }
            column(SD22; SD[22])
            {
            }
            column(SD23; SD[23])
            {
            }
            column(SD24; SD[24])
            {
            }
            column(SD25; SD[25])
            {
            }
            column(SD26; SD[26])
            {
            }
            column(SD27; SD[27])
            {
            }
            column(SD28; SD[28])
            {
            }
            column(SD29; SD[29])
            {
            }
            column(SD30; SD[30])
            {
            }
            column(SD31; SD[31])
            {
            }
            column(Totals; Totals)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(D);
                Clear(D2);
                Clear(Totals);

                for i := 1 to 31 do begin
                    SD[i] := (FromDate - 1) + i;
                    Patcharg.Reset();
                    Patcharg.SetRange(Patcharg."Transaction Type", "HMS Transactions code"."Transaction Type");
                    Patcharg.SetRange(Patcharg.Date, (FromDate - 1) + i);
                    if Patcharg.Find('-') then
                        D2[i] := Patcharg.Count;
                end;
                Patcharg.Reset();
                Patcharg.SetRange(Patcharg."Transaction Type", "HMS Transactions code"."Transaction Type");
                Patcharg.SetFilter(Patcharg.Date, '%1..%2', FromDate, (FromDate - 1) + 31);
                if Patcharg.Find('-') then
                    Totals := Patcharg.Count;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
                if FromDate = 0D then
                    Error('Please enter the starting date');
                for i := 1 to 31 do
                    SD[i] := (FromDate - 1) + i;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(From; FromDate)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the FromDate field.';
                }
                field("To"; ToDate)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ToDate field.';
                }
                field(Branch; Branch)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch field.';
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
        CompInf: Record "Company Information";
        Patcharg: Record "HMS Patient Charges";
        FromDate: Date;
        SD: array[31] of Date;
        ToDate: Date;
        D: array[40] of Decimal;
        D2: array[40] of Decimal;
        Totals: Decimal;
        i: Integer;
        Branch: Option ,MAIN,BUNGOMA,NAIROBI;
        YearText: Text;
}
