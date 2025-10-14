namespace PTL.HMIS;

page 52203197 "HMS Laboratory Results Entry"
{
    ApplicationArea = All;
    Caption = 'HMS Laboratory Results Entry';
    PageType = List;
    SourceTable = "HMS Laboratory Results Entry";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the Laboratory No. field.', Comment = '%';
                }
                field("Laboratory Test Code"; Rec."Laboratory Test Code")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Code field.', Comment = '%';
                }
                field("Laboratory Test Name"; Rec."Laboratory Test Name")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Name field.', Comment = '%';
                }
                field("Specimen Code"; Rec."Specimen Code")
                {
                    ToolTip = 'Specifies the value of the Specimen Code field.', Comment = '%';
                }
                field("Specimen Name"; Rec."Specimen Name")
                {
                    ToolTip = 'Specifies the value of the Specimen Name field.', Comment = '%';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the value of the Assigned User ID field.', Comment = '%';
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ToolTip = 'Specifies the value of the Collection Date field.', Comment = '%';
                }
                field("Collection Time"; Rec."Collection Time")
                {
                    ToolTip = 'Specifies the value of the Collection Time field.', Comment = '%';
                }
                field("Measuring Unit Code"; Rec."Measuring Unit Code")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Code field.', Comment = '%';
                }
                field("Measuring Unit Name"; Rec."Measuring Unit Name")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Name field.', Comment = '%';
                }
                field(Results; Rec.Results)
                {
                    ToolTip = 'Specifies the value of the Results field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies the value of the Positive field.', Comment = '%';
                }
                field("Test Normal Ranges"; Rec."Test Normal Ranges")
                {
                    ToolTip = 'Specifies the value of the Test Normal Ranges field.', Comment = '%';
                }
                field("Test Units"; Rec."Test Units")
                {
                    ToolTip = 'Specifies the value of the Test Units field.', Comment = '%';
                }
                field(Flag; Rec.Flag)
                {
                    ToolTip = 'Specifies the value of the Flag field.', Comment = '%';
                }
                field(Reactive; Rec.Reactive)
                {
                    ToolTip = 'Specifies the value of the Reactive field.', Comment = '%';
                }
                field("Normal Range"; Rec."Normal Range")
                {
                    ToolTip = 'Specifies the value of the Normal Range field.', Comment = '%';
                }
                field("Sort Test"; Rec."Sort Test")
                {
                    ToolTip = 'Specifies the value of the Sort Test field.', Comment = '%';
                }
                field("Lab Test  Date"; Rec."Lab Test  Date")
                {
                    ToolTip = 'Specifies the value of the Lab Test  Date field.', Comment = '%';
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ToolTip = 'Specifies the value of the Reviewed By field.', Comment = '%';
                }
                field("Reveiw Date"; Rec."Reveiw Date")
                {
                    ToolTip = 'Specifies the value of the Reveiw Date field.', Comment = '%';
                }
                field("Review Time"; Rec."Review Time")
                {
                    ToolTip = 'Specifies the value of the Review Time field.', Comment = '%';
                }
                field("Critical Value"; Rec."Critical Value")
                {
                    ToolTip = 'Specifies the value of the Critical Value field.', Comment = '%';
                }
                field("Critical Ranges"; Rec."Critical Ranges")
                {
                    ToolTip = 'Specifies the value of the Critical Ranges field.', Comment = '%';
                }
                field("Lab Unique No"; Rec."Lab Unique No")
                {
                    ToolTip = 'Specifies the value of the Lab Unique No field.', Comment = '%';
                }
            }
        }
    }
    
}
