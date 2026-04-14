xmlport 85007 "Chart of Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(NodeName1)
        {
            tableelement("GLAccount"; "G/L Account")
            {
                AutoReplace = true;
                fieldattribute(A1; GLAccount."No.")
                {
                }
                fieldattribute(A2; GLAccount.Name)
                {
                }
                fieldattribute(A3; GLAccount."Account Type")
                {
                }
                fieldattribute(A4; GLAccount."Income/Balance")
                {
                }
            }
        }
    }
}