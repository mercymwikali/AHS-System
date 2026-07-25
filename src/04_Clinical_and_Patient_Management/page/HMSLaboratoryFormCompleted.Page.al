page 85511 "HMS Laboratory Form Completed"
{
    Editable = false;
    PageType = Card;
    SourceTable = "HMS Laboratory Form Header";
    SourceTableView = where(Status = filter(Completed));
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Lab. Reference No."; Rec."Lab. Reference No.")
                {
                    ToolTip = 'Specifies the value of the Lab. Reference No. field.';
                }
                field("Cash Sale"; Rec."Cash Sale")
                {
                    ToolTip = 'Specifies the value of the Cash Sale field.';
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    Caption = 'Laboratory Date';
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    Caption = 'Laboratory Time';
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    Caption = 'Link No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("ADM No."; Rec."ADM No.")
                {
                    ToolTip = 'Specifies the value of the ADM No. field.';
                }
                field("Memeber No"; Rec."Memeber No")
                {
                    ToolTip = 'Specifies the value of the Memeber No field.';
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Date field.';
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Supervisor ID field.';

                    trigger OnValidate()
                    begin
                        // GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(SupervisorName; SupervisorName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            group("Laboratory Test Findings")
            {
                Caption = 'Laboratory Test Findings';
                part(Control1000000000; "HMS Labaratory Test Line")
                {
                    SubPageLink = "Laboratory No." = field("Laboratory No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register Item Usage")
            {
                Caption = 'Register Item Usage';
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "HMS Laboratory Item Header";
                RunPageLink = "Laboratory No." = FIELD("Laboratory No.");
                Visible = false;
                ToolTip = 'Executes the Register Item Usage action.';
            }
            action("&Mark as Completed")
            {
                Caption = '&Mark as Completed';
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the &Mark as Completed action.';

                trigger OnAction()
                begin
                    if Confirm('Mark the Laboratory Test as Completed?', false) = false then
                        exit;
                    blnCompleted := true;
                    LabLine.Reset();
                    LabLine.SetRange(LabLine."Laboratory No.", Rec."Laboratory No.");
                    if LabLine.Find('-') then
                        repeat
                            if LabLine.Completed = false then
                                blnCompleted := false;
                        until LabLine.Next() = 0;

                    if blnCompleted = false then
                        Error('Please ensure that all the tests are marked as completed')
                    else begin
                        Rec.Status := Rec.Status::Completed;
                        Rec."Completion Date" := Today;
                        Rec."Completion Time" := Time;
                        Rec."Supervisor ID" := UserId;
                        Rec.Modify();
                        // Update Queue
                        Patient.Get(Rec."Patient No.");
                        if not HMSQue.Get(Rec."Patient No.", Patient."Active Visit No", Rec."Laboratory No.") then begin
                            HMSQue.Init();
                            HMSQue."Patient No" := Rec."Patient No.";
                            HMSQue."Visit No" := Patient."Active Visit No";
                            HMSQue."Document No" := Rec."Laboratory No.";
                            HMSQue.Type := 'LABORATORY';
                            HMSQue."Doctor ID" := Rec."Doctor ID";
                            HMSQue.Insert();
                        end;
                        Message('Laboratory Test Marked as Completed');
                    end;
                end;
            }
            action("Charges Lines")
            {
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Link No" = FIELD("Link No.");
                Visible = false;
                ToolTip = 'Executes the Charges Lines action.';
            }
            separator(Separator7)
            {
            }
            action("Dispatch To Doctor")
            {
                Caption = 'Dispatch To Doctor';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Dispatch To Doctor action.';

                trigger OnAction()
                begin
                    if Confirm('Dispatch selected Appointment to Doctor?', false) = false then
                        exit;
                    if HSMApp.Get(Rec."Link No.") then begin  // Create treatment header if its from Appointment
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                        docHeader.Init();
                        docHeader."Treatment No." := NewNo;
                        docHeader."Treatment Date" := Today;
                        docHeader."Treatment Time" := Time;
                        docHeader."Doctor ID" := HSMApp.Doctor;
                        docHeader."Patient No." := HSMApp."Patient No.";
                        docHeader."Student No." := HSMApp."Student No.";
                        docHeader."Employee No." := HSMApp."Employee No.";
                        docHeader."Relative No." := HSMApp."Relative No.";
                        docHeader.Direct := true;
                        //:=LabHeader."Request Area"::Doctor;
                        docHeader."Link Type" := 'Outpatient';
                        docHeader."Link No." := HSMApp."Appointment No.";
                        docHeader.Insert();
                        // Update Queue
                        Patient.Get(Rec."Patient No.");
                        HMSQue.Init();
                        HMSQue."Patient No" := Rec."Patient No.";
                        HMSQue."Visit No" := Patient."Active Visit No";
                        HMSQue."Document No" := NewNo;
                        HMSQue.Type := 'LABORATORY';
                        HMSQue."Doctor ID" := HSMApp.Doctor;
                        HMSQue."Queue Type" := 'RESULTS';
                        HMSQue.Date := Today;
                        HMSQue.Time := Time;
                        HMSQue.Insert();
                    end;

                    blnCompleted := true;
                    LabLine.Reset();
                    LabLine.SetRange(LabLine."Laboratory No.", Rec."Laboratory No.");
                    if LabLine.Find('-') then
                        repeat
                            if LabLine.Completed = false then
                                blnCompleted := false;
                        until LabLine.Next() = 0;

                    if blnCompleted = false then
                        Error('Please ensure that all the tests are marked as completed')
                    else begin
                        Rec.Status := Rec.Status::Completed;
                        Rec.Modify();

                        Message('Laboratory Test Marked as Completed');
                    end;
                end;
            }
            action("Print Results")
            {
                Image = ResetStatus;
                Promoted = true;
                ToolTip = 'Executes the Print Results action.';
                trigger OnAction()
                var
                    LabReport: Report "HMS Lab Results2";
                begin
                    LabRes.SetFilter(LabRes."Laboratory No.", Rec."Laboratory No.");
                    if LabRes.Find('-') then
                        LabReport.SetTableView(LabRes);
                    LabReport.Run();
                end;
            }
            action(Reopen)
            {
                ApplicationArea = all;
                ToolTip = 'Re open The Completed lab request';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::New;
                    Rec.Modify();
                end;
            }
        }
    }

    var
        HSMApp: Record "HMS Appointment Form Header";
        HMSQue: Record "HMS Doctor Queue";
        LabRes: Record "HMS Laboratory Results Entry";
        LabLine: Record "HMS Laboratory Test Line";
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        docHeader: Record "HMS Treatment Form Header";
        NoSeriesMgt: Codeunit "No. Series";
        blnCompleted: Boolean;
        NewNo: Code[20];
        PatientName: Text[100];
        SupervisorName: Text[100];

    /* procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
    end; */
}
