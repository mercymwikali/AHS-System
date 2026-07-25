Page 85252 "Responsibility Center List BR"
{
    ApplicationArea = All;
    Caption = 'Responsibility Center List';
    Editable = true;
    PageType = Card;
    SourceTable = "Responsibility Center BR";
    UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(RespCtr)
            {
                Caption = '&Resp. Ctr.';
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Responsibility Center Card BR";
                    RunPageLink = Code = field(Code);
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = const(5714),
                                      "No." = field(Code);
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'Executes the Dimensions-Single action.';
                    }
                    action(DimensionsMultiple)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions-&Multiple';
                        ToolTip = 'Executes the Dimensions-&Multiple action.';

                        trigger OnAction()
                        var
                            RespCenter: Record "Responsibility Center";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(RespCenter);
                            // DefaultDimMultiple.SetMultiRespCenter(RespCenter);
                            DefaultDimMultiple.RunModal();
                        end;
                    }
                }
            }
        }
    }
}
