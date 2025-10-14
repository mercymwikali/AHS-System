xmlport 52202426 "HMS Branch Charges"
{
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(Charge; "HMS Charges Prices")
            {
                fieldattribute(Code; Charge."Branch Code")
                {
                }
                fieldattribute(Code2; Charge."Charge Code")
                {
                }
                fieldattribute(Code3; Charge."Cash Amount")
                {
                }
                fieldattribute(Code4; Charge."Corporate Amount")
                {
                }
            }
        }
    }
}