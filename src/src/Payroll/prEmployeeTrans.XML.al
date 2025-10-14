xmlport 52202427 "PrEmployeeTransactions"
{
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(prEmp; "prEmployee Transactions")
            {
                fieldattribute(No; prEmp."Employee Code")
                {
                }
                fieldattribute(tCode; prEmp."Transaction Code")
                {
                }
                fieldattribute(Name; prEmp."Transaction Name")
                {
                }
                fieldattribute(Amt; prEmp.Amount)
                {
                }
                fieldattribute(perio; prEmp."Payroll Period")
                {
                }
            }
        }
    }
}