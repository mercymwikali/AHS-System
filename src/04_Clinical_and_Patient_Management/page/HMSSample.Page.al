namespace PTL.HMIS;

page 85432 "HMS Sample"
{
    ApplicationArea = All;
    Caption = 'HMS Sample';
    PageType = List;
    SourceTable = "HMS Sample";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Lab No"; Rec."Lab Test Code")
                {
                    ToolTip = 'Specifies the value of the Lab No field.', Comment = '%';
                }
                field("Test Name"; Rec."Test Name")
                {
                    ToolTip = 'Specifies the value of the Test Name field.', Comment = '%';
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ToolTip = 'Specifies the value of the Collection Date field.', Comment = '%';
                }
                field("Collection Time"; Rec."Collection Time")
                {
                    ToolTip = 'Specifies the value of the Collection Time field.', Comment = '%';
                }
                field("Collected By"; Rec."Collected By")
                {
                    ToolTip = 'Specifies the value of the Collected By field.', Comment = '%';
                }
                field("Type of Tube"; Rec."Type of Tube")
                {
                    ToolTip = 'Specifies the value of the Type of Tube field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.', Comment = '%';
                }
                field("Receipt Rejection Date"; Rec."Receipt Rejection Date")
                {
                    ToolTip = 'Specifies the value of the Receipt Rejection Date field.', Comment = '%';
                }
                field("Sample Retained"; Rec."Sample Retained")
                {
                    ToolTip = 'Specifies the value of the Sample Retained field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Received Rejected By"; Rec."Received Rejected By")
                {
                    ToolTip = 'Specifies the value of the Received Rejected By field.', Comment = '%';
                }
                field(Received; Rec.Received)
                {
                    ToolTip = 'Specifies the value of the Received field.', Comment = '%';
                }
                field("Receipt Rejection Time"; Rec."Receipt Rejection Time")
                {
                    ToolTip = 'Specifies the value of the Receipt Rejection Time field.', Comment = '%';
                }
                field("Reason for Rejection"; Rec."Reason for Rejection")
                {
                    ToolTip = 'Specifies the value of the Reason for Rejection field.', Comment = '%';
                }
                field("Sample Retention Status"; Rec."Sample Retention Status")
                {
                    ToolTip = 'Specifies the value of the Sample Retention Status field.', Comment = '%';
                }
                field("Date Referred"; Rec."Date Referred")
                {
                    ToolTip = 'Specifies the value of the Date Referred field.', Comment = '%';
                }
                field("Time Referred"; Rec."Time Referred")
                {
                    ToolTip = 'Specifies the value of the Time Referred field.', Comment = '%';
                }
                field("Refered By"; Rec."Refered By")
                {
                    ToolTip = 'Specifies the value of the Refered By field.', Comment = '%';
                }
                field("Referal hospital"; Rec."Referal hospital")
                {
                    ToolTip = 'Specifies the value of the Referal hospital field.', Comment = '%';
                }
                field("Remarks to Referal"; Rec."Remarks to Referal")
                {
                    ToolTip = 'Specifies the value of the Remarks to Referal field.', Comment = '%';
                }
                field(TAT; Rec.TAT)
                {
                    ToolTip = 'Specifies the value of the TAT field.', Comment = '%';
                }
                field("Lab Unique ID"; Rec."Lab Unique ID")
                {
                    ToolTip = 'Specifies the value of the Lab Unique ID field.', Comment = '%';
                }
            }
        }
    }
}
