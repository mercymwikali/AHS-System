Page 85785 "Pr Payroll Setup Card"
{
    PageType = List;
    SourceTable = "prVital Setup Info";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Locum Transaction Code"; Rec."Locum Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Locum Transaction Code field.', Comment = '%';
                }
            }
            group(TaxRelief)
            {
                Caption = 'Tax Relief';
                field(SetupCode; Rec."Setup Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Setup Code field.';
                }
                field(Control22; Rec."Tax Relief")
                {
                    ToolTip = 'Specifies the value of the Tax Relief field.';
                }
                field(InsuranceRelief; Rec."Insurance Relief")
                {
                    ToolTip = 'Specifies the value of the Insurance Relief field.';
                }
                field(MaxRelief; Rec."Max Relief")
                {
                    ToolTip = 'Specifies the value of the Max Relief field.';
                }
                field("Part Teaching Earning Code"; Rec."Part Teaching Earning Code")
                {
                    ToolTip = 'Specifies the value of the Part Teaching Earning Code field.';
                }
                field("Part timer Tax Rate"; Rec."Part timer Tax Rate")
                {
                    ToolTip = 'Specifies the value of the Part timer Tax Rate field.';
                }
                field("Minimum Taxable Pay"; Rec."Minimum Taxable Pay")
                {
                    ToolTip = 'Specifies the value of the Minimum Taxable Pay field.';
                }
            }
            group(NSSFContribution)
            {
                Caption = 'NSSF Contribution';
                field(NSSFEmployee; Rec."NSSF Employee")
                {
                    ToolTip = 'Specifies the value of the NSSF Employee field.';
                }
                field(NSSFEmployerFactor; Rec."NSSF Employer Factor")
                {
                    ToolTip = 'Specifies the value of the NSSF Employer Factor field.';
                }
                field(NSSFBasedon; Rec."NSSF Based on")
                {
                    ToolTip = 'Specifies the value of the NSSF Based on field.';
                }
                field("Implement New NSSF"; Rec."Implement New NSSF")
                {
                    ToolTip = 'Specifies the value of the Implement New NSSF field.';
                }
                field("NSSF Lower Earning Limit(LEL)"; Rec."NSSF Lower Earning Limit(LEL)")
                {
                    ToolTip = 'Specifies the value of the NSSF Lower Earning Limit(LEL) field.';
                }
                field("NSSF Upper Earning Limit(UEL)"; Rec."NSSF Upper Earning Limit(UEL)")
                {
                    ToolTip = 'Specifies the value of the NSSF Upper Earning Limit(UEL) field.';
                }
                field("Minimum NSSF Deduction"; Rec."Minimum NSSF Deduction")
                {
                    ToolTip = 'Specifies the value of the Minimum NSSF Deduction field.', Comment = '%';
                }

                field("NSSF Rate"; Rec."NSSF Rate")
                {
                    ToolTip = 'Specifies the value of the NSSF Rate field.';
                }

            }
            group(SHIF)
            {
                Caption = 'Social Health Insurance Fund';
                field("Minimum SHIF Deduction"; Rec."Minimum SHIF Deduction")
                {
                    ToolTip = 'Specifies the value of the Minimum SHIF Deduction field.', Comment = '%';
                }
                field("Implement SHA Deduction"; Rec."Implement SHA Deduction")
                {
                    ToolTip = 'Specifies the value of the Implement SHA Deduction field.', Comment = '%';
                }

                field("SHIF Based on"; Rec."SHIF Based on")
                {
                    Caption = 'SHIF Based on:';
                    ToolTip = 'Specifies the value of the Select one: field.';
                }
                field("SHA Deduction Percentage"; Rec."SHA Deduction Percentage")
                {
                    ToolTip = 'Specifies the value of the SHA Deduction Percentage field.', Comment = '%';
                }
                field("Implement SHIF Relief"; Rec."Implement SHIF Relief")
                {
                    ToolTip = 'Specifies the value of the Implement SHIF Relief field.';
                }
                field("SHIF Relief Percentage"; Rec."SHIF Relief Percentage")
                {
                    ToolTip = 'Specifies the value of the SHIF Relief Percentage field.';
                }
                field("Use Part Time SHIF Rates"; Rec."Use Part Time SHIF Rates")
                {
                    ToolTip = 'Specifies the value of the Use Part Time SHIF Rates field.';
                }
                
            }
            group(Housing)
            {
                Caption = 'Housing Levy';
                field("Implement Housing Levy"; Rec."Implement Housing Levy")
                {
                    ToolTip = 'Specifies the value of the Implement Housing Levy field.';
                }
                field("Employee Housing Levy %"; Rec."Employee Housing Levy")
                {
                    ToolTip = 'Specifies the value of the Employee Housing Levy field.';
                }
                field("Employer Housing Levy %"; Rec."Employer Housing Levy")
                {
                    ToolTip = 'Specifies the value of the Employer Housing Levy field.';
                }
            }
            group(Pension)
            {
                Caption = 'Pension';
                field(MaxPensionContribution; Rec."Max Pension Contribution")
                {
                    ToolTip = 'Specifies the value of the Max Pension Contribution field.';
                }
                field(TaxOnExcessPension; Rec."Tax On Excess Pension")
                {
                    ToolTip = 'Specifies the value of the Tax On Excess Pension field.';
                }
                field("Tax on Exc Pension Reduce PAYE"; Rec."Tax on Exc Pension Reduce PAYE")
                {
                    ToolTip = 'Specifies the value of the Tax on Exc Pension Reduce PAYE field.';
                }
                field("Adjust Pension On NSSF"; Rec."Adjust Pension On NSSF")
                {
                    ToolTip = 'Specifies the value of the Adjust Pension On NSSF field.';
                }
            }
            group(Mortgage)
            {
                Caption = 'Mortgage';
                field("Mortgage Relief Percentage"; Rec."Mortgage Relief Percentage")
                {
                    ToolTip = 'Specifies the value of the Mortgage Relief Percentage field.', Comment = '%';
                }
                field(LessfromTaxablePay; Rec."Mortgage Relief")
                {
                    Caption = 'Less from Taxable Pay';
                    ToolTip = 'Specifies the value of the Less from Taxable Pay field.';
                }
                

            }
            group(OwnerOccupierInterest)
            {
                Caption = 'Owner Occupier Interest';
                field(MaxMonthlyContribution; Rec."OOI Deduction")
                {
                    Caption = 'Max Monthly Contribution';
                    ToolTip = 'Specifies the value of the Max Monthly Contribution field.';
                }
                field(Decemberdeduction; Rec."OOI December")
                {
                    Caption = 'December deduction';
                    ToolTip = 'Specifies the value of the December deduction field.';
                }
            }
            group(StaffLoans)
            {
                Caption = 'Staff Loans';
                field(LoanMarketRate; Rec."Loan Market Rate")
                {
                    ToolTip = 'Specifies the value of the Loan Market Rate field.';
                }
                field(LoanCorporateRate; Rec."Loan Corporate Rate")
                {
                    ToolTip = 'Specifies the value of the Loan Corporate Rate field.';
                }
            }
            group(Gratuity)
            {
                Caption = 'Gratuity';
                field(Control1; Rec.Gratuity)
                {
                    ToolTip = 'Specifies the value of the Gratuity field.';
                }
            }
            
            group(PayslipMessage)
            {
                Caption = 'Payslip Message';
                
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ToolTip = 'Specifies the value of the Payslip Message field.', Comment = '%';
                }
                
            }
            
        }
    }

    actions
    {
    }
}
