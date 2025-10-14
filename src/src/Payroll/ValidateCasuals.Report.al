Report 52202684 "Validate Casuals"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Casual Payment Lines"; "Casual Payment Lines")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(DocumentNo_CasualPaymentLines; "Casual Payment Lines"."Document No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CasualPaymentHeader.Reset();
                CasualPaymentHeader.SetRange(CasualPaymentHeader."No.", "Casual Payment Lines"."Document No.");
                if CasualPaymentHeader.Find('-') then begin
                    HREmployeex.Reset();
                    HREmployeex.SetRange(HREmployeex."ID Number", "Casual Payment Lines"."ID Number");
                    if HREmployeex.Find('-') then
                        repeat
                            "Casual Payment Lines"."Payroll Period" := CasualPaymentHeader."Payroll Period";

                            NSSReliefSetUp.Get();

                            // casuals**************
                            if "Contract Type" = "contract type"::casual then begin
                                TaxablePAYE := "Basic Amount" - NSSReliefSetUp."NSSF Employee";
                                ReliefAmount := NSSReliefSetUp."Tax Relief";
                                TotalPAYE := fnGetEmployeePaye(TaxablePAYE);
                                if TotalPAYE > 0 then
                                    "PAYE Amount" := TotalPAYE - ReliefAmount
                                else
                                    "PAYE Amount" := 0;
                                "NHIF Amount" := fnGetEmployeeNHIF("Basic Amount");
                                "NSSF Amount" := NSSReliefSetUp."NSSF Employee";
                                "Net Pay" := "Basic Amount" - ("PAYE Amount" + "NHIF Amount" + "NSSF Amount");
                            end else
                                if "Contract Type" = "contract type"::"Part-timers" then begin
                                    TotalPAYE := "Casual Payment Lines"."Basic Amount";
                                    ReliefAmount := 0;
                                    if TotalPAYE > 0 then
                                        "PAYE Amount" := (TotalPAYE * (NSSReliefSetUp."Part timer Tax Rate" / 100))
                                    else
                                        "PAYE Amount" := 0;

                                    "Net Pay" := "Basic Amount" - ("PAYE Amount");
                                end;

                            "Casual Payment Lines".Modify();
                        until HREmployeex.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Validated successfully');
            end;

            trigger OnPreDataItem()
            begin

                TaxablePAYE := 0;
                ReliefAmount := 0;
                TotalPAYE := 0;
                if "Contract Type" = "contract type"::" " then
                    Error('Contract Type must have value');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Choose Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contract Type field.';
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
        HREmployeex: Record "Casual Employees";
        CasualPaymentHeader: Record "Casual Payment Header";
        NSSReliefSetUp: Record "prVital Setup Info";
        ReliefAmount: Decimal;
        TaxablePAYE: Decimal;
        TotalPAYE: Decimal;
        "Contract Type": Option " ",casual,"Part-timers";
}
