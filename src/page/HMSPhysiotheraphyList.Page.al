Page 85410 "HMS Physiotheraphy List"
{
    CardPageID = "HMS Physio Form Header";
    PageType = List;
    SourceTable = "HMS Physiotheraphy Form Header";
    SourceTableView = where(Closed = const(false));
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
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(PhysioDate; Rec."Physio Date")
                {
                    ToolTip = 'Specifies the value of the Physio Date field.';
                }
                field(PhysioTime; Rec."Physio Time")
                {
                    ToolTip = 'Specifies the value of the Physio Time field.';
                }
                field(PhysioUserID; Rec."Physio User ID")
                {
                    ToolTip = 'Specifies the value of the Physio User ID field.';
                }
                field(PhysioRemarks; Rec."Physio Remarks")
                {
                    ToolTip = 'Specifies the value of the Physio Remarks field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(ADMNo; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field(Names; Rec."Surname Name" + ' ' + Rec."Last Name")
                {
                    Caption = 'Names';
                    ToolTip = 'Specifies the value of the Names field.';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
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

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Surname Name");
        Rec.CalcFields("Last Name");
    end;
}
