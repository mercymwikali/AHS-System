table 52202980 "Brief MSE Form"
{
    Caption = 'Brief MSE Form';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; "Date Taken"; Date)
        {
            Caption = 'Date Taken';
        }
        field(3; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(4; "Encounter No"; Code[30])
        {
            Caption = 'Encounter No';
        }
        field(5; "Section ID"; Code[50])
        {
            Caption = 'Section ID';
            TableRelation = "Form Sections"."Section ID";
        }
        field(6; "Category ID"; Code[50])
        {
            Caption = 'Category ID';
            TableRelation = "Form Category"."Category ID" where("Section ID" = field("Section ID"));
        }
        field(8; "Item ID"; Code[50])
        {
            Caption = 'Item ID';
            TableRelation = "Form Items"."Item ID" where("Category ID" = field("Category ID"));
        }
        field(9; "Item Name"; Text[150])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Form Items"."Item Name" where("Item ID" = field("Item ID")));
        }
        field(10; IsSelected; Boolean)
        {
            Caption = 'IsSelected';
        }
        field(11; "Other (Specify)"; Text[250])
        {
            Caption = 'Other (Specify)';
        }
        field(12; "Section Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Section Name" where("Section ID" = field("Section ID")));
        }
        field(13; "Category Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Category"."Category Name" where("Category ID" = field("Category ID")));
        }
        field(15; "Is Text Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Items"."Is Text Item" where("Item ID" = field("Item ID")));
        }
        field(16; "Administered By"; Text[50])
        {

        }
        field(17; "Form Type"; Enum "Notes Form Types")
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Form Sections"."Form Type" where("Section ID" = field("Section ID")));
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Administered By" = '' then 
            "Administered By" := CopyStr(UserId, 1, MaxStrLen("Administered By"));
    end;  
    trigger OnModify()
    begin
        if "Administered By" = '' then 
            "Administered By" := CopyStr(UserId, 1, MaxStrLen("Administered By"));
    end;  

}
