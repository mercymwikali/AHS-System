Query 85200 "Smart Treatment Diagnosis"
{
    elements
    {
        dataitem(HMS_Treatment_Form_Header; "HMS Treatment Form Header")
        {
            column(Patient_No_; "Patient No.") { }
            column(Treatment_No_; "Treatment No.") { }
            column(Treatment_Type; "Treatment Type") { }
            dataitem(HMS_Treatment_Form_Diagnosis; "HMS Treatment Form Diagnosis")
            {
                DataItemLink = "Treatment No." = HMS_Treatment_Form_Header."Treatment No.";
                column(Diagnosis_Code; "Diagnosis Code") { }
                column(Diagnosis_No_; "Diagnosis No.") { }
                column(Diagnosis_Type; "Diagnosis Type") { }
                column(Remarks; Remarks) { }
            }
        }
    }
}