page 85293 "HMS Admission Admitted List"
{
    CardPageId = "HMS Admission Header Admitted";
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = filter(Admitted|Discharged));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No; Rec."Admission No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Date; Rec."Admission Date")
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Time; Rec."Admission Time")
                {
                    Caption = 'Time';
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(Ward; Rec.Ward)
                {
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field("Ward Room"; Rec."Ward Room")
                {
                    ToolTip = 'Specifies the value of the Ward Room field.';
                }
                field(Bed; Rec.Bed)
                {
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Psychiatric Coding"; Rec."Psychiatric Coding")
                {
                    ToolTip = 'Specifies the value of the Psychiatric Coding field';
                }
                field("Code Reason"; Rec."Code Reason")
                {
                    ToolTip = 'Specifies the value of the Coding Reason field';
                }
                field(SystemId; SystemId)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
