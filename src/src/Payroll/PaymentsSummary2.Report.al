Report 52202601 "Payments Summary 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PaymentsSummary2.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102755015; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756027; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756028; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
            {
            }
            column(PayrollSummary; 'COMPANY PAYROLL SUMMARY')
            {
            }
            column(PeriodNamez; 'PERIOD:  ' + PeriodName)
            {
            }
            column(TransDesc; 'TRANSACTION DESC.')
            {
            }
            column(payments; 'PAYMENTS')
            {
            }
            column(deductions; 'DEDUCTIONS')
            {
            }
            column(kirinyagatitle; COMPANYNAME)
            {
            }
            column(abreviation; 'MUST')
            {
            }
            column(DetDate; DetDate)
            {
            }
            column(EmpNo; "prPeriod Transactions"."Employee Code")
            {
            }
            column(empName; empName)
            {
            }
            column(EmpAmount; "prPeriod Transactions".Amount)
            {
            }
            column("code"; "prPeriod Transactions"."Transaction Code")
            {
            }
            column(name; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Transaction; "prPeriod Transactions"."Transaction Code" + ': ' + "prPeriod Transactions"."Transaction Name")
            {
            }
            column(TotLabel; "prPeriod Transactions"."Transaction Code" + ': ' + "prPeriod Transactions"."Transaction Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(empName);
                if emps.Get("prPeriod Transactions"."Employee Code") then
                    empName := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";

                if not (((("prPeriod Transactions"."Group Order" = 1) and
                ("prPeriod Transactions"."Sub Group Order" <> 1)) or
               ("prPeriod Transactions"."Group Order" = 3) or
                (("prPeriod Transactions"."Group Order" = 4) and
                 ("prPeriod Transactions"."Sub Group Order" <> 0)))) then
                    CurrReport.Skip();

                "prPayroll Periods".Reset();
                "prPayroll Periods".SetRange("prPayroll Periods"."Date Opened", SelectedPeriod);
                if "prPayroll Periods".Find('-') then begin
                    Clear(DetDate);
                    DetDate := Format("prPayroll Periods"."Period Name");
                end;

                /*IF NOT ( ((("prPeriod Transactions"."Group Order"=7) AND
                     (("prPeriod Transactions"."Sub Group Order"<>6)
                    AND ("prPeriod Transactions"."Sub Group Order"<>5))) OR
                    (("prPeriod Transactions"."Group Order"=8) AND
                     ("prPeriod Transactions"."Sub Group Order"<>9)))) THEN BEGIN
                      CurrReport.SKIP;
                      END; */

                /*
              CLEAR(rows);
              CLEAR(rows2);
              "prPeriod Transactions".RESET;
              "prPeriod Transactions".SETRANGE("Payroll Period",SelectedPeriod);
              "prPeriod Transactions".SETFILTER("Group Order",'=1|3|4|7|8|9');
              //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');
              "prPeriod Transactions".SETCURRENTKEY("Payroll Period","Group Order","Sub Group Order");
              IF "prPeriod Transactions".FIND('-') THEN BEGIN
              CLEAR(DetDate);
              DetDate:=FORMAT("prPayroll Periods"."Period Name");
              REPEAT
              BEGIN
              IF "prPeriod Transactions".Amount>0 THEN BEGIN
              IF (("prPeriod Transactions"."Group Order"=4) AND ("prPeriod Transactions"."Sub Group Order"=0)) THEN
                GPY:=GPY+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=7) AND
              (("prPeriod Transactions"."Sub Group Order"=3) OR ("prPeriod Transactions"."Sub Group Order"=1) OR
               ("prPeriod Transactions"."Sub Group Order"=2)))  THEN
                STAT:=STAT+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=8) AND
              (("prPeriod Transactions"."Sub Group Order"=1) OR ("prPeriod Transactions"."Sub Group Order"=0))) THEN
                 DED:=DED+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=9) AND ("prPeriod Transactions"."Sub Group Order"=0)) THEN
                NETS:=NETS+"prPeriod Transactions".Amount;

              //TotalsAllowances:=TotalsAllowances+"prPeriod Transactions".Amount;
                  IF ((("prPeriod Transactions"."Group Order"=1) AND
                   ("prPeriod Transactions"."Sub Group Order"<>1)) OR
                  ("prPeriod Transactions"."Group Order"=3) OR
                   (("prPeriod Transactions"."Group Order"=4) AND
                    ("prPeriod Transactions"."Sub Group Order"<>0))) THEN BEGIN // A Payment
                    CLEAR(countz);
                   // countz:=1;
                    CLEAR(found);
                    REPEAT
                   BEGIN
                     countz:=countz+1;
                     IF (PayTrans[countz])="prPeriod Transactions"."Transaction Name" THEN found:=TRUE;
                     END;
                    UNTIL ((countz=(ARRAYLEN(PayTransAmt))) OR ((PayTrans[countz])="prPeriod Transactions"."Transaction Name")
                    OR ((PayTrans[countz])=''));
                   rows:= countz;
                  PayTrans[rows]:="prPeriod Transactions"."Transaction Name";
                  PayTransAmt[rows]:=PayTransAmt[rows]+"prPeriod Transactions".Amount;
                  END ELSE IF ((("prPeriod Transactions"."Group Order"=7) AND
                   (("prPeriod Transactions"."Sub Group Order"<>6)
                  AND ("prPeriod Transactions"."Sub Group Order"<>5))) OR
                  (("prPeriod Transactions"."Group Order"=8) AND
                   ("prPeriod Transactions"."Sub Group Order"<>9))) THEN BEGIN
                    CLEAR(countz);
                   // countz:=1;
                    CLEAR(found);
                    REPEAT
                   BEGIN
                     countz:=countz+1;
                     IF (DedTrans[countz])="prPeriod Transactions"."Transaction Name" THEN found:=TRUE;
                     END;
                    UNTIL ((countz=(ARRAYLEN(DedTransAmt))) OR ((DedTrans[countz])="prPeriod Transactions"."Transaction Name")
                    OR ((DedTrans[countz])=''));
                   rows:= countz;
                  DedTrans[rows]:="prPeriod Transactions"."Transaction Name";
                  DedTransAmt[rows]:=DedTransAmt[rows]+"prPeriod Transactions".Amount;
                  END;
                  END; // If Amount >0;
              END;
              UNTIL "prPeriod Transactions".NEXT=0;
              END;// End prPeriod Transactions Repeat
              // MESSAGE('Heh'+FORMAT(rows)+', '+FORMAT(rows2));
                                    */
            end;

            trigger OnPreDataItem()
            begin

                //LastFieldNo := FIELDNO("Period Year");
                "prPeriod Transactions".SetFilter("prPeriod Transactions"."Payroll Period", '=%1', SelectedPeriod);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period Filter';
                    TableRelation = "prPayroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Period Filter field.';
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

    trigger OnInitReport()
    begin
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then
            PeriodName := objPeriod."Period Name";

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        Clear(rows);
        Clear(GPY);
        Clear(STAT);
        Clear(DED);
        Clear(NETS);
    end;

    var
        CompanyInfo: Record "Company Information";
        emps: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        "prPayroll Periods": Record "prPayroll Periods";
        PeriodFilter: Date;
        SelectedPeriod: Date;
        DED: Decimal;
        GPY: Decimal;
        NETS: Decimal;
        STAT: Decimal;
        rows: Integer;
        PeriodName: Text[30];
        DetDate: Text[100];
        empName: Text[250];
}
