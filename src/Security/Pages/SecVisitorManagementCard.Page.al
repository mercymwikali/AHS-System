Page 52202787 "Sec-Visitor Management Card"
{
    PageType = Card;
    SourceTable = "Sec-Visitor Management";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(VisitorCategory; Rec."Visitor Category")
                {
                    Caption = 'Visitor Category';
                    ToolTip = 'Specifies the value of the Visitor Category field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }

                field(VisitorsName; Rec."Visitor Name")
                {
                    Caption = 'Visitors Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Visitors Name field.';
                }
                field(PurposeofVisit; Rec."Purpose of Visit")
                {
                    Caption = 'Purpose of Visit';
                    ToolTip = 'Specifies the value of the Purpose of Visit field.';
                }
                field("Reason For Visit"; Rec."Reason For Visit")
                {
                    Caption = 'Reason For Visit';
                    ToolTip = 'Specifies the value of the Reason For Visit field.', Comment = '%';
                }
                field(IDNumber; Rec."ID Number")
                {
                    Caption = 'ID Number';
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(VisitorCarRegNumber; Rec."Visitor Car Reg Number")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Visitor Car Reg Number field.';
                }
                field(PersonToVisitNo; Rec."Visitor Number")
                {
                    Caption = 'Person To Visit No.';
                    ToolTip = 'Specifies the value of the Person To Visit No. field.';
                }
                field(PersonToVisitName; Rec."Person To See")
                {
                    Caption = 'Person To Visit Name';
                    ToolTip = 'Specifies the value of the Person To Visit Name field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the Branch';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(VisitorPassNo; Rec."Visitor Pass No.")
                {
                    ToolTip = 'Specifies the value of the Visitor Pass No. field.';
                }
                field(CarRegNumber; Rec."Car Reg. Number")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Car Reg. Number field.';
                }
                field(Status; Rec.Status)
                {
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InitiatedBy; Rec."Initiated By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiated By field.';
                }
                field(InitiatedDate; Rec."Initiated Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiated Date field.';
                }
                field(InitiatedByTime; Rec."Initiated By Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiated By Time field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(ClearedDate; Rec."Cleared Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared Date field.';
                }
                field(ClearedByTime; Rec."Cleared By Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared By Time field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(admin)
            {
                Caption = 'Admit';
                Image = AddContacts;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Admit action.';

                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnGateAdmitVisitor(Rec);
                end;
            }
            action("Issue Visitors Gate Pass")
            {
                Caption = 'Issue Visitors Gate Pass';
                Image = pass;
                Promoted = true;
                RunObject = Report "Visitors Gate Pass";
                ToolTip = 'Executes the Issue Visitors Gate Pass action.';

                trigger OnAction()
                begin
                    if Confirm('Issue visitors Gate Pass as admitted?', true) = false then
                        Error('Cancelled by user: %1', UserId);
                    // FIXME: Issue Visitor GatePass method missing
                    Message('Visitors Gate Pass No' + Rec."Visitor Pass No." + 'Issued.');
                end;
            }
        }
        area(Processing)
        {
            action("Convert to Patient")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Confirm;
                Caption = 'Convert to Patient';
                ToolTip = 'Convert the visit number to patient for registration';

                trigger OnAction()
                var
                    HMSPatient: Record "HMS Patient";
                    HMSProcesses: Codeunit "HMS Processes";
                    HMSPatientCard: Page "HMS Patients";
                    PatientNo: Code[30];
                begin
                    Rec.TestField(Status, Rec.Status::Entered);
                    PatientNo := HMSProcesses.FnConvertVisitorToPatient(Rec.No);
                    HMSPatient.Reset();
                    if HMSPatient.Get(PatientNo) then begin
                        HMSPatientCard.SetRecord(HMSPatient);
                        HMSPatientCard.Run();
                    end;
                end;
            }
        }
    }
}
