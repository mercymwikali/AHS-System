Page 52202674 "Invoice Dispatch Header-Posted"
{
    Editable = false;
    PageType = Document;
    SourceTable = "Invoice Dispatch Headerd";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(CustomerNo; Rec."Customer No")
                {
                    ToolTip = 'Specifies the value of the Customer No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            group(Control8)
            {
                part(Lines; "Invoice Dispatch Lines")
                {
                    SubPageLink = No = field(No);
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Dispatch")
            {
                Image = PostOrder;
                Visible = false;
                ToolTip = 'Executes the Post Dispatch action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to Post the dispatch?') then begin
                        DispatchLines.Reset();
                        DispatchLines.SetRange(DispatchLines.No, Rec.No);
                        if DispatchLines.Find('-') then
                            repeat
                                InvH.Reset();
                                InvH.SetRange(InvH."No.", Rec.No);
                                if InvH.Find('-') then begin
                                    //InvH."Appointment No":=TRUE;
                                    InvH."Dispatch No" := Rec.No;
                                    InvH.Modify();
                                end;
                            until DispatchLines.Next() = 0;
                        Rec."User ID" := Rec."User ID";
                        Rec."Posting Date" := Today;
                        Rec.Posted := true;
                        Rec.Modify();
                    end;
                end;
            }
            action("Print Dispatch Summary")
            {
                Image = "Report";
                ToolTip = 'Executes the Print Dispatch Summary action.';
                trigger OnAction()
                begin
                    DispatchLines.Reset();
                    DispatchLines.SetFilter(DispatchLines.No, Rec.No);
                    DispatchLines.SetRange(DispatchLines.Select, true);
                    if DispatchLines.Find('-') then
                        REPORT.Run(70135664, true, true, DispatchLines);
                end;
            }
        }
    }

    var
        DispatchLines: Record "Invoice Dispatch Linesd";
        InvH: Record "Sales Invoice Header";
}
