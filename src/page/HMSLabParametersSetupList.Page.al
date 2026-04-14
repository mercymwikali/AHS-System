Page 85523 "HMS Lab Parameters Setup List"
{
    PageType = List;
    SourceTable = "HMS Lab Parameters setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LaboratoryTestCode; Rec."Laboratory Test Code")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Code field.';
                }
                field(LaboratoryTestName; Rec."Laboratory Test Name")
                {
                    ToolTip = 'Specifies the value of the Laboratory Test Name field.';
                }
                field(SpecimenCode; Rec."Specimen Code")
                {
                    ToolTip = 'Specifies the value of the Specimen Code field.';
                }
                field(SpecimenName; Rec."Specimen Name")
                {
                    ToolTip = 'Specifies the value of the Specimen Name field.';
                }
                field(MeasuringUnitCode; Rec."Measuring Unit Code")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Code field.';
                }
                field(MeasuringUnitName; Rec."Measuring Unit Name")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Name field.';
                }
                field(TestNormalRanges; Rec."Test Normal Ranges")
                {
                    ToolTip = 'Specifies the value of the Test Normal Ranges field.';
                }
                field(MinRange; Rec."Min Range")
                {
                    ToolTip = 'Specifies the value of the Min Range field.';
                }
                field(MaxRange; Rec."Max Range")
                {
                    ToolTip = 'Specifies the value of the Max Range field.';
                }
                field(TestNormalRanges2; Rec."Test Normal Ranges2")
                {
                    ToolTip = 'Specifies the value of the Test Normal Ranges2 field.';
                }
                field(Arrangement; Rec.Arrangement)
                {
                    ToolTip = 'Specifies the value of the Arrangement field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("C HIGH 0-5 Years"; Rec."C HIGH 0-5 Years")
                {
                    ToolTip = 'Specifies the value of the C HIGH 0-5 Years field.', Comment = '%';
                }
                field("C HIGH 6-18 Years Female"; Rec."C HIGH 6-18 Years Female")
                {
                    ToolTip = 'Specifies the value of the C HIGH 6-18 Years Female field.', Comment = '%';
                }
                field("C HIGH 6-18 Years Male"; Rec."C HIGH 6-18 Years Male")
                {
                    ToolTip = 'Specifies the value of the C HIGH 6-18 Years Male field.', Comment = '%';
                }
                field("C HIGH Adult Female"; Rec."C HIGH Adult Female")
                {
                    ToolTip = 'Specifies the value of the C HIGH Adult Female field.', Comment = '%';
                }
                field("C HIGH Adult Male"; Rec."C HIGH Adult Male")
                {
                    ToolTip = 'Specifies the value of the C HIGH Adult Male field.', Comment = '%';
                }
                field("C LOW 0-5 Years"; Rec."C LOW 0-5 Years")
                {
                    ToolTip = 'Specifies the value of the C LOW 0-5 Years field.', Comment = '%';
                }
                field("C LOW 6-18 Years Female"; Rec."C LOW 6-18 Years Female")
                {
                    ToolTip = 'Specifies the value of the C LOW 6-18 Years Female field.', Comment = '%';
                }
                field("C LOW 6-18 Years Male"; Rec."C LOW 6-18 Years Male")
                {
                    ToolTip = 'Specifies the value of the C LOW 6-18 Years Male field.', Comment = '%';
                }
                field("C LOW Adult Female"; Rec."C LOW Adult Female")
                {
                    ToolTip = 'Specifies the value of the C LOW Adult Female field.', Comment = '%';
                }
                field("C LOW Adult Male"; Rec."C LOW Adult Male")
                {
                    ToolTip = 'Specifies the value of the C LOW Adult Male field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field("Critical Ranges"; Rec."Critical Ranges")
                {
                    ToolTip = 'Specifies the value of the Critical Ranges field.', Comment = '%';
                }
                field("Critical Value High"; Rec."Critical Value High")
                {
                    ToolTip = 'Specifies the value of the Critical Value High field.', Comment = '%';
                }
                field("Critical Value Low"; Rec."Critical Value Low")
                {
                    ToolTip = 'Specifies the value of the Critical Value Low field.', Comment = '%';
                }
                field("Max 0 Years-5 Years"; Rec."Max 0 Years-5 Years")
                {
                    ToolTip = 'Specifies the value of the Max 0 Years-5 Years field.', Comment = '%';
                }
                field("Max 6 Years - 18 Years Female"; Rec."Max 6 Years - 18 Years Female")
                {
                    ToolTip = 'Specifies the value of the Max 6 Years - 18 Years Female field.', Comment = '%';
                }
                field("Max 6 Years - 18 Years Male"; Rec."Max 6 Years - 18 Years Male")
                {
                    ToolTip = 'Specifies the value of the Max 6 Years - 18 Years Male field.', Comment = '%';
                }
                field("Max Adult Female"; Rec."Max Adult Female")
                {
                    ToolTip = 'Specifies the value of the Max Adult Female field.', Comment = '%';
                }
                field("Max Adult Male"; Rec."Max Adult Male")
                {
                    ToolTip = 'Specifies the value of the Max Adult Male field.', Comment = '%';
                }
                field("Min 0 Years-5 Years"; Rec."Min 0 Years-5 Years")
                {
                    ToolTip = 'Specifies the value of the Min 0 Years-5 Years field.', Comment = '%';
                }
                field("Min 6 Years - 18 Years Female"; Rec."Min 6 Years - 18 Years Female")
                {
                    ToolTip = 'Specifies the value of the Min 6 Years - 18 Years Female field.', Comment = '%';
                }
                field("Min 6 Years - 18 Years Male"; Rec."Min 6 Years - 18 Years Male")
                {
                    ToolTip = 'Specifies the value of the Min 6 Years - 18 Years Male field.', Comment = '%';
                }
                field("Min Adult Female"; Rec."Min Adult Female")
                {
                    ToolTip = 'Specifies the value of the Min Adult Female field.', Comment = '%';
                }
                field("Min Adult Male"; Rec."Min Adult Male")
                {
                    ToolTip = 'Specifies the value of the Min Adult Male field.', Comment = '%';
                }                
                field("Result Type"; Rec."Result Type")
                {
                    ToolTip = 'Specifies the value of the Result Type field.', Comment = '%';
                }                
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Copy Measuring Unit';
                Image = Refresh;
                trigger OnAction()
                var
                    HMSLabParametersSetup: Record "HMS Lab Parameters Setup";
                begin
                    HMSLabParametersSetup.Reset();
                    if HMSLabParametersSetup.FindSet() then 
                    repeat
                        HMSLabParametersSetup."Measuring unit 2" := HMSLabParametersSetup."Measuring Unit Code";
                        HMSLabParametersSetup.Modify();
                    until HMSLabParametersSetup.Next() = 0;
                    
                end;
            }
        }
    }
}
