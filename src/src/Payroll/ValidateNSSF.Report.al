Report 52202541 "Validate NSSF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ValidateNSSF.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Salary.Reset();
                Salary.SetRange(Salary."No.", "prSalary Card"."Employee Code");
                if Salary.Find('-') then
                    if Salary."NSSF No." <> '' then begin
                        "prSalary Card"."Pays NSSF" := true;
                        "prSalary Card".Modify(true);
                    end;
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
        Salary: Record "HR-Employee";
}
