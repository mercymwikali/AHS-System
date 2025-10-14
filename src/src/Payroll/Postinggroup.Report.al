Report 52202534 "Posting group"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Postinggroup.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(no; Vendor."No.")
            {
            }
            column(name; Vendor.Name)
            {
            }
            column(group; Vendor."Vendor Posting Group")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vendor."Gen. Bus. Posting Group" := 'LOCAL';
                Vendor.Modify();
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}
