page 85348 "HMS ICU Header"
{
    PageType = Document;
    SourceTable = "HMS ICU Form Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
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
                field(Control12; Rec."Nurse Notes")
                {
                    ShowCaption = false;
                }
                field("Treatment Notes"; Rec."Treatment Notes")
                {
                    ToolTip = 'Specifies the value of the Treatment Notes field.';
                }
                part(Control24; "HMS ICU Lines")
                {
                    SubPageLink = "No." = FIELD("No.");
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
            separator(Separator23)
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
            separator(Separator21)
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
                separator(Separator30)
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
                separator(Separator31)
                {
                }
                action("Print Observation Chart")
                {
                    ToolTip = 'Executes the Print Observation Chart action.';
                    trigger OnAction()
                    begin
                        ICUOb.Reset();
                        ICUOb.SetRange(ICU, true);
                        ICUOb.SetFilter(ICUOb."Admission No", Rec."No.");
                        ICUOb.SetFilter("ICU Category", '%1', 0);
                        if ICUOb.Find('-') then
                            REPORT.Run(70135151, true, true, ICUOb);
                    end;
                }
            }
        }
    }

    var
        ICUOb: Record "HMS General Observation";
}
