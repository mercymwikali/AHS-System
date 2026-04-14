report 85072 "HMS Bed Occupancy"
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem("HMS Admission Form Header"; "HMS Admission Form Header")
        {
            DataItemTableView = where(Status = filter(Admitted));
            RequestFilterFields = Branch, "Admission Date";
            column(Admission_No_; "Admission No.")
            {
            }
            column(Ward; Ward)
            {
            }
            column(Bed; Bed)
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(Admission_Date; "Admission Date")
            {
            }
            column(Patname; Patname)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.name)
            {
            }
            trigger OnAfterGetRecord()
            begin

                if HMSPat.get("Patient No.") then
                    Patname := HMSPat."Search Name";
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        CompInf: Record "Company Information";
        HMSPat: Record "HMS Patient";
        Patname: text[100];
}