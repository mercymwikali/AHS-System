table 52202979 "Form Category"
{
    Caption = 'Form Category';
    DataClassification = ToBeClassified;
    LookupPageId = "Section Categories Setup";
    
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; "Section ID"; Code[50])
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
        field(3; "Category ID"; Code[50])
        {
            Caption = 'Category ID';
        }
        field(4; "Category Name"; Text[150])
        {
            Caption = 'Category Name';
        }
        field(5; "Parent Category ID"; Code[50])
        {
            Caption = 'Parent Category ID';
            TableRelation = "Form Category"."Category ID";

            trigger OnValidate()
            begin
                if "Parent Category ID" = "Category ID" then
                    Error('Parent Category ID cannot be the same as Category ID.');
            end;
        }
        field(6; "Has Children"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Form Category" where("Parent Category ID" = field("Category ID")));
        }
        field(7; "Is Leaf Category"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Form Category" where("Parent Category ID" = field("Category ID")));
        }
        field(8; "Input Type"; Option)
        {
            OptionCaption = 'radio,checkbox,text';
            OptionMembers = radio,checkbox,"text";
        }
        field(9; "Form Type"; Enum "Notes Form Types")
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
