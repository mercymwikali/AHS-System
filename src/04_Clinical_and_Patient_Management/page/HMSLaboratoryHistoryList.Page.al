Page 85515 "HMS Laboratory History List"
{
    CardPageID = "HMS Laboratory Form Completed";
    Editable = false;
    PageType = List;
    SourceTable = "HMS Laboratory Form Header";
    SourceTableView = where(Status = const(Completed));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(LaboratoryNo; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(LaboratoryDate; Rec."Laboratory Date")
                {
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(LaboratoryTime; Rec."Laboratory Time")
                {
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(ADMNo; Rec."ADM No.")
                {
                    ToolTip = 'Specifies the value of the ADM No. field.';
                }
                field(MemeberNo; Rec."Memeber No")
                {
                    ToolTip = 'Specifies the value of the Memeber No field.';
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
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(ScheduledTime; Rec."Scheduled Time")
                {
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(OpenCharges; Rec."Open Charges")
                {
                    ToolTip = 'Specifies the value of the Open Charges field.';
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
