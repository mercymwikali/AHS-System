Table 85429 "HR Posting Groups"
{
    // DrillDownPageID = UnknownPage39005883;
    // LookupPageID = UnknownPage39005883;

    fields
    {
        field(50000; "Posting Group"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Training Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(50002; "Training Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(50003; "Training Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Training Credit A/C Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Training Credit A/C Type" = const("Bank Account")) "Bank Account"."No.";
        }
        field(50004; "Recruitment Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(50005; "Recruitment Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(50006; "Recruitment Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Recruitment Credit A/C Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Recruitment Credit A/C Type" = const("Bank Account")) "Bank Account"."No.";
        }
        field(50007; "Comp. Act. Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(50008; "Comp. Act. Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(50009; "Comp. Act. Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Comp. Act. Credit A/C Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Comp. Act. Credit A/C Type" = const("Bank Account")) "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Posting Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
