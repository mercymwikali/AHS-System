Table 85365 "Applicants Qualification"
{
    Caption = 'Applicants Qualification';
    DataCaptionFields = "Employee No.";
    // DrillDownPageID = UnknownPage39005860;
    // LookupPageID = UnknownPage39005860;

    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Applicants."Application No";
        }
        field(50001; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50002; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            NotBlank = true;
            TableRelation = "HR Qualifications".Code;

            trigger OnValidate()
            begin
                Qualifications.Reset();
                Qualifications.SetRange(Qualifications.Code, "Qualification Code");
                if Qualifications.Find('-') then
                    Qualification := Qualifications.Description;
            end;
        }
        field(50003; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(50004; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(50005; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(50006; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(50007; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(50008; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(50009; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(50010; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(50011; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Qualification"),
                                                                     "No." = field("Employee No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(50013; "Qualification Type"; Option)
        {
            NotBlank = false;
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
        }
        field(50014; Qualification; Text[200])
        {
            NotBlank = true;
        }
        field(50015; "Score ID"; Decimal)
        {
            TableRelation = "Score Setup"."Score ID";
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
        key(Key2; "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Qualifications: Record Qualification;
}
