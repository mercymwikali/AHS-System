Codeunit 85026 "Page Management Ext"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]

    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)

    begin
        IF PageID = 70135426 THEN
            PageID := 70135443; // Change from List to Card
        IF PageID = 70135400 then
            PageID := 70135390;
        IF PageID = 70135395 THEN
            PageID := 70135362;
        IF PageID = 70135407 THEN
            PageID := 70135405;
        IF PageID = 70135371 THEN
            PageID := 70135339;
        if PageID = 70135353 then
            PageID := 70135390;
        if PageID = 70134851 then
            PageID := 70135656;
        if PageID = 51879 then
            PageID := 50710;
        //if PageID = 51756 then PageID := 50710;
    end;
}
