report 85073 "HMS Charges Prices"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/HMSChargesPrices.rdl';

    dataset
    {
        dataitem(DataItemName; "HMS Charges Prices")
        {
            column(Branch_Code; "Branch Code")
            {
            }
            column(Charge_Code; "Charge Code")
            {
            }
            column(Corporate_Amount; "Corporate Amount")
            {
            }
            column(Cash_Amount; "Cash Amount")
            {
            }
            column(ChargeName; ChargeName)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            trigger OnAfterGetRecord()
            var
                ChargeRec: Record "HMS Charges";
            begin
                if ChargeRec.get("Charge Code") then
                    ChargeName := ChargeRec.Description;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        CompInf: Record "Company Information";
        ChargeName: Text[100];
}