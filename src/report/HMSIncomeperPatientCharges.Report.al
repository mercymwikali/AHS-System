Report 85181 "HMS Income per Patient Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Financial/HMSIncomeperPatientCharges.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            RequestFilterFields = "Patient No.", "Code", Date;
            column(ReportForNavId_1; 1)
            {
            }
            column(PatientNo_HMSPatientCharges; "HMS Patient Charges"."Patient No." + ' - ' + hmspat.Surname + ' ' + hmspat."Last Name")
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
            column(Remarks_HMSPatientCharges; "HMS Patient Charges".Remarks)
            {
            }
            column(Date_HMSPatientCharges; "HMS Patient Charges".Date)
            {
            }
            column(AmountPaid_HMSPatientCharges; "HMS Patient Charges"."Amount Paid")
            {
            }
            column(TotalAmount_HMSPatientCharges; "HMS Patient Charges"."Total Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if hmspat.Get("HMS Patient Charges"."Patient No.") then;

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
        hmspat: Record "HMS Patient";
}
