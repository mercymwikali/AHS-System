Page 52203081 "HR My Approved Leaves (Header)"
{
    Caption = 'My Approved Leaves';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Leave Application";
    SourceTableView = where(Status = filter(= Posted));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec."Application Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(CampusCode; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Campus Code field.';
                }
                field(DepartmentCode; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field(AppliedDays; Rec."Applied Days")
                {
                    ToolTip = 'Specifies the value of the Applied Days field.';
                }
                field(StartingDate; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(ReturnDate; Rec."Return Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field(AvaillableDays; Rec."Availlable Days")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Availlable Days field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = '&Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    begin
                        DocumentType := Documenttype::"Leave Application";
                        ApprovalEntries.SetRecordFilters(Database::"HR Leave Application", DocumentType, Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                action(PrintPreview)
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    ToolTip = 'Executes the Print/Preview action.';
                    RunObject = report "HR Leave Application Form";

                    trigger OnAction()
                    var
                        ApplicationForm: report "HR Leave Application Form";
                    begin
                        ApplicationForm.SetTableView(Rec);
                        ApplicationForm.RunModal();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    trigger OnInit()
    begin
        PurposeEditable := true;
        "Starting DateEditable" := true;
        "Applied DaysEditable" := true;
        "Department CodeEditable" := true;
        "Campus CodeEditable" := true;
        "Employee NoEditable" := true;
        DateEditable := true;
        "No.Editable" := true;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        Rec.SetFilter("User ID", UserId);
        UpdateControls();
    end;

    var
        ApprovalEntries: Page "Approval Entries";
        [InDataSet]
        "Applied DaysEditable": Boolean;
        [InDataSet]
        "Campus CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Department CodeEditable": Boolean;
        [InDataSet]
        "Employee NoEditable": Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        [InDataSet]
        "Starting DateEditable": Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            "No.Editable" := false;
            DateEditable := false;
            "Employee NoEditable" := false;
            "Campus CodeEditable" := false;
            "Department CodeEditable" := false;
            "Applied DaysEditable" := false;
            "Starting DateEditable" := false;
            PurposeEditable := false;
            //  CurrForm."Process Leave Allowance".EDITABLE:=FALSE;
        end else begin
            "No.Editable" := true;
            DateEditable := true;
            "Employee NoEditable" := true;
            "Campus CodeEditable" := true;
            "Department CodeEditable" := true;
            "Applied DaysEditable" := true;
            "Starting DateEditable" := true;
            PurposeEditable := true;
            // CurrForm."Process Leave Allowance".EDITABLE:=TRUE;
        end;
    end;
}
