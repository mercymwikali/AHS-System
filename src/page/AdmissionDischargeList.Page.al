Page 85275 "Admission Discharge List"
{
    CardPageId = "HMS Discharge Header";
    PageType = List;
    SourceTable = "HMS Admission Discharge Header";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(AdmissionNo; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field(Date; Rec."Discharge Date")
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Time; Rec."Discharge Time")
                {
                    Caption = 'Time';
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field(WardNo; Rec."Ward No.")
                {
                    ToolTip = 'Specifies the value of the Ward No. field.';
                }
                field(BedNo; Rec."Bed No.")
                {
                    ToolTip = 'Specifies the value of the Bed No. field.';
                }
                field(DateofAdmission; Rec."Date of Admission")
                {
                    ToolTip = 'Specifies the value of the Date of Admission field.';
                }
                field(TimeOfAdmission; Rec."Time Of Admission")
                {
                    ToolTip = 'Specifies the value of the Time Of Admission field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Names; Rec.Surname + '' + Rec."Middle Name" + '' + Rec."Last Name")
                {
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the value of the Surname + '''' + Rec.Middle Name + '''' + Rec.Last Name field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(NurseID; Rec."Nurse ID")
                {
                    ToolTip = 'Specifies the value of the Nurse ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
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
        area(Navigation)
        {
            action("PatientCharges")
            {
                Caption = 'Patient Charges';
                Image = SuggestFinancialCharge;
                RunObject = page "HMS Patient Charges List";
                RunPageLink = "Patient No." = field("Patient No.");
                Visible = false;
                ToolTip = 'Executes the Patient Charges action.';
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
