Table 85384 "Employee Qualifications Fin"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; Type; Option)
        {
            OptionCaption = ' ,Internal,External,Others';
            OptionMembers = " ",Internal,External,Others;
        }
        field(50002; "From Date"; Date)
        {
        }
        field(50003; "To Date"; Date)
        {
        }
        field(50004; Institution; Code[30])
        {
            TableRelation = "Hr Institutions"."Institution Code";
        }
        field(50005; Description; Text[150])
        {
        }
        field(50006; Qualification; Option)
        {
            OptionCaption = ' ,Certificate,Diploma,Undergraduate,Masters,PHD,Higher Diploma';
            OptionMembers = " ",Certificate,Diploma,Undergraduate,Masters,PHD,"Higher Diploma";
        }
        field(50007; "Institution Name"; Text[250])
        {
            CalcFormula = lookup("Hr Institutions"."Institution Name" where("Institution Code" = field(Institution)));
            FieldClass = FlowField;
        }
        field(50008; "Highest Qualification"; Boolean)
        {
            trigger OnValidate()
            begin
                // qual.RESET;
                if ("Highest Qualification" = true) then begin
                    qual.Reset();
                    qual.SetRange(qual."Employee No.", "Employee No.");
                    qual.SetRange(qual."Highest Qualification", true);
                    if qual.Find('-') then
                        if qual.Count > 0 then
                            Error('You cannot have more than one highest qualifications for' + Format(qual."Employee No."));
                end;
            end;
        }
        field(50009; Rank; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Qualification, Type, Institution)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        qual: Record "Employee Qualifications Fin";
}
