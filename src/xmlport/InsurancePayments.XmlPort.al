xmlport 85004 "Insurance Payments"
{
    Caption = 'Insurance Payments';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(InsuranceReceiptsPayments; "Insurance Receipts Payments")
            {
                fieldelement(CustomerNo; InsuranceReceiptsPayments."Customer No")
                {
                }
                fieldelement(InvoiceNo; InsuranceReceiptsPayments."Invoice No")
                {
                }
                fieldelement(MemberNo; InsuranceReceiptsPayments."Member No")
                {
                }
                fieldelement(PatientNo; InsuranceReceiptsPayments."Patient No")
                {
                }
                fieldelement(PatientName; InsuranceReceiptsPayments."Patient Name")
                {
                }
                fieldelement(InvoiceAmount; InsuranceReceiptsPayments."Invoice Amount")
                {
                }
                fieldelement(AmountPayed; InsuranceReceiptsPayments."Amount Payed")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
