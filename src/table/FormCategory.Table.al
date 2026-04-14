table 85329 "Form Category"
{
    Caption = 'Form Category';
    DataClassification = ToBeClassified;
    LookupPageId = "Section Categories Setup";
    
    fields
    {
        field(50000; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(50001; "Section ID"; Code[50])
        {
            Caption = 'Section ID';
            TableRelation = "Form Sections"."Section ID";
            trigger OnValidate()
            var
            FormSections: Record "Form Sections";
            begin
                FormSections.Reset();
                FormSections.SetRange("Section ID", "Section ID");
                if FormSections.FindFirst() then
                    "Form Type" := FormSections."Form Type";
            end;
        }
        field(50002; "Category ID"; Code[50])
        {
            Caption = 'Category ID';
        }
        field(50003; "Category Name"; Text[150])
        {
            Caption = 'Category Name';
        }
        field(50004; "Parent Category ID"; Code[50])
        {
            Caption = 'Parent Category ID';
            TableRelation = "Form Category"."Category ID";

            trigger OnValidate()
            begin
                if "Parent Category ID" = "Category ID" then
                    Error('Parent Category ID cannot be the same as Category ID.');
            end;
        }
        field(50005; "Has Children"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Form Category" where("Parent Category ID" = field("Category ID")));
        }
        field(50006; "Is Leaf Category"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Form Category" where("Parent Category ID" = field("Category ID")));
        }
        field(50007; "Input Type"; Option)
        {
            OptionCaption = 'radio,checkbox,text';
            OptionMembers = radio,checkbox,"text";
        }
        field(50008; "Form Type"; Enum "Notes Form Types")
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Form Sections"."Form Type" where("Section ID" = field("Section ID")));
        }
    }
    keys
    {
        key(PK; "Line No.","Section ID","Category ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        FormCategory: Record "Form Category";
    begin
        if "Category ID" = '' then begin
            FormCategory.Reset();
            if FormCategory.FindLast() then 
                "Category ID" := IncStr(FormCategory."Category ID")
            else   
                "Category ID" := 'CAT0001';
        end;

    end;
}
