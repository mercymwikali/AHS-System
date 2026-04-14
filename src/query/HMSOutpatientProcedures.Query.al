Query 85155 "HMS Outpatient Procedures"
{
    elements
    {
        dataitem(HMS_Outpatient_Procedures; "HMS Outpatient Procedures")
        {
            column(Line_No; "Line No")
            {
            }
            column(Treatment_No; "Treatment No")
            {
            }
            column(Patient_No; "Patient No")
            {
            }
            column("Procedure"; "Procedure")
            {
            }
            column(Description; Description)
            {
            }
            column(Department; Department)
            {
            }
            column(Employee; Employee)
            {
            }
            column(Procedure_Date; "Procedure Date")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(ProcedureStatus; Status)
            {
            }
            column(Time_Interval; "Time Interval")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Outpatient_Procedures."Patient No";
                column(Search_Name; "Search Name")
                {
                }
                dataitem(HMS_Treatment_Form_Header; "HMS Treatment Form Header")
                {
                    DataItemLink = "Treatment No." = HMS_Outpatient_Procedures."Treatment No";
                    column(Status; Status)
                    {
                    }
                }
            }
        }
    }
}
