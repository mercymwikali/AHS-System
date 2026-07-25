enum 85010 DischargeTypesEnum
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Normal)
    {
        Caption = 'Normal';
    }
    value(2; Transfered)
    {
        Caption = 'Transfered';
    }
    value(3; Deceased)
    {
        Caption = 'Deceased';
    }
    value(4; DAMA)
    {
        Caption = 'Discharge Against Medical Advice';        
    }
}