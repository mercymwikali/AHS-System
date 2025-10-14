namespace HMISBC.HMISBC;

query 52202576 "Allergies and Medications"
{
    Caption = 'Allergies and Medications';
    QueryType = Normal;

    elements
    {
        dataitem(TrAllergyandMedicationform; "Tr Allergy and Medication form")
        {
            column(Allergen; Allergen)
            {
            }
            column("Date"; "Date")
            {
            }
            column("Type"; "Type")
            {
            }
            column(AssessedBy; "Assessed By")
            {
            }
            column(Complaints; Complaints)
            {
            }
            column(DrugAllergy; "Drug Allergy")
            {
            }
            column(FoodAllergy; "Food Allergy")
            {
            }
            column(ObservationNo; "Observation No.")
            {
            }
            column(ReasonforRevisit; "Reason for Revisit")
            {
            }
            column(SystemId; SystemId) { }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
