Page 85391 "HMS Patients Visit List"
{
    PageType = List;
    SourceTable = "HMS Patient Visit Nos";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PatientNo; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(VisitNo; Rec."Visit No")
                {
                    ToolTip = 'Specifies the value of the Visit No field.';
                }
                field("Posting No"; Rec."Posting No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posting No field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field(DoctorAmount; Rec."Doctor Amount")
                {
                    ToolTip = 'Specifies the value of the Doctor Amount field.';
                }
                field("Doctor Amount Posting"; Rec."Doctor Amount Posting")
                {
                    ToolTip = 'Specifies the value of the Doctor Amount Posting field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(InvoiceNo; Rec."Invoice No")
                {
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(InsuranceNo; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field(Show; Rec.Show)
                {
                    ToolTip = 'Specifies the value of the Show field.';
                }
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(CorpBalance; Rec."Corp Balance")
                {
                    ToolTip = 'Specifies the value of the Corp Balance field.';
                }
                field(Doctor; Rec."Doctor%")
                {
                    ToolTip = 'Specifies the value of the Doctor% field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
                field(CompletionTime; Rec."Completion Time")
                {
                    ToolTip = 'Specifies the value of the Completion Time field.';
                }
                field(CompletedBy; Rec."Completed By")
                {
                    ToolTip = 'Specifies the value of the Completed By field.';
                }
                field(BatchNo; Rec."Batch No")
                {
                    ToolTip = 'Specifies the value of the Batch No field.';
                }
            }
        }
    }

    actions
    {
    }
}
