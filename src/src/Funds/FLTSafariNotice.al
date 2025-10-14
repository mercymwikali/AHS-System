page 52202489 "FLT Safari Notices"
{
    PageType = Document;
    SourceTable = "FLT-Safari Notice";
    SourceTableView = WHERE(Status = FILTER(<> Submitted));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group("Employee Safari Notices")
            {
                field("Safari No."; Rec."Safari No.")
                {
                    ToolTip = 'Specifies the value of the Safari No. field.';
                }
                field("Proposed By"; Rec."Proposed By")
                {
                    ToolTip = 'Specifies the value of the Proposed By field.';
                }
                field("Proposer Name"; Rec."Proposer Name")
                {
                    ToolTip = 'Specifies the value of the Proposer Name field.';
                }
                field("Proposer Department"; Rec."Proposer Department")
                {
                    ToolTip = 'Specifies the value of the Proposer Department field.';
                }
                field("Proposed Date"; Rec."Proposed Date")
                {
                    ToolTip = 'Specifies the value of the Proposed Date field.';
                }
                field("Officer Going"; Rec."Officer Going")
                {
                    ToolTip = 'Specifies the value of the Officer Going field.';
                }
                field("Officer Going Name"; Rec."Officer Going Name")
                {
                    ToolTip = 'Specifies the value of the Officer Going Name field.';
                }
                field("Officer Designation"; Rec."Officer Designation")
                {
                    ToolTip = 'Specifies the value of the Officer Designation field.';
                }
                field("Purpose Of Visit"; Rec."Purpose Of Visit")
                {
                    ToolTip = 'Specifies the value of the Purpose Of Visit field.';
                }
                field("Place to Visit"; Rec."Place to Visit")
                {
                    ToolTip = 'Specifies the value of the Place to Visit field.';
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ToolTip = 'Specifies the value of the Departure Date field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field("Departure Mileage"; Rec."Departure Mileage")
                {
                    ToolTip = 'Specifies the value of the Departure Mileage field.';
                }
                field("Reg. No"; Rec."Reg. No")
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
                field("Estimated Cost of Safari"; Rec."Estimated Cost of Safari")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost of Safari field.';
                }
                field(Dept; Rec.Dept)
                {
                    ToolTip = 'Specifies the value of the Dept field.';
                }
                field("T.O. Name"; Rec."T.O. Name")
                {
                    ToolTip = 'Specifies the value of the T.O. Name field.';
                }
                field("T.O. Approval Date"; Rec."T.O. Approval Date")
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
            part("Officers Going on Safari"; "FLT Officers Going on Safari")
            {
                Caption = 'Officers Going on Safari';
                SubPageLink = "Safari No." = FIELD("Safari No.");
            }
        }
    }

    actions
    {
    }
}
