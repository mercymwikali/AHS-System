Page 85317 "HMS Appointment List"
{
    CardPageID = "HMS Appointment Form Header";
    DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = List;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(New));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                // Editable = false;
                field(AppointmentNo; Rec."Appointment No.")
                {
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field(AppointmentDate; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(AppointmentTime; Rec."Appointment Time")
                {
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(AppointmentType; Rec."Appointment Type")
                {
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                }
                field("Visit Type"; Rec."Visit Type")
                {
                    ToolTip = 'Specifies the value of the Visit Type field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(SearchNames; Rec.SearchNames)
                {
                    Caption = 'Names';
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(RelativeNo; Rec."Relative No.")
                {
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(MembershipNo; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field(InsuranceName; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
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

    trigger OnAfterGetRecord()
    begin
        FullNames := '';
        if PatientRec.Get(Rec."Patient No.") then
            FullNames := PatientRec.Surname + ' ' + PatientRec."Last Name";
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    var
        PatientRec: Record "HMS Patient";
        FullNames: Text[100];
}
