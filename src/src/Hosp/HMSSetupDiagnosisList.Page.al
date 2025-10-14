Page 52202838 "HMS Setup Diagnosis List"
{
    PageType = List;
    SourceTable = "HMS Setup Diagnosis";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field(Diagnosis; Rec.Diagnosis)
                {
                    ToolTip = 'Specifies the value of the Diagnosis field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                field("Expected Date of Discharge"; Rec."Expected Date of Discharge")
                {
                    ToolTip = 'Specifies the value of the Expected Date of Discharge field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewDiagnosis)
            {
                Caption = 'New Diagnosis';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Setup Diagnosis Card";
                ToolTip = 'Executes the New Diagnosis action.';
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
