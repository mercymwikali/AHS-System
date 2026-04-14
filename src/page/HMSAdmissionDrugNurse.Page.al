page 85296 "HMS Admission Drug Nurse"
{
    PageType = List;
    SourceTable = "HMS Admission Drug Nurse";
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Issued; Rec.Issued)
                {
                    ToolTip = 'Specifies the value of the Issued field.';
                }
                field("Drug No."; Rec."Drug No.")
                {
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field.';
                }
                field("Issued Time"; Rec."Issued Time")
                {
                    ToolTip = 'Specifies the value of the Issued Time field.';
                }
            }
        }
    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Issued Date" := Today;
        Rec."Issued Time" := Time;
    end;

    var
        HMSPatient: Record "HMS Patient";
}

