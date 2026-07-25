Report 85141 "HMS Lab Tests Summary"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSLabTestsSummary.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = where("Transaction Type" = const('LABORATORY'), Posted = filter(true));
            RequestFilterFields = Date;
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionType_HMSPatientCharges; "HMS Patient Charges"."Transaction Type")
            {
            }
            column(Code_HMSPatientCharges; "HMS Patient Charges".Code)
            {
            }
            column(Description_HMSPatientCharges; "HMS Patient Charges".Description)
            {
            }
            column(Amount_HMSPatientCharges; "HMS Patient Charges".Amount)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(PatientTypeLk_HMSPatientCharges; "HMS Patient Charges"."Patient Type Lk")
            {
            }
            column(Date; "HMS Patient Charges".Date)
            {
            }

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
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

    var
        CompInf: Record "Company Information";
}
