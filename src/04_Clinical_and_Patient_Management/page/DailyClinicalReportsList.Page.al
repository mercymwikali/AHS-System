namespace PTL.HMISBC;
using PTL.HMIS;

page 85011 "Daily Clinical Reports List"
{
    ApplicationArea = All;
    Caption = 'Daily Clinical Reports List';
    CardPageId = "Daily Clinical Reports Header";
    PageType = List;
    SourceTable = "Daily Clinical Reports Header";
    UsageCategory = ReportsAndAnalysis;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Total Bed Occupancy"; Rec."Total Bed Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total Bed Occupancy field.', Comment = '%';
                }
                field("Total Admissions"; Rec."Total Admissions")
                {
                    ToolTip = 'Specifies the value of the Total Admissions field.', Comment = '%';
                }
                field("Total MAKL Occupancy"; Rec."Total MAKL Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total MAKL Occupancy field.', Comment = '%';
                }
                field("Total MAKL %"; Rec."Total MAKL %")
                {
                    ToolTip = 'Specifies the value of the Total MAKL % field.', Comment = '%';
                }
                field("Total SHA Occupancy"; Rec."Total SHA Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total SHA Occupancy field.', Comment = '%';
                }
                field("Total SHA %"; Rec."Total SHA %")
                {
                    ToolTip = 'Specifies the value of the Total SHA % field.', Comment = '%';
                }
                field("Total Acute"; Rec."Total Acute")
                {
                    ToolTip = 'Specifies the value of the Total Acute field.', Comment = '%';
                }
                field("Total IP C.P"; Rec."Total IP C.P")
                {
                    ToolTip = 'Specifies the value of the Total IP C.P field.', Comment = '%';
                }
                field("Total IP C.P %"; Rec."Total IP C.P %")
                {
                    ToolTip = 'Specifies the value of the Total IP C.P % field.', Comment = '%';
                }
                field("Total OP Visits"; Rec."Total OP Visits")
                {
                    ToolTip = 'Specifies the value of the Total OP Visits field.', Comment = '%';
                }
                field("Total OP C.P"; Rec."Total OP C.P")
                {
                    ToolTip = 'Specifies the value of the Total OP C.P field.', Comment = '%';
                }
                field("Total OP C.P %"; Rec."Total OP C.P %")
                {
                    ToolTip = 'Specifies the value of the Total OP C.P % field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Report&Recepients")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Clinical Report Recepients";
                ToolTip = 'Executes the Report&Recepients action.';
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Date Filter", '..%1', Rec.Date);
        Rec.SETFILTER("Discharge Date Filter", '%1..', Rec.Date);
    end;
}
