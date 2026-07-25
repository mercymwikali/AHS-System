namespace PTL.HMISBC;

enum 85001 ApiActions
{
    Extensible = true;
    
    value(0; Create)
    {
        Caption = 'Create';
    }
    value(1; Edit)
    {
        Caption = 'Edit';
    }
    value(2; Delete)
    {
        Caption = 'Delete';
    }
}
