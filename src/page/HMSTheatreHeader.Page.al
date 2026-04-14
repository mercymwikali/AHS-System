page 85459 "HMS Theatre Header"
{
    PageType = Document;
    SourceTable = "HMS Theatre Form Header";

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
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Theatre Date"; Rec."Theatre Date")
                {
                    ToolTip = 'Specifies the value of the Theatre Date field.';
                }
                field("Theatre Time"; Rec."Theatre Time")
                {
                    ToolTip = 'Specifies the value of the Theatre Time field.';
                }
                field("Surgery Code"; Rec."Surgery Code")
                {
                    ToolTip = 'Specifies the value of the Surgery Code field.';
                }
                field(Surgery; Rec.Surgery)
                {
                    ToolTip = 'Specifies the value of the Surgery field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
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
                field(Control28; Rec."Surgeon Notes")
                {
                    ShowCaption = false;
                }
                field("Operation Notes"; Rec."Operation Notes")
                {
                    ToolTip = 'Specifies the value of the Operation Notes field.';
                }
                field(Control30; Rec."Nurse Notes")
                {
                    ShowCaption = false;
                }
                field("Treatment Notes"; Rec."Treatment Notes")
                {
                    ToolTip = 'Specifies the value of the Treatment Notes field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("Circulating Nurse ID"; Rec."Circulating Nurse ID")
                {
                    ToolTip = 'Specifies the value of the Circulating Nurse ID field.';
                }
                field("Anaesthetist ID"; Rec."Anaesthetist ID")
                {
                    ToolTip = 'Specifies the value of the Anaesthetist ID field.';
                }
                field(Instructions; Rec.Instructions)
                {
                    ToolTip = 'Specifies the value of the Instructions field.';
                }
                field("Scrub Nurse"; Rec."Scrub Nurse")
                {
                    ToolTip = 'Specifies the value of the Scrub Nurse field.';
                }
                field("Pre-op Diagnosis"; Rec."Pre-op Diagnosis")
                {
                    ToolTip = 'Specifies the value of the Pre-op Diagnosis field.';
                }
                field("Post-op Diagnosis"; Rec."Post-op Diagnosis")
                {
                    ToolTip = 'Specifies the value of the Post-op Diagnosis field.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.';
                }
                part(Control24; "HMS Treatment Theatre Lines")
                {
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Forward for Findings")
            {
                Caption = '&Forward for Findings';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Forward for Findings action.';

                trigger OnAction()
                begin
                    /*Ask for userconfirmation*/
                    if Confirm('Forward the Theater Results?', true) = false then
                        exit;
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify();
                    Message('Theater Test Request Forwarded');
                end;
            }
            group(Notes)
            {
                action("Nurse Notes")
                {
                    Caption = 'Nurse Notes';
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Nurse Notes action.';

                    trigger OnAction()
                    begin
                        //HMS Theatre Nurse Notes
                        TheatreNotes.Reset();
                        TheatreNotes.SetRange(TheatreNotes."Theatre No.", Rec."No.");
                        TheatreNotes.SetRange(TheatreNotes."Nurse ID", UserId);
                        TheatreNotes.SetRange(TheatreNotes.notesType, TheatreNotes.notesType::"Nurse Notes");
                        if TheatreNotes.Find('-') then
                            PAGE.Run(70135041, TheatreNotes)
                        else begin
                            TheatreNotes.Init();
                            TheatreNotes."Theatre No." := Rec."No.";
                            TheatreNotes."Notes Date" := Today;
                            TheatreNotes."Notes Time" := Time;
                            TheatreNotes."Nurse ID" := UserId;
                            TheatreNotes.notesType := TheatreNotes.notesType::"Nurse Notes";
                            TheatreNotes.Insert();
                            PAGE.Run(70135041, TheatreNotes)
                        end;
                    end;
                }
                action("Surgeon Notes")
                {
                    Caption = 'Surgeons Notes';
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Surgeons Notes action.';

                    trigger OnAction()
                    begin
                        //HMS Theatre Nurse Notes
                        TheatreNotes.Reset();
                        TheatreNotes.SetRange(TheatreNotes."Theatre No.", Rec."No.");
                        TheatreNotes.SetRange(TheatreNotes."Nurse ID", UserId);
                        TheatreNotes.SetRange(TheatreNotes.notesType, TheatreNotes.notesType::"Surgeon Notes");
                        if TheatreNotes.Find('-') then
                            PAGE.Run(70135042, TheatreNotes)
                        else begin
                            TheatreNotes.Init();
                            TheatreNotes."Theatre No." := Rec."No.";
                            TheatreNotes."Notes Date" := Today;
                            TheatreNotes."Notes Time" := Time;
                            TheatreNotes."Nurse ID" := UserId;
                            TheatreNotes.notesType := TheatreNotes.notesType::"Surgeon Notes";
                            TheatreNotes.Insert();
                            PAGE.Run(70135042, TheatreNotes)
                        end;
                    end;
                }
                action("Operations Notes")
                {
                    Caption = 'Operations Notes';
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Operations Notes action.';

                    trigger OnAction()
                    begin
                        //HMS Theatre Nurse Notes
                        TheatreNotes.Reset();
                        TheatreNotes.SetRange(TheatreNotes."Theatre No.", Rec."No.");
                        TheatreNotes.SetRange(TheatreNotes."Nurse ID", UserId);
                        TheatreNotes.SetRange(TheatreNotes.notesType, TheatreNotes.notesType::"Operation Notes");
                        if TheatreNotes.Find('-') then
                            PAGE.Run(70135043, TheatreNotes)
                        else begin
                            TheatreNotes.Init();
                            TheatreNotes."Theatre No." := Rec."No.";
                            TheatreNotes."Notes Date" := Today;
                            TheatreNotes."Notes Time" := Time;
                            TheatreNotes."Nurse ID" := UserId;
                            TheatreNotes.notesType := TheatreNotes.notesType::"Operation Notes";
                            TheatreNotes.Insert();
                            PAGE.Run(70135043, TheatreNotes)
                        end;
                    end;
                }
                action("Biopsy Specimen")
                {
                    Caption = 'Biopsy Specimen';
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Biopsy Specimen action.';

                    trigger OnAction()
                    begin
                        //HMS Theatre Nurse Notes
                        TheatreNotes.Reset();
                        TheatreNotes.SetRange(TheatreNotes."Theatre No.", Rec."No.");
                        TheatreNotes.SetRange(TheatreNotes."Nurse ID", UserId);
                        TheatreNotes.SetRange(TheatreNotes.notesType, TheatreNotes.notesType::"Biopsy Specimen");
                        if TheatreNotes.Find('-') then
                            PAGE.Run(70135045, TheatreNotes)
                        else begin
                            TheatreNotes.Init();
                            TheatreNotes."Theatre No." := Rec."No.";
                            TheatreNotes."Notes Date" := Today;
                            TheatreNotes."Notes Time" := Time;
                            TheatreNotes."Nurse ID" := UserId;
                            TheatreNotes.notesType := TheatreNotes.notesType::"Biopsy Specimen";
                            TheatreNotes.Insert();
                            PAGE.Run(70135045, TheatreNotes)
                        end;
                    end;
                }
                action(Complications)
                {
                    Caption = 'Complications';
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Complications action.';

                    trigger OnAction()
                    begin
                        //HMS Theatre Nurse Notes
                        TheatreNotes.Reset();
                        TheatreNotes.SetRange(TheatreNotes."Theatre No.", Rec."No.");
                        TheatreNotes.SetRange(TheatreNotes."Nurse ID", UserId);
                        TheatreNotes.SetRange(TheatreNotes.notesType, TheatreNotes.notesType::Complications);
                        if TheatreNotes.Find('-') then
                            PAGE.Run(70135044, TheatreNotes)
                        else begin
                            TheatreNotes.Init();
                            TheatreNotes."Theatre No." := Rec."No.";
                            TheatreNotes."Notes Date" := Today;
                            TheatreNotes."Notes Time" := Time;
                            TheatreNotes."Nurse ID" := UserId;
                            TheatreNotes.notesType := TheatreNotes.notesType::Complications;
                            TheatreNotes.Insert();
                            PAGE.Run(70135044, TheatreNotes)
                        end;
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Theatre Notes")
            {
                Caption = 'Theatre Notes';
                ToolTip = 'Executes the Theatre Notes action.';

                trigger OnAction()
                begin
                    REPORT.Run(70134833, true, true, Rec);
                end;
            }
        }
    }

    var
        TheatreNotes: Record "HMS Operational Notes";
}
