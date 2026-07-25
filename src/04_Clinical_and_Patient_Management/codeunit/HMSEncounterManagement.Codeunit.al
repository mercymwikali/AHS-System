namespace HMISBC.HMISBC;
using System;

codeunit 85034 "HMS Encounter Management"
{
    procedure InsertRecord(var RecRef: RecordRef)
    begin
        RecRef.Insert();
    end;

    procedure ModifyRecord(var RecRef: RecordRef)
    begin
        RecRef.Modify();
    end;

    procedure DeleteRecord(var RecRef: RecordRef)
    begin
        RecRef.Delete();
    end;

    procedure DeleteAllRecords(var RecRef: RecordRef)
    begin
        RecRef.DeleteAll();
    end;
}
