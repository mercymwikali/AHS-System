namespace PTL.Hospital;

page 85006 "Patient Charges"
{
    ApplicationArea = All;
    Caption = 'Patient Charges';
    PageType = ListPart;
    SourceTable = "HMS Patient Charges";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ToolTip = 'Specifies the value of the Appointment No field.', Comment = '%';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
            }
        }
    }
}
