Page 85148 "FLT Safari Notices List"
{
    CardPageID = "FLT Safari Notices";
    PageType = List;
    SourceTable = "FLT-Safari Notice";
    SourceTableView = where(Status = filter(<> Submitted));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater("Employee Safari Notices")
            {
                field(SafariNo; Rec."Safari No.")
                {
                    ToolTip = 'Specifies the value of the Safari No. field.';
                }
                field(ProposedBy; Rec."Proposed By")
                {
                    ToolTip = 'Specifies the value of the Proposed By field.';
                }
                field(ProposerName; Rec."Proposer Name")
                {
                    ToolTip = 'Specifies the value of the Proposer Name field.';
                }
                field(ProposerDepartment; Rec."Proposer Department")
                {
                    ToolTip = 'Specifies the value of the Proposer Department field.';
                }
                field(ProposedDate; Rec."Proposed Date")
                {
                    ToolTip = 'Specifies the value of the Proposed Date field.';
                }
                field(OfficerGoing; Rec."Officer Going")
                {
                    ToolTip = 'Specifies the value of the Officer Going field.';
                }
                field(OfficerGoingName; Rec."Officer Going Name")
                {
                    ToolTip = 'Specifies the value of the Officer Going Name field.';
                }
                field(OfficerDesignation; Rec."Officer Designation")
                {
                    ToolTip = 'Specifies the value of the Officer Designation field.';
                }
                field(PurposeOfVisit; Rec."Purpose Of Visit")
                {
                    ToolTip = 'Specifies the value of the Purpose Of Visit field.';
                }
                field(PlacetoVisit; Rec."Place to Visit")
                {
                    ToolTip = 'Specifies the value of the Place to Visit field.';
                }
                field(DepartureDate; Rec."Departure Date")
                {
                    ToolTip = 'Specifies the value of the Departure Date field.';
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field(DepartureMileage; Rec."Departure Mileage")
                {
                    ToolTip = 'Specifies the value of the Departure Mileage field.';
                }
                field(RegNo; Rec."Reg. No")
                {
                    ToolTip = 'Specifies the value of the Reg. No field.';
                }
                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the Make field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(EstimatedCostofSafari; Rec."Estimated Cost of Safari")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost of Safari field.';
                }
                field(Dept; Rec.Dept)
                {
                    ToolTip = 'Specifies the value of the Dept field.';
                }
                field(TOName; Rec."T.O. Name")
                {
                    ToolTip = 'Specifies the value of the T.O. Name field.';
                }
                field(TOApprovalDate; Rec."T.O. Approval Date")
                {
                    ToolTip = 'Specifies the value of the T.O. Approval Date field.';
                }
                field(Makes; Rec.Makes)
                {
                    ToolTip = 'Specifies the value of the Makes field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
            }
        }
    }

    actions
    {
    }
}
