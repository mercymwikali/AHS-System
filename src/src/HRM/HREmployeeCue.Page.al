Page 52203077 "HR Employee Cue"
{
    PageType = CardPart;
    SourceTable = "Hr Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(CurrentEmployees)
            {
                Caption = 'Current Employees';
                field(EmployeeActive; Rec."Employee-Normal")
                {
                    Caption = 'Current Employees';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Current Employees field.';
                }
                field(EmployeesMale; Rec."Employee-Male")
                {
                    Caption = 'Employees - Male';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Employees - Male field.';
                }
                field(EmployeesFemale; Rec."Employee-Female")
                {
                    Caption = 'Employees - Female';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Employees - Female field.';
                }
            }
            cuegroup(Departments)
            {
                Caption = 'DEPARTMENTAL STAFF';

                field(CEO; Rec.CEO)
                {
                    ToolTip = 'Specifies the value of the CEO field.', Comment = '%';
                }
                field(CHAIRMAN; Rec.CHAIRMAN)
                {
                    ToolTip = 'Specifies the value of the CHAIRMAN field.', Comment = '%';
                }
                field("CLINICAL SERVICES"; Rec."CLINICAL SERVICES")
                {
                    ToolTip = 'Specifies the value of the CLINICAL SERVICES field.', Comment = '%';
                }
                field(CMH_W; Rec.CMH_W)
                {
                    ToolTip = 'Specifies the value of the Corporate Mental Health and Wellness field.', Comment = '%';
                }
                field(CORPORATE_PSY; Rec.CORPORATE_PSY)
                {
                    ToolTip = 'Specifies the value of the CORPORATE PSYCHIATRY field.', Comment = '%';
                }
                field("Cleared Visitors"; Rec."Cleared Visitors")
                {
                    ToolTip = 'Specifies the value of the Cleared Visitors field.';
                }
                field(DOCTOR; Rec.DOCTOR)
                {
                    ToolTip = 'Specifies the value of the Doctor field.', Comment = '%';
                }
                field(EXTERNAL_PSY; Rec.EXTERNAL_PSY)
                {
                    ToolTip = 'Specifies the value of the PSYCHIATRY EXTERNAL field.', Comment = '%';
                }
            }
            cuegroup(ContractType)
            {
                Caption = 'Contract Type';
                field(ActivePermanentPR; Rec."Employee-Normal (PR)")
                {
                    ToolTip = 'Specifies the value of the Employee-Normal (PR) field.';
                }

            }
            cuegroup(OtherCues)
            {
                Caption = 'Other Cues';
                field(PartTimeEmployees; Rec."Part Time Employees")
                {
                    ToolTip = 'Specifies the value of the Part Time Employees field.';
                }
                field(InactiveEmp; Rec."Employee-InNormal (PR)")
                {
                    Caption = 'In-Active Employees';
                    ToolTip = 'Specifies the value of the In-Active Employees field.';
                }
            }
        }
    }

    actions
    {
    }
}
