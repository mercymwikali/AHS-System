report 52202657 "HMS Insurance Rates"
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Consultant_Consultation_Code; "Consultant Consultation Code")
            {
            }
            column(Resident_Consultation_Code; "Resident Consultation Code")
            {
            }
            column(ResidenFee; ResidenFee)
            {
            }
            column(ConsultantFee; ConsultantFee)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ResidenFee := 0;
                ConsultantFee := 0;
                HMSPrices.reset();
                HMSPrices.setrange("Charge Code", Customer."Resident Consultation Code");
                HMSPrices.setfilter("Branch Code", Customer.getfilter("Global Dimension 1 Filter"));
                if HMSPrices.find('-') then
                    ResidenFee := HMSPrices."Corporate Amount";

                HMSPrices.reset();
                HMSPrices.setrange("Charge Code", Customer."Consultant Consultation Code");
                HMSPrices.setfilter("Branch Code", Customer.getfilter("Global Dimension 1 Filter"));
                if HMSPrices.find('-') then
                    ConsultantFee := HMSPrices."Corporate Amount";
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        CompInf: record "Company Information";
        HMSPrices: Record "HMS Charges Prices";
        ConsultantFee: Decimal;
        ResidenFee: Decimal;
}