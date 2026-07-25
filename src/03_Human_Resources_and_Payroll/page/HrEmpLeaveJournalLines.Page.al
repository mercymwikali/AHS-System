Page 85034 "Hr Emp. Leave Journal Lines"
{
    PageType = List;
    SourceTable = "HR Employee Leave Journal";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field(StaffName; Rec."Staff Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(TransactionDescription; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field(NoofDays; Rec."No. of Days")
                {
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(LeaveBalancePrevYear; Rec."Leave Balance")
                {
                    Caption = 'Leave Balance Prev. Year';
                    ToolTip = 'Specifies the value of the Leave Balance Prev. Year field.';
                }
                field(AllowCarryForward; Rec."Allow Carry Forward")
                {
                    ToolTip = 'Specifies the value of the Allow Carry Forward field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(GetAnnual_Leave)
            {
                Caption = 'Get Annual Leave Allocations';
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Get Annual Leave Allocations action.';

                trigger OnAction()
                begin
                    if Confirm('Generate annual Leave allocations?', true) = false then
                        exit;
                    Clear(ints);

                    leaveJournal.Reset();
                    if leaveJournal.Find('-') then
                        leaveJournal.DeleteAll();

                    hremployee.Reset();
                    hremployee.SetRange(hremployee.Status, hremployee.Status::Normal);
                    if hremployee.Find('-') then
                        // Populate leave journal with
                        repeat

                            if ((hremployee."Salary Category" <> '') and (hremployee."Salary Grade" <> '')) then begin
                                salaryGrades.Reset();
                                salaryGrades.SetRange(salaryGrades."Employee Category", hremployee."Salary Category");
                                salaryGrades.SetRange(salaryGrades."Salary Grade code", hremployee."Salary Grade");
                                if salaryGrades.Find('-') then
                                    if salaryGrades."Annual Leave Days" <> 0 then begin

                                        "Days Allocated" := salaryGrades."Annual Leave Days";
                                        /*
                                                                                if "Days Allocated" > 0 then begin
                                                                                    //check if the leave extension requisition has been raised and approved
                                                                                    staffReq.Reset;
                                                                                    staffReq.SetRange(staffReq.RequisitionType, staffReq.Requisitiontype::"Leave Extension Requisition");
                                                                                    staffReq.SetRange(staffReq.Status, staffReq.Status::Approved);
                                                                                    staffReq.SetRange(staffReq."Employee No", hremployee."No.");
                                                                                    if staffReq.Find('-') then begin
                                                                                        "Days Allocated" := "Days Allocated" + staffReq."Applied Days";
                                                                                    end;
                                                                                end;
                                        */
                                        // populate the Journal
                                        leaveledger.Reset();
                                        leaveledger.SetRange(leaveledger."Document No", hremployee."No.");
                                        leaveledger.SetRange(leaveledger."Leave Period", Date2dmy(Today, 3));
                                        leaveledger.SetFilter(leaveledger."Entry Type", '<>%1', leaveledger."entry type"::Allocation);
                                        //IF not leaveledger.FIND('-') THEN BEGIN

                                        // Insert the Journals
                                        // Delete Existing Journal Entries first
                                        hremployee.SetFilter(hremployee."Date Filter", '<%1', 20170101D);
                                        hremployee.CalcFields("Leave Balance");
                                        LeaveBal := hremployee."Leave Balance";
                                        ints := ints + 1;
                                        leaveJournal.Init();
                                        leaveJournal."Line No." := ints;
                                        leaveJournal."Staff No." := hremployee."No.";
                                        leaveJournal."Staff Name" := hremployee."First Name" + ' ' + hremployee."Middle Name" + ' ' + hremployee."Last Name";
                                        leaveJournal."Transaction Description" := 'Leave Allocations for ' + Format(Date2dmy(Today, 3));
                                        leaveJournal."Leave Type" := 'ANNUAL';
                                        leaveJournal."No. of Days" := "Days Allocated";
                                        leaveJournal."Transaction Type" := leaveJournal."transaction type"::Allocation;
                                        leaveJournal."Document No." := 'ALL-' + Format(Date2dmy(Today, 3));
                                        leaveJournal."Posting Date" := Today;
                                        leaveJournal."Leave Period" := Date2dmy(Today, 3);
                                        leaveJournal."Leave Balance" := LeaveBal;
                                        leaveJournal.Insert();
                                        //END;
                                    end;
                            end;
                        until hremployee.Next() = 0;
                    Message('Annual leave days generated successfully!');
                end;
            }
            action(Post_Leave)
            {
                Caption = 'Post Leave Journal';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post Leave Journal action.';

                trigger OnAction()
                var
                    HRPostLeaveJnlEnt: Codeunit "HR Post Leave Journal Ent.";
                begin
                    HRPostLeaveJnlEnt.Run();
                end;
            }
            /* group(Import)
            {
                Caption = '&Actions';
                action(ImportLeaveBalances)
                {
                    Caption = 'Import Leave Balances';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Import Leave Balances action.';

                    trigger OnAction()
                    begin
                        if Confirm('!!!!!!!!!!!!!!!!!!!!....................... IMPORTANT.................!!!!!!!!!!!!!!!!!!!!!!!\' +
                        'Please ensure that your data is saved in ''.CSV'' format i.e. Comma delimeted.' +
                        '\The data should be in the following format:\' +
                        ' Line No|Staff No|Name|Description|Leave Type|No. of Days|Trans Type|Doc. No|Post Date|Leave Period.\' +
                        '\' +
                        '...........................EXAMPLE.........................\' +
                        '1|0001|Wanjala Tom|2015Leave days|ANNUAL|23|ALLOCATION|leave_2015|22012015|2015\' +
                        '2|0002|Jacinta Mwali|2015Leave days|ANNUAL|23|ALLOCATION|leave_2015|22012015|2015\' +
                        '\' +
                        'Continue?', true) = false then
                            Error('Cancelled by user!');

                        Xmlport.Run(70134687, false, true);
                        Message('Imported Successfully!');
                    end;
                }
            } */
        }
    }

    var
        hremployee: Record "HR-Employee";
        leaveJournal: Record "HR Employee Leave Journal";
        leaveledger: Record "HR Leave Ledger";
        salaryGrades: Record "Job_Salary grade/steps";
        "Days Allocated": Decimal;
        // staffReq: Record UnknownRecord70134985;
        LeaveBal: Decimal;
        ints: Integer;
}
