Page 85370 "HMS Operation nurse Notes"
{
    PageType = List;
    SourceTable = "HMS Operational Notes";
    SourceTableView = where(notesType = filter("Surgeon Notes"));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.';
                }
            }
        }
    }

    actions
    {
    }
}
