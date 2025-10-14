namespace HMISBC.HMISBC;

query 52202595 "Dietary Intake Form Lines"
{
    Caption = 'Dietary Intake Form Lines';
    QueryType = Normal;

    elements
    {
        dataitem(DietaryIntakeFormLines; "Dietary Intake Form Lines")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(Category; Category)
            {
            }
            column(Comment; Comment)
            {
            }
            column(LineNo; "Line No")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
