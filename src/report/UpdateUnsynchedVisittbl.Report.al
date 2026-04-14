namespace PTL.Hospital;

report 85049 "Update Unsynched Visit tbl"
{
    ApplicationArea = All;
    Caption = 'Update Unsynched Visit tbl';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where("Shortcut Dimension 4 Code" = filter('CORPORATE'), Posted = filter(true), "Invoice Number" = filter(''));
            RequestFilterFields = Date;
            column(VisitNo; "Visit No")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Code; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Date; "Date")
            {
            }
            column(ShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VisitswithUnsyncedCharges.Reset();
                VisitswithUnsyncedCharges.SetRange("Visit No", HMSPatientCharges."Visit No");
                if VisitswithUnsyncedCharges.IsEmpty() then begin
                    VisitswithUnsyncedCharges.Init();
                    VisitswithUnsyncedCharges."Visit No" := HMSPatientCharges."Visit No";
                    VisitswithUnsyncedCharges.Insert();
                end;
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
    var
    VisitswithUnsyncedCharges: Record "Visits with Unsynced Charges";
}
