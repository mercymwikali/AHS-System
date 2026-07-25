namespace PTL.HMIS;

page 85286 "Doctor Clinical Reports"
{
    ApplicationArea = All;
    Caption = 'Doctor Clinical Reports';
    PageType = ListPart;
    SourceTable = "HMS Setup Doctor";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("Doctors Name"; Rec."Doctors Name")
                {
                    ToolTip = 'Specifies the value of the Doctors Name field.';
                }
                field(Specialization; Rec.Specialization)
                {
                    ToolTip = 'Specifies the value of the Specialization field.';
                }
                field("Total OP"; Rec."Total OP")
                {
                    ToolTip = 'Specifies the value of the Total OP field.', Comment = '%';
                }
                field("Total IP"; Rec."Total IP")
                {
                    ToolTip = 'Specifies the value of the Total IP field.', Comment = '%';
                }
            }
        }
    }
    procedure CalcReports(SetDate: Date) 
    begin
        // Rec."Date Filter" := SetDate;
        Rec.CalcFields("Total IP", "Total OP");
    end;
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Discharge Date Filter" ,'%1..', WorkDate());
        Rec.SetFilter("IP Date Filter" ,'%1..', WorkDate());
        Rec.SetFilter("Date Filter" ,'%1..', WorkDate());
        
    end;
}
