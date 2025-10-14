xmlport 52202429 "HMS Patient Vist Nos"
{
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(NodeName2; "HMS Patient Visit Nos")
            {
                AutoUpdate = true;
                fieldattribute(NodeName3; NodeName2."Patient No")
                {
                }
                fieldattribute(NodeName4; NodeName2."Visit No")
                {
                }
                fieldattribute(NodeName5; NodeName2."Doctor ID")
                {
                }
                fieldattribute(NodeName6; NodeName2."Posting No")
                {
                }
                fieldattribute(NodeName7; NodeName2.Completed)
                {
                }
                fieldattribute(NodeName8; NodeName2."Completed By")
                {
                }
            }
        }
    }

    requestpage
    {
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ToolTip = 'Executes the ActionName action.';
                }
            }
        }
    }
}