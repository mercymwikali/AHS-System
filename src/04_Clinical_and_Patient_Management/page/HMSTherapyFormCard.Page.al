page 85001 "HMS Therapy Form Card"
{
    ApplicationArea = All;
    Caption = 'HMS Therapy Form Card';
    PageType = Card;
    SourceTable = "HMS Therapy Form Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Search_Name; Rec.Search_Name)
                {
                    ToolTip = 'Specifies the value of the Search_Name field.';
                }
                field("Treatment Notes"; Rec."Treatment Notes")
                {
                    ToolTip = 'Specifies the value of the Treatment Notes field.';
                }
                field("Therapy Date"; Rec."Therapy Date")
                {
                    Caption = 'Therapy Date';
                    ToolTip = 'Specifies the value of the Therapy Date field.';
                }
                field("Therapy Type"; Rec."Therapy Type")
                {
                    Caption = 'Therapy Type';
                    ToolTip = 'Specifies the value of the Therapy Type field.';
                }
                field("Therapy Description"; Rec."Therapy Description")
                {
                    Caption = 'Therapy Description';
                    ToolTip = 'Specifies the value of the Therapy Description field.';
                }
                field("Therapy Session"; Rec."Therapy Session")
                {
                    Caption = 'Therapy Session';
                    ToolTip = 'Specifies the value of the Therapy Session field.';
                }
                field("Therapy Time"; Rec."Therapy Time")
                {
                    Caption = 'Therapy Time';
                    ToolTip = 'Specifies the value of the Therapy Time field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field("Therapy Remarks"; Rec."Therapy Remarks")
                {
                    Caption = 'Therapy Remarks';
                    ToolTip = 'Specifies the value of the Therapy Remarks field.';
                }
            }
            group(Notes)
            {
                field("Therapy Notes"; TherapyNotesContent)
                {
                    Caption = 'Therapy Notes';
                    ToolTip = 'Specifies the value of the Therapy Notes field.';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;

                    trigger OnValidate()
                    begin
                        setTherapyNotesContent();
                    end;
                }
            }
            group(Processes)
            {
                Caption = 'Vitals';
                part(Control1102760003; "HMS Treatment Form Processes")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(Laboratory)
            {
                Caption = 'Laboratory';
                part(Control1102760004; "HMS Treatment Form Laboratory")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(Radiology)
            {
                Caption = 'Radiology';
                part(Control1102760006; "HMS Treatment Form Radiology")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(Diagnosis)
            {
                Caption = 'Diagnosis';
                part(Control1102760007; "HMS Treatment Form Diagnosis")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }

            group(Prescription)
            {
                Caption = 'Prescription';
                part(Control1102760005; "HMS Treatment Form Drug")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }

            group(Prescriptions)
            {
                Caption = 'Consumable';
                part("HMS Admission Form Drug"; "HMS Admission Form Drug")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Admission No." = field("Treatment No.");
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                part(Control1102760038; "HMS Treatment Form Referral")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
        }
    }
    var
        TherapyNotesContent: text;

    trigger OnAfterGetRecord()
    begin
        getTherapyNotesContent();
    end;

    local procedure setTherapyNotesContent()
    var
        outStream: OutStream;
    begin
        Rec."Therapy Notes".CreateOutStream(outStream);
        outStream.Write(TherapyNotesContent);
        Rec.Modify();
    end;

    local procedure getTherapyNotesContent()
    var
        inStream: InStream;
    begin
        Rec.CalcFields("Therapy Notes");
        Rec."Therapy Notes".CreateInStream(inStream);
        inStream.Read(TherapyNotesContent);
    end;
}
