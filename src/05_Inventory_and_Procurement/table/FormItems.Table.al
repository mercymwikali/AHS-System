table 85330 "Form Items"
{
    Caption = 'Form Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Item ID"; Code[30])
        {
            Caption = 'Item ID';
        }
        field(50001; "Category ID"; Code[50])
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
        field(50002; "Item Name"; Text[150])
        {
            Caption = 'Item Name';
        }
        field(50003; "Is Text Item"; Boolean)
        {
            Caption = 'Is Text Item';
        }
        field(50004; "Input Type"; Option)
        {
            OptionCaption = 'radio,checkbox,text';
            OptionMembers = radio,checkbox,"text";
        }
        field(50005; "Form Type"; Enum "Notes Form Types")
        {
        }
        field(50006; "Section ID"; Code[50])
        {
            TableRelation = "Form Sections"."Section ID";
        }
        field(50007; "Category Name"; Text[150])
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
