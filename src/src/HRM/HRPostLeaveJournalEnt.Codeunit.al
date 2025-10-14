// Codeunit 52202428 "HR Post Leave Journal Ent."
// {
//     trigger OnRun()
//     var
//         Var1: Code[10];
//         progre: Dialog;
//         counts: Integer;
//         RecCount1: Text[120];
//         RecCount2: Text[120];
//         RecCount3: Text[120];
//         RecCount4: Text[120];
//         RecCount5: Text[120];
//         RecCount6: Text[120];
//         RecCount7: Text[120];
//         RecCount8: Text[120];
//         RecCount9: Text[120];
//         RecCount10: Text[120];
//         BufferString: Text[1024];
//     begin

//         if Confirm('Post Leave Journal Lines?', false) = false then
//             exit;

//         hrLeaveJournal.Reset();
//         // HrEmployee.SETRANGE(HrEmployee."Employee Type",HrEmployee."Employee Type"::Permanent);
//         //HrEmployee.SETRANGE(HrEmployee.Status,HrEmployee.Status::Normal);
//         if hrLeaveJournal.Find('-') then begin

//             Clear(RecCount1);
//             Clear(RecCount2);
//             Clear(RecCount3);
//             Clear(RecCount4);
//             Clear(RecCount5);
//             Clear(RecCount6);
//             Clear(RecCount7);
//             Clear(RecCount8);
//             Clear(RecCount9);
//             Clear(RecCount10);
//             Clear(counts);
//             progre.Open('Processing Please wait..............\#1###############################################################' +
//             '\#2###############################################################' +
//             '\#3###############################################################' +
//             '\#4###############################################################' +
//             '\#5###############################################################' +
//             '\#6###############################################################' +
//             '\#7###############################################################' +
//             '\#8###############################################################' +
//             '\#9###############################################################' +
//             '\#10###############################################################' +
//             '\#11###############################################################' +
//             '\#12###############################################################' +
//             '\#13###############################################################',
//                 RecCount1,
//                 RecCount2,
//                 RecCount3,
//                 RecCount4,
//                 RecCount5,
//                 RecCount6,
//                 RecCount7,
//                 RecCount8,
//                 RecCount9,
//                 RecCount10,
//                 Var1,
//                 Var1,
//                 BufferString
//             );
//             Clear(lastNo);
//             leaveLedger.Reset();
//             leaveLedger.SetFilter(leaveLedger."Entry No.", '<>%1', 0);
//             if leaveLedger.FindLast() then
//                 lastNo := leaveLedger."Entry No." + 10
//             else
//                 lastNo := 10;
//             repeat
//                 //Post Leave Journals
//                 leaveLedger.Init();
//                 leaveLedger."Entry No." := lastNo;
//                 leaveLedger."Employee No" := hrLeaveJournal."Staff No.";
//                 leaveLedger."Document No" := hrLeaveJournal."Document No.";
//                 leaveLedger."Leave Type" := hrLeaveJournal."Leave Type";
//                 leaveLedger."Transaction Date" := hrLeaveJournal."Posting Date";
//                 leaveLedger."Transaction Type" := hrLeaveJournal."Transaction Type";
//                 if ((hrLeaveJournal."Transaction Type" = hrLeaveJournal."transaction type"::"Positive Adjustment") or
//                 (hrLeaveJournal."Transaction Type" = hrLeaveJournal."transaction type"::Allocation)) then
//                     leaveLedger."No. of Days" := hrLeaveJournal."No. of Days"
//                 else
//                     if ((hrLeaveJournal."Transaction Type" = hrLeaveJournal."transaction type"::"Negative Adjustment") or
//                     (hrLeaveJournal."Transaction Type" = hrLeaveJournal."transaction type"::Application)) then
//                         leaveLedger."No. of Days" := ((hrLeaveJournal."No. of Days") * (-1));

//                 leaveLedger."Transaction Description" := hrLeaveJournal."Transaction Description";
//                 leaveLedger."Leave Period" := Date2dwy(Today, 3);

//                 leaveLedger.Insert();
//                 lastNo := lastNo + 10;
//                 // Insert into the ledger entry table

//                 // Remove prev balance if caryy forward not allowed
//                 if (hrLeaveJournal."Transaction Type" = hrLeaveJournal."transaction type"::Allocation) and (hrLeaveJournal."Allow Carry Forward" = true) then begin
//                     leaveLedger.Init();
//                     leaveLedger."Entry No." := lastNo;
//                     leaveLedger."Employee No" := hrLeaveJournal."Staff No.";
//                     leaveLedger."Document No" := hrLeaveJournal."Document No.";
//                     leaveLedger."Leave Type" := hrLeaveJournal."Leave Type";
//                     leaveLedger."Transaction Date" := hrLeaveJournal."Posting Date";
//                     if hrLeaveJournal."Leave Balance" > 0 then
//                         leaveLedger."Transaction Type" := hrLeaveJournal."transaction type"::"Positive Adjustment"
//                     else
//                         leaveLedger."Transaction Type" := hrLeaveJournal."transaction type"::"Negative Adjustment";

//                     if leaveLedger."Transaction Type" = leaveLedger."transaction type"::"Positive Adjustment" then
//                         leaveLedger."No. of Days" := hrLeaveJournal."Leave Balance";

//                     if leaveLedger."Transaction Type" = leaveLedger."transaction type"::"Negative Adjustment" then
//                         leaveLedger."No. of Days" := hrLeaveJournal."Leave Balance" * -1;

//                     leaveLedger."Transaction Description" := 'Prev Year Leave Balance Adjustment';
//                     leaveLedger."Leave Period" := Date2dwy(Today, 3);
//                     if leaveLedger."No. of Days" <> 0 then
//                         leaveLedger.Insert();
//                     lastNo := lastNo + 10;
//                 end;

//                 if HrEmployee.Get(hrLeaveJournal."Staff No.") then;
//                 Clear(Var1);
//                 counts := counts + 1;
//                 if counts = 1 then
//                     RecCount1 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                 HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                 else
//                     if counts = 2 then
//                         RecCount2 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                     HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                     else
//                         if counts = 3 then
//                             RecCount3 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                         HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                         else
//                             if counts = 4 then
//                                 RecCount4 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                             HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                             else
//                                 if counts = 5 then
//                                     RecCount5 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                 HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                 else
//                                     if counts = 6 then
//                                         RecCount6 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                     HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                     else
//                                         if counts = 7 then
//                                             RecCount7 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                         HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                         else
//                                             if counts = 8 then
//                                                 RecCount8 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                             HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                             else
//                                                 if counts = 9 then
//                                                     RecCount9 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                                 HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                                 else
//                                                     if counts = 10 then
//                                                         RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                                     HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
//                                                     else
//                                                         if counts > 10 then begin
//                                                             RecCount1 := RecCount2;
//                                                             RecCount2 := RecCount3;
//                                                             RecCount3 := RecCount4;
//                                                             RecCount4 := RecCount5;
//                                                             RecCount5 := RecCount6;
//                                                             RecCount6 := RecCount7;
//                                                             RecCount7 := RecCount8;
//                                                             RecCount8 := RecCount9;
//                                                             RecCount9 := RecCount10;
//                                                             RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
//                                                         HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
//                                                         end;
//                 Clear(BufferString);
//                 BufferString := 'Total Records processed = ' + Format(counts);

//                 progre.Update();
//             until hrLeaveJournal.Next() = 0;
//             ////Progress Window
//             progre.Close();
//         end;
//         hrLeaveJournal.DeleteAll();
//         Message('Leave Journal posted successfully!');
//     end;

//     var
//         HrEmployee: Record "HR-Employee";
//         hrLeaveJournal: Record "HR Employee Leave Journal";
//         leaveLedger: Record "HR Leave Ledger";
//         lastNo: Integer;
// }

Codeunit 52202428 "HR Post Leave Journal Ent."
{
    trigger OnRun()
    var
        ProgressManager: Codeunit "Progress View Manager";
        ProgressDialog: Dialog;
        DisplayList: array[10] of Text[120];
        BufferString: Text[1024];
        ProcessedCount: Integer;
        LastEntryNo: Integer;
    begin
        if not Confirm('Post Leave Journal Lines?', false) then
            exit;

        if not hrLeaveJournal.Find('-') then
            exit;

        ProgressManager.OpenProgress(ProgressDialog, DisplayList, BufferString);

        LastEntryNo := GetNextEntryNo();

        repeat
            PostLeaveJournalLine(hrLeaveJournal, LastEntryNo);
            LastEntryNo += 10;

            ProgressManager.UpdateProgress(hrLeaveJournal."Staff No.", DisplayList, ProcessedCount, BufferString, ProgressDialog);
        until hrLeaveJournal.Next() = 0;

        ProgressManager.CloseProgress(ProgressDialog);

        hrLeaveJournal.DeleteAll();
        Message('Leave Journal posted successfully!');
    end;

    local procedure GetNextEntryNo(): Integer
    begin
        leaveLedger.Reset();
        leaveLedger.SetFilter("Entry No.", '<>%1', 0);
        if leaveLedger.FindLast() then
            exit(leaveLedger."Entry No." + 10)
        else
            exit(10);
    end;

    local procedure PostLeaveJournalLine(var LeaveJournal: Record "HR Employee Leave Journal"; var LastEntryNo: Integer)
    begin
        InsertLedgerEntry(LeaveJournal, LastEntryNo);

        if (LeaveJournal."Transaction Type" = LeaveJournal."Transaction Type"::Allocation) and LeaveJournal."Allow Carry Forward" then begin
            LastEntryNo += 10;
            InsertCarryForwardAdjustment(LeaveJournal, LastEntryNo);
        end;
    end;

    local procedure InsertLedgerEntry(LeaveJournal: Record "HR Employee Leave Journal"; EntryNo: Integer)
    begin
        leaveLedger.Init();
        leaveLedger."Entry No." := EntryNo;
        leaveLedger."Employee No" := LeaveJournal."Staff No.";
        leaveLedger."Document No" := LeaveJournal."Document No.";
        leaveLedger."Leave Type" := LeaveJournal."Leave Type";
        leaveLedger."Transaction Date" := LeaveJournal."Posting Date";
        leaveLedger."Transaction Type" := LeaveJournal."Transaction Type";

        case LeaveJournal."Transaction Type" of
            LeaveJournal."Transaction Type"::"Positive Adjustment",
            LeaveJournal."Transaction Type"::Allocation:
                leaveLedger."No. of Days" := LeaveJournal."No. of Days";

            LeaveJournal."Transaction Type"::"Negative Adjustment",
            LeaveJournal."Transaction Type"::Application:
                leaveLedger."No. of Days" := LeaveJournal."No. of Days" * -1;
        end;

        leaveLedger."Transaction Description" := LeaveJournal."Transaction Description";
        leaveLedger."Leave Period" := Date2dwy(Today, 3);
        leaveLedger.Insert();
    end;

    local procedure InsertCarryForwardAdjustment(LeaveJournal: Record "HR Employee Leave Journal"; EntryNo: Integer)
    begin
        leaveLedger.Init();
        leaveLedger."Entry No." := EntryNo;
        leaveLedger."Employee No" := LeaveJournal."Staff No.";
        leaveLedger."Document No" := LeaveJournal."Document No.";
        leaveLedger."Leave Type" := LeaveJournal."Leave Type";
        leaveLedger."Transaction Date" := LeaveJournal."Posting Date";

        if LeaveJournal."Leave Balance" > 0 then begin
            leaveLedger."Transaction Type" := LeaveJournal."Transaction Type"::"Positive Adjustment";
            leaveLedger."No. of Days" := LeaveJournal."Leave Balance";
        end else begin
            leaveLedger."Transaction Type" := LeaveJournal."Transaction Type"::"Negative Adjustment";
            leaveLedger."No. of Days" := LeaveJournal."Leave Balance" * -1;
        end;

        leaveLedger."Transaction Description" := 'Prev Year Leave Balance Adjustment';
        leaveLedger."Leave Period" := Date2dwy(Today, 3);

        if leaveLedger."No. of Days" <> 0 then
            leaveLedger.Insert();
    end;

    var
        hrLeaveJournal: Record "HR Employee Leave Journal";
        leaveLedger: Record "HR Leave Ledger";
}

