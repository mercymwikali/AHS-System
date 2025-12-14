table 52202948 "Tr Allergy and Medication form"
{
    Caption = 'Tr Allergy and Medication form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Observation No."; Code[30])
        {
            Caption = 'Observation No.';
        }
        field(2; Complaints; Text[300])
        {
            Caption = 'Complaints';
        }
        field(3; "Reason for Revisit"; Option)
        {
            Caption = 'Reason for Revisit';
            OptionCaption = ' ,Patient not Improving,Patient Deteriorated,New Presentation,Follow Up';
            OptionMembers = " ","Patient not Improving","Patient Deteriorated","New Presentation","Follow Up";
        }
        field(4; "Food Allergy"; Text[300])
        {
            Caption = 'Food Allergy';
        }
        field(5; "Drug Allergy"; Text[300])
        {
            Caption = 'Drug Allergy';
        }

        field(6; "Assessed By"; Code[30])
        {
            Caption = 'Assessed By';

        }
        field(7; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(8; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(9; Type; Option)
        {
            OptionCaption = 'Food,Drug, Chronic Illness';
            OptionMembers = Food,Drug,"Chronic Illness";
        }
        field(10; Allergen; Text[100])
        {

        }
        field(11; "Chronic Illness"; Text[300])
        {
            Caption = 'Chronic Illness';
        }
    }
    keys
    {
        key(PK; "Observation No.", "Line No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Assessed By" = '' then
            "Assessed By" := Format(UserId);

        if Date = 0D then
            Date := Today;
    end;
}
