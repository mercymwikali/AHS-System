Report 85065 "Diagnosis Under 5yrs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DiagnosisUnder5yrs.rdl';

    dataset
    {
        dataitem("HMS Setup Diagnosis"; "HMS Setup Diagnosis")
        {
            DataItemTableView = where("Total Treatments" = filter(<> 0), Code = filter(<> ''));
            column(ReportForNavId_2; 2)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(cname; CompInfor.Name)
            {
            }
            column(Caddress; CompInfor.Address)
            {
            }
            column(ccity; CompInfor.City)
            {
            }
            column(cmobile; CompInfor."Phone No.")
            {
            }
            column(Cpic; CompInfor.Picture)
            {
            }
            column(Printed_On; Pdate)
            {
            }
            column(Printed_Time; ptime)
            {
            }
            column(Printed_By; Puser)
            {
            }
            column(LocationCode_ItemLedgerEntry; "HMS Setup Diagnosis".Code)
            {
            }
            column(Name_Customer; "HMS Setup Diagnosis".Description)
            {
            }
            column(Month; MonthName)
            {
            }
            dataitem("HMS Treatment Form Diagnosis"; "HMS Treatment Form Diagnosis")
            {
                CalcFields = "Diagnosis Date", "Diagnosis Count", PatientNoF;
                DataItemLink = "Diagnosis No." = field(Code);
                DataItemTableView = where("Diagnosis Count" = filter(> 0));
                column(ReportForNavId_35; 35)
                {
                }
                column(D1st; D[1])
                {
                }
                column(D2nd; D[2])
                {
                }
                column(D3rd; D[3])
                {
                }
                column(D4th; D[4])
                {
                }
                column(D5th; D[5])
                {
                }
                column(D6th; D[6])
                {
                }
                column(D7th; D[7])
                {
                }
                column(D8th; D[8])
                {
                }
                column(D9th; D[9])
                {
                }
                column(D10th; D[10])
                {
                }
                column(D11th; D[11])
                {
                }
                column(D12th; D[12])
                {
                }
                column(D13th; D[13])
                {
                }
                column(D14th; D[14])
                {
                }
                column(D15th; D[15])
                {
                }
                column(D16th; D[16])
                {
                }
                column(D17th; D[17])
                {
                }
                column(D18th; D[18])
                {
                }
                column(D19th; D[19])
                {
                }
                column(D20th; D[20])
                {
                }
                column(D21st; D[21])
                {
                }
                column(D22nd; D[22])
                {
                }
                column(D23rd; D[23])
                {
                }
                column(D24th; D[24])
                {
                }
                column(D25th; D[25])
                {
                }
                column(D26th; D[26])
                {
                }
                column(D27th; D[27])
                {
                }
                column(D28th; D[28])
                {
                }
                column(D29th; D[29])
                {
                }
                column(D30th; D[30])
                {
                }
                column(D31st; D[31])
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

                trigger OnAfterGetRecord()
                begin
                    Clear(D);
                    Clear(D2);
                    "HMS Treatment Form Diagnosis".DDate := "HMS Treatment Form Diagnosis"."Diagnosis Date";
                    "HMS Treatment Form Diagnosis".Modify();
                    CalculateAge();
                    if "HMS Treatment Form Diagnosis"."Age in Years" < 5 then
                        for i := 1 to 15 do begin
                            DiagS.Reset();
                            DiagS.SetRange(DiagS.DDate, SD[i]);
                            DiagS.SetRange(DiagS."Diagnosis No.", "HMS Setup Diagnosis".Code);
                            if DiagS.Find('-') then begin
                                DiagS.CalcFields("Diagnosis Date", "Diagnosis Count");
                                D[i] := DiagS."Diagnosis Count";
                            end;
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    if SDate = 0D then
                        Error('Please enter the starting date');
                    for i := 1 to 15 do
                        SD[i] := (SDate - 1) + i;
                    custNo := '';
                    GetMonthName();
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfor.Get();
                CompInfor.CalcFields(Picture);
                Pdate := WorkDate();
                ptime := Time;
                Puser := UserId;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SDate field.';
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
        CompInfor: Record "Company Information";
        DiagS: Record "HMS Treatment Form Diagnosis";
        Puser: Code[50];
        Pdate: Date;
        SD: array[31] of Date;
        SDate: Date;
        D2: array[40] of Decimal;
        CurrentYear: Integer;
        D: array[40] of Integer;
        i: Integer;
        Month: Integer;
        PatientAge: Integer;
        YearBirth: Integer;
        custNo: Text;
        MonthName: Text;
        ptime: Time;

    local procedure CalculateAge()
    begin
        //******kumali get patient Age***********
        "HMS Treatment Form Diagnosis".CalcFields("Date of Birth");
        if "HMS Treatment Form Diagnosis"."Date of Birth" <> 0D then begin
            YearBirth := Date2dmy("HMS Treatment Form Diagnosis"."Date of Birth", 3);
            CurrentYear := Date2dmy(Today, 3);
            PatientAge := CurrentYear - YearBirth;
            "HMS Treatment Form Diagnosis"."Age in Years" := PatientAge;
            "HMS Treatment Form Diagnosis".Modify();
        end;
    end;

    local procedure GetMonthName()
    begin
        Month := Date2dmy(SDate, 2);
        if Month = 1 then
            MonthName := 'JANUARY'
        else
            if Month = 2 then
                MonthName := 'FEBRUARY'
            else
                if Month = 3 then
                    MonthName := 'MARCH'
                else
                    if Month = 4 then
                        MonthName := 'APRIL'
                    else
                        if Month = 5 then
                            MonthName := 'MAY'
                        else
                            if Month = 6 then
                                MonthName := 'JUNE'
                            else
                                if Month = 7 then
                                    MonthName := 'JULY'
                                else
                                    if Month = 8 then
                                        MonthName := 'AUGUST'
                                    else
                                        if Month = 9 then
                                            MonthName := 'SEPTEMBER'
                                        else
                                            if Month = 10 then
                                                MonthName := 'OCTOBER'
                                            else
                                                if Month = 11 then
                                                    MonthName := 'NOVEMBER'
                                                else
                                                    if Month = 12 then
                                                        MonthName := 'DECEMBER';
    end;
}
