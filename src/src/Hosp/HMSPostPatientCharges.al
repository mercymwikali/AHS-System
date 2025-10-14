report 52202434 "HMS Post Charges"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    UsageCategory = Administration;

    dataset
    {
        dataitem("HMSPatientCharges"; "HMS Patient Charges")
        {
            DataItemTableView = where("Posting Document No" = filter(''));
            RequestFilterFields = "Patient No.", "Visit No";
            trigger OnAfterGetRecord()
            var
                HMSPost: Codeunit "HMS Patient-integration";
            begin
                HMSPost.PostCharges("Patient No.", "Visit No", false);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the ActionName action.';
                }
            }
        }
    }
}