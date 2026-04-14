page 85292 "HMS Active Treatment List"
{
    ApplicationArea = All;
    PageType = List;
    CardPageID = "HMS Treatment Form Header";
    SourceTable = "HMS Treatment Form Header";
    SourceTableView = where(Status = filter(TreatmentStatus::Active));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;                
                field(TreatmentNo; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                    StyleExpr = UrgencyStatusColor;
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(TreatmentType; Rec."Treatment Type")
                {
                    ToolTip = 'Specifies the value of the Treatment Type field.';
                }
                field(TreatmentDate; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Treatment Date field.';
                }
                field(TreatmentTime; Rec."Treatment Time")
                {
                    ToolTip = 'Specifies the value of the Treatment Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Waiting At"; Rec."Waiting At")
                {
                    ToolTip = 'Specifies the value of the Waiting At field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(AdmNo; Rec."Adm No.")
                {
                    ToolTip = 'Specifies the value of the Adm No. field.';
                }
                field(PatientName; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Urgency Status"; Rec."Urgency Status")
                {
                    Tooltip = 'Specifies the value of the Urgency Status field.';
                }
            }
        }
    }

    actions
    {
    }
    var
        UrgencyStatusColor: Text;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Surname);
        Rec.CalcFields("Last Name");
        UrgencyStatusColor := GetUrgencyStatusColor(Rec."Urgency Status");        
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
    local procedure GetUrgencyStatusColor(UrgencyStatus: Enum "Urgency Status Enum"): Text
    var
        UrgencyColorCodingSetup: Record "Urgency Color Coding Setup";
    begin
        if UrgencyColorCodingSetup.Get(UrgencyStatus) then
            exit(UrgencyColorCodingSetup.StyleExpr)
        else
            exit('');
    end;
}

