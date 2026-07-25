enum 85018 PrescriptionDoseEnum
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; STAT)
    {
        Caption = 'STAT';
    }
    value(2; PRN)
    {
        Caption = 'As Needed';
    }
    value(3; BID)
    {
        Caption = 'Twice a Day';
    }
    value(4; TID)
    {
        Caption = 'Three Times a Day';
    }
    value(5; OD)
    {
        Caption = 'Once a Day';
    }
    value(6; QID)
    {
        Caption = 'Four Times a Day';
    }
    value(8; HOURLY)
    {
        Caption = 'HOURLY';
    }
    value(9; NOCTE)
    {
        Caption = 'At Night';
    }
}