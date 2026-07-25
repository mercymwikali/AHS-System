Page 85305 "HMS Admission Verified List"
{
    CardPageId = "HMS Admission Form Header";
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = filter(Verified));
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
                field(Names; Names)
                {
                    caption = 'Patient Names';
                    ToolTip = 'Specifies the value of the Patient Names field.';
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
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;//for portal use
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

    trigger OnAfterGetRecord()
    var
        PatRec: Record "HMS Patient";
    begin
        if PatRec.get(Rec."Patient No.") then
            Names := PatRec."Search Name";
    end;

    var
        Names: Text[200];
}
