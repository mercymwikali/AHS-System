Query 52202511 "Diagnosis List"
{
    OrderBy = ascending(Diagnosis);
    TopNumberOfRows = 1000000;

    elements
    {
        dataitem(HMS_Setup_Diagnosis; "HMS Setup Diagnosis")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
        }
    }
}
