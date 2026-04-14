table 85328 "Consultation Notes Form"
{
    Caption = 'Consultation Notes Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Entry No"; Integer)
        {
            Caption = 'Entry No';
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
        field(50013; "Form Type"; Enum "Notes Form Types")
        {
            Caption = 'Form Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Form Type" where("Section ID" = field("Section ID")));
        }
        field(50014; "Input Type"; Option)
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
