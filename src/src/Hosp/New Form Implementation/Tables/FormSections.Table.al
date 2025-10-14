table 52202978 "Form Sections"
{
    Caption = 'Form Sections';
    DataClassification = ToBeClassified;
    LookupPageId = "Form Sections Setup";

    fields
    {
        field(1; "Section ID"; Code[30])
        {
            Caption = 'Section ID';
        }
        field(2; "Section Name"; Text[100])
        {
            Caption = 'Section Name';
        }
        field(3; "Form Type"; Enum "Notes Form Types")
        {
        }
    }
    keys
    {
        key(PK; "Section ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        FormSections: Record "Form Sections";
    begin
        if "Section ID" = '' then begin
            FormSections.Reset();
            if FormSections.FindLast() then
                "Section ID" := IncStr(FormSections."Section ID")
        end
        else
            "Section ID" := 'SEC001';

    end;
}
