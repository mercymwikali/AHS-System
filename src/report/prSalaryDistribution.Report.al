Report 85297 "prSalary Distribution"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(prSalaryCard; "prSalary Card")
        {
            RequestFilterFields = "Employee Code", "Payroll Period", "Employee Status";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin

                MakeExcelDataBody();
            end;

            trigger OnPostDataItem()
            begin
                CreateExcelbook();
            end;

            trigger OnPreDataItem()
            begin
                //IF PrintToExcel THEN
                // UserSetup.Get(UserId);
                // SetFilter(PayrollCode,'=%1',UserSetup."Payroll Code");
                MakeExcelInfo();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(myFilter; myFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Code';
                    TableRelation = "PR Transaction Codes"."Transaction Code";
                    ToolTip = 'Specifies the value of the Transaction Code field.';
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
        ExcelBuf: Record "Excel Buffer" temporary;
        objEmp: Record "HR-Employee";
        premployer: Record "prEmployer Deductions";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodTransO: Record "prPeriod Transactions";
        Trans: Record "PR Transaction Codes";
        Dates: Codeunit "HR Dates";
        PayrollCode: Code[50];
        TotalmyAmount: Decimal;
        TOTDed: Decimal;
        DAge: Text[100];
        myFilter: Text[1000];

    procedure MakeExcelInfo()
    begin
        //ExcelBuf.SetUseInfoSheed;
        ExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        if myFilter = '' then
            myFilter := '001..PYAR';

        ExcelBuf.AddColumn('AMPATH SALARY MATRIX', false, '', true, false, true, '', 0);
        //ExcelBuf.AddColumn(Value,IsFormula,CommentText,IsBold,IsItalics,IsUnderline,NumFormat,CellType)
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Payroll Period', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('PF No.', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Date Of Joining', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('First Name', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Middle Name', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Last Name', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('RS', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Project', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Donor', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Department', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Program Area', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('County', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Station', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Job Specification', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('ID Number', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('PIN Number', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('NHIF no', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('NSSF no', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Birth Date', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Age', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Gender', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Salutation', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Email', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Telephone Number', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Contract Status', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Service Category', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('MFL Code', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Contract End Date', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Date of Leaving', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('BasicPay', false, '', true, false, true, '', 0);
        Trans.Reset();
        Trans.SetFilter(Trans."Transaction Code", myFilter);
        Trans.SetRange(Trans."Transaction Type", Trans."transaction type"::Income);
        if Trans.Find('-') then
            repeat
                if (Trans."Transaction Code" <> '893') and (Trans."Transaction Code" <> '897') then begin
                    Evaluate(Trans."Payroll Filter", prSalaryCard.GetFilter("Payroll Period"));
                    Trans.CalcFields("Used Count");
                    if Trans."Used Count" > 0 then
                        ExcelBuf.AddColumn(Trans."Transaction Name", false, '', false, false, true, '', 0);
                end;
            until Trans.Next() = 0;
        ExcelBuf.AddColumn('Gross Pay', false, '', false, false, true, '', 0);

        Trans.Reset();
        Trans.SetFilter(Trans."Transaction Code", myFilter);
        Trans.SetRange(Trans."Transaction Type", Trans."transaction type"::Deduction);
        if Trans.Find('-') then
            repeat
                Evaluate(Trans."Payroll Filter", prSalaryCard.GetFilter("Payroll Period"));
                Trans.CalcFields("Used Count");
                if Trans."Used Count" > 0 then
                    ExcelBuf.AddColumn(Trans."Transaction Name", false, '', false, false, true, '', 0);
            until Trans.Next() = 0;
        ExcelBuf.AddColumn('NSSF', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('NHIF', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('PAYE', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Total Deductions', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Gratuity', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Pension Company', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Nssf', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Nita Deduction', false, '', false, false, true, '', 0);
        ExcelBuf.AddColumn('Net Pay', false, '', false, false, true, '', 0);
        ExcelBuf.NewRow();

        /*

        Trans.RESET;
        Trans.SETFILTER(Trans."Transaction Code",myFilter);
        IF Trans.FIND('-') THEN REPEAT
            ExcelBuf.AddColumn(Trans."Transaction Name",FALSE,'',FALSE,FALSE,TRUE,'',0);
        UNTIL Trans.NEXT=0;

        ExcelBuf.AddColumn('Gross Pay',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('NHIF',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('NSSF',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('PAYE',FALSE,'',FALSE,FALSE,TRUE,'',0);

        ExcelBuf.AddColumn('Gratuity',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('Pension Company',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('Nssf',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('Net Pay',FALSE,'',FALSE,FALSE,TRUE,'',0);
        ExcelBuf.NewRow;
        */
    end;

    procedure MakeExcelDataBody()
    begin
        objEmp.Reset();
        objEmp.SetRange(objEmp."No.", prSalaryCard."Employee Code");
        if objEmp.Find('-') then begin
            ExcelBuf.AddColumn(prSalaryCard."Payroll Period", false, '', false, false, true, '', 0);
            ExcelBuf.AddColumn(prSalaryCard."Employee Code", false, '', false, false, true, '0000', 0);
            ExcelBuf.AddColumn(objEmp."Date Of Join", false, '', false, false, true, '0000', 0);
            ExcelBuf.AddColumn(objEmp."First Name", false, '', false, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Middle Name", false, '', false, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Last Name", false, '', false, false, true, '', 0);
            // ExcelBuf.AddColumn(prSalaryCard.Grade,false,'',false,false,true,'',0);
            // ExcelBuf.AddColumn(prSalaryCard."Global Dimension 2 Code",false,'',false,false,true,'',0);
            //  ExcelBuf.AddColumn(prSalaryCard."Global Dimension 1 Code",false,'',true,false,true,'',0);
            // ExcelBuf.AddColumn(prSalaryCard."Shortcut Dimension 3 Code",false,'',true,false,true,'',0);
            // ExcelBuf.AddColumn(prSalaryCard."Program Name",false,'',true,false,true,'',0);
            //  ExcelBuf.AddColumn(prSalaryCard."Shortcut Dimension 4 Code",false,'',true,false,true,'',0);

            //  if prSalaryCard."Shortcut Dimension 5 Code" = '' then mDim5 := objEmp."Shortcut Dimension 5 Code" else mDim5 := prSalaryCard."Shortcut Dimension 5 Code";

            // ExcelBuf.AddColumn(mDim5,false,'',true,false,true,'',0);
            // prSalaryCard.CalcFields("Job Title LK");
            // ExcelBuf.AddColumn(prSalaryCard."Job Title LK",false,'',true,false,true,'',0);

            ExcelBuf.AddColumn(objEmp."ID Number", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."PAYE Number", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."NHIF No.", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."NSSF No.", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Date Of Birth", false, '', true, false, true, '', 0);
            if (objEmp."Date Of Birth" <> 0D) then
                if objEmp."Date Of Birth" <= Today then
                    DAge := Dates.DetermineAge(objEmp."Date Of Birth", Today)
                else
                    Message(prSalaryCard."Employee Code");
            ExcelBuf.AddColumn(DAge, false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp.Gender, false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp.Title, false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."E-Mail", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Cellular Phone Number", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Contract Type", false, '', true, false, true, '', 0);
            // ExcelBuf.AddColumn(objEmp."Service Category",false,'',true,false,true,'',0);
            //  ExcelBuf.AddColumn(objEmp."MFL Code",false,'',true,false,true,'',0);
            ExcelBuf.AddColumn(objEmp."Contract End Date", false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(objEmp."Date Of Leaving", false, '', true, false, true, '', 0);

            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'BPAY');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);

            Trans.Reset();
            Trans.SetFilter(Trans."Transaction Code", myFilter);
            Trans.SetRange(Trans."Transaction Type", Trans."transaction type"::Income);
            if Trans.Find('-') then
                repeat
                    if (Trans."Transaction Code" <> '893') and (Trans."Transaction Code" <> '897') then begin
                        Evaluate(Trans."Payroll Filter", prSalaryCard.GetFilter("Payroll Period"));
                        Trans.CalcFields("Used Count");
                        if Trans."Used Count" > 0 then begin

                            TotalmyAmount := 0;
                            PeriodTrans.Reset();
                            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
                            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", Trans."Transaction Code");
                            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
                            //  PeriodTrans.SetFilter(PeriodTrans."Payroll Code",prSalaryCard.PayrollCode);//PayrollCode );
                            if PeriodTrans.Find('-') then
                                repeat
                                    ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', false, false, true, '#,##0.00', ExcelBuf."cell type"::Number);
                                    TotalmyAmount := TotalmyAmount + PeriodTrans.Amount;
                                until PeriodTrans.Next() = 0
                            else
                                ExcelBuf.AddColumn(0, false, '', false, false, true, '', 0);
                        end;
                    end;
                until Trans.Next() = 0;
            //Gross pay before deductions
            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'GPAY');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);
            //

            //Deductions
            Trans.Reset();
            Trans.SetFilter(Trans."Transaction Code", myFilter);
            Trans.SetRange(Trans."Transaction Type", Trans."transaction type"::Deduction);
            if Trans.Find('-') then
                repeat
                    Evaluate(Trans."Payroll Filter", prSalaryCard.GetFilter("Payroll Period"));
                    Trans.CalcFields("Used Count");
                    if Trans."Used Count" > 0 then begin

                        TotalmyAmount := 0;
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
                        PeriodTrans.SetFilter(PeriodTrans."Transaction Code", Trans."Transaction Code");
                        PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
                        // PeriodTrans.SetFilter(PeriodTrans."Payroll Code",prSalaryCard.PayrollCode);//PayrollCode );
                        if PeriodTrans.Find('-') then
                            repeat
                                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', false, false, true, '#,##0.00', ExcelBuf."cell type"::Number);
                                TotalmyAmount := TotalmyAmount + PeriodTrans.Amount;
                            until PeriodTrans.Next() = 0
                        else
                            ExcelBuf.AddColumn(0, false, '', false, false, true, '', 0);
                    end;
                until Trans.Next() = 0;
            //
            //NSSF Employee
            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'NSSF');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', false, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);
            //NHIF
            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'NHIF');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', false, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);
            //PAYE
            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'PAYE');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', false, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);

            // Deductions
            TOTDed := 0;
            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Group Text", 'DEDUCTIONS|STATUTORIES');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                repeat
                    if PeriodTrans."Transaction Code" <> 'TOT-DED' then
                        TOTDed := TOTDed + PeriodTrans.Amount;
                until PeriodTrans.Next() = 0;

            ExcelBuf.AddColumn(TOTDed, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number);

            PeriodTransO.Reset();
            PeriodTransO.SetRange(PeriodTransO."Employee Code", prSalaryCard."Employee Code");
            PeriodTransO.SetFilter(PeriodTransO."Transaction Code", '362');
            PeriodTransO.SetFilter(PeriodTransO."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTransO.SetFilter(PeriodTransO."Payroll Code", PayrollCode);
            if PeriodTransO.Find('-') then
                ExcelBuf.AddColumn(PeriodTransO.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number);
            //Pension
            premployer.Reset();
            premployer.SetRange(premployer."Employee Code", prSalaryCard."Employee Code");
            premployer.SetFilter(premployer."Transaction Code", '767');
            premployer.SetFilter(premployer."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            premployer.SetFilter(premployer."Payroll Code", PayrollCode);
            if premployer.Find('-') then
                ExcelBuf.AddColumn(premployer.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number);

            //Pension
            //NSSF
            premployer.Reset();
            premployer.SetRange(premployer."Employee Code", prSalaryCard."Employee Code");
            premployer.SetFilter(premployer."Transaction Code", 'NSSF');
            premployer.SetFilter(premployer."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            premployer.SetFilter(premployer."Payroll Code", PayrollCode);
            if premployer.Find('-') then
                ExcelBuf.AddColumn(premployer.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);

            //NSSF
            //NITA
            premployer.Reset();
            premployer.SetRange(premployer."Employee Code", prSalaryCard."Employee Code");
            premployer.SetFilter(premployer."Transaction Code", 'NITA');
            premployer.SetFilter(premployer."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            premployer.SetFilter(premployer."Payroll Code", PayrollCode);
            if premployer.Find('-') then
                ExcelBuf.AddColumn(premployer.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number);

            //NITA

            PeriodTrans.Reset();
            PeriodTrans.SetRange(PeriodTrans."Employee Code", prSalaryCard."Employee Code");
            PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'NPAY');
            PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '=%1', prSalaryCard."Payroll Period");
            PeriodTrans.SetFilter(PeriodTrans."Payroll Code", PayrollCode);
            if PeriodTrans.Find('-') then
                ExcelBuf.AddColumn(PeriodTrans.Amount, false, '', true, false, true, '#,##0.00', ExcelBuf."cell type"::Number)
            else
                ExcelBuf.AddColumn(0, false, '', true, false, true, '', 0);

            ExcelBuf.NewRow();

            /*
            //BPay------------------------------------------------------------------------
             PeriodTrans.RESET;
             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'BPAY');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN
               ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0)
              ELSE
                 ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

           //Income------------------------------------------------------------------------
           Trans.RESET;
           Trans.SETFILTER(Trans."Transaction Code",'<>%1','');
           IF Trans.FIND('-') THEN REPEAT
             Trans."Current Month Filter" := SelectedPeriod;
             Trans.CALCFIELDS(TransExists);
             IF Trans.TransExists = TRUE THEN BEGIN
             PeriodTrans.RESET;
             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",Trans."Transaction Code");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN
               ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',FALSE,FALSE,TRUE,'',0)
             ELSE
               ExcelBuf.AddColumn(0,FALSE,'',FALSE,FALSE,TRUE,'',0);
             END;
           UNTIL Trans.NEXT=0;
           //GrossPay------------------------------------------------------------------------
             PeriodTrans.RESET;
             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'GPAY');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

            //Statutories------------------------------------------------------------------------
             PeriodTrans.RESET;
             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'NHIF');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

            //NSSF
             PeriodTrans.RESET;
             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'NSSF');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

             PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'PAYE');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

             PeriodTransO.RESET;
             PeriodTransO.SETRANGE(PeriodTransO."Employee Code",prSalaryCard."Employee Code");
             PeriodTransO.SETFILTER(PeriodTransO."Transaction Code",'362');
             PeriodTransO.SETFILTER(PeriodTransO."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTransO.SETFILTER(PeriodTransO."Payroll Code",PayrollCode );
             IF PeriodTransO.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTransO.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

             //Pension
             premployer.RESET;
             premployer.SETRANGE(premployer."Employee Code",prSalaryCard."Employee Code");
             premployer.SETFILTER(premployer."Transaction Code",'767');
             premployer.SETFILTER(premployer."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             premployer.SETFILTER(premployer."Payroll Code",PayrollCode );
             IF premployer.FIND('-') THEN  ExcelBuf.AddColumn(premployer.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

            //Pension
             //NSSF
             premployer.RESET;
             premployer.SETRANGE(premployer."Employee Code",prSalaryCard."Employee Code");
             premployer.SETFILTER(premployer."Transaction Code",'NSSF');
             premployer.SETFILTER(premployer."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             premployer.SETFILTER(premployer."Payroll Code",PayrollCode );
             IF premployer.FIND('-') THEN  ExcelBuf.AddColumn(premployer.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

            //NSSF

           PeriodTrans.SETRANGE(PeriodTrans."Employee Code",prSalaryCard."Employee Code");
             PeriodTrans.SETFILTER(PeriodTrans."Transaction Code",'NPAY');
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Period",'=%1',prSalaryCard."Payroll Period");
             PeriodTrans.SETFILTER(PeriodTrans."Payroll Code",PayrollCode );
             IF PeriodTrans.FIND('-') THEN  ExcelBuf.AddColumn(PeriodTrans.Amount,FALSE,'',TRUE,FALSE,TRUE,'',0) ELSE
             ExcelBuf.AddColumn(0,FALSE,'',TRUE,FALSE,TRUE,'',0);

           ExcelBuf.NewRow;
           */
        end;
    end;

    procedure CreateExcelbook()
    begin

        //   ExcelBuf.CreateBook('C:\ERP\NAV.xlsx','SalaryDist');

        ExcelBuf.CreateBookAndOpenExcel('', 'SalaryDist', '', '', UserId);
        //ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        //ExcelBuf.GiveUserControl;
        Message('DONE');
    end;
}
