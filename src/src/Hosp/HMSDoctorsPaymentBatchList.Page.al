page 52202719 "HMS Doctors Payment Batch List"
{
    CardPageID = "HMS Doctors Payment Batch";
    Editable = false;
    PageType = List;
    SourceTable = "HMS Doctors Payment Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Payment Batch")
            {
                Image = Print;
                ToolTip = 'Executes the Print Payment Batch action.';

                trigger OnAction()
                begin

                    DocRec.Reset();
                    DocRec.SetFilter(DocRec."Completed Filter", '%1', true);
                    if DocRec.Find('-') then
                        REPORT.Run(70135150, true, true, DocRec);
                end;
            }
            separator(Separator9)
            {
            }
            action("Reverse Batch")
            {
                Image = Reject;
                ToolTip = 'Executes the Reverse Batch action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to Reverse the selected records?', false) then begin

                        PatVist.Reset();
                        PatVist.SetRange(PatVist."Batch No", Rec.No);
                        if PatVist.Find('-') then
                            repeat
                                PatVist.Completed := false;
                                PatVist."Completed By" := UserId;
                                PatVist."Completion Date" := Today;
                                PatVist.Modify();
                            until PatVist.Next() = 0;
                        Message('Reversal Completed Successfuly');
                    end;
                end;
            }
            separator(Separator11)
            {
            }
            action("Print Doctor Summary")
            {
                Image = Print;
                RunObject = Report "HMS Doctors Payments Summary";
                ToolTip = 'Executes the Print Doctor Summary action.';
            }
        }
    }

    var
        PatVist: Record "HMS Patient Visit Nos";
        DocRec: Record "HMS Setup Doctor";
}
