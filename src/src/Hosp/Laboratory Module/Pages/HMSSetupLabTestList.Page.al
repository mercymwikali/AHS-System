Page 52202844 "HMS Setup Lab Test List"
{
    PageType = List;
    SourceTable = "HMS Setup Lab Test";
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
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }                
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddCharges)
            {
                ApplicationArea = All;
                Caption = 'Add or Update Charges';
                Promoted = true;
                PromotedCategory = Process;
                Image = CalculateLines;
                ToolTip = 'Action to Update Charges List';

                trigger OnAction()
                var
                    HMSCharges: Record "HMS Charges";
                begin
                    // Add your code here
                    HMSCharges.Reset();
                    HMSCharges.SetRange(Code, Rec.Code);
                    if HMSCharges.FindFirst() then begin
                        HMSCharges.Description := Rec.Description;
                        HMSCharges."Transaction Type" := 'Laboratory';
                        HMSCharges.Amount := Rec.Amount;
                        HMSCharges.Modify();
                        
                        Message('Modified');
                    end else begin                        
                        HMSCharges.Init();
                        HMSCharges.Code := Rec.Code;
                        HMSCharges."Transaction Type" := 'Laboratory';
                        HMSCharges.Description := Rec.Description;
                        HMSCharges.Amount := Rec.Amount;
                        HMSCharges."Insurance Amount" := Rec."Insurance Amount";
                        HMSCharges."Income G/L Account No" := Rec."G/L Account";
                        HMSCharges.Insert();

                        Message('Inserted');
                    end;

                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
