namespace PTL.HMIS;

enum 85020 "Urgency Status Enum"
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
