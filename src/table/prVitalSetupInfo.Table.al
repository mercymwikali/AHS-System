Table 85550 "prVital Setup Info"
{
    fields
    {
        field(50000; "Setup Code"; Code[10])
        {
            Description = '[Relief]';
        }
        field(50001; "Tax Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(50002; "Insurance Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(50003; "Max Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(50004; "Mortgage Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(50005; "Max Pension Contribution"; Decimal)
        {
            Description = '[Pension]';
        }
        field(50006; "Tax On Excess Pension"; Decimal)
        {
            Description = '[Pension]';
        }
        field(50007; "Loan Market Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(50008; "Loan Corporate Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(50009; "Taxable Pay (Normal)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(50010; "Taxable Pay (Agricultural)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(50011; "SHIF Based on"; Option)
        {
            Description = '[SHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(50012; "NSSF Employee"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(50013; "NSSF Employer Factor"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(50014; "OOI Deduction"; Decimal)
        {
            Description = '[OOI]';
        }
        field(50015; "OOI December"; Decimal)
        {
            Description = '[OOI]';
        }
        field(50016; "Security Day (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50017; "Security Night (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50018; "Ayah (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50019; "Gardener (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50020; "Security Day (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50021; "Security Night (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50022; "Ayah (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50023; "Gardener (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50024; "Benefit Threshold"; Decimal)
        {
            Description = '[Servant]';
        }
        field(50025; "Payslip Message"; Text[100])
        {
        }
        field(50026; "NSSF Based on"; Option)
        {
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(50027; Gratuity; Decimal)
        {
        }
        field(50028; "Disability Threshold"; Decimal)
        {
        }
        field(50029; "Part timer Tax Rate"; Decimal)
        {
        }
        field(50030; "Use Part Time SHIF Rates"; Boolean)
        {
        }
        field(50031; "Tax on Exc Pension Reduce PAYE"; Boolean)
        {
        }
        field(50032; "Part Teaching Earning Code"; code[20])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code" where("Transaction Type" = const(Income));
        }
        field(50033; "Implement SHIF Relief"; boolean)
        { }
        field(50034; "SHIF Relief Percentage"; Decimal)
        {
        }
        field(50035; "NSSF Rate"; Decimal)
        {
        }
        field(50036; "NSSF Lower Earning Limit(LEL)"; Decimal)
        {
        }
        field(50037; "NSSF Upper Earning Limit(UEL)"; Decimal)
        {
        }
        field(50038; "Implement New NSSF"; Boolean)
        {
        }
        field(50039; "Enable Relief On PAYE Only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Minimum Taxable Pay"; Decimal)
        {
        }
        field(50041; "AHL Percentage"; Decimal)
        {
            
        }
        field(50042; "Minimum SHIF Deduction"; Decimal)
        {

        }
        field(50043; "Minimum NSSF Deduction"; Decimal)
        {
            
        }
        field(50044; "Implement Housing Levy"; Boolean)
        {
        }
        field(50045; "Employee Housing Levy"; Decimal)
        {
        }
        field(50046; "Employer Housing Levy"; Decimal)
        {
        }
        field(50047; "Adjust Pension On NSSF"; Boolean)
        {
        }
        field(50048; "SHA Deduction Percentage"; Decimal)
        {

        }
        field(50049; "Implement SHA Deduction"; Boolean)
        {

        }
        field(50050; "Mortgage Relief Percentage"; Decimal)
        {

        }
        field(50051; "Locum Transaction Code"; Code[10])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
    }

    keys
    {
        key(Key1; "Setup Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
