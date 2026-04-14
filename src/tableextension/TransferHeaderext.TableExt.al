tableextension 85030 "Transfer Header ext" extends "Transfer Header"
{
    fields
    {
        field(50100; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Cancelled;
        }
    }
}