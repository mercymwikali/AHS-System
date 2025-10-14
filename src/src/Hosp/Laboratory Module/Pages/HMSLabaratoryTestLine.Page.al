Page 52202886 "HMS Labaratory Test Line"
{
    PageType = ListPart;
    SourceTable = "HMS Laboratory Test Line";
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
                    Visible = false;
                }
                field(SpecimenName; Rec."Specimen Name")
                {
                    ToolTip = 'Specifies the value of the Specimen Name field.';
                    Visible = false;
                }
                field(CollectionDate; Rec."Collection Date")
                {
                    ToolTip = 'Specifies the value of the Collection Date field.';
                }
                field(CollectionTime; Rec."Collection Time")
                {
                    ToolTip = 'Specifies the value of the Collection Time field.';
                }
                field(MeasuringUnitCode; Rec."Measuring Unit Code")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Code field.';
                    Visible = false;
                }
                field(MeasuringUnitName; Rec."Measuring Unit Name")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit Name field.';
                    Visible = false;
                }
                field(CountValue; Rec."Count Value")
                {
                    ToolTip = 'Specifies the value of the Count Value field.';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies the value of the Positive field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }

                /**
                **Portal Fields
                */
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the Laboratory No. field.';
                    Visible = false;
                }
                field("Sample Collected"; Rec."Sample Collected")
                {
                    ToolTip = 'Specifies the value of the Sample Collected field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
                field("Results Added"; Rec."Results Added")
                {
                    ToolTip = 'Specifies the value of the Results Added field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateResultsTemplate)
            {
                Caption = 'Generate Results Template';
                ApplicationArea = All;
                ToolTip = 'Executes the Generate Results Template action.';

                trigger OnAction()
                var
                    HMSLabParameterssetup: Record "HMS Lab Parameters setup";
                    HMSLaboratoryResultsEntry: Record "HMS Laboratory Results Entry";
                begin
                    // Delete All Results First
                    HMSLaboratoryResultsEntry.Reset();
                    HMSLaboratoryResultsEntry.SetRange("Laboratory No.", Rec."Laboratory No.");
                    HMSLaboratoryResultsEntry.SetRange("Laboratory Test Code", Rec."Laboratory Test Code");
                    if HMSLaboratoryResultsEntry.FindSet() then
                        HMSLaboratoryResultsEntry.DeleteAll();

                    // Re insert Results
                    HMSLabParameterssetup.Reset();
                    HMSLabParameterssetup.SetRange("Laboratory Test Code", Rec."Laboratory Test Code");
                    HMSLabParameterssetup.SetAutoCalcFields("Result Type");
                    if HMSLabParameterssetup.FindSet() then
                        repeat
                            HMSLaboratoryResultsEntry.Init();
                            HMSLaboratoryResultsEntry."Laboratory No." := Rec."Laboratory No.";
                            HMSLaboratoryResultsEntry."Laboratory Test Code" := Rec."Laboratory Test Code";
                            HMSLaboratoryResultsEntry."Specimen Code" := HMSLabParameterssetup."Specimen Code";
                            HMSLaboratoryResultsEntry.Validate("Specimen Code");
                            HMSLaboratoryResultsEntry."Collection Date" := Today;
                            HMSLaboratoryResultsEntry."Collection Time" := Time;
                            HMSLaboratoryResultsEntry."Measuring Unit Code" := HMSLabParameterssetup."Measuring Unit Code";
                            HMSLaboratoryResultsEntry."Result Type" := HMSLabParameterssetup."Result Type";
                            HMSLaboratoryResultsEntry.Insert();
                        until HMSLabParameterssetup.Next() = 0;

                    if GuiAllowed then Message('Results Template Generated. You can Now Enter Results');
                end;
            }
            action(SampleCollection)
            {
                Caption = 'Sample Collection';
                ApplicationArea = All;
                RunObject = page "HMS Sample";
                RunPageLink = "Laboratory No" = field("Laboratory No.");
                ToolTip = 'Executes the Sample Collection action.';
            }
            action(ResultsEntry)
            {
                Caption = 'Results Entry';
                ApplicationArea = All;
                RunObject = page "HMS Laboratory Results Entry";
                RunPageLink = "Laboratory No." = field("Laboratory No."),
                                "Laboratory Test Code" = field("Laboratory Test Code");
                ToolTip = 'Executes the Results Entry action.';
            }

        }
    }
}
