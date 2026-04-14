page 85392 "HMS Patient Visits"
{
    PageType = List;
    SourceTable = "HMS Patient Visit Nos";
    SourceTableView = WHERE(Completed = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patient No"; Rec."Patient No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("Visit No"; Rec."Visit No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field("Posting No"; Rec."Posting No")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                    ToolTip = 'Specifies the value of the Posting No field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Doctor Amount"; Rec."Doctor Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Amount field.';
                }
                field("Doctor Amount Posted"; Rec."Doctor Amount Posted")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Amount Posted field.';
                }
                field("Doctor Amount Posting"; Rec."Doctor Amount Posting")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Amount Posting field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Charge Posting No"; Rec."Charge Posting No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Charge Posting No field.';
                }
                field(Show; Rec.Show)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Show field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Doctor Amount All"; Rec."Doctor Amount All")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Amount All field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark All")
            {
                ApplicationArea = Basic, Suite;
                Image = SelectLineToApply;
                ToolTip = 'Executes the Mark All action.';
                trigger OnAction()
                begin
                    PatVist.Reset();
                    PatVist.SetFilter(PatVist.Completed, '%1', false);
                    if PatVist.Find('-') then
                        repeat
                            PatVist.Show := true;
                            PatVist.Modify();
                        until PatVist.Next() = 0;
                end;
            }
            action("UnMark All")
            {
                ApplicationArea = Basic, Suite;
                Image = SelectEntries;
                ToolTip = 'Executes the UnMark All action.';
                trigger OnAction()
                begin
                    PatVist.Reset();
                    PatVist.SetFilter(PatVist.Completed, '%1', false);
                    if PatVist.Find('-') then
                        repeat
                            PatVist.Show := false;
                            PatVist.Modify();
                        until PatVist.Next() = 0;
                end;
            }
            separator(Separator17)
            {
            }
            action("Print Summary")
            {
                ApplicationArea = Basic, Suite;
                Image = AnalysisView;
                ToolTip = 'Executes the Print Summary action.';
                trigger OnAction()
                begin
                    DocRec.Reset();
                    DocRec.SetFilter(DocRec."Completed Filter", '%1', false);
                    if DocRec.Find('-') then
                        REPORT.Run(70135150, true, true, DocRec);
                    /*
                    PatVist.RESET;
                    PatVist.SETFILTER(PatVist.Show,'%1',TRUE);
                    PatVist.SETFILTER(PatVist.Completed,'%1',FALSE);
                    IF PatVist.FIND('-') THEN
                      REPORT.RUN(70135150,TRUE,TRUE,Pa);
                    */
                end;
            }
            separator(Separator20)
            {
            }
            action("Post Doctor Invoice")
            {
                ApplicationArea = Basic, Suite;
                Image = ApplyEntries;
                ToolTip = 'Executes the Post Doctor Invoice action.';
                trigger OnAction()
                begin
                    PatVist.Reset();
                    //PatVist.SETRANGE(PatVist.Show,TRUE);
                    PatVist.SetRange(PatVist.Completed, false);
                    if PatVist.Find('-') then
                        REPORT.Run(51930, true, true, PatVist);
                end;
            }
            separator(Separator25)
            {
            }
            action("Mark As Completed")
            {
                ApplicationArea = Basic, Suite;
                Image = SendTo;
                ToolTip = 'Executes the Mark As Completed action.';
                trigger OnAction()
                begin
                    if Confirm('Do you really want to mark the selected records as completed?', false) then begin
                        HMSSetup.Get();

                        PatVist.Reset();
                        PatVist.SetRange(PatVist.Show, true);
                        PatVist.SetRange(PatVist.Completed, false);
                        PatVist.SetRange(PatVist.Posted, true);
                        if PatVist.Find('-') then begin
                            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Doctors Payment Nos", 0D, true);
                            DocPay.Init();
                            DocPay.No := NewNo;
                            DocPay.Date := Today;
                            DocPay.Time := Time;
                            DocPay."Posted By" := UserId;
                            DocPay.Insert();
                            repeat
                                PatVist."Batch No" := NewNo;
                                PatVist.Completed := true;
                                PatVist."Completed By" := Rec."User ID";
                                PatVist."Completion Date" := Today;
                                PatVist."Completion Time" := Time;
                                PatVist.Modify();
                            until PatVist.Next() = 0;
                        end;
                        Message('Successfully Marked as completed');
                    end;
                end;
            }
            separator(Separator24)
            {
            }
            action("Mass Selection")
            {
                ApplicationArea = Basic, Suite;
                Image = SelectEntries;
                RunObject = Report "Suggest Doctor Payments";
                ToolTip = 'Executes the Mass Selection action.';
            }
            separator(Separator26)
            {
            }
            action("Generate Patients Visits")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest Patients Visits';
                Image = AvailableToPromise;
                Promoted = true;
                RunObject = Report "HMS Generate Patient Visits";
                ToolTip = 'Executes the Suggest Patients Visits action.';
            }
            separator(Separator28)
            {
            }
            action("Suggest Paid Invoices")
            {
                ApplicationArea = Basic, Suite;
                Image = Suggest;
                RunObject = Report "HMS Suggest Paid Doctor Inv";
                ToolTip = 'Executes the Suggest Paid Invoices action.';
            }
            action("Update Posted Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Posted Entries';
                Image = SendTo;
                ToolTip = 'Executes the Refresh Posted Entries action.';
                trigger OnAction()
                var
                    PatVisits: record "HMS Patient Visit Nos";
                begin
                    if Confirm('Do you really want to Refresh the Posted Entries?', false) then begin
                        PatVisits.reset();
                        PatVisits.setrange(Posted, false);
                        if PatVisits.find('-') then
                            repeat
                                VendL.Reset();
                                VendL.SetRange(VendL."Document No.", PatVisits."Visit No");
                                VendL.SetRange(VendL."Vendor No.", PatVisits."Doctor ID");
                                if VendL.find('-') then
                                    PatVisits.Posted := true;

                                VendL.Reset();
                                VendL.SetRange(VendL."Document No.", PatVisits."Posting No");
                                VendL.SetRange(VendL."Vendor No.", PatVisits."Doctor ID");
                                if VendL.find('-') then
                                    PatVisits.Posted := true;
                                PatVisits.Modify();
                            until PatVisits.next() = 0;

                        Message('Successfully Updated');
                    end;
                end;
            }
        }
    }

    var
        DocPay: Record "HMS Doctors Payment Batch";
        PatVist: Record "HMS Patient Visit Nos";
        HMSSetup: Record "HMS Setup";
        DocRec: Record "HMS Setup Doctor";
        VendL: Record "Vendor Ledger Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
}
