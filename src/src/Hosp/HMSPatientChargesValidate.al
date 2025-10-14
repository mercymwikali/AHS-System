report 52202683 "HMS Validate Charges Amount"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    UsageCategory = Administration;
    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            trigger OnAfterGetRecord()
            begin
                Validate("HMS Patient Charges".Amount);
                if "HMS Patient Charges"."Doctor ID" <> '' then
                    Validate("HMS Patient Charges"."Doctor ID");
                "HMS Patient Charges".modify();
            end;
        }
    }
}
