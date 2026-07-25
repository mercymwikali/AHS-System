namespace PTL.Hospital;

report 85046 "Delete Unsynced invoice"
{
    Caption = 'Delete Unsynced invoice';
    ProcessingOnly = true;
    dataset
    {
        dataitem(VisitswithUnsyncedCharges; "Visits with Unsynced Charges")
        {
            column(LineNo; "Line No")
            {
            }
            column(VisitNo; "Visit No")
            {
            }
            column(PatientNumber; "Patient Number")
            {
            }
            column(PostedInvoiceNumber; "Posted Invoice Number")
            {
            }
            column(SynchedwithsalesInvoice; "Synched with sales Invoice")
            {
            }
            column(FirstInvoicenumber; "First Invoice number")
            {
            }
            column(NoofChargesMissing; "No of Charges Missing")
            {
            }
            column(MissingChargesAmount; "Missing Charges Amount")
            {
            }
            trigger OnAfterGetRecord()
            begin
                VisitswithUnsyncedCharges.Delete();
            end;
            trigger OnPostDataItem()
            begin
                Message('done');
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
