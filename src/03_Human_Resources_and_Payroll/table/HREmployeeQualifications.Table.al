Table 85281 "HR Employee Qualifications"
{
    Caption = 'Employee Qualification';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Qualified Employees";
    LookupPageID = "Employee Qualifications";

    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(50002; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(50003; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(50004; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(50005; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50006; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(50007; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(50008; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(50009; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(50010; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Qualification"),
                                                                     "No." = field("Employee No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(50012; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification Type"));
        }
        field(50013; "Qualification Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                /*.SETFILTER(Requirments."Qualification Type","Qualification Type");
                Requirments.SETFILTER(Requirments.Code,"Qualification Code");
                IF Requirments.FIND('-') THEN
                 Qualification := Requirments.Description; */

                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;

                fnTrackChanges('Change in Qualification', Format(xRec."Qualification Code"), Format("Qualification Code"));
            end;
        }
        field(50014; "Qualification Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
            Error(Text000);
    end;

    trigger OnInsert()
    begin
        Employee.Get("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Employee: Record "HR-Employee";
        HRQualifications: Record "HR Qualifications";
        Text000: label 'You cannot delete employee qualification information if there are comments associated with it.';

    procedure fnTrackChanges(columnss: Code[250]; oldValue: Code[250]; NewValue: Code[250])
    var
        HRtracker: Record "HR Change Entries";
    begin
        HRtracker.Init();
        HRtracker."employee No" := "Employee No.";
        HRtracker."Change Date" := Today;
        HRtracker."Change Description" := columnss;
        HRtracker."Old Value" := oldValue;
        HRtracker."New Value" := NewValue;
        HRtracker.UserID := UserId;
        HRtracker.Insert();
    end;
}
