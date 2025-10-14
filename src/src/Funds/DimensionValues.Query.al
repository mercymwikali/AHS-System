query 52202536 "Dimension Values"
{
    QueryType = Normal;

    elements
    {
        dataitem("DimensionValue"; "Dimension Value")
        {
            DataItemTableFilter = Blocked = const(false), "Dimension Value Type" = const(Standard);
            column(Code; Code)
            {
            }
            column(Name; Name)
            {
            }
            column(Global_Dimension_No_; "Global Dimension No.")
            {
            }
            column(HOD; HOD)
            {
                //
            }
            
            column(Dimension_Code; "Dimension Code")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}