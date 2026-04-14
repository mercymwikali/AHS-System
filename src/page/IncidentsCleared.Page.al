Page 85169 "Incidents Cleared"
{
    CardPageID = "Incident Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sec-Visitor Management";
    SourceTableView = where(Status = filter(Entered),
                            "Incident Reported" = filter(true),
                            "Action Taken" = filter(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(VisitorName; Rec."Person To See")
                {
                    Caption = 'Visitor Name';
                    ToolTip = 'Specifies the value of the Visitor Name field.';
                }
                field(PurposeofVisit; Rec."Purpose of Visit")
                {
                    ToolTip = 'Specifies the value of the Purpose of Visit field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(Control12; Rec."Visitor Name")
                {
                    Caption = 'Person To See';
                    ToolTip = 'Specifies the value of the Person To See field.';
                }
                field(CarRegNumber; Rec."Car Reg. Number")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Car Reg. Number field.';
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
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InitiatedBy; Rec."Initiated By")
                {
                    ToolTip = 'Specifies the value of the Initiated By field.';
                }
                field(InitiatedByTime; Rec."Initiated By Time")
                {
                    ToolTip = 'Specifies the value of the Initiated By Time field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(ClearedByTime; Rec."Cleared By Time")
                {
                    ToolTip = 'Specifies the value of the Cleared By Time field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(ActionRecommended; Rec."Action Recommended")
                {
                    ToolTip = 'Specifies the value of the Action Recommended field.';
                }
                field(ActionTaken; Rec."Action Taken")
                {
                    ToolTip = 'Specifies the value of the Action Taken field.';
                }
                field(IncidentDetails; Rec."Incident Details")
                {
                    ToolTip = 'Specifies the value of the Incident Details field.';
                }
                field(IncidentWitness; Rec."Incident Witness")
                {
                    ToolTip = 'Specifies the value of the Incident Witness field.';
                }
                label(Control21)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(admin)
            {
                Caption = 'Admit';
                Image = AddContacts;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Admit action.';

                trigger OnAction()
                begin
                    Rec.TestField("Visitor Name");
                    Rec.TestField("ID Number");
                    Rec.TestField("Phone Number");
                    Rec.TestField("Person To See");
                    Rec.TestField("Purpose of Visit");
                    Rec.TestField(Department);
                    Rec.TestField("Visitor Pass No.");

                    if Confirm('Mark visitor as admitted?', true) = false then
                        Error('Cancelled by user: ' + UserId);

                    Rec."Initiated By" := UserId;
                    Rec."Initiated By Time" := Time;
                    Rec."Initiated Date" := Today;
                    Rec.Status := Rec.Status::Entered;
                    Rec.Modify();
                    Message('Admitted!');
                end;
            }
        }
    }
}
