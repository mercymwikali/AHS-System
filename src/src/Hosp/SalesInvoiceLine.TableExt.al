tableextension 52202445 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(70134700; "PatientNo"; code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
    }
}