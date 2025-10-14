namespace PTL.HMIS;

page 52203179 "HMS Treatment List(Psychology)"
{
    ApplicationArea = All;
    Caption = 'HMS Treatment List(Psychology)';
    PageType = List;
    CardPageId = "Treatment Form Header(Therapy)";
    SourceTable = "HMS Treatment Form Header";
    SourceTableView = where(isTherapy = filter(true));
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;
                field(TreatmentNo; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
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
            }
        }
    }
}
