Page 52202606 "Incident Card"
{
    PageType = Card;
    SourceTable = "Sec-Visitor Management";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(IncidentNumber; Rec."Incident Number")
                {
                    ToolTip = 'Specifies the value of the Incident Number field.';
                }
                field(IncidentCategory; Rec."Incident Category")
                {
                    ToolTip = 'Specifies the value of the Incident Category field.';
                }
                field(No; Rec.No)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(VisitorCategory; Rec."Visitor Category")
                {
                    ToolTip = 'Specifies the value of the Visitor Category field.';
                }
                field(VisitorsName; Rec."Person To See")
                {
                    Caption = 'Visitors Name';
                    ToolTip = 'Specifies the value of the Visitors Name field.';
                }
                field(PurposeofVisit; Rec."Purpose of Visit")
                {
                    ToolTip = 'Specifies the value of the Purpose of Visit field.';
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Concerned Department';
                    ToolTip = 'Specifies the value of the Concerned Department field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(CarRegNumber; Rec."Car Reg. Number")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Car Reg. Number field.';
                }
                field(PersonToVisitNo; Rec."Visitor Number")
                {
                    Caption = 'Person To Visit No.';
                    ToolTip = 'Specifies the value of the Person To Visit No. field.';
                }
                field(PersonToVisitName; Rec."Visitor Name")
                {
                    Caption = 'Person To Visit Name';
                    ToolTip = 'Specifies the value of the Person To Visit Name field.';
                }
                field(VisitorPassNo; Rec."Visitor Pass No.")
                {
                    ToolTip = 'Specifies the value of the Visitor Pass No. field.';
                }
                field(VisitorCarRegNumber; Rec."Visitor Car Reg Number")
                {
                    ToolTip = 'Specifies the value of the Visitor Car Reg Number field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(IncidentReported; Rec."Incident Reported")
                {
                    ToolTip = 'Specifies the value of the Incident Reported field.';
                }
                field(ReportedBy; Rec."Initiated By")
                {
                    Caption = 'Reported By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reported By field.';
                }
                field(ReportedDate; Rec."Initiated Date")
                {
                    Caption = 'Reported Date>';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reported Date> field.';
                }
                field(ReportedByTime; Rec."Initiated By Time")
                {
                    Caption = 'Reported By Time>';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reported By Time> field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(ClearedDate; Rec."Cleared Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared Date field.';
                }
                field(ClearedByTime; Rec."Cleared By Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cleared By Time field.';
                }
            }
            group(IncidentReport)
            {
                Caption = 'Incident Report';
                field(IncidentDetails; Rec."Incident Details")
                {
                    ToolTip = 'Specifies the value of the Incident Details field.';
                }
                field(IncidentWitness; Rec."Incident Witness")
                {
                    ToolTip = 'Specifies the value of the Incident Witness field.';
                }
                field(WitnessContacts; Rec."Witness Contacts")
                {
                    ToolTip = 'Specifies the value of the Witness Contacts field.';
                }
                field(WitnessID; Rec."Witness ID")
                {
                    ToolTip = 'Specifies the value of the Witness ID field.';
                }
                field(ActionRecommended; Rec."Action Recommended")
                {
                    ToolTip = 'Specifies the value of the Action Recommended field.';
                }
                field(ActionTaken; Rec."Action Taken")
                {
                    ToolTip = 'Specifies the value of the Action Taken field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Action Taken")
            {
                Caption = 'Action Taken';
                Image = AddContacts;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Action Taken action.';

                trigger OnAction()
                begin
                    /*TESTFIELD("Visitor Name");
                    TESTFIELD("ID Number");
                    TESTFIELD("Phone Number");
                    TESTFIELD("Person To See");
                    TESTFIELD("Purpose of Visit");
                    TESTFIELD(Department);
                    TESTFIELD("Visitor Pass No.");
                    */
                    if Confirm('Execute Recommended Action?', true) = false then
                        Error('Cancelled by user: ' + UserId);

                    Rec."Initiated By" := UserId;
                    Rec."Initiated By Time" := Time;
                    Rec."Initiated Date" := Today;
                    Rec."Action Taken" := true;
                    Rec.Modify();
                    Message('Action Executed!');
                end;
            }
        }
    }
}
