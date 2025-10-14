table 52202982 "Consultation Notes Form"
{
    Caption = 'Consultation Notes Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
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
            trigger OnValidate()
            var
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
                HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
            begin
                HMSAdmissionFormHeader.Reset();
                HMSAdmissionFormHeader.SetRange("Admission No.", "Encounter No");
                if HMSAdmissionFormHeader.FindFirst() then
                    "Patient No" := HMSAdmissionFormHeader."Patient No."
                else begin
                    HMSTreatmentFormHeader.Reset();
                    HMSTreatmentFormHeader.SetRange("Treatment No.", "Encounter No");
                    if HMSTreatmentFormHeader.FindFirst() then
                        "Patient No" := HMSTreatmentFormHeader."Patient No.";
                end;
            end;
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
            trigger OnValidate()
            var
                FormItems: Record "Form Items";
            begin
                FormItems.Reset();
                FormItems.SetRange("Item ID", "Item ID");
                if FormItems.FindFirst() then begin
                    "Section ID" := FormItems."Section ID";
                    "Category ID" := FormItems."Category ID";
                    "Input Type" := FormItems."Input Type";
                end;
            end;
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
        field(16; "Form Type"; Enum "Notes Form Types")
        {
            Caption = 'Form Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Form Type" where("Section ID" = field("Section ID")));
        }
        field(17; "Input Type"; Option)
        {
            OptionCaption = 'radio,checkbox,text';
            OptionMembers = radio,checkbox,"text";
        }
    }
    keys
    {
        key(PK; "Entry No", "Encounter No", "Item ID")
        {
            Clustered = true;
        }
        key(SK; "Entry No")
        {

        }
    }
}
