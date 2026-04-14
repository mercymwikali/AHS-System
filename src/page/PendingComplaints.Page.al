Page 85091 "Pending Complaints"
{
    Caption = 'Compliments/Complaints List';
    CardPageID = "Complaints/Compliments Card";
    Editable = false;
    PageType = List;
    SourceTable = "Corporate Management";
    SourceTableView = where(Status = filter(Open),
                            "Meeting Held?" = filter(false),
                            Complaints = filter(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(CustomerName; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Requestdate; Rec."Request date")
                {
                    ToolTip = 'Specifies the value of the Request date field.';
                }
                field(RequiredDate; Rec."Required Date")
                {
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(Name; Rec."Visitor Name")
                {
                    Caption = 'Name';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(RequisitioningOfficer; Rec."Requisitioning Officer")
                {
                    ToolTip = 'Specifies the value of the Requisitioning Officer field.';
                }
                field(NatureofMeeting; Rec."Nature of Meeting")
                {
                    ToolTip = 'Specifies the value of the Nature of Meeting field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(MeetingScheduleDate; Rec."Meeting Schedule Date")
                {
                    ToolTip = 'Specifies the value of the Meeting Schedule Date field.';
                }
                field(NumberOfParticipants; Rec."Number  Of Participants")
                {
                    ToolTip = 'Specifies the value of the Number  Of Participants field.';
                }
                field(RoomAvailability; Rec."Room Availability")
                {
                    ToolTip = 'Specifies the value of the Room Availability field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InitiatedBy; Rec."Initiated By")
                {
                    ToolTip = 'Specifies the value of the Initiated By field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(IssueDate; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
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
