page 52203153 "HMS Therapy List"
{
    ApplicationArea = All;
    Caption = 'HMS Therapy Sessions List';
    PageType = List;
    SourceTable = "HMS Therapy Form Header";
    CardPageId = "HMS Therapy Form Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field("Therapy Type"; Rec."Therapy Type")
                {
                    ToolTip = 'Specifies the value of the Therapy Type field.';
                }
                field("Therapy Date"; Rec."Therapy Date")
                {
                    ToolTip = 'Specifies the Value of the Trapy type field';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }

                field("Therapy Session"; Rec."Therapy Session")
                {
                    ToolTip = 'Specifies the value of the Therapy Session field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Search_Name; Rec.Search_Name)
                {
                    ToolTip = 'Specifies the value of the Search_Name field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                }
                field("Therapy Time"; Rec."Therapy Time")
                {
                    ToolTip = 'Specifies the value of the Therapy Time field.';
                }
                field("Therapy Description"; Rec."Therapy Description")
                {
                    ToolTip = 'Specifies the value of the Therapy Description field.';
                }
                field("Therapy User ID"; Rec."Therapy User ID")
                {
                    ToolTip = 'Specifies the value of the Therapist User ID field.';
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
        area(Processing)
        {
            action("Print Haemodialysis Chart")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = PrintForm;
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Executes the Print Haemodialysis Chart action.';

                trigger OnAction()
                var
                    Diald: Record "Dialysis Patient Info";
                begin
                    Diald.Reset();
                    Diald.SetRange(TreatmentNo, "Treatment No.");
                    if Diald.Find('-') then
                        Report.RunModal(Report::"HMS HaemoDialysis Chart", true, false, Diald)
                    else
                        Error('The Therapy chart has not been filled for this date');

                end;
            }
        }
    }
}
