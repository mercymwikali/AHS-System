Page 52202680 "HMS ICU History"
{
    CardPageID = "HMS ICU Header";
    PageType = List;
    SourceTable = "HMS ICU Form Header";
    SourceTableView = where(Status = filter(Closed));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(ICUDate; Rec."ICU Date")
                {
                    ToolTip = 'Specifies the value of the ICU Date field.';
                }
                field(ICUTime; Rec."ICU Time")
                {
                    ToolTip = 'Specifies the value of the ICU Time field.';
                }
                field(ICUUserID; Rec."ICU User ID")
                {
                    ToolTip = 'Specifies the value of the ICU User ID field.';
                }
                field(ICURemarks; Rec."ICU Remarks")
                {
                    ToolTip = 'Specifies the value of the ICU Remarks field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
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
                field(ICUNotes; Rec."ICU Notes")
                {
                    ToolTip = 'Specifies the value of the ICU Notes field.';
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
