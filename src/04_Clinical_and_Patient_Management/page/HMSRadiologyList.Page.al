Page 85419 "HMS Radiology List"
{
    CardPageID = "HMS Radiology Form Header";
    PageType = List;
    SourceTable = "HMS Radiology Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field("Link No."; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field("Link Type"; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.', Comment = '%';
                }
                field(RadiologyNo; Rec."Radiology No.")
                {
                    ToolTip = 'Specifies the value of the Radiology No. field.';
                }
                field(RadiologyDate; Rec."Radiology Date")
                {
                    ToolTip = 'Specifies the value of the Radiology Date field.';
                }
                field(RadiologyTime; Rec."Radiology Time")
                {
                    ToolTip = 'Specifies the value of the Radiology Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Editable = false;
                }
                field("Treatment No.";"Treatment No.")
                {
                    ToolTip = 'specifies the value of the Treatment No field';
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
