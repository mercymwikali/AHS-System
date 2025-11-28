namespace PTL.HMIS;

enum 52202436 "Dispatch Areas"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Consultation)
    {
        Caption = 'Consultation';
    }
    value(2; Triage)
    {
        Caption = 'Triage';
    }
    value(3; Pharmacy)
    {
        Caption = 'Pharmacy';
    }
    value(4; Laboratory)
    {
        Caption = 'Laboratory';
    }
    value(5; Radiology)
    {
        Caption = 'Radiology';
    }
    value(6; Procedures)
    {
        Caption = 'Procedures';
    }
  
    value(7; Billing)
    {
        Caption = 'Billing';
    }
}
