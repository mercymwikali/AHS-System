Page 52202475 "HR Employee Fee Weiver"
{
    CardPageID = "HR Employee Weiver";
    PageType = List;
    SourceTable = "HR Employee Tuition Waiver";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(DateofAppointment; Rec."Date of Appointment")
                {
                    ToolTip = 'Specifies the value of the Date of Appointment field.';
                }
                field(ContractType; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ToolTip = 'Specifies the value of the Beneficiary field.';
                }
                field(BeneficiaryRegNo; Rec."Beneficiary RegNo")
                {
                    ToolTip = 'Specifies the value of the Beneficiary RegNo field.';
                }
                field(NameofBeneficiary; Rec."Name of Beneficiary")
                {
                    ToolTip = 'Specifies the value of the Name of Beneficiary field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field(BeneficiaryBOB; Rec."Beneficiary BOB")
                {
                    ToolTip = 'Specifies the value of the Beneficiary BOB field.';
                }
                field(BeneficiaryAge; Rec."Beneficiary Age")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Age field.';
                }
                field(NameofProgramme; Rec."Name of Programme")
                {
                    ToolTip = 'Specifies the value of the Name of Programme field.';
                }
                field(SchoolOffering; Rec."School Offering")
                {
                    ToolTip = 'Specifies the value of the School Offering field.';
                }
                field(DurationofStudy; Rec."Duration of Study")
                {
                    ToolTip = 'Specifies the value of the Duration of Study field.';
                }
                field(CurrentYear; Rec."Current Year")
                {
                    ToolTip = 'Specifies the value of the Current Year field.';
                }
                field(CurrentSemester; Rec."Current Semester")
                {
                    ToolTip = 'Specifies the value of the Current Semester field.';
                }
                field(CampusOffering; Rec."Campus Offering")
                {
                    ToolTip = 'Specifies the value of the Campus Offering field.';
                }
                field(TotalTuition; Rec."Total Tuition")
                {
                    ToolTip = 'Specifies the value of the Total Tuition field.';
                }
                field(AmountofWaiver; Rec."Amount of Waiver")
                {
                    ToolTip = 'Specifies the value of the Amount of Waiver field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
            }
        }
    }

    actions
    {
    }
}
