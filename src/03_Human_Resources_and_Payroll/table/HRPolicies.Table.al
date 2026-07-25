Table 85428 "HR Policies"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Rules & Regulations"; Text[250])
        {
        }
        field(50003; "Document Link"; Text[200])
        {
        }
        field(50004; Remarks; Text[200])
        {
            NotBlank = false;
        }
        field(50005; "Language Code (Default)"; Code[10])
        {
        }
        field(50006; Attachement; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50007; Type; Option)
        {
            OptionCaption = 'Is Rules & Regulation,Is Policy,Is Hr Procedure';
            OptionMembers = "Is Rules & Regulation","Is Policy","Is Hr Procedure";
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
