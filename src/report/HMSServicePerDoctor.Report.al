report 85125 "HMS Service Per Doctor"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReports/ServicePerDoctor.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Header"; "HMS Treatment Form Header")
        {
            DataItemTableView = where("Doctor ID" = filter(<> ''));
            RequestFilterFields = "Treatment Date";
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Treatment_Date; "Treatment Date")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(Link_No_; "Link No.")
            {
            }
            column(Treatment_No_; "Treatment No.")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(DocName; DocName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                DocName := '';
                if DocRec.get("Doctor ID") then
                    DocName := DocRec."Doctors Name";
            end;

            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    var
        CompInf: Record "Company Information";
        DocRec: Record "HMS Setup Doctor";
        DocName: text[200];
}