tableextension 52202451 "Transfer Header ext" extends "Transfer Header"
{
    fields
    {
        field(51000; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Cancelled;
        }
    }
}