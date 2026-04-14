query 85150 "HMS Charge Branch Prices"
{
    QueryType = Normal;

    elements
    {
        dataitem(HMS_Charges_Prices; "HMS Charges Prices")
        {
            column(Branch_Code; "Branch Code")
            {
            }
            column(Charge_Code; "Charge Code")
            {
            }
            column(Cash_Amount; "Cash Amount")
            {
            }
            column(Corporate_Amount; "Corporate Amount")
            {
            }
            dataitem(HMS_Charges; "HMS Charges")
            {
                DataItemLink = "Code" = HMS_Charges_Prices."Charge Code";
                column("Code"; "Code")
                {
                }
                column(Description; Description)
                {
                }
                column(Transaction_Type; "Transaction Type")
                {
                }
                column(Income_G_L_Account_No; "Income G/L Account No")
                {
                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {
                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}