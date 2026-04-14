Page 85461 "HMS Theatre List"
{
    CardPageID = "HMS Theatre Header";
    PageType = List;
    SourceTable = "HMS Theatre Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(TheatreDate; Rec."Theatre Date")
                {
                    ToolTip = 'Specifies the value of the Theatre Date field.';
                }
                field(TheatreTime; Rec."Theatre Time")
                {
                    ToolTip = 'Specifies the value of the Theatre Time field.';
                }
                field(SurgeryCode; Rec."Surgery Code")
                {
                    ToolTip = 'Specifies the value of the Surgery Code field.';
                }
                field(Surgery; Rec.Surgery)
                {
                    ToolTip = 'Specifies the value of the Surgery field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(NextAppointmentDate; Rec."Next Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Date field.';
                }
                field(SurnameName; Rec."Surname Name")
                {
                    ToolTip = 'Specifies the value of the Surname Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(ADMNo; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field(SurgeonNotes; Rec."Surgeon Notes")
                {
                    ToolTip = 'Specifies the value of the Surgeon Notes field.';
                }
                field(OperationNotes; Rec."Operation Notes")
                {
                    ToolTip = 'Specifies the value of the Operation Notes field.';
                }
                field(NurseNotes; Rec."Nurse Notes")
                {
                    ToolTip = 'Specifies the value of the Nurse Notes field.';
                }
                field(TreatmentNotes; Rec."Treatment Notes")
                {
                    ToolTip = 'Specifies the value of the Treatment Notes field.';
                }
            }
        }
    }

    actions
    {
    }
}
