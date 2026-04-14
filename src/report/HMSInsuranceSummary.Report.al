Report 85088 "HMS Insurance Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSInsuranceSummary.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = where("Posted Invoice No." = filter(<> ''), "Insurance No" = filter(<> ''));
            RequestFilterFields = "Insurance No", Date;
            column(ReportForNavId_1; 1)
            {
            }
            column(Visit_No; "Visit No")
            {
            }
            column(Date; Date)
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(PatRecMember; PatRec."Membership No")
            {
            }
            column(PatRecScheme; PatRec."Scheme Name")
            {
            }
            column(SearchNames; PatRec."Search Name")
            {
            }
            column(Visit_Balance; "Visit Balance")
            {
            }
            column(Visit_Amount; "Visit Amount")
            {
            }
            column(Invoice_Amount; "Invoice Amount")
            {
            }
            column(Visit_Paid_Amount; "Visit Paid Amount")
            {
            }
            column(Posted_Invoice_No_; "Posted Invoice No.")
            {
            }
            column(Insurance_No; "Insurance No")
            {
            }
            column(patientNames; PatRec."Search Name")
            {
            }
            column(InsuranceNames; Cust.Name)
            {
            }
            column(PatientType; PatientType)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(BranchFilter; "Shortcut Dimension 1 Code")
            {
            }
            column(DateFilter; Date)
            {
            }

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                PatRec.get("HMS Patient Charges"."Patient No.");
                if Cust.get("HMS Patient Charges"."Insurance No") then;
                if "HMS Patient Charges".InPatient = true then
                    PatientType := 'IP'
                else
                    PatientType := 'OP';
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
        Cust: Record customer;
        PatRec: Record "HMS Patient";
        PatientType: code[20];
}
