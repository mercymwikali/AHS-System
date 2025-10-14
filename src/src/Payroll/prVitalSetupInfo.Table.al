Table 52202603 "prVital Setup Info"
{
    fields
    {
        field(1; "Setup Code"; Code[10])
        {
            Description = '[Relief]';
        }
        field(2; "Tax Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(3; "Insurance Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(4; "Max Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(5; "Mortgage Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(6; "Max Pension Contribution"; Decimal)
        {
            Description = '[Pension]';
        }
        field(7; "Tax On Excess Pension"; Decimal)
        {
            Description = '[Pension]';
        }
        field(8; "Loan Market Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(9; "Loan Corporate Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(10; "Taxable Pay (Normal)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(11; "Taxable Pay (Agricultural)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(12; "SHIF Based on"; Option)
        {
            Description = '[SHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(13; "NSSF Employee"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(14; "NSSF Employer Factor"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(15; "OOI Deduction"; Decimal)
        {
            Description = '[OOI]';
        }
        field(16; "OOI December"; Decimal)
        {
            Description = '[OOI]';
        }
        field(17; "Security Day (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(18; "Security Night (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(19; "Ayah (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(20; "Gardener (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(21; "Security Day (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(22; "Security Night (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(23; "Ayah (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(24; "Gardener (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(25; "Benefit Threshold"; Decimal)
        {
            Description = '[Servant]';
        }
        field(26; "Payslip Message"; Text[100])
        {
        }
        field(28; "NSSF Based on"; Option)
        {
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(29; Gratuity; Decimal)
        {
        }
        field(30; "Disability Threshold"; Decimal)
        {
        }
        field(31; "Part timer Tax Rate"; Decimal)
        {
        }
        field(32; "Use Part Time SHIF Rates"; Boolean)
        {
        }
        field(33; "Tax on Exc Pension Reduce PAYE"; Boolean)
        {
        }
        field(34; "Part Teaching Earning Code"; code[20])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code" where("Transaction Type" = const(Income));
        }
        field(35; "Implement SHIF Relief"; boolean)
        { }
        field(36; "SHIF Relief Percentage"; Decimal)
        {
        }
        field(37; "NSSF Rate"; Decimal)
        {
        }
        field(38; "NSSF Lower Earning Limit(LEL)"; Decimal)
        {
        }
        field(39; "NSSF Upper Earning Limit(UEL)"; Decimal)
        {
        }
        field(40; "Implement New NSSF"; Boolean)
        {
        }
        field(41; "Enable Relief On PAYE Only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Minimum Taxable Pay"; Decimal)
        {
        }
        field(43; "AHL Percentage"; Decimal)
        {
            
        }
        field(44; "Minimum SHIF Deduction"; Decimal)
        {

        }
        field(45; "Minimum NSSF Deduction"; Decimal)
        {
            
        }
        field(50102; "Implement Housing Levy"; Boolean)
        {
        }
        field(50103; "Employee Housing Levy"; Decimal)
        {
        }
        field(50104; "Employer Housing Levy"; Decimal)
        {
        }
        field(50105; "Adjust Pension On NSSF"; Boolean)
        {
        }
        field(50106; "SHA Deduction Percentage"; Decimal)
        {

        }
        field(50107; "Implement SHA Deduction"; Boolean)
        {

        }
        field(50108; "Mortgage Relief Percentage"; Decimal)
        {

        }
        field(50109; "Locum Transaction Code"; Code[10])
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
