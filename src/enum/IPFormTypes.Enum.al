namespace PTL.HMIS;

enum 85014 "IP Form Types"
{
    Extensible = true;
    
    value(0; "MSE Form")
    {
        Caption = 'MSE Form';
    }
    value(1; "Dietary Intake Form")
    {
        Caption = 'Dietary Intake Form';
    }
    value(2; "Covid 19 Checklist")
    {
        Caption = 'Covid 19 Checklist';
    }
    value(3; "Brief MSE Form")
    {
        Caption = 'Brief MSE Form';
    }
}
