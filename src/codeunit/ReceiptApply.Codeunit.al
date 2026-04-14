codeunit 85018 "Receipt Apply"
{
    // version NAVW13.00

    TableNo = "Receipt Line q";

    trigger OnRun()
    begin
        ReceiptLine.COPY(Rec);
        BilToCustNo := ReceiptLine."Account No.";
        CustLedgEntry.SETCURRENTKEY("Customer No.", Open);
        CustLedgEntry.SETRANGE("Customer No.", BilToCustNo);
        CustLedgEntry.SETRANGE(Open, TRUE);
        IF ReceiptLine."Applies-to ID" = '' THEN
            ReceiptLine."Applies-to ID" := ReceiptLine.No;
        IF ReceiptLine."Applies-to ID" = '' THEN
            ERROR(
              Text000,
              ReceiptLine.FIELDCAPTION(No), ReceiptLine.FIELDCAPTION("Applies-to ID"));
        // ApplyCustEntries.SetReceipts(ReceiptLine,CustLedgEntry,ReceiptLine.FIELDNO("Applies-to ID"));
        // ApplyCustEntries.SETRECORD(CustLedgEntry);
        // ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        // ApplyCustEntries.LOOKUPMODE(TRUE);
        // OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
        // CLEAR(ApplyCustEntries);
        IF NOT OK THEN
            EXIT;
        CustLedgEntry.RESET();
        CustLedgEntry.SETCURRENTKEY("Customer No.", Open);
        CustLedgEntry.SETRANGE("Customer No.", BilToCustNo);
        CustLedgEntry.SETRANGE(Open, TRUE);
        CustLedgEntry.SETRANGE("Applies-to ID", ReceiptLine."Applies-to ID");
        IF CustLedgEntry.FIND('-') THEN BEGIN
            ReceiptLine."Applies-to Doc. Type" := 0;
            ReceiptLine."Applies-to Doc. No." := '';
        END ELSE
            ReceiptLine."Applies-to ID" := '';

        ReceiptLine.MODIFY();
    end;

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ReceiptLine: Record "Receipt Line q";
        OK: Boolean;
        BilToCustNo: Code[20];
        Text000: Label 'You must specify %1 or %2.';
}
