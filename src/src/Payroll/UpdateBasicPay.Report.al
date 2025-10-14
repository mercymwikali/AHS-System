Report 52202602 "Update Basic Pay"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*proc.OPEN('#1#############################');
                 "Employe Buff".RESET;
                "Employe Buff".SETRANGE("Employe Buff"."Employee No.","prSalary Card"."Employee Code");
                "Employe Buff".SETRANGE("Employe Buff"."Transaction Name",'BASIC SALARY');
                IF NOT ("Employe Buff".FIND('-')) THEN BEGIN
                // Nobasic Salary
                IF HrEmployee.GET("prSalary Card"."Employee Code") THEN BEGIN
                 proc.UPDATE(1,HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                 SLEEP(200);
               // HrEmployee.Status:=HrEmployee.Status::Resigned;
               // HrEmployee.MODIFY;
                 END;
                END;
                 proc.CLOSE;   */
                "prSalary Card"."Basic Pay" := 0;
                "prSalary Card".Modify();
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
