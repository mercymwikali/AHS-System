Table 85409 "HR Employee Attachments"
{
    fields
    {
        field(50000; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(50002; "Document Link"; Text[200])
        {
        }
        field(50003; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(50004; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
        }
        field(50005; Attachment; Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure PlaceFilter(prompt: Boolean; EmployeeNo: Code[10]): Boolean
    begin
        if prompt then
            SetFilter("Employee No", EmployeeNo);
    end;
}
