Page 85625 "HR Appraisal Evaluation Areas"
{
    PageType = List;
    SourceTable = "HR Appraisal Evaluation Areas";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field(CategorizeAs; Rec."Categorize As")
                {
                    ToolTip = 'Specifies the value of the Categorize As field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(SubCategory; Rec."Sub Category")
                {
                    ToolTip = 'Specifies the value of the Sub Category field.';
                }
                field(Group; Rec.Group)
                {
                    ToolTip = 'Specifies the value of the Group field.';
                }
                field(AssignTo; Rec."Assign To")
                {
                    ToolTip = 'Specifies the value of the Assign To field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(IncludeinEvaluationForm; Rec."Include in Evaluation Form")
                {
                    ToolTip = 'Specifies the value of the Include in Evaluation Form field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
