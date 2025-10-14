Page 52202695 "HMS Admission Lines"
{
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Ward; Rec.Ward)
                {
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(AdmissionDate; Rec."Admission Date")
                {
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field(AdmissionTime; Rec."Admission Time")
                {
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field(AdmissionArea; Rec."Admission Area")
                {
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
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
    }
}
