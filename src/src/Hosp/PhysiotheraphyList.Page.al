Page 52202970 "Physiotheraphy List"
{
    //  CardPageID = "HMS Physio Form Header";
    PageType = List;
    SourceTable = "HMS Physiotherapy Form Header";
    SourceTableView = where(Closed = const(false));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                ToolTip = 'Executes the Physio List action.';
                // RunObject = Page UnknownPage70135297;
            }
        }
    }
}
