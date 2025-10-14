Page 52202972 "CLosed Physiotheraphy List"
{
    //  CardPageID = "HMS Physio Form Header";
    PageType = List;
    SourceTable = "HMS Physiotherapy Form Header";
    ApplicationArea = Basic, Suite;
    // SourceTableView = where(Code=filter(2));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Observation No."; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.';
                }
                field("Observation Date"; Rec."Observation Date")
                {
                    ToolTip = 'Specifies the value of the Observation Date field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Observation Remarks"; Rec."Observation Remarks")
                {
                    ToolTip = 'Specifies the value of the Observation Remarks field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
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
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Physio)
            {
                Caption = 'Physio List';
                Image = List;
                RunObject = Page "HMS Physiotherapy Types";
                ToolTip = 'Executes the Physio List action.';
            }
        }
    }
}
