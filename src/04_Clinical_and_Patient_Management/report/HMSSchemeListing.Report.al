Report 85124 "HMS Scheme Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSSchemeListing.rdl';

    dataset
    {
        dataitem("HMS Scheme Plan Services"; "HMS Scheme Plan Services")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_HMSSchemePlanServices; "HMS Scheme Plan Services".Code)
            {
            }
            column(Description_HMSSchemePlanServices; "HMS Scheme Plan Services".Description)
            {
            }
            column(Insurance_HMSSchemePlanServices; "HMS Scheme Plan Services".Insurance)
            {
            }
            column(Amount_HMSSchemePlanServices; "HMS Scheme Plan Services".Amount)
            {
            }
            column(Drugs_HMSSchemePlanServices; "HMS Scheme Plan Services".Drugs)
            {
            }
            column(ApplicableSection_HMSSchemePlanServices; "HMS Scheme Plan Services"."Applicable Section")
            {
            }
            column(ShortcutDimension1Code_HMSSchemePlanServices; "HMS Scheme Plan Services"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_HMSSchemePlanServices; "HMS Scheme Plan Services"."Shortcut Dimension 2 Code")
            {
            }
            column(Accounttype_HMSSchemePlanServices; "HMS Scheme Plan Services"."Account type")
            {
            }
            column(BillingType_HMSSchemePlanServices; "HMS Scheme Plan Services"."Billing Type")
            {
            }
            column(ReccuringType_HMSSchemePlanServices; "HMS Scheme Plan Services"."Reccuring Type")
            {
            }
            column(TransactionType_HMSSchemePlanServices; "HMS Scheme Plan Services"."Transaction Type")
            {
            }
            column(PercentageRate_HMSSchemePlanServices; "HMS Scheme Plan Services"."Percentage Rate")
            {
            }
            column(ExpenseGLAccountNo_HMSSchemePlanServices; "HMS Scheme Plan Services"."Expense G/L Account No")
            {
            }
            column(DoctorPercentage_HMSSchemePlanServices; "HMS Scheme Plan Services"."Doctor Percentage")
            {
            }
            column(InsuranceAmount_HMSSchemePlanServices; "HMS Scheme Plan Services"."Insurance Amount")
            {
            }
            column(Branch2Amount_HMSSchemePlanServices; "HMS Scheme Plan Services"."Branch2 Amount")
            {
            }
            column(Branch3Amount_HMSSchemePlanServices; "HMS Scheme Plan Services"."Branch3 Amount")
            {
            }
            column(InsuranceName_HMSSchemePlanServices; "HMS Scheme Plan Services"."Insurance Name")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}
