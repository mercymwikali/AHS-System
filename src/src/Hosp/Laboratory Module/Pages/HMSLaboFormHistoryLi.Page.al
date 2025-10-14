Page 52202964 "HMS Labo Form History Li"
{
    CardPageID = "HMS Laboratory Form History";
    PageType = List;
    SourceTable = "HMS Laboratory Form Header";
    SourceTableView = where(Status = const(Completed));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control19)
            {
                field(LaboratoryNo; Rec."Laboratory No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(LabReferenceNo; Rec."Lab. Reference No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Lab. Reference No. field.';
                }
                field(LaboratoryDate; Rec."Laboratory Date")
                {
                    Caption = 'Laboratory Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field(LaboratoryTime; Rec."Laboratory Time")
                {
                    Caption = 'Laboratory Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field(RequestArea; Rec."Request Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    Caption = 'Link No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(ScheduledDate; Rec."Scheduled Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Date field.';
                }
                field(ScheduledTime; Rec."Scheduled Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Supervisor ID field.';

                    trigger OnValidate()
                    begin
                        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(SupervisorName; SupervisorName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SupervisorName field.';
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(RelativeNo; Rec."Relative No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        PatientName: Text[100];
        SupervisorName: Text[100];

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        /*Patient.RESET;
        PatientName:='';
        IF Patient.GET(PatientNo) THEN
          BEGIN
            PatientName:=Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
          END;  */
    end;

    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        /*User.RESET;
        SupervisorName:='';
        IF User.GET("User ID") THEN
          BEGIN
           // SupervisorName:=User.Name;
          END;*/
    end;

    trigger OnAfterGetCurrRecord()
    begin
        /*xRec := Rec;
        GetPatientName("Patient No.",PatientName);
        GetSupervisorName("Supervisor ID",SupervisorName);*/
    end;
}
