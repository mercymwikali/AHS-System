namespace PTL.HMIS;

query 85079 "Insurance Scheme Names Setup"
{
    Caption = 'Insurance Scheme Names Setup';
    QueryType = Normal;
    
    elements
    {
        dataitem(InsuranceSchemeSetup; "Insurance Scheme Setup")
        {
            column(LineNo; "Line No")
            {
            }
            column(InsuranceCode; "Insurance Code")
            {
            }
            column(SchemeName; "Scheme Name")
            {
            }
            column(SystemId; SystemId)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
