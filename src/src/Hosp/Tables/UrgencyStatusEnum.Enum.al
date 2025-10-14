namespace PTL.HMIS;

enum 52202429 "Urgency Status Enum"
{
    Extensible = true;

    value(1; Normal)
    {
        Caption = 'Normal';
    }
    value(2; Urgent)
    {
        Caption = 'Urgent';
    }
    value(3; Emergency)
    {
        Caption = 'Emergency';
    }
}
