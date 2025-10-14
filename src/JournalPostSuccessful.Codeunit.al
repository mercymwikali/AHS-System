Codeunit 52202435 "Journal Post Successful"
{
    trigger OnRun()
    begin
    end;

    procedure PostedSuccessfully(DocNo: Code[20]) Posted: Boolean
    var
        GLEntry: Record "G/L Entry";
    begin
        Posted := FALSE;
        GLEntry.RESET();
        GLEntry.SETRANGE(GLEntry."Document No.", DocNo);
        IF GLEntry.FIND('-')
        THEN
            Posted := TRUE;
    end;

    procedure IsPosted(DocNo: Code[20]) Posted: Boolean
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.RESET();
        GLEntry.SETRANGE(GLEntry."Document No.", DocNo);
        IF GLEntry.FIND('-') THEN
            Posted := TRUE
        ELSE
            Posted := FALSE;
    end;

    procedure PostForcedReversal(DocNo: code[20])
    var
        BankL: Record "Bank Account Ledger Entry";
        CustL: Record "Cust. Ledger Entry";
        Cust: Record customer;
        CustD: Record "Detailed Cust. Ledg. Entry";
        VendD: Record "Detailed Vendor Ledg. Entry";
        GL: record "G/L Entry";
        VendL: Record "Vendor Ledger Entry";
    begin
        gl.reset();
        gl.setrange(GL."Document No.", DocNo);
        //gl.setrange(gl."Posting Date", pdate);
        if gl.find('-') then
            gl.DeleteAll();

        CustL.reset();
        CustL.setrange(CustL."Document No.", DocNo);
        if CustL.find('-') then begin
            if Cust.get(CustL."Customer No.") then
                if Cust."Departure Date" <> CustL."Posting Date" then begin
                    Cust."Departure Date" := CustL."Posting Date";
                    Cust."Date Returned" := today;
                    Cust.modify();
                end;
            CustL.DeleteAll();
        end;

        CustD.reset();
        CustD.setrange(CustD."Document No.", DocNo);
        if CustD.find('-') then
            CustD.DeleteAll();

        vendL.reset();
        vendL.setrange(vendL."Document No.", DocNo);
        if vendL.find('-') then
            vendL.DeleteAll();

        VendD.reset();
        VendD.setrange(VendD."Document No.", DocNo);
        if VendD.find('-') then
            VendD.DeleteAll();

        BankL.reset();
        BankL.setrange(BankL."Document No.", DocNo);
        if BankL.find('-') then
            BankL.DeleteAll();
    end;
}
