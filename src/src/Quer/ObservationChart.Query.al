Query 52202527 "Observation Chart"
{
    OrderBy = descending(Date), descending(Line_No);

    elements
    {
        dataitem(HMS_General_Observation; "HMS General Observation")
        {
            column(Patient_No; "Patient No")
            {
            }
            column(Line_No; "Line No")
            {
            }
            column(Date; Date)
            {
            }
            column(Category; Category)
            {
            }
            column(Category_Value; "Category Value")
            {
            }
            column(Timing; Timing)
            {
            }
            column(Admission_No; "Admission No")
            {
            }
            column(ICU_Timings; "ICU Timings")
            {
            }
            column(ICU; ICU)
            {
            }
            column(ICU_Category; "ICU Category")
            {
            }
            column(ICU_Observation_Cateory; "ICU Observation Cateory")
            {
            }
        }
    }
}
