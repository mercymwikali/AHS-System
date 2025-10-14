namespace PTL.HMIS;
enum 52202426 TreatmentStatus
{
    Extensible = true;

    value(0; New)
    {
        Caption = 'New';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Referred)
    {
        Caption = 'Referred';
    }
    value(4; Cancelled)
    {
        Caption = 'Cancelled';
    }
}