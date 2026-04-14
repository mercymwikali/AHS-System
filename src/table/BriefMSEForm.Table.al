table 85327 "Brief MSE Form"
{
    Caption = 'Brief MSE Form';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(50001; "Date Taken"; Date)
        {
            Caption = 'Date Taken';
        }
        field(50002; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50003; "Encounter No"; Code[30])
        {
            Caption = 'Encounter No';
        }
        field(50004; "Section ID"; Code[50])
        {
            Caption = 'Section ID';
            TableRelation = "Form Sections"."Section ID";
        }
        field(50005; "Category ID"; Code[50])
        {
            Caption = 'Category ID';
            TableRelation = "Form Category"."Category ID" where("Section ID" = field("Section ID"));
        }
        field(50006; "Item ID"; Code[50])
        {
            Caption = 'Item ID';
            TableRelation = "Form Items"."Item ID" where("Category ID" = field("Category ID"));
        }
        field(50007; "Item Name"; Text[150])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Form Items"."Item Name" where("Item ID" = field("Item ID")));
        }
        field(50008; IsSelected; Boolean)
        {
            Caption = 'IsSelected';
        }
        field(50009; "Other (Specify)"; Text[250])
        {
            Caption = 'Other (Specify)';
        }
        field(50010; "Section Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Section Name" where("Section ID" = field("Section ID")));
        }
        field(50011; "Category Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Category"."Category Name" where("Category ID" = field("Category ID")));
        }
        field(50012; "Is Text Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Items"."Is Text Item" where("Item ID" = field("Item ID")));
        }
        field(50013; "Administered By"; Text[50])
        {

        }
        field(50014; "Form Type"; Enum "Notes Form Types")
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
