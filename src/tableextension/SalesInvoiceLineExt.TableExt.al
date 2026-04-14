tableextension 85023 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "PatientNo"; code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
    }
}