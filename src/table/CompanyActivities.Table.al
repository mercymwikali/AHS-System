Table 85375 "Company Activities"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Day; Date)
        {
        }
        field(50003; Venue; Text[200])
        {
        }
        field(50004; Responsibility; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            var
                objEmployees: Record "HR-Employee";
            begin
                objEmployees.Reset();
                objEmployees.SetRange(objEmployees."No.", Rec.Responsibility);
                if objEmployees.Find() then
                    Rec."Employee Name" := objEmployees."First Name" + ' ' + objEmployees."Middle Name" + ' ' + objEmployees."Last Name";
            end;
        }
        field(50005; Costs; Decimal)
        {
        }
        field(50006; "G/L Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(50007; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Bank';
            OptionMembers = "G/L Account",Bank;

            trigger OnValidate()
            begin
                //{
                //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                //GLAccts.GET(GLAccts."No.")
                //ELSE
                //Banks.GET(Banks."No.");
                //}
            end;
        }
        field(50008; "Bal. Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(50009; Post; Boolean)
        {
        }
        field(50010; Posted; Boolean)
        {
            Editable = true;
        }
        field(50011; "Attachment No."; Integer)
        {
        }
        field(50012; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
        }
        field(50013; Attachement; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50014; "Employee Name"; Code[150])
        {
            FieldClass = Normal;
        }
        field(50015; "First Name"; Text[50])
        {
            CalcFormula = lookup("HR-Employee"."First Name" where("No." = field(Responsibility)));
            FieldClass = FlowField;
        }
        field(50016; "Middle Name"; Text[50])
        {
            CalcFormula = lookup("HR-Employee"."Middle Name" where("No." = field(Responsibility)));
            FieldClass = FlowField;
        }
        field(50017; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HR-Employee"."Last Name" where("No." = field(Responsibility)));
            FieldClass = FlowField;
        }
        field(50018; Attachments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
