Page 85032 "Staff List"
{
    Editable = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = where("Customer Posting Group" = const('IMPREST'));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer.';
                }
                field(Address2; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field(TelexNo; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(BloodGroup; Rec."Blood Group")
                {
                    ToolTip = 'Specifies the value of the Blood Group field.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field.';
                }
                field(PaymentsBy; Rec."Payments By")
                {
                    ToolTip = 'Specifies the value of the Payments By field.';
                }
                field(IDNo; Rec."ID No")
                {
                    ToolTip = 'Specifies the value of the ID No field.';
                }
                field(CustomerType; Rec."Customer Type")
                {
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field(BirthCert; Rec."Birth Cert")
                {
                    ToolTip = 'Specifies the value of the Birth Cert field.';
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
