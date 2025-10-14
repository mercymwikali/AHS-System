report 52202627 "HMS Reccuring Charges"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    UsageCategory = Administration;
    dataset
    {
        dataitem("HMS Patient"; "HMS Patient")
        {
            CalcFields = "Exist in Discharge";
            DataItemTableView = where(Activated = const(true), Inpatient = const(true), "Current Adm No" = filter(<> ''), "Active Visit No" = filter(<> ''));
            trigger OnAfterGetRecord()
            var
                HMSPost: Codeunit "HMS Patient-integration";
            begin
                if "HMS Patient"."Exist in Discharge" = 0 then
                    HMSPost.CalculateReccuringCharges("HMS Patient"."Patient No.");
            end;
        }
    }
}