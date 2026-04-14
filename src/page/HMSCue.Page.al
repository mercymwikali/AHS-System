Page 85330 "HMS Cue"
{
    PageType = CardPart;
    SourceTable = "HMS Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(RegistrationStatistics)
            {
                Caption = 'Registration Statistics';
                field(WalkInPatients; Rec."Walk-In Patients")
                {
                    ToolTip = 'Specifies the value of the Walk-In Patients field.';
                }
                field(CashPatients; Rec."Cash Patients")
                {
                    ToolTip = 'Specifies the value of the Cash Patients field.';
                }
                field(AllOutPatients; Rec."All Out-Patients")
                {
                    ToolTip = 'Specifies the value of the All Out-Patients field.';
                }
                field(CorporateOutPatients; Rec."Corporate Out Patients")
                {
                    ToolTip = 'Specifies the value of the Corporate Out Patients field.';
                }
                field(TodaysNewVisits; Rec."Today's New Visits")
                {
                    ToolTip = 'Specifies the value of the Today''s New Visits field.';
                }
            }
            cuegroup(Control5)
            {
                Caption = 'Registration Statistics';
                field(AllInPatients; Rec."All In-Patients")
                {
                    ToolTip = 'Specifies the value of the All In-Patients field.';
                }
                field(CorporateInPatients; Rec."Corporate In Patients")
                {
                    ToolTip = 'Specifies the value of the Corporate In Patients field.';
                }
                field(TodaysVisits; Rec."Today's Visits")
                {
                    ToolTip = 'Specifies the value of the Today''s Visits field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetFilter(CurrentDate, '=%1', WorkDate());
    end;
}
