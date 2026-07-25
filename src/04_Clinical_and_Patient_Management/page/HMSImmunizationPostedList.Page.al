Page 85358 "HMS Immunization Posted List"
{
    CardPageID = "HMS Immunization Posted";
    Editable = false;
    PageType = List;
    SourceTable = "HMS Immunization";
    SourceTableView = where(Posted = const(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field(No; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(ImmunizationDate; Rec."Immunization Date")
                {
                    ToolTip = 'Specifies the value of the Immunization Date field.';
                }
                field(ImmunizationTime; Rec."Immunization Time")
                {
                    ToolTip = 'Specifies the value of the Immunization Time field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';

                    trigger OnValidate()
                    begin
                        Patient.Reset();
                        if Patient.Get(Rec."Patient No.") then
                            Rec."Patient Name" := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    end;
                }
                field(PatientName; Rec."Patient Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(ImmunizationNo; Rec."Immunization No.")
                {
                    ToolTip = 'Specifies the value of the Immunization No. field.';
                }
                field(ImmunizationName; Rec."Immunization Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Immunization Name field.';
                }
                field(Given; Rec.Given)
                {
                    ToolTip = 'Specifies the value of the Given field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        Patient: Record "HMS Patient";
}
