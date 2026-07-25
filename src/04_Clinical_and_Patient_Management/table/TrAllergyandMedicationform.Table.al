table 85353 "Tr Allergy and Medication form"
{
    Caption = 'Tr Allergy and Medication form';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Observation No."; Code[30])
        {
            Caption = 'Observation No.';
        }
        field(50001; Complaints; Text[300])
        {
            Caption = 'Complaints';
        }
        field(50002; "Reason for Revisit"; Option)
        {
            Caption = 'Reason for Revisit';
            OptionCaption = ' ,Patient not Improving,Patient Deteriorated,New Presentation,Follow Up';
            OptionMembers = " ","Patient not Improving","Patient Deteriorated","New Presentation","Follow Up";
        }
        field(50003; "Food Allergy"; Text[300])
        {
            Caption = 'Food Allergy';
        }
        field(50004; "Drug Allergy"; Text[300])
        {
            Caption = 'Drug Allergy';
        }

        field(50005; "Assessed By"; Code[30])
        {
            Caption = 'Assessed By';

        }
        field(50006; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50007; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50008; Type; Option)
        {
            OptionCaption = 'Food,Drug, Chronic Illness';
            OptionMembers = Food,Drug,"Chronic Illness";
        }
        field(50009; Allergen; Text[100])
        {

        }
        field(50010; "Chronic Illness"; Text[300])
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
