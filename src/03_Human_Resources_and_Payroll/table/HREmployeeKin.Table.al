Table 85412 "HR Employee Kin"
{
    Caption = 'Employee Relative';

    fields
    {
        field(50000; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(50002; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(50003; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(50004; "ID No/Passport No"; Text[50])
        {
        }
        field(50005; "Date Of Birth"; Date)
        {
        }
        field(50006; Occupation; Text[100])
        {
        }
        field(50007; Address; Text[250])
        {
        }
        field(50008; "Office Tel No"; Text[100])
        {
        }
        field(50009; "Home Tel No"; Text[50])
        {
        }
        field(50010; Remarks; Text[250])
        {
        }
        field(50011; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary,Dependant;
        }
        field(50012; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(50013; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Relative"),
                                                                     "No." = field("Employee Code"),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Code"; Code[10])
        {
        }
        field(50015; "Percentage(%)"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Percentage(%)" > 100 then
                    Error('The total Percentage for all Beneficiaries should not be more than 100%');
            end;
        }
        field(50016; "No."; Code[10])
        {
        }
        field(50017; "Member ID"; Text[30])
        {
        }
        field(50018; Category; Text[30])
        {
        }
        field(50019; Gender; Option)
        {
            OptionCaption = 'male,female';
            OptionMembers = male,female;
        }
    }

    keys
    {
        key(Key1; "Employee Code", SurName, "Other Names")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."table name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll();
    end;
}
