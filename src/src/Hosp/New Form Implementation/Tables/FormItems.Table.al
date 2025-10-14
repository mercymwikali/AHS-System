table 52202981 "Form Items"
{
    Caption = 'Form Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item ID"; Code[30])
        {
            Caption = 'Item ID';
        }
        field(3; "Category ID"; Code[50])
        {
            Caption = 'Category ID';
            TableRelation = "Form Category"."Category ID";
            trigger OnValidate()
            var 
            FormCategory: Record "Form Category";
            begin
                FormCategory.Reset();
                FormCategory.SetRange("Category ID", "Category ID");
                if FormCategory.FindFirst() then begin
                    "Section ID" := FormCategory."Section ID";
                    "Form Type" := FormCategory."Form Type";                    
                end;
            end;
        }
        field(6; "Item Name"; Text[150])
        {
            Caption = 'Item Name';
        }
        field(7; "Is Text Item"; Boolean)
        {
            Caption = 'Is Text Item';
        }
        field(8; "Input Type"; Option)
        {
            OptionCaption = 'radio,checkbox,text';
            OptionMembers = radio,checkbox,"text";
        }
        field(9; "Form Type"; Enum "Notes Form Types")
        {
        }
        field(10; "Section ID"; Code[50])
        {
            TableRelation = "Form Sections"."Section ID";
        }
        field(11; "Category Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Category"."Category Name" where("Category ID" = field("Category ID")));
        }
        
    }
    keys
    {
        key(PK; "Item ID")
        {
            Clustered = true;
        }
        key(SectionCategory; "Category ID")
        {
        }
    }

    trigger OnInsert()
    var
        FormItems: Record "Form Items";
    begin
        if "Item ID" = '' then begin
            FormItems.Reset();
            if FormItems.FindLast() then 
                "Item ID" := IncStr(FormItems."Item ID")
            else   
                "Item ID" := 'ITM0001';
        end;

    end;
}
