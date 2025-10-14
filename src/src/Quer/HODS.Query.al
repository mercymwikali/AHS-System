Query 52202492 HODS
{
    elements
    {
        dataitem(Dimension_Value; "Dimension Value")
        {
            column("Code"; "Code")
            {
            }
            column(Name; Name)
            {
            }
            column(HOD; HOD)
            {
            }
            filter(Dimension_Code; "Dimension Code")
            {
                ColumnFilter = Dimension_Code = const('DEPARTMENT');
            }
        }
    }
}
