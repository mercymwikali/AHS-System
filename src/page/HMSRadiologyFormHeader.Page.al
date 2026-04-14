page 85417 "HMS Radiology Form Header"
{
    PageType = Document;
    SourceTable = "HMS Radiology Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Radiology No."; Rec."Radiology No.")
                {
                    ToolTip = 'Specifies the value of the Radiology No. field.';
                }
                field("Radiology Area"; Rec."Radiology Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Radiology Area field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field("Radiology Date"; Rec."Radiology Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Radiology Date field.';
                }
                field("Radiology Time"; Rec."Radiology Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Radiology Time field.';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                    trigger OnValidate()
                    begin
                        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Search Names"; Rec."Search Names")
                {
                    Caption = 'Patient Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(SupervisorName; SupervisorName)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                }
            }
            part(Control1102760004; "HMS Radiology Form Line")
            {
                SubPageLink = "Radiology no." = FIELD("Radiology No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Forward Radiology Request")
            {
                Caption = '&Forward Radiology Request';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Forward Radiology Request action.';
                trigger OnAction()
                var
                    CuHMSPro: Codeunit "HMS Processes";
                begin
                    if Confirm('Forward the Radiology Test?', false) = false then
                        exit;
                    CuHMSPro.FnRadiologyForwardRequest(Rec);
                    Message('The Radiology Test Request has been Forwarded');
                end;
            }
            action("Charges Lines")
            {
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Link No" = FIELD("Link No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetPatientName(Rec."Patient No.");
    end;

    var
        HMSQue: Record "HMS Doctor Queue";
        Patient: Record "HMS Patient";
        Supervisor: Record User;
        PatientName: Text[100];
        SupervisorName: Text[100];

    procedure GetPatientName(var PatientNo: Code[20])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            Rec."Search Names" := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        Supervisor.Reset();
        SupervisorName := '';
        if Supervisor.Get("User ID") then
            SupervisorName := Supervisor."User Name";
    end;
}
