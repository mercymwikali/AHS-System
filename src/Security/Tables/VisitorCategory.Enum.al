namespace PTL.HMIS; 

enum 52202424 "Visitor Category"
{
    Extensible = true;
    
    value(0; Other)
    {
        Caption = 'Other';
    }
    value(1; Patient)
    {
        Caption = 'Patient';
    }
    value(2; Employee)
    {
        Caption = 'Employee';
    }
    
}
