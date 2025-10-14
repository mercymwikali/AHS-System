page 52202682 "HMS ICU List"
{
    CardPageID = "HMS ICU Header";
    PageType = List;
    SourceTable = "HMS ICU Form Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("ICU Date"; Rec."ICU Date")
                {
                    ToolTip = 'Specifies the value of the ICU Date field.';
                }
                field("ICU Time"; Rec."ICU Time")
                {
                    ToolTip = 'Specifies the value of the ICU Time field.';
                }
                field("ICU User ID"; Rec."ICU User ID")
                {
                    ToolTip = 'Specifies the value of the ICU User ID field.';
                }
                field("ICU Remarks"; Rec."ICU Remarks")
                {
                    ToolTip = 'Specifies the value of the ICU Remarks field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Link Type"; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field("Next Appointment Date"; Rec."Next Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Date field.';
                }
                field("Surname Name"; Rec."Surname Name")
                {
                    ToolTip = 'Specifies the value of the Surname Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("ADM No"; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field("ICU Notes"; Rec."ICU Notes")
                {
                    ToolTip = 'Specifies the value of the ICU Notes field.';
                }
                field("Operation Notes"; Rec."Operation Notes")
                {
                    ToolTip = 'Specifies the value of the Operation Notes field.';
                }
                field(Control25; Rec."Nurse Notes")
                {
                    ShowCaption = false;
                }
                field("Treatment Notes"; Rec."Treatment Notes")
                {
                    ToolTip = 'Specifies the value of the Treatment Notes field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Doctor Visit")
            {
                Caption = 'Doctor Visit';
                Image = StepInto;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Treatment Form Header";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              Status = FILTER(TreatmentStatus::New);
                ToolTip = 'Executes the Doctor Visit action.';
            }
            separator(Separator33)
            {
            }
            action("Treatment History")
            {
                Image = History;
                Promoted = true;
                RunObject = Page "HMS Treatment History List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Treatment History action.';
            }
            separator(Separator31)
            {
            }
            action(Charges)
            {
                Image = Accounts;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Invoice ID" = FIELD("Link No.");
                ToolTip = 'Executes the Charges action.';
            }
            group("Nurse Activities")
            {
                action("Nurse Notes")
                {
                    Image = Comment;
                    Promoted = true;
                    RunObject = Page "HMS Admission Nurse Notes";
                    RunPageLink = "Admission No." = FIELD("No.");
                    ToolTip = 'Executes the Nurse Notes action.';
                }
                action("Daily Process/Procedures")
                {
                    RunObject = Page "HMS Admission Form Process";
                    RunPageLink = "Admission No." = FIELD("Link No.");
                    ToolTip = 'Executes the Daily Process/Procedures action.';
                }
                action(Injections)
                {
                    RunObject = Page "HMS Admission Injection";
                    RunPageLink = "Admission No." = FIELD("Link No.");
                    ToolTip = 'Executes the Injections action.';
                }
                action(Prescriptions)
                {
                    RunObject = Page "HMS Admission Form Drug";
                    RunPageLink = "Admission No." = FIELD("Link No.");
                    ToolTip = 'Executes the Prescriptions action.';
                }
                action("Treatment Sheet")
                {
                    RunObject = Page "HMS Admission Drug Nurse";
                    RunPageLink = "Admission No." = FIELD("Link No.");
                    ToolTip = 'Executes the Treatment Sheet action.';
                }
                separator(Separator39)
                {
                }
                action("Hourly Observation")
                {
                    Image = AddWatch;
                    RunObject = Page "HMS ICU Observations";
                    RunPageLink = "Admission No" = FIELD("No.");
                    ToolTip = 'Executes the Hourly Observation action.';
                }
                action("Hourly Observation Chart")
                {
                    Image = ChartOfAccounts;
                    RunObject = Page "HMS ICU Observation Chart";
                    RunPageLink = "Admission No" = FIELD("No.");
                    ToolTip = 'Executes the Hourly Observation Chart action.';
                }
            }
        }
    }
}
