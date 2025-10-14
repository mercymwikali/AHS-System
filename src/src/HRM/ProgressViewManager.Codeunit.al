namespace PTL.Utilities;

codeunit 52202466 "Progress View Manager"
{
    SingleInstance = false;

    procedure OpenProgress(var ProgressDialog: Dialog; var DisplayList: array[10] of Text[120]; var BufferString: Text[1024])
    var
        var1: Code[10];
    begin
        Clear(DisplayList);
        Clear(BufferString);
        Clear(var1);

        ProgressDialog.Open(
            'Processing Please wait..............\#1###############################################################' +
            '\#2###############################################################' +
            '\#3###############################################################' +
            '\#4###############################################################' +
            '\#5###############################################################' +
            '\#6###############################################################' +
            '\#7###############################################################' +
            '\#8###############################################################' +
            '\#9###############################################################' +
            '\#10###############################################################' +
            '\#11###############################################################' +
            '\#12###############################################################' +
            '\#13###############################################################',
            DisplayList[1], DisplayList[2], DisplayList[3], DisplayList[4], DisplayList[5],
            DisplayList[6], DisplayList[7], DisplayList[8], DisplayList[9], DisplayList[10],
            Var1, Var1, BufferString
        );
    end;

    procedure UpdateProgress(EmployeeNo: Code[20]; var DisplayList: array[10] of Text[120]; var ProcessedCount: Integer; var BufferString: Text[1024]; var ProgressDialog: Dialog)
    var
        Employee: Record "HR-Employee";
        EmployeeName: Text;
        i: Integer;
    begin
        ProcessedCount += 1;

        if Employee.Get(EmployeeNo) then
            EmployeeName := StrSubstNo('%1: %2 %3 %4', Employee."No.", Employee."First Name", Employee."Middle Name", Employee."Last Name");

        if ProcessedCount <= ArrayLen(DisplayList) then
            DisplayList[ProcessedCount] := Format(ProcessedCount) + '). ' + EmployeeName
        else begin
            // Shift list up by 1
            for i := 1 to ArrayLen(DisplayList) - 1 do
                DisplayList[i] := DisplayList[i + 1];

            DisplayList[ArrayLen(DisplayList)] := Format(ProcessedCount) + '). ' + EmployeeName;
        end;

        BufferString := 'Total Records processed = ' + Format(ProcessedCount);
        ProgressDialog.Update();
    end;

    procedure CloseProgress(var ProgressDialog: Dialog)
    begin
        ProgressDialog.Close();
    end;
}

