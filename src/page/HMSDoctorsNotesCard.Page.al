page 85336 "HMS Doctors Notes Card"
{
    ApplicationArea = All;
    Caption = 'HMS Doctors Notes Card';
    PageType = Card;
    SourceTable = "HMS Notes";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field(TreatmentNo; Rec.TreatmentNo) { }
                field(PatientNo; Rec."Patient No") { }
                field("Patient Name"; Rec."Patient Name") { }
                field("Treatment Date"; Rec."Treatment Date") { }
                field("Treatment Time"; Rec."Treatment Time") { }
                field("Notes Type"; Rec."Notes Type")
                {
                    ToolTip = 'Select the Notes Type to edit';
                    trigger OnValidate()
                    begin
                        UpdateNotesSelection();
                    end;
                }
                field("User ID"; Rec."User ID") { }
                field("Created Date"; Rec."Created Date") { }
                field(Clinic; Rec.Clinic) { }
                field("Creation Time"; Rec."Creation Time") { }
            }

            group("Doctor Notes")
            {
                Caption = 'Doctor Notes';
              //  InstructionalText = 'All notes for this treatment are displayed.';

                field("Notes Type Selection"; Rec."Notes Type")
                    {
                        Caption = 'Notes Type';
                    }
                    field(Notes; Rec.Notes)
                    {
                        Caption = 'Notes';
                        MultiLine = true;
                        Editable = (Rec."Notes Type" = Rec."Notes Type"); // Only editable if selected in header
                        
                    }
            }
        }
    }

    local procedure UpdateNotesSelection()
    var
        NotesRec: Record "HMS Notes";
    begin
        // Reload all notes for the TreatmentNo
        NotesRec.SetRange("TreatmentNo", Rec.TreatmentNo);
        if NotesRec.FindSet() then
            repeat
                // If Notes Type matches selected header type, load Notes in editable field
                if NotesRec."Notes Type" = Rec."Notes Type" then
                    Rec.Notes := NotesRec.Notes;
            until NotesRec.Next() = 0;

        CurrPage.Update();
    end;
}
