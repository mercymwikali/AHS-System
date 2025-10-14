page 52202552 "Temp Delete"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Temp Delete";
    SourceTableView = where(Posted = filter(false));
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Doc No"; Rec."Doc No")
                {
                    ToolTip = 'Specifies the value of the Doc No field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Entries Count"; Rec."Entries Count")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Entries Count field.';
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostDelete)
            {
                caption = 'Post Delete';
                ToolTip = 'Executes the Post Delete action.';
                trigger OnAction()
                var
                    BankL: Record "Bank Account Ledger Entry";
                    CustL: Record "Cust. Ledger Entry";
                    CustD: Record "Detailed Cust. Ledg. Entry";
                    VendD: Record "Detailed Vendor Ledg. Entry";
                    GLEntry: Record "G/L Entry";
                    TempDel: Record "Temp Delete";
                    vendL: Record "Vendor Ledger Entry";
                begin
                    if Confirm('Do you really want to delete the selected entries?', false) then begin
                        TempDel.reset();
                        TempDel.setrange(Posted, false);
                        if TempDel.Find('-') then
                            repeat
                                GLEntry.reset();
                                GLEntry.setrange("Document No.", TempDel."Doc No");
                                GLEntry.setrange("Posting Date", TempDel."Posting Date");
                                if GLEntry.find('-') then
                                    GLEntry.DeleteAll();

                                CustL.reset();
                                CustL.setrange("Document No.", TempDel."Doc No");
                                CustL.setrange("Posting Date", TempDel."Posting Date");
                                if CustL.find('-') then
                                    CustL.DeleteAll();

                                CustD.reset();
                                CustD.setrange("Document No.", TempDel."Doc No");
                                CustD.setrange("Posting Date", TempDel."Posting Date");
                                if CustD.find('-') then
                                    CustD.DeleteAll();

                                VendL.reset();
                                VendL.setrange("Document No.", TempDel."Doc No");
                                VendL.setrange("Posting Date", TempDel."Posting Date");
                                if VendL.find('-') then
                                    VendL.DeleteAll();

                                VendD.reset();
                                VendD.setrange("Document No.", TempDel."Doc No");
                                VendD.setrange("Posting Date", TempDel."Posting Date");
                                if VendD.find('-') then
                                    VendD.DeleteAll();

                                BankL.reset();
                                BankL.setrange("Document No.", TempDel."Doc No");
                                BankL.setrange("Posting Date", TempDel."Posting Date");
                                if BankL.find('-') then
                                    BankL.DeleteAll();

                                TempDel.Posted := true;
                                TempDel.modify();
                            until TempDel.Next() = 0;
                        message('Complete');
                    end;
                end;
            }
            action(PostReopen)
            {
                caption = 'Post Re-Open';
                ToolTip = 'Executes the Post Re-Open action.';
                trigger OnAction()
                var
                    CustL: Record "Cust. Ledger Entry";
                    CustD: Record "Detailed Cust. Ledg. Entry";
                    VendD: Record "Detailed Vendor Ledg. Entry";
                    TempDel: Record "Temp Delete";
                    vendL: Record "Vendor Ledger Entry";
                begin
                    if Confirm('Do you really want to Re-Open the Selected Entries', false) then begin
                        TempDel.reset();
                        TempDel.setrange(Posted, false);
                        if TempDel.Find('-') then
                            repeat
                                CustD.reset();
                                CustD.setrange("Document No.", TempDel."Doc No");
                                CustD.setrange("Posting Date", TempDel."Posting Date");
                                CustD.setfilter("Entry Type", '<>%1', CustD."Entry Type"::"Initial Entry");
                                if CustD.find('-') then
                                    repeat
                                        CustD.DeleteAll();
                                    Until CustD.Next() = 0;
                                CustL.reset();
                                CustL.setrange("Document No.", TempDel."Doc No");
                                CustL.setrange("Posting Date", TempDel."Posting Date");
                                if CustL.find('-') then
                                    repeat
                                        CustL.Open := true;
                                        CustL.modify();
                                    Until CustL.Next() = 0;
                                VendD.reset();
                                VendD.setrange("Document No.", TempDel."Doc No");
                                VendD.setrange("Posting Date", TempDel."Posting Date");
                                VendD.setfilter("Entry Type", '<>%1', VendD."Entry Type"::"Initial Entry");
                                if VendD.find('-') then
                                    repeat
                                        VendD.DeleteAll();
                                    Until VendD.Next() = 0;
                                VendL.reset();
                                VendL.setrange("Document No.", TempDel."Doc No");
                                VendL.setrange("Posting Date", TempDel."Posting Date");
                                if VendL.find('-') then
                                    repeat
                                        VendL.Open := true;
                                        VendL.modify();
                                    Until VendL.Next() = 0;

                                TempDel.Posted := true;
                                TempDel.modify();
                            until TempDel.Next() = 0;
                        message('Complete');
                    end;
                end;
            }
        }
    }
}