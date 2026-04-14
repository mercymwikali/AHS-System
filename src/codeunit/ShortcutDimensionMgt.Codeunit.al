codeunit 85024 ShortcutDimensionMgt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure TransferDimValueToItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean)
    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimensionCode: array[8] of Code[20];
    begin
        DimMgt.GetShortcutDimensions(ItemLedgerEntry."Dimension Set ID", ShortcutDimensionCode);
        ItemLedgerEntry."ShortcutDim3Code" := ShortcutDimensionCode[3];
        ItemLedgerEntry."ShortcutDim4Code" := ShortcutDimensionCode[4];
        ItemLedgerEntry."ShortcutDim5Code" := ShortcutDimensionCode[5];
        ItemLedgerEntry."ShortcutDim6Code" := ShortcutDimensionCode[6];
        ItemLedgerEntry."ShortcutDim7Code" := ShortcutDimensionCode[7];
        ItemLedgerEntry."ShortcutDim8Code" := ShortcutDimensionCode[8];
    end;
    /*       [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
        procedure InsertGLEntry(var GenJnlLine : Record "Gen. Journal Line";GLEntry : Record "G/L Entry";CalcAddCurrResiduals : Boolean)
        var
            DimMgt: Codeunit DimensionManagement;
            ShortcutDimensionCode: array[8] of Code[20];
        begin
            DimMgt.GetShortcutDimensions(GLEntry."Dimension Set ID", ShortcutDimensionCode);
            GLEntry."ShortcutDim3Code" := ShortcutDimensionCode[3];
            GLEntry."ShortcutDim4Code" := ShortcutDimensionCode[4];
            GLEntry."ShortcutDim5Code" := ShortcutDimensionCode[5];
            GLEntry."ShortcutDim6Code" := ShortcutDimensionCode[6];
            GLEntry."ShortcutDim7Code" := ShortcutDimensionCode[7];
            GLEntry."ShortcutDim8Code" := ShortcutDimensionCode[8];
        end; */
}